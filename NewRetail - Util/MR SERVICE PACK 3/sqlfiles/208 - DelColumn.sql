IF EXISTS(SELECT I.name FROM sysobjects T INNER JOIN sysindexes I ON (T.id = I.id) WHERE T.xtype = 'U' AND I.name = 'PI_Invoice_LastChange' AND T.name = 'Invoice')
	DROP INDEX Invoice.PI_Invoice_LastChange
GO

IF EXISTS(SELECT SC.name FROM sysobjects O INNER JOIN syscolumns SC ON (O.id = SC.id) WHERE O.xtype = 'U' AND SC.name = 'LastChange' AND O.Name = 'Invoice')
	ALTER TABLE Invoice DROP COLUMN LastChange
GO
