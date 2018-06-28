begin tran;

-- Find every combination of TabGroup and IDTipoComissionado
with AllCombos as (
    select IDGroup, IDTipoPessoa
    from TabGroup
    cross join TipoPessoa
    where TabGroup.System <> 1
),
-- Then compare that with the ones that exist and tell me what's left (i.e. missing).
MissingCombos as (
    select IDTipoPessoa, IDGroup
    from AllCombos AC
    left join GroupToComissionType GCT on (
        -- IDTipoComissionado has the same value as IDTipoPessoa.
        GCT.IDTipoComissionado = AC.IDTipoPessoa
        and GCT.GroupID = AC.IDGroup
    )
    where GCT.GroupID is null
)
insert into GroupToComissionType (IDTipoComissionado, GroupID, Comission)
select IDTipoPessoa, IDGroup, 0.00
from MissingCombos;

rollback tran;