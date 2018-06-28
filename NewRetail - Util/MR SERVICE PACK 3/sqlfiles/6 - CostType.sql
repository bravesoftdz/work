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

CREATE TABLE dbo.Tmp_CostType
	(
	IDCostType int NOT NULL,
	CostType varchar(50) NOT NULL,
	DefaultValue money NOT NULL,
	Desativado int NULL,
	Hidden bit NULL,
	System bit NULL
	)  ON [PRIMARY]
GO


IF EXISTS(SELECT * FROM dbo.CostType)
	 EXEC('INSERT INTO dbo.Tmp_CostType (IDCostType, CostType, DefaultValue, Desativado, Hidden, System)
		SELECT IDCostType, CostType, DefaultValue, Desativado, Hidden, System FROM dbo.CostType TABLOCKX')
GO

DECLARE @temp Varchar (8000)
SET @temp = ''
SELECT @temp = @temp + 'ALTER TABLE ' + TabelaDerivada+ CHAR (13)+
+ CHAR(9)+'DROP CONSTRAINT ' + ConstraintName + CHAR (13)
FROM vw_Sis_ChaveEstrangeira
WHERE TabelaOriginal = 'CostType'
EXEC(@temp)
GO

DROP TABLE dbo.CostType
GO

ALTER TABLE dbo.Tmp_CostType ADD CONSTRAINT
	DF_Zero109 DEFAULT (0) FOR Desativado
GO

ALTER TABLE dbo.Tmp_CostType ADD CONSTRAINT
	DF_Zero110 DEFAULT (0) FOR Hidden
GO

ALTER TABLE dbo.Tmp_CostType ADD CONSTRAINT
	DF_Zero111 DEFAULT (0) FOR System
GO

EXECUTE sp_rename N'dbo.Tmp_CostType', N'CostType', 'OBJECT'
GO

ALTER TABLE dbo.CostType ADD CONSTRAINT
	PK_TipoCusto_4__10 PRIMARY KEY CLUSTERED 
	(
	IDCostType
	) ON [PRIMARY]

GO

CREATE NONCLUSTERED INDEX PI_CostType_CostType ON dbo.CostType
	(
	CostType
	) ON [PRIMARY]
GO

CREATE TRIGGER tr_CostType_InsUpt ON dbo.CostType
FOR INSERT,UPDATE
NOT FOR REPLICATION
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Testo a existencia do CostType

	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

SET NOCOUNT ON

if	EXISTS 	(
		SELECT
			INSERTED.IDCostType
		FROM
			INSERTED,
			CostType
		WHERE
			INSERTED.CostType = CostType.CostType
			AND
			CostType.IDCostType <> INSERTED.IDCostType
			AND
			INSERTED.Desativado = 0
			AND
			CostType.Desativado = 0
		)

	BEGIN
		RAISERROR ('DUP_CostType_CostType can not be duplicated',16,-1)
		ROLLBACK TRANSACTION
		RETURN
	END
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
