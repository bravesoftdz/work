use MainRetailDB

declare @id int
select @id = IDParam from Param where IDParam = 118
if ( @id is null ) begin
   insert into Param (IDParam, SrvParameter, SrvValue, SrvType, Description, DefaultValue, Desativado, IDMenu, ReplLastChange)
values (118, 'Recalculate discounts on each item', 'Item', 'Boolean', 'If this option is Item, then discounts will recalculate as each item is added to the cart. Set to Sale to have discounts recalculate only when Process is pressed', 'Item', 0, 1, null)
end

go