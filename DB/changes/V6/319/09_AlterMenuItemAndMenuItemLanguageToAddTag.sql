/*
 * Create or recreate the sub-menu entry for 'Tag' along with translation.
 */
begin tran;
set nocount on;

delete from MenuItemLanguage
	where IDMenu = 5 and IDSubMenu = 17 and IDLanguage = 1;
delete from MenuItem
    where IDMenu = 5 and IDSubMenu = 17;

insert into MenuItem (
	IDMenu, IDSubMenu, Name,  ParentMenu,  Tip)
values (
	5,      17,        'Tag', 'Inventory', 'Create and maintain Tags'
);

insert into MenuItemLanguage (
    IDMenu, IDSubMenu, IDLanguage, Name,  ParentMenu,  Tip
)
values (
    5,      17,        1,          'Tag', 'Inventory', 'Create and maintain Tags'
);

commit tran;