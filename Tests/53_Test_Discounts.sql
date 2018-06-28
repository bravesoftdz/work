/*
begin tran;

declare @TestDocumentID int = 3889;
declare @write_to_PIM bit = 1;

-- First test is just the customer discount, none others.
-- 6% is the highest discount that's done in that table, we'll go 5%.
insert into Ent_CustomerDiscount (IDTipoPessoa, IDGroup, Discount) values (2, 50, 5);
exec sp_PreSale_SetDiscount @TestDocumentID, @write_to_PIM;
select * from vw_PreInventoryMovWithDiscounts where DocumentID = @TestDocumentID;
delete from Ent_CustomerDiscount where IDTipoPessoa = 2 and IDGroup = 50 and Discount = 5;


insert into Discounts (
    IDDiscount, Start_Timestamp, End_Timestamp, DiscType,
    FirstTimeCustomerOnly, CustomerCardRequired, IsStackable
)
values (
    1, '2013-01-01 00:00:00', '2013-12-31 00:00:00', 'Promo',
    0, 0, 0
);

-- select 'Before SPs: ' as debug_msg, IDPreInventoryMov, Qty, SalePrice, Discount
-- from PreInventoryMov
-- where DocumentID = @TestDocumentID 
-- order by 2;


delete from DiscountEntries;
insert into DiscountEntries
    (IDDiscountEntry, IDDiscount, RewardAmount, AmountType)
values (1, 1, 0.80, 'Amount Off Item');
exec sp_PreSale_SetDiscount @TestDocumentID, @write_to_PIM;
select * from vw_PreInventoryMovWithDiscounts where DocumentID = @TestDocumentID;

delete from DiscountEntries;
insert into DiscountEntries
    (IDDiscountEntry, IDDiscount, RewardAmount, AmountType)
values (1, 1, .25, 'Percent Off Item');
exec sp_PreSale_SetDiscount @TestDocumentID, @write_to_PIM;
select * from vw_PreInventoryMovWithDiscounts where DocumentID = @TestDocumentID;

delete from DiscountEntries;
insert into DiscountEntries
    (IDDiscountEntry, IDDiscount, RewardAmount, AmountType)
values (1, 1, 5.00, 'Sale Price');
exec sp_PreSale_SetDiscount @TestDocumentID, @write_to_PIM;
select * from vw_PreInventoryMovWithDiscounts where DocumentID = @TestDocumentID;

delete from Discounts;
delete from DiscountEntries;
insert into Discounts (
    IDDiscount, Start_Timestamp, End_Timestamp, DiscType,
    FirstTimeCustomerOnly, CustomerCardRequired, IsStackable
)
values (
    1, '2013-01-01 00:00:00', '2013-12-31 00:00:00', 'Coupon',
    0, 0, 0
);
insert into DiscountEntries
    (IDDiscountEntry, IDDiscount, RewardAmount, AmountType)
values (1, 1, 7.50, 'Amount Off Item');
exec sp_PreSale_SetDiscount @TestDocumentID, @write_to_PIM;
select * from vw_PreInventoryMovWithDiscounts where DocumentID = @TestDocumentID;

ROLLBACK TRAN;
*/