IF NOT EXISTS (Select TableName From Rep_Table where TableName = 'Pur_PurchaseItemTaxRet')
BEGIN
  Insert Rep_Table (TableName, TableAlias) VALUES ('Pur_PurchaseItemTaxRet', 'Pur_PurchaseItemTaxRet')
END
GO
