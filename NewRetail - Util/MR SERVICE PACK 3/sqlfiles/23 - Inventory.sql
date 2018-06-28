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


CREATE TABLE dbo.Tmp_Inventory
	(
	StoreID int NOT NULL,
	ModelID int NOT NULL,
	IDInventory int NOT NULL,
	QtyOnPreSale int NOT NULL,
	QtyOnHand int NOT NULL,
	QtyOnOrder int NOT NULL,
	QtyOnRepair int NOT NULL,
	MaxQty int NOT NULL,
	MinQty int NOT NULL,
	Location varchar(30) NULL,
	QtyContada int NULL,
	DataContagem smalldatetime NULL,
	UltimaMovimentacao smalldatetime NULL,
	UltimaContagem smalldatetime NULL,
	AuxCalculo int NULL,
	Avaiable bit NULL,
	Hidden bit NULL,
	QtyOnPrePurchase int NULL,
	LastPurchase datetime NULL,
	FirstPurchase datetime NULL,
	TotalPurchase int NULL
	)  ON [PRIMARY]
GO

IF EXISTS(SELECT * FROM dbo.Inventory)
	 EXEC('INSERT INTO dbo.Tmp_Inventory (StoreID, ModelID, IDInventory, QtyOnPreSale, QtyOnHand, QtyOnOrder, QtyOnRepair, MaxQty, MinQty, Location, QtyContada, DataContagem, UltimaMovimentacao, UltimaContagem, AuxCalculo, Avaiable, Hidden, QtyOnPrePurchase, LastPurchase, FirstPurchase, TotalPurchase)
		SELECT StoreID, ModelID, IDInventory, QtyOnPreSale, QtyOnHand, QtyOnOrder, QtyOnRepair, MaxQty, MinQty, Location, QtyContada, DataContagem, UltimaMovimentacao, UltimaContagem, AuxCalculo, Avaiable, Hidden, QtyOnPrePurchase, LastPurchase, FirstPurchase, TotalPurchase FROM dbo.Inventory TABLOCKX')
GO

DECLARE @temp Varchar (8000)
SET @temp = ''
SELECT DISTINCT @temp = @temp + 'ALTER TABLE ' + TabelaDerivada+ CHAR (13)+
+ CHAR(9)+'DROP CONSTRAINT ' + ConstraintName + CHAR (13)
FROM vw_Sis_ChaveEstrangeira
WHERE TabelaOriginal = 'Inventory'
EXEC(@temp)
GO

DROP TABLE dbo.Inventory
GO

ALTER TABLE dbo.Tmp_Inventory ADD CONSTRAINT
	DF_Zero59 DEFAULT (0) FOR QtyOnPreSale
GO

ALTER TABLE dbo.Tmp_Inventory ADD CONSTRAINT
	DF_Zero60 DEFAULT (0) FOR QtyOnHand
GO

ALTER TABLE dbo.Tmp_Inventory ADD CONSTRAINT
	DF_Zero61 DEFAULT (0) FOR QtyOnOrder
GO

ALTER TABLE dbo.Tmp_Inventory ADD CONSTRAINT
	DF_Zero62 DEFAULT (0) FOR QtyOnRepair
GO

ALTER TABLE dbo.Tmp_Inventory ADD CONSTRAINT
	DF_Zero63 DEFAULT (0) FOR MaxQty
GO

ALTER TABLE dbo.Tmp_Inventory ADD CONSTRAINT
	DF_Zero64 DEFAULT (0) FOR MinQty
GO

ALTER TABLE dbo.Tmp_Inventory ADD CONSTRAINT
	DF_Zero65 DEFAULT (0) FOR Avaiable
GO

ALTER TABLE dbo.Tmp_Inventory ADD CONSTRAINT
	DF_Zero66 DEFAULT (0) FOR Hidden
GO

ALTER TABLE dbo.Tmp_Inventory ADD CONSTRAINT
	DF_Zero67 DEFAULT (0) FOR QtyOnPrePurchase
GO

EXECUTE sp_rename N'dbo.Tmp_Inventory', N'Inventory', 'OBJECT'
GO

ALTER TABLE dbo.Inventory ADD CONSTRAINT
	PK_Inventory_StoreID PRIMARY KEY CLUSTERED 
	(
	StoreID,
	ModelID
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX XIF457Inventory ON dbo.Inventory
	(
	StoreID
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX XIF458Inventory ON dbo.Inventory
	(
	ModelID
	) ON [PRIMARY]
GO

ALTER TABLE dbo.Inventory WITH NOCHECK ADD CONSTRAINT
	FK_Model_Inventory_ModelID FOREIGN KEY
	(
	ModelID
	) REFERENCES dbo.Model
	(
	IDModel
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.Inventory WITH NOCHECK ADD CONSTRAINT
	FK_Store_Inventory_StoreID FOREIGN KEY
	(
	StoreID
	) REFERENCES dbo.Store
	(
	IDStore
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.InvResetHistory WITH NOCHECK ADD CONSTRAINT
	FK_Inventory_InvResetHistory_IDStoreIDModel FOREIGN KEY
	(
	IDStore,
	IDModel
	) REFERENCES dbo.Inventory
	(
	StoreID,
	ModelID
	) NOT FOR REPLICATION
GO

