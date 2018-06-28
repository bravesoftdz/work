SET QUOTED_IDENTIFIER ON
GO

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

SET ARITHABORT ON
GO

SET NUMERIC_ROUNDABORT OFF
GO

SET CONCAT_NULL_YIELDS_NULL ON
GO

SET ANSI_NULLS ON
GO

SET ANSI_PADDING ON
GO

SET ANSI_WARNINGS ON
GO

CREATE TABLE dbo.Tmp_Pur_PurchaseItem
	(
	IDPurchaseItem int NOT NULL,
	IDPurchase int NULL,
	IDGroup int NULL,
	IDFornecedor int NULL,
	IDModel int NULL,
	IDPOItem int NULL,
	BarCode varchar(20) NULL,
	Qty int NULL,
	NewCostPrice money NULL,
	NewSalePrice money NULL,
	NewSuggRetail money NULL
	)  ON [PRIMARY]
GO

IF EXISTS(SELECT * FROM dbo.Pur_PurchaseItem)
	 EXEC('INSERT INTO dbo.Tmp_Pur_PurchaseItem (IDPurchaseItem, IDPurchase, IDGroup, IDFornecedor, IDModel, IDPOItem, BarCode, Qty, NewCostPrice, NewSalePrice, NewSuggRetail)
		SELECT IDPurchaseItem, IDPurchase, IDGroup, IDFornecedor, IDModel, IDPOItem, BarCode, Qty, NewCostPrice, NewSalePrice, NewSuggRetail FROM dbo.Pur_PurchaseItem TABLOCKX')
GO

DECLARE @temp Varchar (8000)
SET @temp = ''
SELECT @temp = @temp + 'ALTER TABLE ' + TabelaDerivada+ CHAR (13)+
+ CHAR(9)+'DROP CONSTRAINT ' + ConstraintName + CHAR (13)
FROM vw_Sis_ChaveEstrangeira
WHERE TabelaOriginal = 'Pur_PurchaseItem'
EXEC(@temp)
GO

DROP TABLE dbo.Pur_PurchaseItem
GO

EXECUTE sp_rename N'dbo.Tmp_Pur_PurchaseItem', N'Pur_PurchaseItem', 'OBJECT'
GO

ALTER TABLE dbo.Pur_PurchaseItem ADD CONSTRAINT
	PK__Pur_PurchaseItem__00AA174D PRIMARY KEY CLUSTERED 
	(
	IDPurchaseItem
	) ON [PRIMARY]

GO

CREATE NONCLUSTERED INDEX XIF101Pur_PurchaseItem ON dbo.Pur_PurchaseItem
	(
	IDModel
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX XIF102Pur_PurchaseItem ON dbo.Pur_PurchaseItem
	(
	IDPurchase
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX XIF103Pur_PurchaseItem ON dbo.Pur_PurchaseItem
	(
	IDGroup
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX XIF394Pur_PurchaseItem ON dbo.Pur_PurchaseItem
	(
	IDFornecedor
	) ON [PRIMARY]
GO

ALTER TABLE dbo.Pur_PurchaseItem WITH NOCHECK ADD CONSTRAINT
	FK_Pessoa_PurchaseItem_IDFornecedor FOREIGN KEY
	(
	IDFornecedor
	) REFERENCES dbo.Pessoa
	(
	IDPessoa
	) NOT FOR REPLICATION

GO

ALTER TABLE dbo.Pur_PurchaseItem WITH NOCHECK ADD CONSTRAINT
	FK_TabGroup_PurchaseItem_IDGroup FOREIGN KEY
	(
	IDGroup
	) REFERENCES dbo.TabGroup
	(
	IDGroup
	) NOT FOR REPLICATION

GO

ALTER TABLE dbo.Pur_PurchaseItem WITH NOCHECK ADD CONSTRAINT
	FK_Purchase_PurchaseItem_IDPurchase FOREIGN KEY
	(
	IDPurchase
	) REFERENCES dbo.Pur_Purchase
	(
	IDPurchase
	) NOT FOR REPLICATION

GO

ALTER TABLE dbo.Pur_PurchaseItem WITH NOCHECK ADD CONSTRAINT
	FK_Model_PurchaseItem_IDModel FOREIGN KEY
	(
	IDModel
	) REFERENCES dbo.Model
	(
	IDModel
	) NOT FOR REPLICATION

GO

ALTER TABLE dbo.Pur_PurchaseItemSerial WITH NOCHECK ADD CONSTRAINT
	FK_PurchaseItem_PurchaseItemSerial_IDPurchaseItem FOREIGN KEY
	(
	IDPurchaseItem
	) REFERENCES dbo.Pur_PurchaseItem
	(
	IDPurchaseItem
	) NOT FOR REPLICATION

GO

