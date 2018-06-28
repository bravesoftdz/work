DELETE FROM Rep_Field
WHERE TableName = 'InvoiceToCostType'
GO

DELETE FROM Rep_Table
WHERE TableName = 'InvoiceToCostType'
GO

EXEC sp_Rep_AddTableField InvoiceToCostType
GO
