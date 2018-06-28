USE [MainRetailDB]
GO

/****** Object:  View [dbo].[vw_All_Discounts]    Script Date: 05/18/2016 21:46:05 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_All_Discounts]'))
DROP VIEW [dbo].[vw_All_Discounts]
GO


/****** Object:  View [dbo].[vw_All_Discounts]    Script Date: 05/18/2016 21:46:05 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE view [dbo].[vw_All_Discounts] as
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

GO

/****** Object:  View [dbo].[vw_CalcCustomerDiscounts]    Script Date: 05/18/2016 23:45:15 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_CalcCustomerDiscounts]'))
DROP VIEW [dbo].[vw_CalcCustomerDiscounts]
GO


/****** Object:  View [dbo].[vw_CalcCustomerDiscounts]    Script Date: 05/18/2016 23:45:15 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE view [dbo].[vw_CalcCustomerDiscounts] as
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

GO

/****** Object:  View [dbo].[vw_DiscTimeRestrictions]    Script Date: 05/18/2016 23:46:38 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_DiscTimeRestrictions]'))
DROP VIEW [dbo].[vw_DiscTimeRestrictions]
GO


/****** Object:  View [dbo].[vw_DiscTimeRestrictions]    Script Date: 05/18/2016 23:46:38 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

create view [dbo].[vw_DiscTimeRestrictions] as
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

GO

/****** Object:  View [dbo].[vw_DiscDayRestrictions]    Script Date: 05/18/2016 23:47:30 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_DiscDayRestrictions]'))
DROP VIEW [dbo].[vw_DiscDayRestrictions]
GO


/****** Object:  View [dbo].[vw_DiscDayRestrictions]    Script Date: 05/18/2016 23:47:30 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

create view [dbo].[vw_DiscDayRestrictions] as
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

GO

/****** Object:  View [dbo].[vw_DiscSubTotalRestriction]    Script Date: 05/18/2016 23:48:18 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_DiscSubTotalRestriction]'))
DROP VIEW [dbo].[vw_DiscSubTotalRestriction]
GO


/****** Object:  View [dbo].[vw_DiscSubTotalRestriction]    Script Date: 05/18/2016 23:48:18 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

create view [dbo].[vw_DiscSubTotalRestriction] as
    select DocumentID, IDPreInventoryMov, IDDiscount
    from vw_All_Discounts
    where (MinSubtotal is null or MinSubtotal <= Subtotal)
        and (MinDollarAmount is null or MinDollarAmount <= Subtotal);

GO

/****** Object:  View [dbo].[vw_ValidDiscStores]    Script Date: 05/18/2016 23:49:54 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_ValidDiscStores]'))
DROP VIEW [dbo].[vw_ValidDiscStores]
GO

/****** Object:  View [dbo].[vw_ValidDiscStores]    Script Date: 05/18/2016 23:49:54 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

create view [dbo].[vw_ValidDiscStores] as
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

GO

/****** Object:  View [dbo].[vw_ValidMinQuantityDiscounts]    Script Date: 05/18/2016 23:50:44 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_ValidMinQuantityDiscounts]'))
DROP VIEW [dbo].[vw_ValidMinQuantityDiscounts]
GO

/****** Object:  View [dbo].[vw_ValidMinQuantityDiscounts]    Script Date: 05/18/2016 23:50:44 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

create view [dbo].[vw_ValidMinQuantityDiscounts] as
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

GO

/****** Object:  View [dbo].[vw_ValidCustGroupsDiscounts]    Script Date: 05/18/2016 23:51:52 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_ValidCustGroupsDiscounts]'))
DROP VIEW [dbo].[vw_ValidCustGroupsDiscounts]
GO


/****** Object:  View [dbo].[vw_ValidCustGroupsDiscounts]    Script Date: 05/18/2016 23:51:52 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

create view [dbo].[vw_ValidCustGroupsDiscounts] as
    select AD.DocumentID, AD.IDPreInventoryMov, AD.IDDiscount
    from vw_All_Discounts AD
    left join DiscAllowedCustGroups ACG on (ACG.IDDiscount = AD.IDDiscount)
    where ACG.IDTipoPessoa is null or ACG.IDTipoPessoa = AD.IDTipoPessoa
    group by AD.DocumentID, AD.IDPreInventoryMov, AD.IDDiscount;

GO

/****** Object:  View [dbo].[vw_ValidCustRestrDiscounts]    Script Date: 05/18/2016 23:52:43 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_ValidCustRestrDiscounts]'))
DROP VIEW [dbo].[vw_ValidCustRestrDiscounts]
GO

/****** Object:  View [dbo].[vw_ValidCustRestrDiscounts]    Script Date: 05/18/2016 23:52:43 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

create view [dbo].[vw_ValidCustRestrDiscounts] as
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

GO

/****** Object:  View [dbo].[vw_ValidFirstTimeRestrictionDiscounts]    Script Date: 05/18/2016 23:54:13 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_ValidFirstTimeRestrictionDiscounts]'))
DROP VIEW [dbo].[vw_ValidFirstTimeRestrictionDiscounts]
GO


/****** Object:  View [dbo].[vw_ValidFirstTimeRestrictionDiscounts]    Script Date: 05/18/2016 23:54:14 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

create view [dbo].[vw_ValidFirstTimeRestrictionDiscounts] as
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

GO

/****** Object:  View [dbo].[vw_Potential_Discounts]    Script Date: 05/18/2016 23:55:33 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_Potential_Discounts]'))
DROP VIEW [dbo].[vw_Potential_Discounts]
GO


/****** Object:  View [dbo].[vw_Potential_Discounts]    Script Date: 05/18/2016 23:55:33 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE view [dbo].[vw_Potential_Discounts] as
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

GO

/****** Object:  View [dbo].[vw_CalcStandardDiscounts]    Script Date: 05/18/2016 23:56:27 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_CalcStandardDiscounts]'))
DROP VIEW [dbo].[vw_CalcStandardDiscounts]
GO

/****** Object:  View [dbo].[vw_CalcStandardDiscounts]    Script Date: 05/18/2016 23:56:27 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE view [dbo].[vw_CalcStandardDiscounts] as
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

GO

/****** Object:  View [dbo].[vw_CustomerDiscountWithModel]    Script Date: 05/18/2016 23:57:32 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_CustomerDiscountWithModel]'))
DROP VIEW [dbo].[vw_CustomerDiscountWithModel]
GO


/****** Object:  View [dbo].[vw_CustomerDiscountWithModel]    Script Date: 05/18/2016 23:57:32 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

create view [dbo].[vw_CustomerDiscountWithModel] as
    select M.IDModel, ECD.*
    from Model M
    left join Ent_CustomerDiscount ECD on (ECD.IDGroup = M.GroupID);

GO

/****** Object:  View [dbo].[vw_DiscInputs]    Script Date: 05/18/2016 23:58:31 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_DiscInputs]'))
DROP VIEW [dbo].[vw_DiscInputs]
GO


/****** Object:  View [dbo].[vw_DiscInputs]    Script Date: 05/18/2016 23:58:32 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- Store what basically amounts to "input data" from PIM with some other things
-- thrown in for good measure.
CREATE view [dbo].[vw_DiscInputs] (
    IDPreInventoryMov, -- int primary key references PreInventoryMov,
    StoreID, -- int not null references Store(IDStore),
    ModelID, -- int not null references Model(IDModel),
    IDPessoa, -- int not null references Pessoa(IDPessoa),
    DocumentID, -- int not null,
    SalePrice, -- money not null,
    Qty, -- decimal(38,4) not null,
    ManualDiscount -- money
    --,ManualDiscountType varchar(max)
)as
    select PIM.IDPreInventoryMov, PIM.StoreID, PIM.ModelID, PIM.IDPessoa,
        PIM.DocumentID, PIM.SalePrice, PIM.Qty, SMD.ManualDiscount
    from PreInventoryMov PIM
    left join ManualDiscount SMD on (
        SMD.IDPreInventoryMov = PIM.IDPreInventoryMov
    );
    --where DocumentID = @DocumentID;

GO

/****** Object:  View [dbo].[vw_ECDWithModel]    Script Date: 05/18/2016 23:59:18 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_ECDWithModel]'))
DROP VIEW [dbo].[vw_ECDWithModel]
GO


/****** Object:  View [dbo].[vw_ECDWithModel]    Script Date: 05/18/2016 23:59:19 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


create view [dbo].[vw_ECDWithModel] as
    select M.IDModel, ECD.*
    from Model M
    left join Ent_CustomerDiscount ECD on (ECD.IDGroup = M.GroupID);

GO

/****** Object:  View [dbo].[vw_ModelDiscountSummaries]    Script Date: 05/19/2016 00:00:23 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_ModelDiscountSummaries]'))
DROP VIEW [dbo].[vw_ModelDiscountSummaries]
GO


/****** Object:  View [dbo].[vw_ModelDiscountSummaries]    Script Date: 05/19/2016 00:00:23 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO


create view [dbo].[vw_ModelDiscountSummaries] as
    select TM.IDModel, D.IDDiscount, D.DiscountName, D.AmountType,
        D.RewardAmount
    from Discounts D
    join DiscQualifyingTags DQT on (DQT.IDDiscount = D.IDDiscount)
    join TagModel TM on (TM.IDTag = DQT.IDTag);

GO

/****** Object:  View [dbo].[vw_SelectFinalDiscounts]    Script Date: 05/19/2016 00:01:23 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_SelectFinalDiscounts]'))
DROP VIEW [dbo].[vw_SelectFinalDiscounts]
GO


/****** Object:  View [dbo].[vw_SelectFinalDiscounts]    Script Date: 05/19/2016 00:01:23 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE view [dbo].[vw_SelectFinalDiscounts] as
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

GO

/****** Object:  View [dbo].[vw_PreInventoryMovWithDiscounts]    Script Date: 05/19/2016 00:02:41 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_PreInventoryMovWithDiscounts]'))
DROP VIEW [dbo].[vw_PreInventoryMovWithDiscounts]
GO


/****** Object:  View [dbo].[vw_PreInventoryMovWithDiscounts]    Script Date: 05/19/2016 00:02:41 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


create view [dbo].[vw_PreInventoryMovWithDiscounts] as
    select PIM.DocumentID, PIM.IDPreInventoryMov, PIM.ModelID, PIM.Qty,
        PIM.SalePrice, CD.UnitDiscount,
        round(PIM.SalePrice - CD.UnitDiscount, 2) as DiscountedPrice,
        cast(round((PIM.SalePrice * PIM.Qty), 2) as money) as Extension,
        cast(round((PIM.SalePrice * PIM.Qty - (CD.UnitDiscount * PIM.Qty)), 2) as money)
            as DiscountedExtension
    from vw_SelectFinalDiscounts CD
    join PreInventoryMov PIM on (PIM.IDPreInventoryMov = CD.IDPreInventoryMov);

GO

/****** Object:  View [dbo].[vw_TagsWithAttrs]    Script Date: 05/18/2016 15:10:08 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_TagsWithAttrs]'))
DROP VIEW [dbo].[vw_TagsWithAttrs]
GO


/****** Object:  View [dbo].[vw_TagsWithAttrs]    Script Date: 05/18/2016 15:10:08 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO


create view [dbo].[vw_TagsWithAttrs] as
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

GO

/****** Object:  View [dbo].[vw_TagsWithAttrsAndModels]    Script Date: 05/18/2016 15:46:13 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_TagsWithAttrsAndModels]'))
DROP VIEW [dbo].[vw_TagsWithAttrsAndModels]
GO


/****** Object:  View [dbo].[vw_TagsWithAttrsAndModels]    Script Date: 05/18/2016 15:46:13 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO


create view [dbo].[vw_TagsWithAttrsAndModels] as
    select vw_TagsWithAttrs.*, TagModel.IDModel, TagModel.PKTagModel
    from vw_TagsWithAttrs
    left join TagModel on (TagModel.IDTag = vw_TagsWithAttrs.IDTag);

GO