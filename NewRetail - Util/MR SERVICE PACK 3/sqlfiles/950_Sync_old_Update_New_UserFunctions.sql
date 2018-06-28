USE [MainRetailDB]
GO

/****** Object:  UserDefinedFunction [dbo].[fn_CalcPrice]    Script Date: 05/13/2016 19:06:13 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fn_CalcPrice]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[fn_CalcPrice]
GO


/****** Object:  UserDefinedFunction [dbo].[fn_CalcPrice]    Script Date: 05/13/2016 19:06:13 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


/*
 * Prices are selected in the following order of preference.
 * Example usage:
 *     select dbo.fn_CalcPrice(228086, 2192, 1, null);
 *
 * Note that Qty gets updated before this is called so that we
 * don't have to pass in @Qty.
 *
 */
create function [dbo].[fn_CalcPrice] (
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

GO

/****** Object:  UserDefinedFunction [dbo].[fn_IsValidCouponDiscount]    Script Date: 05/13/2016 19:09:39 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fn_IsValidCouponDiscount]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[fn_IsValidCouponDiscount]
GO


/****** Object:  UserDefinedFunction [dbo].[fn_IsValidCouponDiscount]    Script Date: 05/13/2016 19:09:39 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


create function [dbo].[fn_IsValidCouponDiscount] (
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

GO
