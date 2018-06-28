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

CREATE TABLE dbo.Tmp_Fin_CentroCusto
	(
	IDCentroCusto int NOT NULL,
	CentroCusto TDescricao NOT NULL,
	CodigoCentroCusto TCodigoGeral NULL,
	Desativado TBit NULL,
	Hidden TBit NULL,
	System TBit NULL,
	IDCentroCustoParent int NULL
	)  ON [PRIMARY]
GO

EXECUTE sp_bindefault N'dbo.DEF_Bit', N'Tmp_Fin_CentroCusto.Desativado'
GO

EXECUTE sp_bindefault N'dbo.DEF_Bit', N'Tmp_Fin_CentroCusto.Hidden'
GO

EXECUTE sp_bindefault N'dbo.DEF_Bit', N'Tmp_Fin_CentroCusto.System'
GO

IF EXISTS(SELECT * FROM dbo.Fin_CentroCusto)
	 EXEC('INSERT INTO dbo.Tmp_Fin_CentroCusto (IDCentroCusto, CentroCusto, CodigoCentroCusto, Desativado, Hidden, System, IDCentroCustoParent)
		SELECT IDCentroCusto, CentroCusto, CodigoCentroCusto, Desativado, Hidden, System, IDCentroCustoParent FROM dbo.Fin_CentroCusto TABLOCKX')
GO

DECLARE @temp Varchar (8000)
SET @temp = ''
SELECT @temp = @temp + 'ALTER TABLE ' + TabelaDerivada+ CHAR (13)+
+ CHAR(9)+'DROP CONSTRAINT ' + ConstraintName + CHAR (13)
FROM vw_Sis_ChaveEstrangeira
WHERE TabelaOriginal = 'Fin_CentroCusto'
EXEC(@temp)
GO

DROP TABLE dbo.Fin_CentroCusto
GO

EXECUTE sp_rename N'dbo.Tmp_Fin_CentroCusto', N'Fin_CentroCusto', 'OBJECT'
GO

ALTER TABLE dbo.Fin_CentroCusto ADD CONSTRAINT
	PK__Fin_CentroCusto__4316F928 PRIMARY KEY CLUSTERED 
	(
	IDCentroCusto
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX XIF402Fin_CentroCusto ON dbo.Fin_CentroCusto
	(
	IDCentroCustoParent
	) ON [PRIMARY]
GO

ALTER TABLE dbo.Fin_CentroCusto WITH NOCHECK ADD CONSTRAINT
	FK_CentroCusto_CentroCusto_IDCentroCustoParent FOREIGN KEY
	(
	IDCentroCustoParent
	) REFERENCES dbo.Fin_CentroCusto
	(
	IDCentroCusto
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.Fin_Lancamento WITH NOCHECK ADD CONSTRAINT
	FK_CentroCusto_Lancamento_IDCentroCusto FOREIGN KEY
	(
	IDCentroCusto
	) REFERENCES dbo.Fin_CentroCusto
	(
	IDCentroCusto
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.Fin_ContaCorrente WITH NOCHECK ADD CONSTRAINT
	FK_CentroCusto_ContaCorrente_IDCentroCusto FOREIGN KEY
	(
	IDCentroCusto
	) REFERENCES dbo.Fin_CentroCusto
	(
	IDCentroCusto
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.Store WITH NOCHECK ADD CONSTRAINT
	FK_CentroCusto_Store_IDCentroCusto FOREIGN KEY
	(
	IDCentroCusto
	) REFERENCES dbo.Fin_CentroCusto
	(
	IDCentroCusto
	) NOT FOR REPLICATION
GO
