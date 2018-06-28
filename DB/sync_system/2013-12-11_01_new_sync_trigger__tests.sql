set xact_abort on;
go

begin tran;

print 'Update some model and inventory rows';
update Model set SellingPrice = SellingPrice where IDModel in (55519, 55546, 55537);
update Model set SellingPrice = SellingPrice where IDModel in (55520);
update Model set SellingPrice = SellingPrice where IDModel in (10000009);
update Model set SellingPrice = SellingPrice where IDModel in (55519, 55546, 55537);
update Inventory set StoreID = StoreID where StoreID=1 and ModelID = 2;

print 'Simulate an export/sync.';
insert into SyncBatches (SynchronizedOn) values (current_timestamp);
select * from SyncBatches;

print 'Do only two updates now.';
update Model set SellingPrice = SellingPrice where IDModel in (55519, 55546);

select * from SyncChanges;

rollback tran;