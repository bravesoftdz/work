DELETE FROM Rep_Field
WHERE TableName = 'Inv_ModelVendor'
GO

DELETE FROM Rep_Table
WHERE TableName = 'Inv_ModelVendor'
GO

EXEC sp_Rep_AddTableField Inv_ModelVendor
GO

DELETE FROM Rep_Field
WHERE TableName = 'Pessoa'
GO

DELETE FROM Rep_Table
WHERE TableName = 'Pessoa'
GO

EXEC sp_Rep_AddTableField Pessoa
GO

DELETE FROM Rep_Table
WHERE TableName = 'vw_Rep_CommissionDetails'
GO

DELETE FROM Rep_Field
WHERE TableName = 'vw_Rep_CommissionDetails'
GO

EXEC sp_Rep_AddTableField 'vw_Rep_CommissionDetails'
GO

UPDATE Rep_Field
SET 
	DataModule = 'DM',
	DataSet = 'quLookUpCategory',
	ListField = 'Name'
WHERE
	TableName = 'vw_Rep_CommissionDetails'
	AND FieldName = 'Category'
GO

UPDATE Rep_Field
SET
	DataModule = 'DM',
	DataSet = 'quLookUpColor',
	ListField = 'Color'
WHERE
	TableName = 'vw_Rep_CommissionDetails'
	AND FieldName = 'Color'
GO

UPDATE Rep_Field
SET
	DataModule = 'DM',
	DataSet = 'quLookUpCategory',
	ListField = 'Name'
WHERE
	TableName = 'vw_Rep_CommissionDetails'
	AND FieldName = 'IDCategory'
GO

UPDATE Rep_Field
SET
	DataModule = 'DM',
	DataSet = 'quLookUpStore',
	ListField = 'Name'
WHERE
	TableName = 'vw_Rep_CommissionDetails'
	AND FieldName = 'Store'
GO
