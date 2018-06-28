/*
 * I'm told that MainRetail cannot handle "duplicate key" insert errors, and so
 * we avoid them in the TagModel table by removing the unique constraint and
 * simply deleting any duplicates after the fact.
 */
if object_id('tr_RemoveTagModelDuplicates', 'TR') is not null
    drop trigger tr_RemoveTagModelDuplicates;
go
create trigger tr_RemoveTagModelDuplicates on TagModel for insert, update as
    set nocount on;

    with TagModelRowsToKeep as (
        select IDTag, IDModel, min(PKTagModel) as PKTagModelToKeep
        from TagModel
        group by IDTag, IDModel
    )
    delete from TagModel where PKTagModel not in (
        select PKTagModelToKeep from TagModelRowsToKeep
    );
go


-- For testing tr_RemoveTagModelDuplicates:
/*
begin tran;
go

set identity_insert Tag on;

set nocount on;
insert into Tag (IDTag, TagName) values
    (100001, 'Test1'),
    (100002, 'Test2');

insert into TagModel (IDTag, IDModel) values
    (100001, 4),
    (100001, 5),
    (100001, 6),
    (100002, 9),
    (100002, 10),
    (100002, 10);

insert into TagQtyPriceBreak (IDTag, MinQuantity, Discount) values
    (100001, 5,   0.90),
    (100001, 20,  0.80),
    (100001, 100, 0.70),
    --
    (100002, 4,   0.95),
    (100002, 16,  0.90),
    (100002, 64,  0.85);

select * from TagModel where IDTag in (100001, 100002);

insert into TagModel (IDTag, IDModel) values
    (100002, 10),
    (100002, 10);

select * from TagModel where IDTag in (100001, 100002);

rollback;
*/


/*
 * Under testing, it is reported that sometimes PreInventoryMov is left with
 * rows that have Qty = 0, which isn't supposed to happen. Nick said to use
 * a trigger to remove such rows rather than find the root cause.
 *
 * MSSQL docs explain why "from inserted" works for both insert and update:
 *
 * The inserted table stores copies of the affected rows during INSERT and
 * UPDATE statements. During an insert or update transaction, new rows are
 * added to both the inserted table and the trigger table. The rows in the
 * inserted table are copies of the new rows in the trigger table.
 *
 * An update transaction is similar to a delete operation followed by an
 * insert operation; the old rows are copied to the deleted table first, and
 * then the new rows are copied to the trigger table and to the inserted table.
 */
if object_id('tr_RemoveZeroQtyPIMs', 'TR') is not null
    drop trigger tr_RemoveZeroQtyPIMs;
go
create trigger tr_RemoveZeroQtyPIMs on PreInventoryMov for insert, update as
    set nocount on;

    -- Delete extra commissions.
    delete from SaleItemCommission
    where IDPreInventoryMov in (
        select IDPreInventoryMov
        from PreInventoryMov
        where
            Qty = 0
            and InventMovTypeID = 1
            and IDPreInventoryMov in (
                select IDPreInventoryMov from inserted
            )
    );

    delete from PreInventoryMov
    where
        Qty = 0
        and InventMovTypeID = 1
        and IDPreInventoryMov in (
            select IDPreInventoryMov from inserted
        );
go


set ansi_nulls on;
set quoted_identifier on;
go

if object_id('Sal_Coupon') is not null
    drop table Sal_Coupon;
go

create table Sal_Coupon (
    DocumentID int not null,
    CouponCode nvarchar(255) not null,
    constraint PK_Sal_Coupon primary key (DocumentID, CouponCode)
);

alter table Sal_Coupon with check
    add constraint FK_Sal_Coupon_DocumentID
    foreign key (DocumentID)
    references Invoice (IDPreSale)
    on update cascade on delete cascade;

alter table Sal_Coupon with check
    add constraint FK_Sal_Coupon_CouponCode
    foreign key (CouponCode) references DiscCoupons (Code)
    on update cascade on delete cascade;

-- The actual execution plan of the following proves that neither coalesce
-- nor isnull will short-circuit the query execution if the first argument
-- is not null. However, coalesce is about twice as slow.
/*
select
    isnull(
        (select sum(cast(IDInventoryMov as bigint)) from InventoryMov),
        (select sum(cast(IDInvoice as bigint)) from Invoice)
    );

select
    coalesce(
        (select sum(cast(IDInventoryMov as bigint)) from InventoryMov),
        (select sum(cast(IDInvoice as bigint)) from Invoice)
    );
*/
if object_id('fn_CalcPrice', 'FN') is not null
    drop function fn_CalcPrice;
go

/*
 * Prices are selected in the following order of preference.
 * Example usage:
 *     select dbo.fn_CalcPrice(228086, 2192, 1, null);
 *
 * Note that Qty gets updated before this is called so that we
 * don't have to pass in @Qty.
 *
 */
create function fn_CalcPrice (
    @PreInventoryMovID int,
    @SpecialPriceID int = null
)
returns money with execute as caller as
begin
    declare @SalePrice money;

    select @SalePrice =
        ManualPrice
        from ManualPrice
        where IDPreInventoryMov = @PreInventoryMovID;

    if @SalePrice is not null
        return @SalePrice;

    if @SpecialPriceID is not null
        select @SalePrice =
            round(M.FinalCost * (SPBG.SpecialMarkUp + 1), 4)
            from PreInventoryMov PIM
            join Model M on (M.IDModel = PIM.ModelID)
            join SpecialPriceByGroup SPBG on (SPBG.GroupID = M.GroupID)
            where SPBG.SpecialPriceID = @SpecialPriceID
                and PIM.IDPreInventoryMov = @PreInventoryMovID;

    if @SalePrice is not null
        return @SalePrice;

    select @SalePrice =
        I.SellingPrice
        from PreInventoryMov PIM
        join Inventory I on (I.ModelID = PIM.ModeliD and I.StoreID = PIM.StoreID)
        where IDPreInventoryMov = @PreInventoryMovID;

    if @SalePrice is not null
        return @SalePrice;

    -- Gets values for all other rows with the matching IDTag
    with AllPIMTags as (
        select PIM.DocumentID, PIM.IDPreInventoryMov, PIM.Qty,
            TagModel.IDTag
        from PreInventoryMov PIM
        left join TagModel on (TagModel.IDModel = PIM.ModelID)
        where PIM.DocumentID = (
            select top 1 DocumentID
            from PreInventoryMov
            where IDPreInventoryMov = @PreInventoryMovID
        )
        --where PIM.IDPreInventoryMov = @PreInventoryMovID
    ),
    TagsWithQuantities as (
        -- Nick gave the following examples of how you should sum
        -- quantities for qty price breaks:
        -- -1 + -2 + -3 = -6, therefore 6 should be used
        -- -1 + 2 + -3 = -2, so then we use 2
        select IDTag, abs(sum(Qty)) as SumQtyForPriceBreaks
        from AllPIMTags
        group by IDTag
    ),
    PIMTagsWithLargestMinQuantity as (
        select TWQ.IDTag, max(TQPB.MinQuantity) as LargestMinQuantity
        from TagsWithQuantities TWQ
        join TagQtyPriceBreak TQPB on (
            TQPB.IDTag = TWQ.IDTag
            and SumQtyForPriceBreaks >= TQPB.MinQuantity
        )
        group by TWQ.IDTag
    ),
    PIMTagsWithDiscounts as (
        select Foo.*, TQPB.Discount
        from PIMTagsWithLargestMinQuantity Foo
        join TagQtyPriceBreak TQPB on
            (TQPB.IDTag = Foo.IDTag and TQPB.MinQuantity = Foo.LargestMinQuantity)
    ),
    PIMWithPotentialDiscounts as (
        select AllPIMTags.*, PTWD.Discount
        from AllPIMTags
        left join PIMTagsWithDiscounts PTWD on (PTWD.IDTag = AllPIMTags.IDTag)
    ),
    BestDiscounts as (
        select DocumentID, IDPreInventoryMov, max(Discount) as BestDiscount
        from PIMWithPotentialDiscounts
        group by DocumentID, IDPreInventoryMov
    ),
    PIMWithQtyBreakPrices as (
        select PIM.DocumentID, PIM.IDPreInventoryMov, M.SellingPrice, M.PromotionPrice,
            round(((1 - coalesce(BestDiscount, 0)) * M.SellingPrice), 2) as QtyBreakPrice
        from PreInventoryMov PIM
        join Model M on (M.IDModel = PIM.ModelID)
        join BestDiscounts on (BestDiscounts.IDPreInventoryMov = PIM.IDPreInventoryMov)
    ),
    PivotedPrices as (
        select DocumentID, IDPreInventoryMov, PriceName, Price
        from (
            select DocumentID, IDPreInventoryMov,
                SellingPrice, PromotionPrice, QtyBreakPrice
            from PIMWithQtyBreakPrices
        ) PivotedData
        unpivot (
            Price for PriceName in (SellingPrice, PromotionPrice, QtyBreakPrice)
        ) as UnPivotedData
    ),
    LowestPrices as (
        select DocumentID, IDPreInventoryMov, min(Price) as Price
        from PivotedPrices
        -- The unpivot() above will remove nulls, but let's do it again here
        -- so that it would work even if we later switch to a different method
        -- that doesn't remove nulls.
        where Price is not null
        group by DocumentID, IDPreInventoryMov
    )
    select @SalePrice = Price
    from LowestPrices
    where IDPreInventoryMov = @PreInventoryMovID;

    return @SalePrice;
end;
go


if object_id('[dbo].[sp_PreSale_CalcPrice]') is not null drop procedure [dbo].[sp_PreSale_CalcPrice];
go
CREATE procedure [dbo].[sp_PreSale_CalcPrice]
    @IDModel int,
    @StoreID int,
    @Qty int,
    @IDPreInventoryMov int,
    @SpecialPriceID int = null,
    @ManualPrice money = null
as
begin
    set nocount on;

    if (@ManualPrice is not null)
    begin
        merge ManualPrice as target
        using (select @IDPreInventoryMov, @ManualPrice)
            as source (id_preinventorymov,  manual_price)
        on (target.IDPreInventoryMov = source.id_preinventorymov
            and target.IDPreInventoryMov = source.id_preinventorymov)
        when matched then
            update set ManualPrice = source.manual_price
        when not matched then
            insert (IDPreInventoryMov, ManualPrice)
            values (
                source.id_preinventorymov,
                source.manual_price
            );
    end;

    select dbo.fn_CalcPrice(@IDPreInventoryMov, @SpecialPriceID);

END
go



-- One objective is to make it easy to query an order and find out a discount
-- was *not* valid.

if object_id('vw_All_Discounts') is not null drop view vw_All_Discounts;
go
create view vw_All_Discounts as
    select PIM.DocumentID, PIM.IDPreInventoryMov, PIM.StoreID,
        PIM.ModelID,
        PIM.IDPessoa, PIM.SalePrice,
        -- Not sure if abs() is correct here or not. Nick thinks that the
        -- problems with returns can be solved by adding abs() in the right
        -- spot, so this is the first guess (since we don't have a test case
        -- to reproduce the issue yet):
        abs(PIM.Qty) as Qty,
        Invoice.Subtotal,
        Pessoa.IDTipoPessoa, Discounts.*
    from PreInventoryMov PIM
    join Invoice on (Invoice.IDPreSale = PIM.DocumentID)
    join Pessoa on (Pessoa.IDPessoa = PIM.IDPessoa)
    left join Discounts on (1 = 1);
    --cross join Discounts;
go

--select IDPreInventoryMov from PreInventoryMov;

if object_id('fn_IsValidCouponDiscount') is not null
    drop function fn_IsValidCouponDiscount;
go

create function fn_IsValidCouponDiscount (
    @DocumentID int,
    @IDDiscount int
)
returns bit with execute as caller as
begin
    declare @IsValid bit;

    select top 1 @IsValid =
        case when IDPreInventoryMov is not null then
            1
        else
            0
        end
    from PreInventoryMov PIM
    join Discounts D on (D.IDDiscount = @IDDiscount)
    join Sal_Coupon SC on (SC.DocumentID = @DocumentID)
    join DiscCoupons DC on (
        DC.IDDiscount = @IDDiscount
        and DC.Code = SC.CouponCode
    )
    where PIM.DocumentID = @DocumentID;

    return @IsValid;
end
go

if object_id('vw_Potential_Discounts') is not null
    drop view vw_Potential_Discounts;
go

/*****************************************************************************
 **  vw_Potential_Discounts - the view that groups most other views.
 ****************************************************************************/
if object_id('vw_Potential_Discounts') is not null
    drop view vw_Potential_Discounts;
go
create view vw_Potential_Discounts as
    select AD.*
        --,case when DTR.IDDiscount is null then 1 else 0 end as failed_DiscTimeRestrictions
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
    where 1 =
        case when AD.DiscType = 'Coupon' then
            dbo.fn_IsValidCouponDiscount(FTR.DocumentID, FTR.IDDiscount)
        else
            1
        end;
go






-- replaced with CTE
if object_id('vw_CustomerDiscountWithModel') is not null drop view vw_CustomerDiscountWithModel;
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
    with InvMovesWithCustDiscount as (
        select PIM.DocumentID, PIM.IDPreInventoryMov, PIM.StoreID,
            PIM.ModelID,
            PIM.IDPessoa, PIM.SalePrice, PIM.Qty, Invoice.Subtotal,
            Pessoa.IDTipoPessoa,
            ECD.Discount as DiscountPercent,
            round(PIM.SalePrice * (ECD.Discount / 100), 2) as DiscountAmount
        from PreInventoryMov PIM
        join Invoice on (Invoice.IDPreSale = PIM.DocumentID)
        join Pessoa on (Pessoa.IDPessoa = PIM.IDPessoa)
        join Model on (Model.IDModel = PIM.ModelID)
        join Ent_CustomerDiscount ECD on (
            ECD.IDGroup = Model.GroupID
            and ECD.IDTipoPessoa = Pessoa.IDTipoPessoa
        )
    ),
    Final as (
        select
            cast(DocumentID as int) DocumentID,
            cast(IDPreInventoryMov as int) IDPreInventoryMov,
            Qty,
            cast('Customer File Discount' as varchar) DiscountName,
            cast(0 as bit) IsStackable,
            cast(1 as bit) IsPercentDiscount,
            cast(DiscountAmount as money) DiscountAmount,
            cast(DiscountPercent as numeric(5, 2)) DiscountPercent
        from InvMovesWithCustDiscount
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
            vw_Potential_Discounts.DocumentID, IDPreInventoryMov, Qty, SalePrice,
            RewardAmount, DiscType,
            case when DiscType = 'Coupon' then 1 else 0 end as IsStackable,
            case when AmountType = 'Percent Off Item' then 1 else 0 end
                as IsPercentDiscount,
            case when AmountType = 'Amount Off Item' then
                RewardAmount
            when AmountType = 'Percent Off Item' then
                -- Percent is stored as multiplier for performance and converted for display.
                SalePrice - (SalePrice * RewardAmount)
            when AmountType = 'Sale Price' then
                SalePrice - RewardAmount
            end as UnitDiscount
        from vw_Potential_Discounts
    ),
    CD_after_coupons as (
        select CD.DocumentID, IDPreInventoryMov, Qty, SalePrice, RewardAmount,
            DiscType, IsStackable, IsPercentDiscount,
            case when DiscType = 'Coupon' then
                case when (SC.CouponCode is not null) then
                    UnitDiscount
                else
                    0
                end
            else
                UnitDiscount
            end
            as UnitDiscount
        from CD
        left join Sal_Coupon SC on (
            SC.DocumentID = CD.DocumentID
        )
    ),
    CD_with_ext as (
        select *, UnitDiscount * Qty as ExtensionDiscount
        from CD_after_coupons
    ),
    CD_rounded as (
        select *,
            round(UnitDiscount, 4) as UnitDiscountRounded,
            round(ExtensionDiscount, 2) as ExtensionDiscountRounded
        from CD_with_ext
    ),
    CD_with_discount_percent as (
        select DocumentID, IDPreInventoryMov, Qty,
            UnitDiscountRounded as UnitDiscount,
            ExtensionDiscountRounded as ExtensionDiscount,
            SalePrice, RewardAmount, IsStackable, IsPercentDiscount,
            case when IsPercentDiscount = 1 then RewardAmount else 0 end
                as DiscountPercent
        from CD_rounded
    ),
    CD_final as (
        select
            cast(DocumentID as int) DocumentID,
            cast(IDPreInventoryMov as int) IDPreInventoryMov,
            Qty,
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
        select DocumentID, IDPreInventoryMov, Qty,
            max(DiscountAmount) as DiscountAmount
        from PotentialDiscounts
        where IsStackable = 0
        group by DocumentID, IDPreInventoryMov, Qty
    ),
    BothDiscounts as (
        select DocumentID, IDPreInventoryMov, Qty, DiscountAmount
        from GreatestNonStackableDiscounts
        union all
        select DocumentID, IDPreInventoryMov, Qty, DiscountAmount
        from PotentialDiscounts
        where IsStackable = 1
    ),
    SummedDiscounts as (
        select DocumentID, IDPreInventoryMov, Qty, sum(DiscountAmount) as UnitDiscount
        from BothDiscounts
        group by DocumentID, IDPreInventoryMov, Qty
    ),
    ZeroedDiscounts as (
        select DM.DocumentID, DM.IDPreInventoryMov, DM.Qty,
            coalesce(DM.UnitDiscount, 0) as UnitDiscount,
            coalesce(DM.UnitDiscount * DM.Qty, 0) as Discount
        from SummedDiscounts DM
    ),
    FinalDiscounts as (
        select DocumentID, IDPreInventoryMov, Qty,
            cast(round(UnitDiscount, 4) as money) as UnitDiscount,
            cast(round(Discount, 4) as money) as Discount
        from ZeroedDiscounts
    )
    select * from FinalDiscounts;
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


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_PreSale_SubAddItem]
    (
    @PreSaleID      int,
    @IDCliente      int,
    @ModelID        int,
    @StoreID        int,
    @UserID         int,
    @IDComission        int,
    @Qty            float,
    @SalePrice      money,
    @CostPrice      money = Null,
    @Discount       money,
    @MovDate        smalldatetime,
    @IDPreInvMovExchange    int,
    @PreInvMovParentID  int,
    @IDDepartment       int,
    @Promo          bit,
    @IDDescriptionPrice int,
    @IDVendorPrice      int,
    @SuggPrice      int,
    @DocumentNumber     varchar(20),
    @IDDocumentType     int,
    @SequencyNum        int,
    @TotParcial     varchar(10),
    @DiscountPromo      money = 0,
    @UnitDiscount       money =0,
    @PreInventMovID     int = NULL Output,
    @ManualDiscount money = NULL,
    @IDSpecialPrice int = NULL,
    @ManualPrice money = NULL
    )
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    SUMMARY

        - Insert on Inventory Movement
        - Insert on Customer Credit
        - Insert quantities to exchange

    TABLE OF ERRORS FOR RETURN_VALUE

         000  Ok
        -201 Error on Insert Inventory Movement
        -203 Error Adding Models of PacketModel
        -204 Error on Insert in the Customer Credit
        -205 Error on Insert in the Customer Credit PackModel
        -206 Error on Insert quantities required to change PreInvMov
        -207 Error on Insert the quantities in exchange InvMov
        -208 Error on Insert SaleItemCommission
        -209 Error on Insert SaleItemCommission relating to the Kit item
        -210 Error on Insert Inv_MovPrice
        -211 Error on Insert Inv_MovDocument

    MODIFICATION LOG

    Data            Programador     Modificação
    ----------------------- ----------------------- -----------------------------------------------------------------
    15 May  2000        Eduardo Costa       Criacao;
    26 Jun  2001        Davi Gouveia        Log de Return Values;
    29 Oct  2003        Rodrigo Costa       Criado sp_Sis_GetNextCod;
    24 May  2004        André Bogado        Criado Cursor para KitModel;
    18 Aug  2004        Rodrigo Costa       Gravar error log;
    01 Dec  2004        Rodrigo Costa       Gravar no Customer Credit;
    01 Feb  2005        Rodrigo Costa       Inclusao do campo @IDPreInvMovExchange;
    11 Apr  2005        Rodrigo Costa       Inclusao do campo DesiredMarkup no PreInvMov;
    28 Nov  2005        Leonardo Riego      Gravar na SaleItemCommission;
    12 Apr  2006        Leonardo Riego      Novo campo @IDDepartment;
    16 Jun  2006        Rodrigo Costa       Adicionado os parametros para ErrorHistory;
    20 Jul  2007        Maximiliano Muniz   Novos parâmetros @IDDescriptionPrice, @IDVendorPrice e @SuggPrice;
                            Inserção na tabeça Inv_MovPrice;
    08 Aug  2007        Maximiliano Muniz   Novos parâmetros @DocumentNumber e @IDDocumentType;
                            Inserção na tabeça Inv_MovDocument;
    24 Aug  2009        Rodrigo Costa       Inclusao dos campos TotParcial e SequencyNum para o PAF-ECF
    19 Jan  2010        Eliandro Souza      Inclusão do Parametro @DiscountPromo
    10 Dec  2012        Antonio M F Souza   added UnitDiscount parameter
    ----------------------------------------------------------------------------------------------------------------- */

DECLARE @ComissionID        int
DECLARE @IDMovPrice     int
DECLARE @IDMovDocument      int
DECLARE @ErrorLevel     int
DECLARE @SysError       int
DECLARE @IDSaleItemCommission   int
DECLARE @IsNewPIM             boolean
DECLARE @IsUpdate           boolean
--Declaration of variables for ModelChild cursor
DECLARE @ModelIDChild   int
DECLARE @QtyChild       float
DECLARE @PreInvMovIDPack    int



SET @ErrorLevel = 0
-- set @my_tran_count = @@trancount;
-- BEGIN TRAN

/*-------------------------------------------------------------*/
/*      Possible insert on PreInventory Movement               */
/*-------------------------------------------------------------*/
/*
 * A PreInventoryMov row may or may not exist. If a PreInventMovID parameter
 * was passed in, use that for looking up the PreInventoryMov row, but do
 * not assume it exists. If PreInventMovID was not passed in, try searching
 * for an existing row with several other parameters (ModelID, UserID, etc.).
 * If a row is found, the quantity will be increased (i.e. each time add-item
 * is called, it increases quantity by the amount passed in, e.g. one).
 * If no row is found in either case, then @FoundIDPreInventoryMov will be
 * null, so a new PreInventoryMov row is be created.
 * In all cases, @PreInventMovID is set to the passed-in, found, or newly-
 * created PreInventoryMov row.
 */

-- There a small issue with the SP for the cash register: when you add in
-- the same item multiple times using the same user, it adds in the user,
-- multiple times, in the "Sales Person" column. It should only add more
-- than one user if there are multiple different users associated with the
-- item.

DECLARE @FoundIDPreInventoryMov int
DECLARE @OutIDPreInventoryMov int
DECLARE @FinalQty decimal (38,4)

set @IsNewPIM = 0;
-- Check the passed-in ID exists in the table or not.
select @FoundIDPreInventoryMov = @PreInventMovID
from PreInventoryMov
where IDPreInventoryMov = @PreInventMovID

IF (@FoundIDPreInventoryMov is not null)
BEGIN
    --print 'Already have preinventorymov, add or remove to existing quantity.'
    --print 'FoundIDPreInventoryMov: ' + coalesce(cast(@FoundIDPreInventoryMov as varchar), 'null')
    --print 'PreInventMovID: ' + coalesce(cast(@PreInventMovID as varchar), 'null')
    IF (@PreInventMovID IS NOT NULL)
    BEGIN
        SELECT @FinalQty  = @Qty
    END
    ELSE
    BEGIN
        SELECT @FinalQty  = [Qty] + @Qty FROM [dbo].[PreInventoryMov]
        WHERE IDPreInventoryMov = @FoundIDPreInventoryMov
    END

    SET @PreInventMovID = @FoundIDPreInventoryMov;
    SET @IsNewPIM = 0;

    END
ELSE
BEGIN
    set @IsNewPIM = 1;

    SELECT @FoundIDPreInventoryMov = dbo.PreInventoryMov.IDPreInventoryMov
       FROM dbo.PreInventoryMov
    LEFT OUTER JOIN dbo.ManualPrice
       ON dbo.PreInventoryMov.IDPreInventoryMov = dbo.ManualPrice.IDPreInventoryMov
    WHERE dbo.PreInventoryMov.ModelID = @ModelID
    AND dbo.PreInventoryMov.UserID = @UserID
    AND dbo.PreInventoryMov.DocumentID = @PreSaleID
    AND dbo.PreInventoryMov.StoreID = @StoreID
    AND dbo.PreInventoryMov.InventMovTypeID = 1
    AND dbo.ManualPrice.ManualPrice IS NULL;
    --print 'Combined lines FoundIDPreInventoryMov  is cast(@FoundIDPreInventoryMov as varchar)'
    IF (@FoundIDPreInventoryMov is not null)
    BEGIN
        SET @PreInventMovID = @FoundIDPreInventoryMov;
        SELECT @FinalQty  = [Qty] + @Qty FROM [dbo].[PreInventoryMov] WHERE IDPreInventoryMov = @FoundIDPreInventoryMov;
        set @IsNewPIM = 0;
        print 'This has to be here to avoid a discount limit message.  No clue why.'
        --print 'Qty cast(@Qty as varchar) FinalQty cast(@FinalQty as varchar)'
    END
    ELSE
    BEGIN
        --print 'No preinventorymov yet, insert new row.'
        SET @FinalQty  = @Qty;
        EXEC sp_Sis_GetNextCode'PreInventoryMov.IDPreInventoryMov', @PreInventMovID OUTPUT;
        --print 'Got new PreInventMovID: ' + cast(@PreInventMovID as varchar);
    END

    insert into PreInventoryMov
        (
        IDPreInventoryMov,
        InventMovTypeID,
        IDPessoa,
        DocumentID,
        ModelID,
        StoreID,
        MovDate,
        Qty,
        SalePrice,
        Discount,
        CostPrice,
        UserID,
        IDPreInvMovExchange,
        IDPreInventoryMovParent,
        IDDepartment,
        Promo,
        DesiredMarkup,
        SequencyNum,
        TotParcial,
        DiscountPromo,
        UnitDiscount
        )
        SELECT
            @PreInventMovID,
            1,
            @IDCliente,
            @PreSaleID,
            @ModelID,
            @StoreID,
            @MovDate,
            @Qty,
            @SalePrice,
            @Discount+@DiscountPromo,
            coalesce(@CostPrice, (M.VendorCost+M.OtherCost+M.FreightCost)) as CostPrice,
            @UserID,
            @IDPreInvMovExchange,
            @PreInvMovParentID,
            @IDDepartment,
            @Promo,
            TG.DesiredMarkup,
            @SequencyNum,
            @TotParcial,
            @DiscountPromo,
            @UnitDiscount
        FROM
            dbo.Model M
            JOIN TabGroup TG ON (TG.IDGroup = M.GroupID)
        WHERE
            M.IDModel = @ModelID;

    -- if @@rowcount == 0, the insert failed;
    -- Can't do this check here though, becuase nested begin/end have to be closed first.
    -- need to do better error handling.
    if @@rowcount = 0
    begin
        print 'PreInventoryMov insert did not create rows; did the Model and TabGroup rows exist?';
        -- set @ErrorLevel = -201;
        -- goto ERRO
    end



    -- select count(*) from PreInventoryMov where IDPreInventoryMov = @PreInventMovID;

END

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
    SET @ErrorLevel = -201
    GOTO ERRO
END

if @ManualDiscount is not null
begin
    delete from ManualDiscount
    where IDPreInventoryMov = @PreInventMovID

    insert into ManualDiscount (
        IDPreInventoryMov,
        ManualDiscount
    )
    values (
        @PreInventMovID,
        @ManualDiscount
    );
end

/*
 * Recalculate prices with the potentially-new quantity value.
 */
-- So that sp_PreSale_CalcPrice can work directly off the table and not the variable:
update PreInventoryMov
set Qty = @FinalQty
where IDPreInventoryMov = @PreInventMovID;

declare @OutPrice money;
declare @OutCost money;

/*
declare @tablevar table(Price money);
insert into @tablevar(Price)
    EXEC [dbo].[sp_PreSale_CalcPrice] @ModelID, @StoreID, @FinalQty,
    @PreInventMovID, @IDSpecialPrice, @ManualPrice;
SELECT @OutPrice = Price FROM @tablevar;
*/
if (@ManualPrice is not null)
begin
    merge ManualPrice as target
    using (select @PreInventMovID, @ManualPrice)
        as source (id_preinventorymov,  manual_price)
    on (target.IDPreInventoryMov = source.id_preinventorymov
        and target.IDPreInventoryMov = source.id_preinventorymov)
    when matched then
        update set ManualPrice = source.manual_price
    when not matched then
        insert (IDPreInventoryMov, ManualPrice)
        values (
            source.id_preinventorymov,
            source.manual_price
        );
end;

-- select @OutPrice = dbo.fn_CalcPrice(@PreInventMovID, @IDSpecialPrice);
-- select @OutCost = Finalcost from Model where IDModel = @ModelID;

if (@FinalQty = 0)
begin
    delete from PreInventoryMov where IDPreInventoryMov = @PreInventMovID
end
else
begin
    /*
     * Update prices on all items, since adding one may affect the others
     * due to quantity price breaks.
     */
    update PreInventoryMov
    set SalePrice = dbo.fn_CalcPrice(
            IDPreInventoryMov, (
                -- Only pass in the IDSpecialPrice for the one line item that is
                -- associated with this *_SubAddItem call, otherwise null.
                -- A better solution would be to store the IDSpecialPrice
                -- in an associated table, because otherwise an item will only
                -- have the specialprice until a different item is added (and
                -- it has its price recalculated without the specialprice).
                case when IDPreInventoryMov = @PreInventMovID then
                    @IDSpecialPrice
                else
                    null
                end
            )
        ),
        CostPrice = (select FinalCost from Model where IDModel = ModelID)
    where DocumentID = (
        select top 1 DocumentID
        from PreInventoryMov
        where IDPreInventoryMov = @PreInventMovID
    );

end

-- Call every time (i.e. temporarily disable IDParam 118.
-- exec sp_PreSale_SetDiscount @PreSaleID;

/*
 * IDParam 118 is "Calculate discounts on Finalization Only", which controls
 * whether discounts are calculated after each item addition, or just at order
 * finalization. The two valid values are 'Item' (default) or 'Sale'.
 */
declare @UpdateDiscounts char(4);
select @UpdateDiscounts = SrvValue from Param where IDParam = 118;
if @UpdateDiscounts <> 'Sale'
begin
    -- insert into ManualDiscount values (55137, 9.99)
    exec sp_PreSale_SetDiscount @PreSaleID
end



/*****************************************************************************************
    Inclusion of amounts for exchange
******************************************************************************************/
IF (@IDPreInvMovExchange IS NOT NULL)
BEGIN
    --Pre Inv Mov
    UPDATE
        PreInventoryMov
    SET
        QtyExchanged = IsNull(QtyExchanged,0) + ABS(@Qty)
    WHERE
        IDPreInventoryMov = @IDPreInvMovExchange
        AND
        InventMovTypeID = 1

    SET @SysError = @@ERROR
    IF @SysError <> 0
    BEGIN
        SET @ErrorLevel = -206
        GOTO ERRO
    END

    -- Inv Mov
    UPDATE
        InventoryMov
    SET
        QtyExchanged = IsNull(QtyExchanged,0) + ABS(@Qty)
    WHERE
        PreInventoryMovID = @IDPreInvMovExchange
        AND
        InventMovTypeID = 1

    SET @SysError = @@ERROR
    IF @SysError <> 0
    BEGIN
        SET @ErrorLevel = -207
        GOTO ERRO
    END
END


-- Return all records or just item based on input.
IF @PreInventMovID IS NOT NULL
BEGIN
 SELECT PIM.idpreinventorymov, M.IDModel, M.Model, M.Description, PIM.SalePrice,
 PIM.CostPrice, PIM.UnitDiscount, PIM.Discount, PIM.Promo, PIM.Qty,
 round((PIM.Qty * PIM.UnitDiscount), 2) as ExtDiscount,
 round((PIM.Qty * PIM.SalePrice), 2) as ExtPrice,
 (round((PIM.Qty * PIM.SalePrice), 2) - round((PIM.Qty * PIM.UnitDiscount), 2)) as LineSubTotal,
 TC.Tax
  FROM preinventorymov PIM
   join Model M on (PIM.modelid = M.idmodel)
        join StoreToTabGroup STTG on (M.GroupID = STTG.IDGroup and PIM.StoreID = STTG.IDStore)
            join TaxCategory TC on (STTG.IDTaxCategory = TC.IDTaxCategory)
  WHERE PIM.InventMovTypeID = 1 and PIM.IDPreInventoryMov = @PreInventMovID
END
ELSE
BEGIN
 SELECT PIM.idpreinventorymov, M.IDModel, M.Model, M.Description, PIM.SalePrice,
 PIM.CostPrice, PIM.UnitDiscount, PIM.Discount, PIM.Promo, PIM.Qty,
 round((PIM.Qty * PIM.UnitDiscount), 2) as ExtDiscount,
 round((PIM.Qty * PIM.SalePrice), 2) as ExtPrice,
 (round((PIM.Qty * PIM.SalePrice), 2) - round((PIM.Qty * PIM.UnitDiscount), 2)) as LineSubTotal,
 TC.Tax
  FROM preinventorymov PIM
   join Model M on (PIM.modelid = M.idmodel)
        join StoreToTabGroup STTG on (M.GroupID = STTG.IDGroup and PIM.StoreID = STTG.IDStore)
            join TaxCategory TC on (STTG.IDTaxCategory = TC.IDTaxCategory)
  WHERE PIM.InventMovTypeID = 1 and PIM.DocumentID = @PreSaleID
END


/*****************************************************************************************
    Inclusion of Commissions on the SaleItemCommission table
******************************************************************************************/
if @IsNewPIM = 1 begin
    print 'IsNewPIM = 1, so create saleItemcommission row with PreInventMovID = ' + cast(@PreInventMovID as varchar);


    EXEC sp_Sis_GetNextCode'SaleItemCommission.IDSaleItemCommission', @IDSaleItemCommission OUTPUT

    INSERT INTO dbo.SaleItemCommission
        (
         IDSaleItemCommission,
         IDPreInventoryMov,
         IDCommission,
         CommissionPercent
        )
        VALUES
        (
         @IDSaleItemCommission,
         @PreInventMovID,
         @IDComission,
         100
        )

    SET @SysError = @@ERROR
    IF @SysError <> 0
    BEGIN
        SET @ErrorLevel = -208
        GOTO ERRO
    END
end

/*****************************************************************************************
    Inclusion of the Inv_MovPrice table
******************************************************************************************/
IF @IDDescriptionPrice <> 0
BEGIN
    EXEC sp_Sis_GetNextCode 'Inv_MovPrice.IDMovPrice', @IDMovPrice OUTPUT
    INSERT INTO Inv_MovPrice
        (
        IDMovPrice,
        IDPreInventoryMov,
        IDInventoryMov,
        IDDescriptionPrice,
        IDVendor,
        SuggPrice
        )
        VALUES
        (
        @IDMovPrice,
        @PreInventMovID,
        NULL,
        @IDDescriptionPrice,
        @IDVendorPrice,
        @SuggPrice
        )

    SET @SysError = @@ERROR
    IF @SysError <> 0
    BEGIN
        SET @ErrorLevel = -210
        GOTO ERRO
    END
END

/*****************************************************************************************
    Inclusão na tabela de Inv_MovDocument
******************************************************************************************/
IF @DocumentNumber <> ''
BEGIN
    EXEC sp_Sis_GetNextCode 'Inv_MovDocument.IDMovDocument', @IDMovDocument OUTPUT
    INSERT INTO Inv_MovDocument
        (
        IDMovDocument,
        IDPreInventoryMov,
        IDInventoryMov,
        DocumentNumber,
        DocumentDate,
        DocumentStatus,
        IDDocumentType,
        OBS
        )
        VALUES
        (
        @IDMovDocument,
        @PreInventMovID,
        NULL,
        @DocumentNumber,
        @MovDate,
        1,
        @IDDocumentType,
        NULL
        )

    SET @SysError = @@ERROR
    IF @SysError <> 0
    BEGIN
        SET @ErrorLevel = -211
        GOTO ERRO
    END
END


/*****************************************************************************************
    Inclusão dos Creditos para o modelo caso tenha
******************************************************************************************/
if @IsNewPIM = 1 begin
    EXEC sp_PreSale_AddModelCredit
                @PreInventMovID,
                @IDCliente,
                @UserID,
                @StoreID,
                @MovDate;
end

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
    SET @ErrorLevel = -204
    GOTO ERRO
END


/*****************************************************************************************
    Inclusão de Models de PacketModel
******************************************************************************************/

--Declaração do Cursor de ModelChild

DECLARE ModelChild_Cursor CURSOR FOR

    SELECT
        M.IDModel,
        P.Qty
    FROM
        dbo.PackModel P (NOLOCK)
        JOIN dbo.Model M (NOLOCK) ON (P.IDModel= M.IDModel)
    WHERE
        P.IDPackModel = @ModelID


OPEN ModelChild_Cursor

--Inicialização de ModelChild_Cursor
FETCH NEXT FROM ModelChild_Cursor INTO
    @ModelIDChild,
    @QtyChild

--Enquanto tem registros
WHILE
@@FETCH_STATUS = 0
BEGIN
    EXEC sp_Sis_GetNextCode'PreInventoryMov.IDPreInventoryMov', @PreInvMovIDPack OUTPUT

    INSERT dbo.PreInventoryMov
    (
    IDPreInventoryMov,
    InventMovTypeID,
    IDPessoa,
    DocumentID,
    ModelID,
    StoreID,
    MovDate,
    Qty,
    SalePrice,
    Discount,
    CostPrice,
    UserID,
    IDParentPack,
    IDDepartment
    )
    SELECT
        @PreInvMovIDPack,
        1,
        @IDCliente,
        @PreSaleID,
        @ModelIDChild,
        @StoreID,
        @MovDate,
        @Qty * @QtyChild,--Qtde Comprada x Qtde do Kit
        0,
        0,
        FinalCost,
        @UserID,
        @PreInventMovID,
        @IDDepartment
    FROM
        dbo.Model (NOLOCK)
    WHERE
        dbo.Model.IDModel = @ModelIDChild


    SET @SysError = @@ERROR
    IF @SysError <> 0
    BEGIN
        CLOSE ModelChild_Cursor
        DEALLOCATE ModelChild_Cursor
        SET @ErrorLevel = -203
        GOTO ERRO
    END

    /*****************************************************************************************
                   Inclusão do Comissionado na tabela de SaleItemCommission
        ******************************************************************************************/
        EXEC sp_Sis_GetNextCode'SaleItemCommission.IDSaleItemCommission', @IDSaleItemCommission OUTPUT
        INSERT INTO dbo.SaleItemCommission
    (
     IDSaleItemCommission,
     IDPreInventoryMov,
     IDCommission,
     CommissionPercent
    )
    VALUES
    (
     @IDSaleItemCommission,
     @PreInvMovIDPack,
     @IDComission,
     100
    )

        SET @SysError = @@ERROR
        IF @SysError <> 0
        BEGIN
        SET @ErrorLevel = -209
        GOTO ERRO
        END

    /*****************************************************************************************
        Inclusão dos Creditos dos item do pack caso tenha
    ******************************************************************************************/
    EXEC sp_PreSale_AddModelCredit
            @PreInvMovIDPack,
            @IDCliente,
            @UserID,
            @StoreID,

            @MovDate


    SET @SysError = @@ERROR
    IF @SysError <> 0
    BEGIN
        SET @ErrorLevel = -205
        GOTO ERRO
    END

    --Leitura do Proximo
    FETCH NEXT FROM ModelChild_Cursor INTO
        @ModelIDChild,
        @QtyChild

END
--fechamento do cursor
CLOSE ModelChild_Cursor

--Destruição do cursor
DEALLOCATE ModelChild_Cursor

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
    SET @ErrorLevel = -203
    GOTO ERRO
END


OK:
    --COMMIT TRAN
    RETURN 0
ERRO:
    PRINT CAST(@ErrorLevel AS VARCHAR)
    ROLLBACK TRAN

    DECLARE @ErrorLevelStr varchar(510)
    DECLARE @Params varchar(500)
    SET @Params = ' [ @IDCliente = ' + CAST(@IDCliente AS VARCHAR) + ' @ModelID = ' + CAST(@ModelID AS VARCHAR) +
            ' @StoreID = ' + CAST(@StoreID AS VARCHAR) + ' @UserID = '  + CAST(@UserID AS VARCHAR) +
            ' @IDComission = '  + CAST(@IDComission AS VARCHAR) + ' @Qty = '  + CAST(@Qty AS VARCHAR) +
            ' @IDPreInvMovExchange = '  + CAST(@IDPreInvMovExchange AS VARCHAR) +
            ' @PreInvMovParentID = '  + CAST(@PreInvMovParentID AS VARCHAR) +
            ' @IDDepartment = '  + CAST(@IDDepartment AS VARCHAR) +  ' ] '
    SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR) + @Params
    EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PreSale_SubAddItem', @ErrorLevelStr

    RETURN @ErrorLevel


-- Create sprocs for Sal_Coupon

set xact_abort on;
go
begin tran;
go
if object_id('[sp_PreSale_Coupon_Select]') is not null
    drop procedure [sp_PreSale_Coupon_Select];
if object_id('[sp_PreSale_Coupon_Upsert]') is not null
    drop procedure [sp_PreSale_Coupon_Upsert];
if object_id('[sp_PreSale_Coupon_Delete]') is not null
    drop procedure [sp_PreSale_Coupon_Delete];
go

/*****************************************************************************
 * Stored procedures for the "Sal_Coupon" table.
 ****************************************************************************/

create proc [sp_PreSale_Coupon_Select]
    @DocumentID int,
    @CouponCode nvarchar(255)
as
set nocount on
select
    [DocumentID],
    [CouponCode]
from Sal_Coupon
where
    [DocumentID] = @DocumentID
    and [CouponCode] = @CouponCode
set nocount off
go

create proc [sp_PreSale_Coupon_Upsert]
    @DocumentID int,
    @CouponCode nvarchar(255)
as
merge Sal_Coupon as Target
using (
    select
    @DocumentID,
    @CouponCode
)
as Source (
    [DocumentID],
    [CouponCode]
)
on (
    Target.DocumentID = Source.DocumentID
    and Target.CouponCode = Source.CouponCode
)
when not matched then
    insert (
        [DocumentID],
        [CouponCode]
    )
    values (
        Source.DocumentID,
        Source.CouponCode
    );

go

create proc [sp_PreSale_Coupon_Delete]
    @DocumentID int,
    @CouponCode nvarchar(255)
as
set nocount on

delete from Sal_Coupon where
    [DocumentID] = @DocumentID
    and [CouponCode] = @CouponCode

set nocount off
go

commit tran;

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_PreSale_AddItem]
    (
    @PreSaleID          int,
    @IDCliente      int,
    @ModelID            int,
    @StoreID            int,
    @UserID             int,
    @IDComission        int,
    @Qty                float,
    @SalePrice          money,
    @CostPrice      money,
    @Discount           money,
    @MovDate            smalldatetime,
    @ResetDiscount      bit = 0,
    @Manager        bit = 0,
    @Date           DateTime,
    @IDPreInvMovExchange    int,
    @PreInvMovParentID  int,
    @IDDepartment       int,
    @Promo          bit = 0,
    @IDDescriptionPrice int,
    @IDVendorPrice      int,
    @SuggPrice      int,
    @DocumentNumber     varchar(20),
    @IDDocumentType     int,
    @SequencyNum        int = 0,
    @TotParcial     varchar(10) = NULL,
    @DiscountPromo      money = 0,
    @UnitDiscount money,
    @PreInventMovID     int = null Output,
    @ManualDiscount money = null,
    @IDSpecialPrice int = null,
    @ManualPrice money = null
    )
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------    SUMARIO

        - Tests if the total discount and still valid
        - Includes the movement

    ERROR TABLE FOR RETURN_VALUE

        @Result Ok
        -201  Erro in exec @Result = sp_PreSale_SubTestDiscount
        -202  Erro in exec sp_PreSale_SubResetDiscount
        -203  Erro in exec @Result = sp_PreSale_SubAddItem
        -204  Erro in exec sp_PreSale_SubCalcTotal

    LOG OF CHANGES

    Data            Programmer      Modification
    ----------------------- ----------------------- -----------------------------------------------------------------
    2000-05-15      Eduardo Costa       Creation;
    2001-06-26      Davi Gouveia        Log the Return Values;
    2004-08-18      Rodrigo Costa       Write error log;
    2005-02-01      Rodrigo Costa       New field @IDPreInvMovExchange
    2006-04-12      Leonardo Riego      New field @IDDepartment;
    2006-06-16      Rodrigo Costa       Added the parameters for ErrorHistory
    2007-07-20      Maximiliano Muniz   New parameters @IDDescriptionPrice, @IDVendorPrice and @SuggPrice;
    2007-08-08      Maximiliano Muniz   New parameters @DocumentNumber and @IDDocumentType;
    2009-08-24      Rodrigo Costa       Creation of the parameters for TotParcial and SeqNum PAF-ECF
    2010-01-18      Eliandro Souza      New parameter @DiscountPromo
    2012-12-11      Antonio M F Souza   New parameter @UnitDiscount
    2014-03-13      Nicholas Cook       New parameters @ManualDiscount, @IDSpecialPrice, and @ManualPrice along with
                                        rework of how pricing and discounts are calculated.
    ----------------------------------------------------------------------------------------------------------------- */

DECLARE @Result     int
DECLARE @ErrorLevel int
DECLARE @SysError   int

SET @ErrorLevel = 0

BEGIN TRAN

if (@ManualDiscount = 0)
BEGIN
  SET @ManualDiscount = NULL;
END

EXEC @Result = sp_PreSale_SubAddItem
                    @PreSaleID,
                    @IDCliente,
                    @ModelID,
                    @StoreID,
                    @UserID,
                    @IDComission,
                    @Qty,
                    @SalePrice,
                    @CostPrice,
                    @Discount,
                    @MovDate,
                    @IDPreInvMovExchange,
                    @PreInvMovParentID,
                    @IDDepartment,
                    @Promo,
                    @IDDescriptionPrice,
                    @IDVendorPrice,
                    @SuggPrice,
                    @DocumentNumber,
                    @IDDocumentType,
                    @SequencyNum,
                    @TotParcial,
                    @DiscountPromo,
                    @UnitDiscount,
                    @PreInventMovID Output,
                    @ManualDiscount,
                    @IDSpecialPrice,
                    @ManualPrice

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
    SET @ErrorLevel = -203
    GOTO ERRO
END

if @Result <> 0
    rollback tran
else
    exec sp_PreSale_SubCalcTotal @PreSaleID, @Date

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
    SET @ErrorLevel = -204
    GOTO ERRO
END


OK:
    COMMIT TRAN
    RETURN 0
ERRO:
    ROLLBACK TRAN
    PRINT CAST(@ErrorLevel AS VARCHAR)

    DECLARE @ErrorLevelStr varchar(510)
    DECLARE @Params varchar(500)
    SET @Params = ' [ @IDCliente = ' + CAST(@IDCliente AS VARCHAR) + ' @ModelID = ' + CAST(@ModelID AS VARCHAR) +
            ' @StoreID = ' + CAST(@StoreID AS VARCHAR) + ' @UserID = '  + CAST(@UserID AS VARCHAR) +
            ' @IDComission = '  + CAST(@IDComission AS VARCHAR) + ' @Qty = '  + CAST(@Qty AS VARCHAR) +
            ' @IDPreInvMovExchange = '  + CAST(@IDPreInvMovExchange AS VARCHAR) +
            ' @IDDepartment = '  + CAST(@IDDepartment AS VARCHAR) +  ' ] '
    SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR) + @Params
    EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PreSale_AddItem', @ErrorLevelStr

    RETURN @ErrorLevel

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
ALTER  PROCEDURE [dbo].[sp_PreSale_SubCalcItemDiscount]
        (
            @PreSaleID Int
        )
AS
return 0;
go

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    SUMARIO

        - Atualizo Invoice

    TABELA DE ERROS PARA RETURN_VALUE

         000  Ok
        -201  Erro no Update


    LOG DE MODIFICA��ES

    Data            Programador     Modifica��o
    --------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
    15 May  2000        Eduardo Costa       Criacao;
    26 June 2001        Davi Gouveia        Log de Return Values
    18 Aug 2004     Rodrigo Costa       Gravar error log
    26 Oct  2004        Carlos Lima     Calcular Discount, incluindo os Invoices filhos
    20 Jan  2005        Rodrigo Costa       Calcular Discount pegando os valores do InventoryMov
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

/*
 * It is thought that this may no longer be needed, but until further testing
 * is done, we'll just comment it out for now:

DECLARE @ErrorLevel int
DECLARE @SysError   int
DECLARE @TotalDiscount  money
DECLARE @TotalDiscExemp money

SET @ErrorLevel = 0

--Valores do PreInventoryMov
SET @TotalDiscount =
        IsNull((
        SELECT
            Sum(IsNull(PIM.Discount,0))
        FROM
            Invoice INV (NOLOCK)
            JOIN
            PreInventoryMov PIM (NOLOCK)
                ON (INV.IDPreSale = PIM.DocumentID)
            JOIN
            Model MO (NOLOCK)
                ON (PIM.ModelID = MO.IDModel)
            JOIN
            TabGroup TG (NOLOCK)
                ON (MO.GroupID = TG.IDGroup)
        WHERE
            (
                INV.IDPreSale = @PreSaleID
                OR
                INV.IDPreSaleParent = @PreSaleID-- Calcula todos os invoices filhos deste PreSale
            )
            AND
            PIM.InventMovTypeID = 1
            AND
            TG.Taxable = 1
        ),0)

SET @TotalDiscExemp =
        IsNull((
            SELECT
                Sum(IsNull(PIM.Discount,0))
            FROM
                Invoice INV (NOLOCK)
                JOIN
                PreInventoryMov PIM (NOLOCK)
                    ON (INV.IDPreSale = PIM.DocumentID)
                JOIN
                Model MO (NOLOCK)
                    ON (PIM.ModelID = MO.IDModel)
                JOIN
                TabGroup TG (NOLOCK)
                    ON (MO.GroupID = TG.IDGroup)
            WHERE
                (
                    INV.IDPreSale = @PreSaleID
                    OR
                    INV.IDPreSaleParent = @PreSaleID-- Calcula todos os invoices filhos deste PreSale
                )
                AND
                PIM.InventMovTypeID = 1
                AND
                TG.Taxable = 0
        ),0)


--Valores do InventoryMov
SET @TotalDiscount = @TotalDiscount +
        IsNull((
        SELECT
            Sum(IsNull(IM.Discount,0))
        FROM
            Invoice INV (NOLOCK)
            JOIN
            InventoryMov IM (NOLOCK)
                ON (INV.IDInvoice = IM.DocumentID)
            JOIN
            Model MO (NOLOCK)
                ON (IM.ModelID = MO.IDModel)
            JOIN
            TabGroup TG (NOLOCK)
                ON (MO.GroupID = TG.IDGroup)
        WHERE
            (
                INV.IDPreSale = @PreSaleID
                OR
                INV.IDPreSaleParent = @PreSaleID-- Calcula todos os invoices filhos deste PreSale
            )
            AND
            IM.InventMovTypeID = 1
            AND
            TG.Taxable = 1
        ),0)

SET @TotalDiscExemp = @TotalDiscExemp +
        IsNull((
            SELECT
                Sum(IsNull(IM.Discount,0))
            FROM
                Invoice INV (NOLOCK)
                JOIN
                InventoryMov IM (NOLOCK)
                    ON (INV.IDInvoice = IM.DocumentID)
                JOIN
                Model MO (NOLOCK)
                    ON (IM.ModelID = MO.IDModel)
                JOIN
                TabGroup TG (NOLOCK)
                    ON (MO.GroupID = TG.IDGroup)
            WHERE
                (
                    INV.IDPreSale = @PreSaleID
                    OR
                    INV.IDPreSaleParent = @PreSaleID-- Calcula todos os invoices filhos deste PreSale
                )
                AND
                IM.InventMovTypeID = 1
                AND
                TG.Taxable = 0
        ),0)


UPDATE
    dbo.Invoice
SET
    dbo.Invoice.ItemDiscount = Round(@TotalDiscount,4),
        --convert(money, convert(numeric(20, 0), @TotalDiscount * 100) / 100),

    dbo.Invoice.TaxIsemptItemDiscount = Round(@TotalDiscExemp,4)
        --convert(money, convert(numeric(20, 0), @TotalDiscExemp * 100) / 100)
WHERE
    dbo.Invoice.IDPreSale = @PreSaleID

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
    SET @ErrorLevel = -201
    GOTO ERRO
END


OK:
    RETURN 0
ERRO:
    PRINT CAST(@ErrorLevel AS VARCHAR)

    DECLARE @ErrorLevelStr varchar(10)
    SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
    EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PreSale_SubCalcItemDiscount', @ErrorLevelStr

    RETURN @ErrorLevel
GO
*/

/*
 * Usage: exec sp_PreSale_SetDiscount @DocumentID = 123;
 * @DocumentID (int): Indicates which PreInventoryMov lines will be used.
 * This sproc updates PIM (PreInventoryMov). For a read-only equivalent:
 *     select *
 *     from vw_PreInventoryMovWithDiscounts
 *     where DocumentID = @DocumentID;
 * Author: Daniel Browning <dbrowning@pinogy.com>
 */
if object_id(N'sp_PreSale_SetDiscount', N'P') is not null
    drop proc sp_PreSale_SetDiscount;
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
    --declare @Discount money;
    --declare @InvoiceItemDiscount money;
    declare @discounts cursor;
    -- The fast_forward is a performance optimization since we only need to
    -- read through once and do read only operations.
    set @discounts = cursor fast_forward for
        select IDPreInventoryMov, UnitDiscount
        from vw_SelectFinalDiscounts
        where DocumentID = @DocumentID;
    open @discounts
    fetch next from @discounts into @IDPreInventoryMov, @UnitDiscount;

    while @@fetch_status = 0
    begin
        update PreInventoryMov
        set UnitDiscount = @UnitDiscount
        where IDPreInventoryMov = @IDPreInventoryMov
            -- Avoid duplicate I/O when the new discount is the same as the old.
            -- The coalesce() causes the result to be the same even with nulls.
            --and coalesce(UnitDiscount, 0) <> coalesce(@UnitDiscount, 0);

        fetch next from @discounts into @IDPreInventoryMov, @UnitDiscount;
    end
    close @discounts;
    deallocate @discounts;

    with DiscountUpdates as (
        select PIM.IDPreInventoryMov, PIM.UnitDiscount, PIM.Discount,
            MD.ManualDiscount, MD.ManualDiscount * PIM.Qty as ManualDiscountExt
        from ManualDiscount MD
        join PreInventoryMov PIM
            on (PIM.IDPreInventoryMov = MD.IDPreInventoryMov)
        where PIM.DocumentID = @DocumentID
    )
    update DiscountUpdates
    set UnitDiscount = ManualDiscount, Discount = ManualDiscountExt;

    update PreInventoryMov
    set Discount = UnitDiscount * Qty
    where DocumentID = @DocumentID;

    update Invoice
    set ItemDiscount = (
        select sum(Discount) as ItemDiscount
        from PreInventoryMov
        where DocumentID = @DocumentID
    )
    where IDPreSale = @DocumentID;



    return 0;
go
if object_id('vw_TagsWithAttrs') is not null drop view vw_TagsWithAttrs;
go

create view vw_TagsWithAttrs as
    with TagsAndPriceBreaks as (
        select
            Tag.IDTag,
            case when TQPB.IDTag is not null then 1 else 0 end
                as HasQtyPriceBreak
        from Tag
        left join TagQtyPriceBreak TQPB on (TQPB.IDTag = Tag.IDTag)
    ),
    TagsAndPriceBreaksGrouped as (
        select IDTag, cast(HasQtyPriceBreak as bit) as HasQtyPriceBreak
        from TagsAndPriceBreaks
        group by IDTag, HasQtyPriceBreak
    ),
    TagsWithAttrsFinal as (
        select TagsAndPriceBreaksGrouped.*, Tag.TagName
        from TagsAndPriceBreaksGrouped
        join Tag on (TagsAndPriceBreaksGrouped.IDTag = Tag.IDTag)
    )
    select * from TagsWithAttrsFinal;
go

if object_id('vw_TagsWithAttrsAndModels') is not null
    drop view vw_TagsWithAttrsAndModels;
go

create view vw_TagsWithAttrsAndModels as
    select vw_TagsWithAttrs.*, TagModel.IDModel, TagModel.PKTagModel
    from vw_TagsWithAttrs
    left join TagModel on (TagModel.IDTag = vw_TagsWithAttrs.IDTag);
go

if object_id('vw_ModelDiscountSummaries') is not null
    drop view vw_ModelDiscountSummaries;
go

create view vw_ModelDiscountSummaries as
    select TM.IDModel, D.IDDiscount, D.DiscountName, D.AmountType,
        D.RewardAmount
    from Discounts D
    join DiscQualifyingTags DQT on (DQT.IDDiscount = D.IDDiscount)
    join TagModel TM on (TM.IDTag = DQT.IDTag);
go


-- For testing:
/*

begin tran;
go

set identity_insert Tag on;

set nocount on;
insert into Tag (IDTag, TagName) values
    (100001, 'Test1'),
    (100002, 'Test2');

insert into TagModel (IDTag, IDModel) values
    (100001, 4),
    (100001, 5),
    (100001, 6),
    (100002, 9),
    (100002, 10),
    (100002, 10);

insert into TagQtyPriceBreak (IDTag, MinQuantity, Discount) values
    (100001, 5,   0.90),
    (100001, 20,  0.80),
    (100001, 100, 0.70),
    --
    (100002, 4,   0.95),
    (100002, 16,  0.90),
    (100002, 64,  0.85);


select * from vw_TagsWithAttrs;
select * from vw_TagsWithAttrsAndModels;

rollback;
*/

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER  PROCEDURE [dbo].[sp_UpdateSystemQty]
AS

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--  Recalculo dos saldos do sistema.
--  Não faz parte da operação normal do sistema.
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--     CLEAR DOS SALDOS
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

UPDATE
    I
SET
    I.QtyOnHand = 0,
    I.QtyOnOrder = 0,
    I.QtyOnPreSale = 0,
    I.QtyOnPrePurchase =0 ,
    I.QtyOnRepair = 0
FROM
    Inventory I (NOLOCK)

UPDATE
    IMT
SET
    IMT.TotQty = 0,
    IMT.TotCost = 0,
    IMT.TotSale = 0
FROM
    InventoryMovTotal IMT (NOLOCK)


UPDATE
    M
SET
    M.TotQtyOnHand = 0,
    M.TotQtyOnOrder = 0,
    M.TotQtyOnPreSale = 0,
    M.TotQtyOnPrePurchase =0,
    M.TotQtyOnRepair = 0
FROM
    Model M



---###################################################################################################
-- ###### PreInventoryMov atualiza as Qty
---###################################################################################################

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--     INVENTORY
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
UPDATE
    I
SET
    I.QtyOnHand         = IsNull(I.QtyOnHand, 0) + Total.OnHand,
    I.QtyOnOrder        = IsNull(I.QtyOnOrder, 0) + Total.OnOrder,
    I.QtyOnRepair       = IsNull(I.QtyOnRepair, 0) + Total.OnRepair,
    I.QtyOnPrePurchase  = IsNull(I.QtyOnPrePurchase, 0) + Total.OnPrePurchase,
    I.QtyOnPreSale      = IsNull(I.QtyOnPreSale, 0) + Total.OnPreSale

FROM
    (
    SELECT
        ModelID,
        StoreID,
        SUM( IsNull(PIM.Qty * (2*IMT.UpdatePreOnHand-1), 0) ) as OnHand,
        SUM( IsNull((PIM.Qty - IsNull(PIM.QtyRealMov,0)) * (2*IMT.UpdatePreOnOrder-1), 0) ) as OnOrder,
        SUM( IsNull(PIM.Qty * (2*IMT.UpdatePreOnRepair-1), 0) ) as OnRepair,
        SUM( IsNull(PIM.Qty * (2*IMT.UpdatePreOnPrePurchase-1), 0) ) as OnPrePurchase,
        SUM( IsNull(PIM.Qty * (2*IMT.UpdatePreOnPreSale-1), 0) ) as OnPreSale
    FROM
        PreInventoryMov PIM (NOLOCK)
        JOIN InventoryMovType IMT (NOLOCK) ON (PIM.InventMovTypeID = IMT.IDInventMovType)
        JOIN Model M on (PIM.ModelID = M.IDModel)
    WHERE
        --PIM.InventMovTypeID = 1       AND
        PIM.ModelID IS NOT NULL     AND
        PIM.StoreID IS NOT NULL     AND
        M.Desativado = 0
    GROUP BY
        ModelID,
        StoreID
    ) Total
    JOIN Inventory I ON (Total.ModelID = I.ModelID AND Total.StoreID = I.StoreID)


----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--     INVENTORY MASTER
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

UPDATE
    I
SET
    I.QtyOnHand         = IsNull(I.QtyOnHand, 0) + Total.OnHand,
    I.QtyOnOrder        = IsNull(I.QtyOnOrder, 0) + Total.OnOrder,
    I.QtyOnRepair       = IsNull(I.QtyOnRepair, 0) + Total.OnRepair,
    I.QtyOnPrePurchase  = IsNull(I.QtyOnPrePurchase, 0) + Total.OnPrePurchase,
    I.QtyOnPreSale      = IsNull(I.QtyOnPreSale, 0) + Total.OnPreSale
FROM
    (
    SELECT
        M.IDModelParent as ModelID,
        PIM.StoreID,

        SUM( IsNull(PIM.Qty * (2*IMT.UpdatePreOnHand-1), 0) ) as OnHand,
        SUM( IsNull((PIM.Qty - IsNull(PIM.QtyRealMov,0)) * (2*IMT.UpdatePreOnOrder-1), 0) ) as OnOrder,
        SUM( IsNull(PIM.Qty * (2*IMT.UpdatePreOnRepair-1), 0) ) as OnRepair,
        SUM( IsNull(PIM.Qty * (2*IMT.UpdatePreOnPrePurchase-1), 0) ) as OnPrePurchase,
        SUM( IsNull(PIM.Qty * (2*IMT.UpdatePreOnPreSale-1), 0) ) as OnPreSale
    FROM
        PreInventoryMov PIM (NOLOCK)
        JOIN Model M (NOLOCK) ON (PIM.ModelID = M.IDModel)
        JOIN InventoryMovType IMT (NOLOCK) ON (PIM.InventMovTypeID = IMT.IDInventMovType)
    WHERE
        M.IDModelParent IS NOT NULL
        AND M.Desativado = 0
    GROUP BY
        M.IDModelParent,
        PIM.StoreID
    ) Total
    JOIN Inventory I ON (Total.ModelID = I.ModelID AND Total.StoreID = I.StoreID)



----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--  MODEL TOTAL
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------


UPDATE
    M
SET
    M.TotQtyOnHand      = IsNull(M.TotQtyOnHand, 0) + Total.OnHand,
    M.TotQtyOnOrder     = IsNull(M.TotQtyOnOrder, 0) + Total.OnOrder,
    M.TotQtyOnRepair    = IsNull(M.TotQtyOnRepair, 0) + Total.OnRepair,
    M.TotQtyOnPrePurchase   = IsNull(M.TotQtyOnPrePurchase, 0) + Total.OnPrePurchase,
    M.TotQtyOnPreSale   = IsNull(M.TotQtyOnPreSale, 0) + Total.OnPreSale
FROM
    (
    SELECT
        ModelID,
        SUM( IsNull(PIM.Qty * (2*IMT.UpdatePreOnHand-1), 0) ) as OnHand,
        SUM( IsNull((PIM.Qty - IsNull(PIM.QtyRealMov,0)) * (2*IMT.UpdatePreOnOrder-1), 0) ) as OnOrder,
        SUM( IsNull(PIM.Qty * (2*IMT.UpdatePreOnRepair-1), 0) ) as OnRepair,
        SUM( IsNull(PIM.Qty * (2*IMT.UpdatePreOnPrePurchase-1), 0) ) as OnPrePurchase,
        SUM( IsNull(PIM.Qty * (2*IMT.UpdatePreOnPreSale-1), 0) ) as OnPreSale
    FROM
        PreInventoryMov PIM (NOLOCK)
        JOIN InventoryMovType IMT (NOLOCK) ON (PIM.InventMovTypeID = IMT.IDInventMovType)
        JOIN Model M (NOLOCK) ON (PIM.ModelID = M.IDModel)
    WHERE
        M.Desativado = 0
    GROUP BY
        ModelID
    ) Total
    JOIN Model M ON (Total.ModelID = M.IDModel)

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--  MODEL MASTER TOTAL
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

UPDATE  M
SET
    M.TotQtyOnHand      = IsNull(M.TotQtyOnHand, 0) + Total.OnHand,
    M.TotQtyOnOrder     = IsNull(M.TotQtyOnOrder, 0) + Total.OnOrder,
    M.TotQtyOnRepair        = IsNull(M.TotQtyOnRepair, 0) + Total.OnRepair,
    M.TotQtyOnPrePurchase       = IsNull(M.TotQtyOnPrePurchase, 0) + Total.OnPrePurchase,
    M.TotQtyOnPreSale       = IsNull(M.TotQtyOnPreSale, 0) + Total.OnPreSale
FROM
    (
    SELECT
        IDModelParent,
        SUM( IsNull(PIM.Qty * (2*IMT.UpdatePreOnHand-1), 0) ) as OnHand,
        SUM( IsNull((PIM.Qty - IsNull(PIM.QtyRealMov,0)) * (2*IMT.UpdatePreOnOrder-1), 0) ) as OnOrder,
        SUM( IsNull(PIM.Qty * (2*IMT.UpdatePreOnRepair-1), 0) ) as OnRepair,
        SUM( IsNull(PIM.Qty * (2*IMT.UpdatePreOnPrePurchase-1), 0) ) as OnPrePurchase,
        SUM( IsNull(PIM.Qty * (2*IMT.UpdatePreOnPreSale-1), 0) ) as OnPreSale
    FROM
        PreInventoryMov PIM (NOLOCK)
        JOIN Model M (NOLOCK) ON (PIM.ModelID = M.IDModel)
        JOIN InventoryMovType IMT (NOLOCK) ON (PIM.InventMovTypeID = IMT.IDInventMovType)
    WHERE
        M.IDModelParent IS NOT NULL AND
        M.Desativado = 0
    GROUP BY
        IDModelParent
    ) Total
    JOIN Model M ON (Total.IDModelParent = M.IDModel)


---###################################################################################################
-- ###### Inventory atualiza as Qty
---###################################################################################################


----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--     INVENTORY
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

UPDATE
    I
SET
    I.QtyOnHand         = IsNull(I.QtyOnHand, 0) + Total.OnHand,
    I.QtyOnOrder        = IsNull(I.QtyOnOrder, 0) + Total.OnOrder,
    I.QtyOnRepair       = IsNull(I.QtyOnRepair, 0) + Total.OnRepair,
    I.QtyOnPrePurchase  = IsNull(I.QtyOnPrePurchase, 0) + Total.OnPrePurchase,
    I.QtyOnPreSale      = IsNull(I.QtyOnPreSale, 0) + Total.OnPreSale
FROM
    (
    SELECT
        ModelID,
        StoreID,
        SUM( IsNull(IM.Qty * (2*IMT.UpdateOnHand-1), 0) ) as OnHand,
        SUM( IsNull(IM.Qty * (2*IMT.UpdateOnOrder-1), 0) ) as OnOrder,
        SUM( IsNull(IM.Qty * (2*IMT.UpdateOnRepair-1), 0) ) as OnRepair,
        SUM( IsNull(IM.Qty * (2*IMT.UpdateOnPrePurchase-1), 0) ) + IsNull(PPI.Qty,0) as OnPrePurchase,
        SUM( IsNull(IM.Qty * (2*IMT.UpdateOnPreSale-1), 0) ) as OnPreSale
    FROM
        InventoryMov IM (NOLOCK)
        JOIN InventoryMovType IMT (NOLOCK) ON (IM.InventMovTypeID = IMT.IDInventMovType)
        JOIN Model M on (IM.ModelID = M.IDModel)
        LEFT JOIN (
                SELECT
                    PPI.IDModel,
                    PU.IDStore,
                    SUM(Qty - IsNull(QtyRet,0)) as Qty
                FROM
                    Pur_PurchaseItem PPI (NOLOCK)
                    JOIN Pur_Purchase PU (NOLOCK) ON (PU.IDPurchase = PPI.IDPurchase)
                WHERE
                    DateFinalReceiving IS NULL
                GROUP BY
                    PPI.IDModel,
                    PU.IDStore
            ) PPI ON (PPI.IDModel = IM.ModelID AND PPI.IDStore = IM.StoreID)
        WHERE M.Desativado = 0
    GROUP BY
        ModelID,
        StoreID,
        PPI.Qty
    ) Total
    JOIN Inventory I ON (Total.ModelID = I.ModelID AND Total.StoreID = I.StoreID)


----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--     INVENTORY MASTER
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

UPDATE
    I
SET
    I.QtyOnHand         = IsNull(I.QtyOnHand, 0) + Total.OnHand,
    I.QtyOnOrder        = IsNull(I.QtyOnOrder, 0) + Total.OnOrder,
    I.QtyOnRepair       = IsNull(I.QtyOnRepair, 0) + Total.OnRepair,
    I.QtyOnPrePurchase  = IsNull(I.QtyOnPrePurchase, 0) + Total.OnPrePurchase,
    I.QtyOnPreSale      = IsNull(I.QtyOnPreSale, 0) + Total.OnPreSale
FROM
    (
    SELECT
        M.IDModelParent as ModelID,
        StoreID,
        SUM( IsNull(IM.Qty * (2*IMT.UpdateOnHand-1), 0) ) as OnHand,
        SUM( IsNull(IM.Qty * (2*IMT.UpdateOnOrder-1), 0) ) as OnOrder,
        SUM( IsNull(IM.Qty * (2*IMT.UpdateOnRepair-1), 0) ) as OnRepair,
        (SUM( IsNull(IM.Qty * (2*IMT.UpdateOnPrePurchase-1), 0) ) + IsNull(PPI.Qty,0)) as OnPrePurchase,
        SUM( IsNull(IM.Qty * (2*IMT.UpdateOnPreSale-1), 0) ) as OnPreSale
    FROM
        InventoryMov IM (NOLOCK)
        JOIN Model M (NOLOCK) ON (IM.ModelID = M.IDModel)
        JOIN InventoryMovType IMT (NOLOCK) ON (IM.InventMovTypeID = IMT.IDInventMovType)
        LEFT JOIN (
                SELECT
                    PPI.IDModel,
                    PU.IDStore,
                    SUM(Qty - IsNull(QtyRet,0)) as Qty
                FROM
                    Pur_PurchaseItem PPI (NOLOCK)
                    JOIN Pur_Purchase PU (NOLOCK) ON (PU.IDPurchase = PPI.IDPurchase)
                WHERE
                    DateFinalReceiving IS NULL
                GROUP BY
                    PPI.IDModel,
                    PU.IDStore
            ) PPI ON (PPI.IDModel = IM.ModelID AND PPI.IDStore = IM.StoreID)
    WHERE
        M.IDModelParent IS NOT NULL
        AND M.Desativado = 0
    GROUP BY
        M.IDModelParent,
        StoreID,
        PPI.Qty
    ) Total
    JOIN Inventory I ON (Total.ModelID = I.ModelID AND Total.StoreID = I.StoreID)



----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--  MODEL TOTAL
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------


UPDATE
    M
SET
    M.TotQtyOnHand      = IsNull(M.TotQtyOnHand, 0) + Total.OnHand,
    M.TotQtyOnOrder     = IsNull(M.TotQtyOnOrder, 0) + Total.OnOrder,
    M.TotQtyOnRepair    = IsNull(M.TotQtyOnRepair, 0) + Total.OnRepair,
    M.TotQtyOnPrePurchase   = IsNull(M.TotQtyOnPrePurchase, 0) + Total.OnPrePurchase,
    M.TotQtyOnPreSale   = IsNull(M.TotQtyOnPreSale, 0) + Total.OnPreSale
FROM
    (
    SELECT
        ModelID,
        SUM( IsNull(IM.Qty * (2*IMT.UpdateOnHand-1), 0) ) as OnHand,
        SUM( IsNull(IM.Qty * (2*IMT.UpdateOnOrder-1), 0) ) as OnOrder,
        SUM( IsNull(IM.Qty * (2*IMT.UpdateOnRepair-1), 0) ) as OnRepair,
        SUM( IsNull(IM.Qty * (2*IMT.UpdateOnPrePurchase-1), 0) ) + IsNull(PPI.Qty, 0) as OnPrePurchase,
        SUM( IsNull(IM.Qty * (2*IMT.UpdateOnPreSale-1), 0) ) as OnPreSale
    FROM
        InventoryMov IM (NOLOCK)
        JOIN InventoryMovType IMT (NOLOCK)  ON (IM.InventMovTypeID = IMT.IDInventMovType)
        JOIN Model M on (IM.ModelID = M.IDModel)
        LEFT JOIN (
                SELECT
                    PPI.IDModel,
                    SUM(Qty - IsNull(QtyRet,0)) as Qty
                FROM
                    Pur_PurchaseItem PPI (NOLOCK)
                    JOIN Pur_Purchase PU (NOLOCK) ON (PU.IDPurchase = PPI.IDPurchase)
                WHERE
                    DateFinalReceiving IS NULL
                GROUP BY
                    PPI.IDModel,
                    PU.IDStore
            ) PPI ON (PPI.IDModel = IM.ModelID)
        WHERE M.Desativado = 0
    GROUP BY
        ModelID,
        PPI.Qty
    ) Total
    JOIN Model M ON (Total.ModelID = M.IDModel)



----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--  MODEL MASTER TOTAL
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
UPDATE
    M
SET
    M.TotQtyOnHand      = IsNull(M.TotQtyOnHand, 0) + Total.OnHand,
    M.TotQtyOnOrder     = IsNull(M.TotQtyOnOrder, 0) + Total.OnOrder,
    M.TotQtyOnRepair    = IsNull(M.TotQtyOnRepair, 0) + Total.OnRepair,
    M.TotQtyOnPrePurchase   = IsNull(M.TotQtyOnPrePurchase, 0) + Total.OnPrePurchase,
    M.TotQtyOnPreSale   = IsNull(M.TotQtyOnPreSale, 0) + Total.OnPreSale
FROM
    (
    SELECT
        IDModelParent,
        SUM( IsNull(IM.Qty * (2*IMT.UpdateOnHand-1), 0) ) as OnHand,
        SUM( IsNull(IM.Qty * (2*IMT.UpdateOnOrder-1), 0) ) as OnOrder,
        SUM( IsNull(IM.Qty * (2*IMT.UpdateOnRepair-1), 0) ) as OnRepair,
        SUM( IsNull(IM.Qty * (2*IMT.UpdateOnPrePurchase-1), 0) ) as OnPrePurchase,
        SUM( IsNull(IM.Qty * (2*IMT.UpdateOnPreSale-1), 0) ) as OnPreSale
    FROM
        InventoryMov IM (NOLOCK)
        JOIN Model M (NOLOCK) ON (IM.ModelID = M.IDModel)
        JOIN InventoryMovType IMT (NOLOCK) ON (IM.InventMovTypeID = IMT.IDInventMovType)

    WHERE
        M.IDModelParent IS NOT NULL AND
        M.Desativado = 0

    GROUP BY
        IDModelParent
    ) Total
    JOIN Model M ON (Total.IDModelParent = M.IDModel)

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--  MODEL: Atualiza o InventoryMovTotals
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
UPDATE
    IMT
SET
    IMT.TotQty = IsNull(IMT.TotQty, 0) + Total.Qty,
    IMT.TotSale = IsNull(IMT.TotSale, 0) + Total.Sale,
    IMT.TotCost = IsNull(IMT.TotCost, 0) + Total.Cost
FROM
    (
    SELECT
        IM.StoreID,
        IM.ModelID,
        IM.InventMovTypeID,
        DatePart(yy, IM.MovDate) as [Year],
        DatePart(mm, IM.MovDate) as [Month],
        SUM( IsNull( IM.Qty, 0 ) ) as Qty,
        SUM( IsNull( IM.Qty * IM.SalePrice, 0 )  - IsNull(IM.Discount , 0) ) as Sale,
        SUM( IsNull( IM.Qty * IM.CostPrice, 0) ) as Cost
    FROM
        InventoryMov IM (NOLOCK)
    GROUP BY
        IM.StoreID,
        IM.ModelID,
        IM.InventMovTypeID,
        DatePart(yy, IM.MovDate),
        DatePart(mm, IM.MovDate)
    ) as Total
    JOIN InventoryMovTotal IMT  (NOLOCK)
        ON (    Total.StoreID = IMT.StoreID
            AND
            Total.ModelID = IMT.ModelID
            AND
            Total.InventMovTypeID = IMT.InventMovTypeID
            AND
            Total.[Year] = IMT.[Year]
            AND
            Total.[Month] = IMT.[Month] )

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--  MASTER: Atualiza o InventoryMovTotals
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
UPDATE
    IMT
SET
    IMT.TotQty = IsNull(IMT.TotQty, 0) + Total.Qty,
    IMT.TotSale = IsNull(IMT.TotSale, 0) + Total.Sale,
    IMT.TotCost = IsNull(IMT.TotCost, 0) + Total.Cost
FROM
    (
    SELECT
        IM.StoreID,
        M.IDModelParent as ModelID,
        IM.InventMovTypeID,
        DatePart(yy, IM.MovDate) as [Year],
        DatePart(mm, IM.MovDate) as [Month],
        SUM( IsNull( IM.Qty, 0 ) ) as Qty,
        SUM( IsNull( IM.Qty * IM.SalePrice, 0 )  - IsNull(IM.Discount , 0) ) as Sale,
        SUM( IsNull( IM.Qty * IM.CostPrice, 0) ) as Cost
    FROM
        InventoryMov IM (NOLOCK)
        JOIN Model M (NOLOCK) ON (IM.ModelID = M.IDModel)
    WHERE
        M.IDModelParent IS NOT NULL
    GROUP BY
        IM.StoreID,
        M.IDModelParent,
        IM.InventMovTypeID,
        DatePart(yy, IM.MovDate),
        DatePart(mm, IM.MovDate)
    ) as Total
    JOIN InventoryMovTotal IMT
        ON (    Total.StoreID = IMT.StoreID
            AND
            Total.ModelID = IMT.ModelID
            AND
            Total.InventMovTypeID = IMT.InventMovTypeID
            AND
            Total.[Year] = IMT.[Year]
            AND
            Total.[Month] = IMT.[Month] )
GO