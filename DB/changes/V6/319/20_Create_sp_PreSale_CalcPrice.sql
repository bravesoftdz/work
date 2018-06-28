SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

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
	with initial_price as (
		select
			M.SellingPrice,
			SMP.ManualPrice,
			round(M.Finalcost * (SPBG.SpecialMarkUp + 1), 4) as SpecialPrice,
            M.Finalcost,
			SPBG.SpecialPriceID,
			I.SellingPrice as StoreSellingPrice,
			MinQuantity,
			QtyBreakPriceDiscount,
			round(((1-QtyBreakPriceDiscount)*M.SellingPrice),2) as QtyBreakPrice,
			M.PromotionPrice
		from Model M
		join PreInventoryMov PIM on (
			PIM.IDPreInventoryMov = @IDPreInventoryMov
			and PIM.ModelID = @IDModel
		)
		left join ManualPrice SMP on (
			SMP.IDPreInventoryMov = PIM.IDPreInventoryMov
		)
		left join SpecialPriceByGroup SPBG on (
			SPBG.GroupID = M.GroupID and SPBG.SpecialPriceID = @SpecialPriceID
		)
		left join (
			select TM.IDModel, TQ.MinQuantity as MinQuantity, min(TQ.Discount) as QtyBreakPriceDiscount
				from TagModel TM 
				join TagQtyPriceBreak TQ on (TM.idtag = TQ.idtag)
				where TM.IDModel =  @IDModel 
				and TQ.MinQuantity <= (select (abs(sum(qty))+abs(@qty)) as sumqty from preinventorymov where idpreinventorymov <> @IDPreInventoryMov and InventMovTypeID = 1 and 
					Documentid = (select documentid from preinventorymov where idpreinventorymov = @IDPreInventoryMov))
				group by TM.IDModel, TQ.MinQuantity
		) PGT on (PGT.IDModel = PIM.ModelID)
		left join Inventory I on (I.ModelID = @IDModel and I.StoreID = @StoreID)
		where M.IDModel = @IDModel
	),
	prices_to_compare as (
		select 'SellingPrice' as PriceName, SellingPrice as PriceValue from initial_price
		union all select 'PromotionPrice', PromotionPrice from initial_price
		union all select 'QtyBreakPrice', QtyBreakPrice from initial_price
	),
	lowest_price as (
		select top 1 PriceName, PriceValue as RegularPrice
		from prices_to_compare
		where PriceValue is not null
		order by PriceValue asc
	),
	final_price as (
		select
			coalesce(
				@ManualPrice,
				ManualPrice,
				SpecialPrice,
				StoreSellingPrice,
				(select RegularPrice from lowest_price)
			) as Price,
			*
		from initial_price
	)
	select * from final_price;
END
