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

CREATE TABLE dbo.Tmp_GroupCostGift
	(
	IDGroupCostGift int NOT NULL,
	IDGroupCost int NOT NULL,
	IDModel int NOT NULL,
	IDUser int NOT NULL,
	Desativado bit NULL
	)  ON [PRIMARY]
GO

IF EXISTS(SELECT * FROM dbo.GroupCostGift)
	 EXEC('INSERT INTO dbo.Tmp_GroupCostGift (IDGroupCostGift, IDGroupCost, IDModel, IDUser, Desativado)
		SELECT IDGroupCostGift, IDGroupCost, IDModel, IDUser, Desativado FROM dbo.GroupCostGift TABLOCKX')
GO

DECLARE @temp Varchar (8000)
SET @temp = ''
SELECT @temp = @temp + 'ALTER TABLE ' + TabelaDerivada+ CHAR (13)+
+ CHAR(9)+'DROP CONSTRAINT ' + ConstraintName + CHAR (13)
FROM vw_Sis_ChaveEstrangeira
WHERE TabelaOriginal = 'GroupCostGift'
EXEC(@temp)
GO

DROP TABLE dbo.GroupCostGift
GO

EXECUTE sp_rename N'dbo.Tmp_GroupCostGift', N'GroupCostGift', 'OBJECT'
GO

ALTER TABLE dbo.GroupCostGift ADD CONSTRAINT
	PK_GroupCostGift_1__12 PRIMARY KEY CLUSTERED 
	(
	IDGroupCostGift
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX XIF409GroupCostGift ON dbo.GroupCostGift
	(
	IDGroupCost
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX XIF410GroupCostGift ON dbo.GroupCostGift
	(
	IDModel
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX XIF411GroupCostGift ON dbo.GroupCostGift
	(
	IDUser
	) ON [PRIMARY]
GO

ALTER TABLE dbo.GroupCostGift WITH NOCHECK ADD CONSTRAINT
	FK_SystemUser_GroupCostGift_IDUser FOREIGN KEY
	(
	IDUser
	) REFERENCES dbo.SystemUser
	(
	IDUser
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.GroupCostGift WITH NOCHECK ADD CONSTRAINT
	FK_Model_GroupCostGift_IDModel FOREIGN KEY
	(
	IDModel
	) REFERENCES dbo.Model
	(
	IDModel
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
