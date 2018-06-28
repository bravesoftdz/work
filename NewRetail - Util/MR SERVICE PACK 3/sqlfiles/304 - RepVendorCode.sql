DELETE FROM Rep_Field WHERE TableName = 'VendorModelCode'
GO

DELETE FROM Rep_Table WHERE TableName = 'VendorModelCode'
GO

EXEC sp_Rep_AddTableField 'VendorModelCode'
GO
