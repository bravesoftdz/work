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

CREATE TABLE dbo.Tmp_Pur_PurchaseItemSerial
	(
	IDPurchaseItemSerial int NOT NULL,
	IDPurchaseItem int NOT NULL,
	SerialNumber varchar(30) NOT NULL,
	IDPurchase int NULL
	)  ON [PRIMARY]
GO

IF EXISTS(SELECT * FROM dbo.Pur_PurchaseItemSerial)
	 EXEC('INSERT INTO dbo.Tmp_Pur_PurchaseItemSerial (IDPurchaseItemSerial, IDPurchaseItem, SerialNumber, IDPurchase)
		SELECT IDPurchaseItemSerial, IDPurchaseItem, SerialNumber, IDPurchase FROM dbo.Pur_PurchaseItemSerial TABLOCKX')
GO

DROP TABLE dbo.Pur_PurchaseItemSerial
GO

EXECUTE sp_rename N'dbo.Tmp_Pur_PurchaseItemSerial', N'Pur_PurchaseItemSerial', 'OBJECT'
GO

ALTER TABLE dbo.Pur_PurchaseItemSerial ADD CONSTRAINT
	PK__Pur_PurchaseItem__02925FBF PRIMARY KEY CLUSTERED 
	(
	IDPurchaseItemSerial
	) ON [PRIMARY]

GO

CREATE NONCLUSTERED INDEX XIF136Pur_PurchaseItemSerial ON dbo.Pur_PurchaseItemSerial
	(
	IDPurchaseItem
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX XIF137Pur_PurchaseItemSerial ON dbo.Pur_PurchaseItemSerial
	(
	IDPurchase
	) ON [PRIMARY]
GO

ALTER TABLE dbo.Pur_PurchaseItemSerial WITH NOCHECK ADD CONSTRAINT
	FK_Purchase_PurchaseItemSerial_IDPurchase FOREIGN KEY
	(
	IDPurchase
	) REFERENCES dbo.Pur_Purchase
	(
	IDPurchase
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

