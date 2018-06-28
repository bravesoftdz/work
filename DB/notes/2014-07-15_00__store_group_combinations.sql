begin tran;

set nocount on;

/*
 * The query finds store and group combinations that are not in
 * the StoreToTabGroup table. To generate some test data, we
 * simply delete a few.
 */
delete from StoreToTabGroup where (IDStore = 0 and IDGroup = 5);
delete from StoreToTabGroup where (IDStore = 0 and IDGroup = 7);
delete from StoreToTabGroup where (IDStore = 0 and IDGroup = 9);


/*
 * [11:11:29] Nicholas Cook: Need a new version like this that works against
 * storetotabgroup
 * [11:11:43] Nicholas Cook: no join between tabgroup and store though
 *
 * I believe that means that instead of joining against AllComos, we want
 * to join only against StoreToTabGroup. See "Original" below for the version
 * that Nick had me modify.
 */
with AllStores as (
    select IDStore from Store
),
AllGroups as (
    select IDGroup from TabGroup where TabGroup.System <> 1
),
PossibleCombos as (
    select IDStore, IDGroup from AllStores cross join AllGroups
),
MissingCombos as (
    select PC.IDStore, PC.IDGroup
    from PossibleCombos PC
    left join StoreToTabGroup STTG on (
        STTG.IDStore = PC.IDStore
        and STTG.IDGroup = PC.IDGroup
    )
    where STTG.IDGroup is null or STTG.IDStore is null
)
insert into StoreToTabGroup (IDStore, IDGroup, IDTaxCategory)
select IDStore, IDGroup, 2
from MissingCombos;

-- Other queries:
/*
select count(*)
from StoreToTabGroup;

select IDStore, count(*)
from StoreToTabGroup
group by IDStore
having count(*) > 1;

select * from StoreToTabGroup where IDStore in (0, 1) order by IDStore, IDGroup;
*/

-- Original:
/*
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
*/

rollback tran;