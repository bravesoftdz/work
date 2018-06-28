DELETE FROM Rep_Field
WHERE TableName = 'Estado'
GO

DELETE FROM Rep_Table
WHERE TableName = 'Estado'
GO

EXEC sp_Rep_AddTableField Estado
GO
