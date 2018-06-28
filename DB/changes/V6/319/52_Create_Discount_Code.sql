set xact_abort on;
go
begin tran;

/*
 * Conceptually, the views return a set of data with a composite PK made of
 * IDPreInventoryMov, DocumentID and IDDiscount. A single DocumentID may have
 * multiple applicable IDDiscount values (e.g. 10% clearance and 15% employee
 * discount), i.e. stacked discounts.
 *
 * Generally, the views will be queried for a specific DocumentID, but that
 * is not necessarily the case.
 */

-- One objective is to make it easy to query an order and find out a discount
-- was *not* valid.
if object_id('vw_All_Discounts') is not null drop view vw_All_Discounts;
go
create view vw_All_Discounts as
    with InvoiceAggs as (
        select DocumentID, sum(SalePrice) as Subtotal
        from PreInventoryMov
        group by DocumentID
    ),
    doc_and_pessoa as (
        select DocumentID, IDPessoa
        from PreInventoryMov
        group by DocumentID, IDPessoa
    ),
    type_of_person as (
        select DAP.DocumentID, P.IDTipoPessoa
        from doc_and_pessoa DAP
        join Pessoa P on (P.IDPessoa = DAP.IDPessoa)
    ),
    final as (
        select PIM.IDPreInventoryMov, PIM.DocumentID, PIM.StoreID, PIM.ModelID,
            PIM.IDPessoa, PIM.SalePrice, PIM.Qty, Subtotal, SMD.ManualDiscount,
            type_of_person.IDTipoPessoa, Discounts.*
        from PreInventoryMov PIM
        join InvoiceAggs IA on (IA.DocumentID = PIM.DocumentID)
        join type_of_person on (type_of_person.DocumentID = PIM.DocumentID)
        left join ManualDiscount SMD on (
            SMD.IDPreInventoryMov = PIM.IDPreInventoryMov
        )
        cross join Discounts
    )
    select * from final;
go

if object_id('vw_DiscTimeRestrictions') is not null
    drop view vw_DiscTimeRestrictions;
go
create view vw_DiscTimeRestrictions as
    select DocumentID, IDPreInventoryMov, IDDiscount
    from vw_All_Discounts
    where
        (StartOn is null or cast(current_timestamp as date) >= StartOn)
        and (EndOn is null or cast(current_timestamp as date) <= EndOn)
        and (
            BeginTimeOfDay is null
            or BeginTimeOfDay <= cast(current_timestamp as time)
        )
        and (
            EndTimeOfDay is null
            or EndTimeOfDay >= cast(current_timestamp as time)
        );
go

if object_id('vw_DiscDayRestrictions') is not null
    drop view vw_DiscDayRestrictions;
go
create view vw_DiscDayRestrictions as
    -- Query DiscValidOnDays: if there are no rows, then it passes this test.
    -- If there are rows, but none of them match today's DayOfWeek, then fail.
    -- We do this calculation with the following three CTEs:
    with DiscValidOnDaysSet as (
        select
            CZ.DocumentID, CZ.IDPreInventoryMov, CZ.IDDiscount, VOD.DayOfWeek,
            case when
                VOD.IDDiscount is null
                or VOD.DayOfWeek = datepart(weekday, current_timestamp)
            then 1
            else 0
            end as DayIsValid
        from vw_All_Discounts CZ
        left join DiscValidOnDays VOD on (VOD.IDDiscount = CZ.IDDiscount)
    ),
    Final as (
        select DocumentID, IDPreInventoryMov, IDDiscount
        from DiscValidOnDaysSet
        where DayIsValid = 1
        group by DocumentID, IDPreInventoryMov, IDDiscount
    )
    select * from Final;
go

-- Discount invoice (i.e. per DocumentID) restrictions, such as subtotal
if object_id('vw_DiscSubTotalRestriction') is not null
    drop view vw_DiscSubTotalRestriction;
go
create view vw_DiscSubTotalRestriction as
    select DocumentID, IDPreInventoryMov, IDDiscount
    from vw_All_Discounts
    where (MinSubtotal is null or MinSubtotal <= Subtotal)
        and (MinDollarAmount is null or MinDollarAmount <= Subtotal);
go

/*
 * This should not be necessary any more:
    case when PIMS.ModelID in (
        select distinct TagModel.IDModel
        from DiscRewardTags DRT
        join TagModel on (TagModel.IDTag = DRT.IDTag)
        where IDDiscount = DE.IDDiscount
        -- How should we handle PurchasedQty > RewardQuantity?
    ) then
        DE.AmountType
    else
        'None'
    end as NewAmountType
*/

if object_id('vw_ValidDiscStores') is not null
    drop view vw_ValidDiscStores;
go
create view vw_ValidDiscStores as
    with DiscStoresSet as (
        select AD.DocumentID, AD.IDPreInventoryMov, AD.IDDiscount, AD.IDStore as AD_IDStore,
            DS.IDStore as DS_IDStore, DS.IsInclude
        from vw_All_Discounts AD
        left join DiscStores DS on (DS.IDDiscount = AD.IDDiscount)
    ),
    DiscStoresFinal as (
        select DocumentID, IDPreInventoryMov, IDDiscount
        from DiscStoresSet
        where DS_IDStore is null -- <- If there are no rows in DiscStores
            or (AD_IDStore = DS_IDStore and IsInclude = 1)
            or (AD_IDStore <> DS_IDStore and IsInclude = 0)
    )
    select * from DiscStoresFinal;
go

if object_id('vw_ValidMinQuantityDiscounts') is not null
    drop view vw_ValidMinQuantityDiscounts;
go
create view vw_ValidMinQuantityDiscounts as
    with IncludedQtyCount as (
        select AD.DocumentID, AD.IDPreInventoryMov, AD.IDDiscount,
            AD.MinQuantity, AD.Qty as QualifyingQty
        from vw_All_Discounts AD
        where MinQuantity is null or ModelID in (
            select distinct TagModel.IDModel
            from DiscQualifyingTags DQT
            join TagModel on (TagModel.IDTag = DQT.IDTag)
            where IDDiscount = AD.IDDiscount
        )
    ),
    Final as (
        select DocumentID, IDPreInventoryMov, IDDiscount
        from IncludedQtyCount
        where coalesce(MinQuantity, 0) <= QualifyingQty
    )
    select * from Final;
go

if object_id('vw_ValidCustGroupsDiscounts') is not null
    drop view vw_ValidCustGroupsDiscounts;
go
create view vw_ValidCustGroupsDiscounts as
    select AD.DocumentID, AD.IDPreInventoryMov, AD.IDDiscount
    from vw_All_Discounts AD
    left join DiscAllowedCustGroups ACG on (ACG.IDDiscount = AD.IDDiscount)
    where ACG.IDTipoPessoa is null or ACG.IDTipoPessoa = AD.IDTipoPessoa
    group by AD.DocumentID, AD.IDPreInventoryMov, AD.IDDiscount;
go

if object_id('vw_ValidCustRestrDiscounts') is not null
    drop view vw_ValidCustRestrDiscounts;
go
create view vw_ValidCustRestrDiscounts as
    with UseCountByCustomer as (
        select DU.IDDiscount, PIM.IDPessoa, count(*) as CustUseCount
        from DiscUses DU
        join Discounts D on (D.IDDiscount = DU.IDDiscount)
        join PreInventoryMov PIM on (PIM.IDPreInventoryMov = DU.IDInventoryMov)
        group by DU.IDDiscount, PIM.IDPessoa
    ),
    UseCountForAll as (
        select IDDiscount, sum(CustUseCount) as UseCount
        from UseCountByCustomer
        group by IDDiscount
    ),
    -- Discounts with Restriction Information.
    DiscWithRestrInfo as (
        select AD.DocumentID, AD.IDPreInventoryMov, AD.IDDiscount,
            AD.IDPessoa, UCFA.IDDiscount as UCFA_IDDiscount,
            UCBC.IDDiscount as UCBC_IDDiscount,
            AD.MaxUsesPerCustomer, UCBC.CustUseCount,
            AD.MaxUsesInTotal, UCFA.UseCount,
            AD.CustomerCardRequired, P.CustomerCard
        from vw_All_Discounts AD
        join Pessoa P on (P.IDPessoa = AD.IDPessoa) -- for CustomerCard below
        left join UseCountForAll UCFA on (UCFA.IDDiscount = AD.IDDiscount)
        left join UseCountByCustomer UCBC on
            (UCBC.IDDiscount = AD.IDDiscount and UCBC.IDPessoa = AD.IDPessoa)
    ),
    Final as (
        select DocumentID, IDPreInventoryMov, IDDiscount
        from DiscWithRestrInfo
        where
            (MaxUsesPerCustomer is null or MaxUsesPerCustomer >= CustUseCount)
            and (MaxUsesInTotal is null or MaxUsesInTotal >= UseCount)
            and (
                CustomerCardRequired is null
                or CustomerCardRequired = 0
                or CustomerCard is not null
            )
        group by DocumentID, IDPreInventoryMov, IDDiscount
    )
    select * from Final;
go

if object_id('vw_ValidFirstTimeRestrictionDiscounts') is not null
    drop view vw_ValidFirstTimeRestrictionDiscounts;
go
create view vw_ValidFirstTimeRestrictionDiscounts as
    with NumOrdersPerCustomer as (
        select
            AD.IDPessoa, (
                select count(*)
                from InventoryMov IM
                where IM.IDPessoa = AD.IDPessoa
                and IM.InventMovTypeID = (
                    select IDInventMovType
                    from InventoryMovType
                    where Name = 'Sold' and Desativado = 0
                )
                group by IM.IDPessoa
            ) as NumPreviousOrders
        from vw_All_Discounts AD
        group by IDPessoa
    ),
    Final as (
        select AD.DocumentID, AD.IDPreInventoryMov, AD.IDDiscount
        from vw_All_Discounts AD
        join NumOrdersPerCustomer NOPC on (NOPC.IDPessoa = AD.IDPessoa)
        where AD.FirstTimeCustomerOnly is null
            or AD.FirstTimeCustomerOnly = 0
            or NOPC.NumPreviousOrders > 0
    )
    select * from Final;
go


/*****************************************************************************
 **  vw_Potential_Discounts - the view that groups most other views.
 ****************************************************************************/
if object_id('vw_Potential_Discounts') is not null
    drop view vw_Potential_Discounts;
go
create view vw_Potential_Discounts as
    select AD.*,
        case when DTR.IDDiscount is null then 1 else 0 end
        as failed_DiscTimeRestrictions
    from vw_All_Discounts AD
    -- NOTE: If MSSQL does poorly at determining the optimal join order,
    -- then determine a good order manually and join them to eachother
    -- in sequence (instead of joining them all to vw_All_Discounts).
    join vw_DiscTimeRestrictions DTR on
        (DTR.IDPreInventoryMov = AD.IDPreInventoryMov and DTR.IDDiscount = AD.IDDiscount)
    join vw_DiscDayRestrictions DDR on
        (DDR.IDPreInventoryMov = DTR.IDPreInventoryMov and DDR.IDDiscount = DTR.IDDiscount)
    join vw_DiscSubTotalRestriction DST on
        (DST.IDPreInventoryMov = DDR.IDPreInventoryMov and DST.IDDiscount = DDR.IDDiscount)
    join vw_ValidDiscStores VDS on
        (VDS.IDPreInventoryMov = DST.IDPreInventoryMov and VDS.IDDiscount = DST.IDDiscount)
    join vw_ValidMinQuantityDiscounts VMQ on
        (VMQ.IDPreInventoryMov = VDS.IDPreInventoryMov and VMQ.IDDiscount = VDS.IDDiscount)
    join vw_ValidCustGroupsDiscounts VCG on
        (VCG.IDPreInventoryMov = VMQ.IDPreInventoryMov and VCG.IDDiscount = VMQ.IDDiscount)
    join vw_ValidCustRestrDiscounts VCR on
        (VCR.IDPreInventoryMov = VCG.IDPreInventoryMov and VCR.IDDiscount = VCG.IDDiscount)
    join vw_ValidFirstTimeRestrictionDiscounts FTR on
        (FTR.IDPreInventoryMov = VCR.IDPreInventoryMov and FTR.IDDiscount = VCR.IDDiscount)
    ;
go


if object_id('vw_CustomerDiscountWithModel') is not null drop view vw_CustomerDiscountWithModel;
go
create view vw_CustomerDiscountWithModel as
    select M.IDModel, ECD.*
    from Model M
    left join Ent_CustomerDiscount ECD on (ECD.IDGroup = M.GroupID);
go

-- Both vw_CalcCustomerDiscounts and vw_CalcStandardDiscounts
-- return rows that are "Potential" discounts, like this:
--
-- IDPreInventoryMov int not null references PreInventoryMov,
-- DocumentID int not null,
-- DiscountName varchar(max) not null,
-- IsStackable bit not null,
-- IsPercentDiscount bit not null,
-- DiscountAmount money not null,
-- DiscountPercent numeric(5,2),
--
-- -- 1) Customer File Discount: Ent_CustomerDiscount - joins pessoa on IDTipoPessoa
-- and model on idgroup/groupid; % Off based on group item is in. Convert % to
-- amount for comparison (which of the 6 is the highest discount) but keep
-- percentage as a second col.
if object_id('vw_CalcCustomerDiscounts') is not null drop view vw_CalcCustomerDiscounts;
go
create view vw_CalcCustomerDiscounts as
    with InvoiceAndPersons as (
        select DocumentID, IDPessoa
        from PreInventoryMov
        group by DocumentID, IDPessoa
    ),
    InvAndPersonTypes as (
        select DAP.DocumentID, P.IDTipoPessoa
        from InvoiceAndPersons DAP
        join Pessoa P on (P.IDPessoa = DAP.IDPessoa)
    ),
    -- Inventory movements with the associated PersonType (IDTipoPessoa).
    InvMovesWithPersonType as (
        select PIM.DocumentID, PIM.IDPreInventoryMov, PIM.ModelID as IDModel,
            TOD.IDTipoPessoa
        from PreInventoryMov PIM
        left join InvAndPersonTypes TOD on (TOD.DocumentID = PIM.DocumentID)
    ),
    InvMovesWithDiscount as (
        select TM.DocumentID, TM.IDPreInventoryMov, ECDM.Discount as DiscountPercent
        from InvMovesWithPersonType TM
        join vw_CustomerDiscountWithModel ECDM on (
            ECDM.IDTipoPessoa = TM.IDTipoPessoa
            and ECDM.IDModel = TM.IDModel
        )
    ),
    InvMovesWithAppliedDiscount as (
        select ECD.*, PIM.SalePrice * (ECD.DiscountPercent / 100) as DiscountAmount
        from InvMovesWithDiscount ECD
        join PreInventoryMov PIM on (PIM.IDPreInventoryMov = ECD.IDPreInventoryMov)
    ),
    InvMovesWithRoundedDiscount as (
        select IDPreInventoryMov, DocumentID, DiscountPercent,
            round(DiscountAmount, 2) as DiscountAmount
        from InvMovesWithAppliedDiscount
    ),
    Final as (
        select
            cast(DocumentID as int) DocumentID,
            cast(IDPreInventoryMov as int) IDPreInventoryMov,
            cast('Customer File Discount' as varchar) DiscountName,
            cast(0 as bit) IsStackable,
            cast(1 as bit) IsPercentDiscount,
            cast(DiscountAmount as money) DiscountAmount,
            cast(DiscountPercent as numeric(5, 2)) DiscountPercent
        from InvMovesWithRoundedDiscount
    )
    select * from Final;
go

-- Possible discounts here. All discounts with IsStackable = 0 will
-- go through the "there can be only one" selection. Nick would like to
-- save the discount percent separately, for display, if applicable.
-- Would add a "IDPotentialDiscount int identity(1, 1)," column.
-- The only purpose of the IDPotentialDiscount is as a tiebreaker in
-- case two discounts are the same, in which case we could simply
-- pick the one that came first (lowest IDPotentialDiscount) or
-- last (highest IDPotentialDiscount).
if object_id('vw_CalcStandardDiscounts') is not null drop view vw_CalcStandardDiscounts;
go
create view vw_CalcStandardDiscounts as
    -- CD is Calculated Discounts.
    with CD as (
        select
            DocumentID, IDPreInventoryMov, Qty, SalePrice,
            RewardAmount, DiscType,
            case when DiscType = 'Coupon' then 1 else 0 end as IsStackable,
            case when AmountType = 'Amount Off Item' then
                RewardAmount
            when AmountType = 'Percent Off Item' then
                -- Percent is stored as multiplier for performance and converted for display.
                SalePrice - (SalePrice * RewardAmount)
            when AmountType = 'Sale Price' then
                SalePrice - RewardAmount
            end as UnitDiscount,
            case when AmountType = 'Percent Off Item' then 1 else 0 end
                as IsPercentDiscount
        from vw_Potential_Discounts
    ),
    CD_with_ext as (
        select *, UnitDiscount * Qty as ExtensionDiscount
        from CD
    ),
    CD_rounded as (
        select *,
            round(UnitDiscount, 4) as UnitDiscountRounded,
            round(ExtensionDiscount, 2) as ExtensionDiscountRounded
        from CD_with_ext
    ),
    CD_with_discount_percent as (
        select DocumentID, IDPreInventoryMov, UnitDiscountRounded as UnitDiscount,
            ExtensionDiscountRounded as ExtensionDiscount,
            SalePrice, Qty, RewardAmount, IsStackable, IsPercentDiscount,
            case when IsPercentDiscount = 1 then RewardAmount else 0 end
                as DiscountPercent
        from CD_rounded
    ),
    CD_final as (
        select
            cast(DocumentID as int) DocumentID,
            cast(IDPreInventoryMov as int) IDPreInventoryMov,
            cast('Standard Discount' as varchar) DiscountName,
            cast(IsStackable as bit) IsStackable,
            cast(IsPercentDiscount as bit) IsPercentDiscount,
            cast(UnitDiscount as money) DiscountAmount,
            cast(DiscountPercent as numeric(5, 2)) DiscountPercent
        from CD_with_discount_percent
    )
    select * from CD_final;
go

-- While there might be two discounst that tie for the greatest discount amount,
-- we only get the discount amount, not any of the other details, so it doesn't
-- actually matter which one we select. If it did, however, we'd need a method
-- for a tiebreaker, which could be adding the IDPotentialDiscount column (see
-- note for the DiscPotential table).
if object_id('vw_SelectFinalDiscounts') is not null drop view vw_SelectFinalDiscounts;
go
create view vw_SelectFinalDiscounts as
    with PotentialDiscounts as (
        select * from vw_CalcCustomerDiscounts
        union all
        select * from vw_CalcStandardDiscounts
    ),
    GreatestNonStackableDiscounts as (
        select DocumentID, IDPreInventoryMov,
            max(DiscountAmount) as DiscountAmount
        from PotentialDiscounts
        where IsStackable = 0
        group by DocumentID, IDPreInventoryMov
    ),
    BothDiscounts as (
        select DocumentID, IDPreInventoryMov, DiscountAmount
        from GreatestNonStackableDiscounts
        union all
        select DocumentID, IDPreInventoryMov, DiscountAmount
        from PotentialDiscounts
        where IsStackable = 1
    ),
    SummedDiscounts as (
        select DocumentID, IDPreInventoryMov, sum(DiscountAmount) as UnitDiscount
        from BothDiscounts
        group by DocumentID, IDPreInventoryMov
    ),
    DiscountsAfterManual as (
        select PIM.DocumentID, PIM.IDPreInventoryMov, PIM.Qty,
            case when MD.ManualDiscount is not null then
                MD.ManualDiscount
            else
                SD.UnitDiscount
            end as UnitDiscount
        from PreInventoryMov PIM
        left join ManualDiscount MD
            on (MD.IDPreInventoryMov = PIM.IDPreInventoryMov)
        left join SummedDiscounts SD
            on (SD.IDPreInventoryMov = PIM.IDPreInventoryMov)
    ),
    ZeroedDiscounts as (
        select DM.DocumentID, DM.IDPreInventoryMov, DM.Qty,
            coalesce(DM.UnitDiscount, 0) as UnitDiscount,
            coalesce(DM.UnitDiscount * DM.Qty, 0) as Discount
        from DiscountsAfterManual DM
    ),
    RoundedDiscounts as (
        select DocumentID, IDPreInventoryMov, Qty,
            cast(round(UnitDiscount, 4) as money) as UnitDiscount,
            cast(round(Discount, 4) as money) as Discount
        from ZeroedDiscounts
    ),
    FinalDiscounts as (
        select * from RoundedDiscounts
    ),
    InvoiceDiscountSums as (
        select DocumentID, sum(Discount) as InvoiceItemDiscount
        from FinalDiscounts
        group by DocumentID
    ),
    Final as (
        select FD.*, cast(IDS.InvoiceItemDiscount as money) as InvoiceItemDiscount
        from FinalDiscounts FD
        left join InvoiceDiscountSums IDS on (IDS.DocumentID = FD.DocumentID)
    )
    select * from Final;
go

if object_id('vw_PreInventoryMovWithDiscounts') is not null
    drop view vw_PreInventoryMovWithDiscounts;
go

create view vw_PreInventoryMovWithDiscounts as
    select PIM.DocumentID, PIM.IDPreInventoryMov, PIM.ModelID, PIM.Qty,
        PIM.SalePrice, CD.UnitDiscount,
        round(PIM.SalePrice - CD.UnitDiscount, 2) as DiscountedPrice,
        cast(round((PIM.SalePrice * PIM.Qty), 2) as money) as Extension,
        cast(round((PIM.SalePrice * PIM.Qty - (CD.UnitDiscount * PIM.Qty)), 2) as money)
            as DiscountedExtension
    from vw_SelectFinalDiscounts CD
    join PreInventoryMov PIM on (PIM.IDPreInventoryMov = CD.IDPreInventoryMov);
go

/*
 * Usage: exec sp_PreSale_SetDiscount @DocumentID
 * @DocumentID (int): Indicates which PreInventoryMov lines will be used.
 * This sproc updates PIM (PreInventoryMov). For a read-only equivalent:
 *     select *
 *     from vw_PreInventoryMovWithDiscounts
 *     where DocumentID = @DocumentID;
 * Author: Daniel Browning <dbrowning@pinogy.com>
 */
if object_id(N'sp_PreSale_SetDiscount', N'P') is not null drop proc sp_PreSale_SetDiscount;
go
create proc sp_PreSale_SetDiscount
    @DocumentID int
    with execute as caller
as
    set nocount on
    --print 'sp_PreSale_SetDiscount called for DocumentID: '
    --    + cast(@DocumentID as varchar);

    declare @IDPreInventoryMov int;
    declare @UnitDiscount money;
    declare @Discount money;
    declare @InvoiceItemDiscount money;
    declare @discounts cursor;
    -- The fast_forward is a performance optimization since we only need to
    -- read through once and do read only operations.
    set @discounts = cursor fast_forward for
        select IDPreInventoryMov, UnitDiscount, Discount, InvoiceItemDiscount
        from vw_SelectFinalDiscounts
        where DocumentID = @DocumentID;
    open @discounts
    fetch next from @discounts into @IDPreInventoryMov, @UnitDiscount,
        @Discount, @InvoiceItemDiscount;

    -- todo: Move this code to another view so that we can make this SP even
    -- simpler, such that it only selects rows that need to be updated.
    if @@fetch_status = 0
    begin
        update Invoice
        set ItemDiscount = @InvoiceItemDiscount
        where IDPreSale = @DocumentID
            -- Avoid duplicate I/O.
            and coalesce(ItemDiscount, 0) <> coalesce(@InvoiceItemDiscount, 0);
    end

    while @@fetch_status = 0
    begin
        update PreInventoryMov
        set UnitDiscount = @UnitDiscount, Discount = @Discount
        where IDPreInventoryMov = @IDPreInventoryMov
            -- Avoid duplicate I/O when the new discount is the same as the old.
            -- The coalesce() causes the result to be the same even with nulls.
            and coalesce(UnitDiscount, 0) <> coalesce(@UnitDiscount, 0);

        fetch next from @discounts into @IDPreInventoryMov, @UnitDiscount,
            @Discount, @InvoiceItemDiscount;
    end
    close @discounts
    deallocate @discounts

    return 0;
go

if object_id('sp_AllActiveCustomerGroups') is not null drop procedure sp_AllActiveCustomerGroups;
go
create proc sp_AllActiveCustomerGroups as
    set nocount on;
    select IDTipoPessoa, TipoPessoa
    from TipoPessoa
    where Desativado = 0 and Hidden = 0 and Path like '.001%'
    order by TipoPessoa;
    set nocount off;
go

if object_id('sp_AllActiveStores') is not null drop procedure sp_AllActiveStores;
go
create proc sp_AllActiveStores as
    set nocount on;
    select IDStore, Name
    from Store
    where System = 0 and Desativado = 0
    order by Name;
    set nocount off;
go

create index idx_Pessoa_IDPessoa_IDTipoPessoa
    on Pessoa (IDPessoa) include (IDTipoPessoa);

create index idx_Pessoa_IDPessoa_CustomerCard
    on Pessoa (IDPessoa) include (CustomerCard);

create index idx_PreInventoryMov_1 on PreInventoryMov
    (IDPessoa, IDPreInventoryMov, DocumentID);

create index idx_PreInventoryMov_2 on PreInventoryMov
    (IDPessoa, IDPreInventoryMov, DocumentID, ModelID, InventMovTypeID)
    include (SalePrice, Qty);

create index idx_PreInventoryMov_3 on PreInventoryMov
    (DocumentID,	IDPessoa, InventMovTypeID, IDPreInventoryMov, ModelID)
    include (SalePrice, Qty);

create index idx_PreInventoryMov_4 on PreInventoryMov
    (DocumentID, IDPessoa, IDPreInventoryMov, ModelID, InventMovTypeID)
    include (SalePrice, Qty);

create index idx_PreInventoryMov_5 on PreInventoryMov
    (IDPreInventoryMov, DocumentID, ModelID, IDPessoa, InventMovTypeID)
    include (SalePrice, Qty);

create index idx_PreInventoryMov_6 on PreInventoryMov
    (IDPessoa, DocumentID)
    include (InventMovTypeID);

create index idx_PreInventoryMov_7 on PreInventoryMov
    (DocumentID, IDPreInventoryMov)
    include (ModelID, Qty);

create index idx_PreInventoryMov_8 on PreInventoryMov
    (IDPreInventoryMov, DocumentID)
    include (Qty);

create index idx_PreInventoryMov_9 on PreInventoryMov
    (DocumentID, IDPreInventoryMov)
    include (Qty);

create index idx_PreInventoryMov_10 on PreInventoryMov
    (IDPreInventoryMov)
    include (SalePrice);

create index idx_PreInventoryMov_11 on PreInventoryMov
    (DocumentID, InventMovTypeID);

create statistics stat_Pessoa_1 on Pessoa
    ([IDTipoPessoa], [IDPessoa]);

create statistics stat_PreInventoryMov_0 on [PreInventoryMov]
    ([InventMovTypeID], [IDPreInventoryMov], [ModelID]);

create statistics stat_PreInventoryMov_1 on [dbo].[PreInventoryMov]
    ([ModelID], [IDPreInventoryMov], [DocumentID], [IDPessoa]);

create statistics stat_PreInventoryMov_2 ON [dbo].[PreInventoryMov]
    ([DocumentID], [IDPreInventoryMov], [InventMovTypeID], [ModelID]);

create statistics stat_PreInventoryMov_3 ON [dbo].[PreInventoryMov]
    ([DocumentID], [InventMovTypeID], [IDPessoa], [IDPreInventoryMov], [ModelID]);

create statistics stat_Model_1 ON [dbo].[Model]
    ([GroupID], [IDModel]);

create statistics stat_InventoryMov_1 ON [dbo].[InventoryMov]
    ([InventMovTypeID], [IDPessoa]);

create statistics stat_InventoryMov_2 ON [dbo].[InventoryMov]
    ([Promo], [IDPessoa], [InventMovTypeID]);

commit tran;