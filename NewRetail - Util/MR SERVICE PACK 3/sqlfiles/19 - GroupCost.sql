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

CREATE TABLE dbo.Tmp_GroupCost
	(
	IDCost int NOT NULL,
	IDTouristGroup int NOT NULL,
	IDCostType int NOT NULL,
	IDInventoryMov int NULL,
	CostDate smalldatetime NOT NULL,
	UnitCost money NOT NULL,
	Quantity float(53) NULL
	)  ON [PRIMARY]
GO

IF EXISTS(SELECT * FROM dbo.GroupCost)
	 EXEC('INSERT INTO dbo.Tmp_GroupCost (IDCost, IDTouristGroup, IDCostType, IDInventoryMov, CostDate, UnitCost, Quantity)
		SELECT IDCost, IDTouristGroup, IDCostType, IDInventoryMov, CostDate, UnitCost, Quantity FROM dbo.GroupCost TABLOCKX')
GO

DECLARE @temp Varchar (8000)
SET @temp = ''
SELECT @temp = @temp + 'ALTER TABLE ' + TabelaDerivada+ CHAR (13)+
+ CHAR(9)+'DROP CONSTRAINT ' + ConstraintName + CHAR (13)
FROM vw_Sis_ChaveEstrangeira
WHERE TabelaOriginal = 'GroupCost'
EXEC(@temp)
GO

DROP TABLE dbo.GroupCost
GO

ALTER TABLE dbo.Tmp_GroupCost ADD CONSTRAINT
	DF_GetDate2 DEFAULT (getdate()) FOR CostDate
GO

ALTER TABLE dbo.Tmp_GroupCost ADD CONSTRAINT
	DF_Zero120 DEFAULT (0) FOR Quantity
GO

EXECUTE sp_rename N'dbo.Tmp_GroupCost', N'GroupCost', 'OBJECT'
GO

ALTER TABLE dbo.GroupCost ADD CONSTRAINT
	PK__GroupCost__690797E6 PRIMARY KEY CLUSTERED 
	(
	IDCost
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX XIF139GroupCost ON dbo.GroupCost
	(
	IDTouristGroup
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX XIF140GroupCost ON dbo.GroupCost
	(
	IDCostType
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX XIF408GroupCost ON dbo.GroupCost
	(
	IDInventoryMov
	) ON [PRIMARY]
GO

ALTER TABLE dbo.GroupCost WITH NOCHECK ADD CONSTRAINT
	FK_CostType_GroupCost_IDCostType FOREIGN KEY
	(
	IDCostType
	) REFERENCES dbo.CostType
	(
	IDCostType
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.GroupCost WITH NOCHECK ADD CONSTRAINT
	FK_InventoryMov_GroupCost_IDInventoryMov FOREIGN KEY
	(
	IDInventoryMov
	) REFERENCES dbo.InventoryMov
	(
	IDInventoryMov
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.GroupCost WITH NOCHECK ADD CONSTRAINT
	FK_TouristGroup_GroupCost_IDTourisGroup FOREIGN KEY
	(
	IDTouristGroup
	) REFERENCES dbo.TouristGroup
	(
	IDTouristGroup
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.GroupCostGift WITH NOCHECK ADD CONSTRAINT
	FK_GroupCost_GroupCostGift_IDGroupCost FOREIGN KEY
	(
	IDGroupCost
	) REFERENCES dbo.GroupCost
	(
	IDCost
	) NOT FOR REPLICATION
GO

