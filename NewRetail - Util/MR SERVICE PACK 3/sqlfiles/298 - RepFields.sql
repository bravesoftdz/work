sp_Rep_AddTableField VendorTax
GO

INSERT Rep_Table (TableName, TableAlias)
VALUES ('Pur_PurchaseItem', 'Pur_PurchaseItem')
GO

INSERT Rep_Table (TableName, TableAlias)
VALUES ('Pur_PurchaseItemTax', 'Pur_PurchaseItemTax')
GO

sp_Rep_AddTableField TMC_TimeControl
GO

UPDATE Rep_Field
SET DataModule = 'DM', DataSet = 'quLookUpStore', ListField = 'Name'
WHERE FieldName = 'IDStore'            
GO

UPDATE Rep_Field
SET DataModule = 'DM', DataSet = 'quLookUpUser', ListField = 'SystemUser'
WHERE FieldName = 'IDUser'            
GO
