set xact_abort on;
go
begin tran;

declare @IDPreInventoryMov int
exec sp_PreSale_AddItem;1 20555,1,519,1,1,2,1,15.9900,12.0000,0.0000,
    '2014-03-13 16:46:00',0,0,'2014-03-13 16:55:23',NULL,NULL,0,0,0,0,0,'',0,
    NULL,NULL,0.0000,0.0000,@IDPreInventoryMov output

print 'IDPreInventoryMov returned: ' + coalesce(cast(@IDPreInventoryMov as varchar), 'null')
print 'Calling sp_PreSale_AddItem again...'

-- Call again to test the "update qty of existing"
exec sp_PreSale_AddItem;1 20555,1,519,1,1,2,1,15.9900,12.0000,0.0000,
    '2014-03-13 16:46:00',0,0,'2014-03-13 16:55:23',NULL,NULL,0,0,0,0,0,'',0,
    NULL,NULL,0.0000,0.0000,@IDPreInventoryMov output

print 'IDPreInventoryMov after second call: ' + coalesce(cast(@IDPreInventoryMov as varchar), 'null')

rollback tran;