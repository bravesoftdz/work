
-- function doesn't work because SQL Server doesn't support insert/update within CTE.
if object_id(N'fn_PreSale_CalcPrice') is not null
	drop function fn_PreSale_CalcPrice;
go
create function fn_PreSale_CalcPrice (
	@IDModel int, @StoreID int, @Qty int, @IDPreInventoryMov int, @SpecialPriceID int, @ManualPrice money
)
returns table as return (
	/*
	if (@ManualPrice is not null)
	begin		
		merge Sal_PreSaleCalcPrice as target
		using (select @IDPreInventoryMov, @IDModel, @ManualPrice)
			as source (id_pre_inventory_mov,  id_model,  manual_price)
		on (target.IDPreInventoryMov = source.id_pre_inventory_mov
			and target.IDModel = source.id_model)
		when matched then
			update set ManualPrice = source.manual_price
		when not matched then
			insert (IDPreInventoryMov, IDModel, ManualPrice)
			values (
				source.id_pre_inventory_mov,
				source.id_model,
				source.manual_price
			);
	end;
	*/
	
	with part1 as (
		select
			M.SellingPrice,
			PSCP.ManualPrice,
			round(M.Finalcost * (SPBG.SpecialMarkUp + 1), 4) as SpecialPrice,
			SPBG.SpecialPriceID,
			I.SellingPrice as StoreSellingPrice,
			KM2.Qty,
			KM2.QtyBreakPrice,
			M.PromotionPrice
		from Model M
		left join PreInventoryMov PIM on (
			PIM.IDPreInventoryMov = @IDPreInventoryMov
			and PIM.ModelID = @IDModel
		)
		left join Sal_PreSaleCalcPrice PSCP on (
			PSCP.IDPreInventoryMov = PIM.IDPreInventoryMov
			and PSCP.IDModel = PIM.ModelID
		)
		left join SpecialPriceByGroup SPBG on (
			SPBG.GroupID = M.GroupID and SPBG.SpecialPriceID = @SpecialPriceID
		)
		left join (
				select IDModel, Qty, min(SellingPrice) as QtyBreakPrice
				from KitModel
				where IDModel = @IDModel 
				and Qty <= @Qty
				group by IDModel, Qty
		) KM2 on (KM2.IDModel = PIM.ModelID)
		left join Inventory I on (I.ModelID = @IDModel and I.StoreID = @StoreID)
		where M.IDModel = @IDModel
	),
	prices_to_compare as (
		select 'SellingPrice' as PriceName, SellingPrice as PriceValue from part1
		union all select 'PromotionPrice', PromotionPrice from part1
		union all select 'QtyBreakPrice', QtyBreakPrice from part1
	),
	lowest_price as (
		select top 1 PriceName, PriceValue as RegularPrice
		from prices_to_compare
		where PriceValue is not null
		order by PriceValue asc
	)
	select
		coalesce(
			@ManualPrice,
			ManualPrice,
			SpecialPrice,
			StoreSellingPrice,
			(select RegularPrice from lowest_price)
		) as Price,
		*
	from part1

);
go


select * from fn_PreSale_CalcPrice(21963, 1, 1, 100194739, 3, NULL);


--select IDPreInventoryMov from PreInventoryMov where ModelID = 21963;
/*

create function sp_PreSale_CalcPrice (
	@IDModel int, @StoreID int, @Qty int, @IDPreInventoryMov int, @SpecialPriceID int, @ManualPrice money
)
returns table as return (
with part1 as (
	select
		M.IDModel,
		M.SellingPrice,
		PSCP.ManualPrice,
		round(M.Finalcost * (SPBG.SpecialMarkUp + 1), 4) as SpecialPrice,
		SPBG.SpecialPriceID,
		I.SellingPrice as StoreSellingPrice,
		I.StoreID,
		KM2.Qty,
		KM2.QtyBreakPrice,
		M.PromotionPrice
	from Model M
	left join PreInventoryMov PIM on (
		PIM.IDPreInventoryMov = @IDPreInventoryMov
		and PIM.ModelID = @IDModel
	)
	left join Sal_PreSaleCalcPrice PSCP on (
		PSCP.IDPreInventoryMov = PIM.IDPreInventoryMov
		and PSCP.IDModel = PIM.ModelID
	)
	left join SpecialPriceByGroup SPBG on (
		SPBG.GroupID = M.GroupID and SPBG.SpecialPriceID = @SpecialPriceID
	)
	left join (
			select IDModel, Qty, min(SellingPrice) as QtyBreakPrice
			from KitModel
			where IDModel = @IDModel 
			and Qty <= @Qty
			group by IDModel, Qty
	) KM2 on (KM2.IDModel = PIM.ModelID)
	left join Inventory I on (I.ModelID = @IDModel and I.StoreID = @StoreID)
	where M.IDModel = @IDModel
),
prices_to_compare as (
	select 'SellingPrice' as PriceName, SellingPrice as PriceValue from part1
	union all
	select 'PromotionPrice', PromotionPrice from part1
	union all
	select 'QtyBreakPrice', QtyBreakPrice from part1
),
lowest_price as (
	select top 1 PriceName, PriceValue as RegularPrice
	from prices_to_compare
	where PriceValue is not null
	order by PriceValue asc
)
select
	*,
	coalesce(
		@ManualPrice,
		ManualPrice,
		SpecialPrice,
		StoreSellingPrice,
		(select RegularPrice from lowest_price)
	) as Price
from part1

);
go







if OBJECT_ID('tempdb..#items_in_cart') is not null
	drop table #items_in_cart
go

create table #items_in_cart (
	IDModel int,
	SpecialPriceID int,
	StoreID int,
	Qty int
);
go

insert into #items_in_cart values
	(8951, 3, 1, 100),
	(20756, 3, 1, 25),
	(21963, 3, 1, 1),
	(36030, 3, 1, 12);


select *, (
	select Price from dbo.sp_PreSale_CalcPrice(
		IDModel, SpecialPriceID, StoreID, Qty
	) as Price
)
from #items_in_cart;
go
*/
