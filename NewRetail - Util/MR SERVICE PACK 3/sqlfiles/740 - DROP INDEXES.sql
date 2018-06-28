IF EXISTS (	SELECT name FROM sysindexes
		WHERE name = 'XIE_Model_Model')
	DROP INDEX Model.XIE_Model_Model
GO

IF EXISTS (	SELECT name FROM sysindexes
		WHERE name = 'XIF109InventoryMov')
	DROP INDEX InventoryMov.XIF109InventoryMov
GO

IF EXISTS (	SELECT name FROM sysindexes
		WHERE name = 'XIF227PreInventoryMov')
	DROP INDEX PreInventoryMov.XIF227PreInventoryMov
GO
