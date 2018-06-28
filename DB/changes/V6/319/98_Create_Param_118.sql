set nocount on;
delete from Param where IDParam = 118;
insert into Param (
    IDParam, SrvParameter, SrvValue, SrvType, DefaultValue, Desativado, IDMenu,
    Description
)
values (
    118, 'Recalculate discounts on each item', 'Item', 'Boolean', 'Item', 0, 1,
    'If this option is Item, then discounts will recalculate as each item is '
    + 'added to the cart.  Set to Sale to have discounts recalcualte only when '
    + 'Process is pressed.'
);



delete from ParamLanguage where IDParam = 118 and IDLanguage = 1
insert into Paramlanguage values (118, 
                                    1, 
                                    'Recalculate discounts on each item',  
                                    'If this option is Item, then discounts will recalculate as each item is added to the cart.  Set to Sale to have discounts recalcualte only when Process is pressed.', null)
go