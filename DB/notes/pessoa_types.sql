-- Statistics on how many of each type of pessoa there are.
with tipo_stats as (
    select idtipopessoa, count(*) as count
    from pessoa group by idtipopessoa
)
select ts.*, tp.Hidden
from tipo_stats ts
join tipopessoa tp on (tp.idtipopessoa = ts.idtipopessoa);