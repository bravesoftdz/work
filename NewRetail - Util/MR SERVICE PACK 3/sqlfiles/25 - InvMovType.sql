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

CREATE TABLE dbo.Tmp_InventoryMovType
	(
	IDInventMovType int NOT NULL,
	Name varchar(30) NOT NULL,
	Entrando bit NULL,
	System bit NULL,
	Desativado bit NULL,
	Hidden bit NULL,
	UpdateOnHand bit NULL,
	UpdateOnRepair bit NULL,
	UpdateOnOrder bit NULL,
	UpdateOnPreSale bit NULL,
	UpdateOnPrePurchase bit NULL,
	UpdatePreOnHand bit NULL,
	UpdatePreOnRepair bit NULL,
	UpdatePreOnOrder bit NULL,
	UpdatePreOnPreSale bit NULL,
	UpdatePreOnPrePurchase bit NULL
	)  ON [PRIMARY]
GO

IF EXISTS(SELECT * FROM dbo.InventoryMovType)
	 EXEC('INSERT INTO dbo.Tmp_InventoryMovType (IDInventMovType, Name, Entrando, System, Desativado, Hidden, UpdateOnHand, UpdateOnRepair, UpdateOnOrder, UpdateOnPreSale, UpdateOnPrePurchase, UpdatePreOnHand, UpdatePreOnRepair, UpdatePreOnOrder, UpdatePreOnPreSale, UpdatePreOnPrePurchase)
		SELECT IDInventMovType, Name, Entrando, System, Desativado, Hidden, UpdateOnHand, UpdateOnRepair, UpdateOnOrder, UpdateOnPreSale, UpdateOnPrePurchase, UpdatePreOnHand, UpdatePreOnRepair, UpdatePreOnOrder, UpdatePreOnPreSale, UpdatePreOnPrePurchase FROM dbo.InventoryMovType TABLOCKX')
GO

DECLARE @temp Varchar (8000)
SET @temp = ''
SELECT @temp = @temp + 'ALTER TABLE ' + TabelaDerivada+ CHAR (13)+
+ CHAR(9)+'DROP CONSTRAINT ' + ConstraintName + CHAR (13)
FROM vw_Sis_ChaveEstrangeira
WHERE TabelaOriginal = 'InventoryMovType'
EXEC(@temp)
GO

DROP TABLE dbo.InventoryMovType
GO

ALTER TABLE dbo.Tmp_InventoryMovType ADD CONSTRAINT
	DF_Zero112 DEFAULT (0) FOR System
GO

ALTER TABLE dbo.Tmp_InventoryMovType ADD CONSTRAINT
	DF_Zero113 DEFAULT (0) FOR Desativado
GO

ALTER TABLE dbo.Tmp_InventoryMovType ADD CONSTRAINT
	DF_Zero114 DEFAULT (0) FOR Hidden
GO

EXECUTE sp_rename N'dbo.Tmp_InventoryMovType', N'InventoryMovType', 'OBJECT'
GO

ALTER TABLE dbo.InventoryMovType ADD CONSTRAINT
	PK_IMT_IDInventMovType PRIMARY KEY CLUSTERED 
	(
	IDInventMovType
	) ON [PRIMARY]
GO

CREATE UNIQUE NONCLUSTERED INDEX UK_IventoryMovType_Name ON dbo.InventoryMovType
	(
	Name
	) ON [PRIMARY]
GO

ALTER TABLE dbo.InventoryMov WITH NOCHECK ADD CONSTRAINT
	FK_InventoryMovType_IventoryMov_InventMovTypeID FOREIGN KEY
	(
	InventMovTypeID
	) REFERENCES dbo.InventoryMovType
	(
	IDInventMovType
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.PreInventoryMov WITH NOCHECK ADD CONSTRAINT
	FK_InventoryMovType_PreInventoryMov_InventMovTypeID FOREIGN KEY
	(
	InventMovTypeID
	) REFERENCES dbo.InventoryMovType
	(
	IDInventMovType
	) NOT FOR REPLICATION
GO

