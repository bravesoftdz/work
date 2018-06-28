DELETE Rep_Table
WHERE TABLENAME = 'Inv_ModelVendor'
GO

INSERT INTO Rep_Table (TableName, TableAlias)
VALUES ('Inv_ModelVendor', 'Inv_ModelVendor')
GO

DELETE Rep_Table
WHERE TABLENAME = 'Ent_CustomerDiscount'
GO

INSERT INTO Rep_Table (TableName, TableAlias)
VALUES ('Ent_CustomerDiscount', 'Ent_CustomerDiscount')
GO

DELETE Rep_Table
WHERE TABLENAME = 'Inv_Count'
GO

INSERT INTO Rep_Table (TableName, TableAlias)
VALUES ('Inv_Count', 'Inv_Count')
GO

DELETE Rep_Table
WHERE TABLENAME = 'Inv_CountItem'
GO

INSERT INTO Rep_Table (TableName, TableAlias)
VALUES ('Inv_CountItem', 'Inv_CountItem')
GO


DELETE Rep_Table
WHERE TABLENAME = 'Inv_FrozeCount'
GO

INSERT INTO Rep_Table (TableName, TableAlias)
VALUES ('Inv_FrozeCount', 'Inv_FrozeCount')
GO

DELETE Rep_Table
WHERE TABLENAME = 'Mnt_StoreVendorAccount'
GO

INSERT INTO Rep_Table (TableName, TableAlias)
VALUES ('Mnt_StoreVendorAccount', 'Mnt_StoreVendorAccount')
GO
