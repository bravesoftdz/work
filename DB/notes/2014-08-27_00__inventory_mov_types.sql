-- Useful statistics query on InventoryMovType value distribution,
-- or frequency of sales, returns, etc.:
select count(*) as InventoryMovCount, Name, IMT.IDInventMovType
from InventoryMov IM
join InventoryMovType IMT on (IMT.IDInventMovType = IM.InventMovTypeID)
group by IMT.IDInventMovType, Name
order by count(*) desc;