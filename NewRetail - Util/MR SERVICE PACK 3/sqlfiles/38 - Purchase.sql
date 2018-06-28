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

CREATE TABLE dbo.Tmp_Pur_Purchase
	(
	IDPurchase int NOT NULL,
	PurchaseStatus varchar(20) NULL,
	IDFornecedor int NULL,
	IDStore int NULL,
	IDUserPreReceiving int NULL,
	DatePreReceiving datetime NULL,
	IDUserFinalReceiving int NULL,
	DateFinalReceiving datetime NULL,
	SubTotal money NULL,
	Freight money NULL,
	OtherCharges money NULL,
	DocumentType varchar(20) NULL,
	DocumentNumber varchar(20) NULL,
	DocumentDate datetime NULL,
	DocumentDueDate datetime NULL,
	DocumentTotal money NULL
	)  ON [PRIMARY]
GO

IF EXISTS(SELECT * FROM dbo.Pur_Purchase)
	 EXEC('INSERT INTO dbo.Tmp_Pur_Purchase (IDPurchase, PurchaseStatus, IDFornecedor, IDStore, IDUserPreReceiving, DatePreReceiving, IDUserFinalReceiving, DateFinalReceiving, SubTotal, Freight, OtherCharges, DocumentType, DocumentNumber, DocumentDate, DocumentDueDate, DocumentTotal)
		SELECT IDPurchase, PurchaseStatus, IDFornecedor, IDStore, IDUserPreReceiving, DatePreReceiving, IDUserFinalReceiving, DateFinalReceiving, SubTotal, Freight, OtherCharges, DocumentType, DocumentNumber, DocumentDate, DocumentDueDate, DocumentTotal FROM dbo.Pur_Purchase TABLOCKX')
GO

DECLARE @temp Varchar (8000)
SET @temp = ''
SELECT @temp = @temp + 'ALTER TABLE ' + TabelaDerivada+ CHAR (13)+
+ CHAR(9)+'DROP CONSTRAINT ' + ConstraintName + CHAR (13)
FROM vw_Sis_ChaveEstrangeira
WHERE TabelaOriginal = 'Pur_Purchase'
EXEC(@temp)
GO

DROP TABLE dbo.Pur_Purchase
GO

EXECUTE sp_rename N'dbo.Tmp_Pur_Purchase', N'Pur_Purchase', 'OBJECT'
GO

ALTER TABLE dbo.Pur_Purchase ADD CONSTRAINT
	PK__Pur_Purchase__4D5F7D71 PRIMARY KEY CLUSTERED 
	(
	IDPurchase
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX XIF173Pur_Purchase ON dbo.Pur_Purchase
	(
	IDStore
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX XIF174Pur_Purchase ON dbo.Pur_Purchase
	(
	IDUserPreReceiving
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX XIF175Pur_Purchase ON dbo.Pur_Purchase
	(
	IDUserFinalReceiving
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX XIF176Pur_Purchase ON dbo.Pur_Purchase
	(
	IDFornecedor
	) ON [PRIMARY]
GO

ALTER TABLE dbo.Pur_Purchase WITH NOCHECK ADD CONSTRAINT
	FK_Pessoa_Purchase_IDFornecedor FOREIGN KEY
	(
	IDFornecedor
	) REFERENCES dbo.Pessoa
	(
	IDPessoa
	) NOT FOR REPLICATION

GO

ALTER TABLE dbo.Pur_Purchase WITH NOCHECK ADD CONSTRAINT
	FK_SystemUser_Purchase_IDUserFinalReceiving FOREIGN KEY
	(
	IDUserFinalReceiving
	) REFERENCES dbo.SystemUser
	(
	IDUser
	) NOT FOR REPLICATION

GO

ALTER TABLE dbo.Pur_Purchase WITH NOCHECK ADD CONSTRAINT
	FK_SystemUser_Purchase_IDUserPreReceiving FOREIGN KEY
	(
	IDUserPreReceiving
	) REFERENCES dbo.SystemUser
	(
	IDUser
	) NOT FOR REPLICATION

GO

ALTER TABLE dbo.Pur_Purchase WITH NOCHECK ADD CONSTRAINT
	FK_Store_Purchase_IDStore FOREIGN KEY
	(
	IDStore
	) REFERENCES dbo.Store
	(
	IDStore
	) NOT FOR REPLICATION

GO

ALTER TABLE dbo.Pur_PurchaseQtyPrePurchase WITH NOCHECK ADD CONSTRAINT
	FK_Purchase_PurchaseQtyPrePurchase_IDPurchase FOREIGN KEY
	(
	IDPurchase
	) REFERENCES dbo.Pur_Purchase
	(
	IDPurchase
	) NOT FOR REPLICATION

GO

ALTER TABLE dbo.Pur_PurchaseTotal WITH NOCHECK ADD CONSTRAINT
	FK_Purchase_PurchaseTotal_IDPurchase FOREIGN KEY
	(
	IDPurchase
	) REFERENCES dbo.Pur_Purchase
	(
	IDPurchase
	) NOT FOR REPLICATION

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

ALTER TABLE dbo.Pur_PurchaseItem WITH NOCHECK ADD CONSTRAINT
	FK_Purchase_PurchaseItem_IDPurchase FOREIGN KEY
	(
	IDPurchase
	) REFERENCES dbo.Pur_Purchase
	(
	IDPurchase
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.Pur_PurchaseQtyOrder WITH NOCHECK ADD CONSTRAINT
	FK_Purchase_PurchaseQtyOrder_IDPurchase FOREIGN KEY
	(
	IDPurchase
	) REFERENCES dbo.Pur_Purchase
	(
	IDPurchase
	) NOT FOR REPLICATION

GO

