select top 50 DocumentID, COUNT(*)
from PreInventoryMov
where MovDate > '2013-05-01'
group by DocumentID
having COUNT(*) < 10
order by DocumentID desc;

