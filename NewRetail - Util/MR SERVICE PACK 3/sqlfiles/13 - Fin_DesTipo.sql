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

CREATE TABLE dbo.Tmp_Fin_DesdobramentoTipo
	(
	IDDesdobramentoTipo int NOT NULL,
	IDDocumentoTipo int NOT NULL,
	DesdobramentoTipo TDescricao NOT NULL,
	CodigoDesdobramentoTipo TCodigoGeral NOT NULL,
	IdentificadorDesdobramento TCodigoGeral NULL,
	Hidden TControlField NOT NULL,
	System TControlField NOT NULL,
	Desativado TControlField NOT NULL,
	ObrigaNumeroDesdobramento TBit NULL
	)  ON [PRIMARY]
GO

IF EXISTS(SELECT * FROM dbo.Fin_DesdobramentoTipo)
	 EXEC('INSERT INTO dbo.Tmp_Fin_DesdobramentoTipo (IDDesdobramentoTipo, IDDocumentoTipo, DesdobramentoTipo, CodigoDesdobramentoTipo, IdentificadorDesdobramento, Hidden, System, Desativado, ObrigaNumeroDesdobramento)
		SELECT IDDesdobramentoTipo, IDDocumentoTipo, DesdobramentoTipo, CodigoDesdobramentoTipo, IdentificadorDesdobramento, Hidden, System, Desativado, ObrigaNumeroDesdobramento FROM dbo.Fin_DesdobramentoTipo TABLOCKX')
GO

DECLARE @temp Varchar (8000)
SET @temp = ''
SELECT @temp = @temp + 'ALTER TABLE ' + TabelaDerivada+ CHAR (13)+
+ CHAR(9)+'DROP CONSTRAINT ' + ConstraintName + CHAR (13)
FROM vw_Sis_ChaveEstrangeira
WHERE TabelaOriginal = 'Fin_DesdobramentoTipo'
EXEC(@temp)
GO

DROP TABLE dbo.Fin_DesdobramentoTipo
GO

EXECUTE sp_rename N'dbo.Tmp_Fin_DesdobramentoTipo', N'Fin_DesdobramentoTipo', 'OBJECT'
GO

ALTER TABLE dbo.Fin_DesdobramentoTipo ADD CONSTRAINT
	PK__Fin_Desdobrament__18EBB532 PRIMARY KEY CLUSTERED 
	(
	IDDesdobramentoTipo
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX XIF237Fin_DesdobramentoTipo ON dbo.Fin_DesdobramentoTipo
	(
	IDDocumentoTipo
	) ON [PRIMARY]
GO

ALTER TABLE dbo.Fin_Lancamento WITH NOCHECK ADD CONSTRAINT
	FK_DesdobramentoTipo_Lancamento_IDDesdobramentoTipo FOREIGN KEY
	(
	IDDesdobramentoTipo
	) REFERENCES dbo.Fin_DesdobramentoTipo
	(
	IDDesdobramentoTipo
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.Fin_DocumentoTipo WITH NOCHECK ADD CONSTRAINT
	FK_DesdobramentoTipo_DocumentoTipo_IDDesdobramentoTipoDefault FOREIGN KEY
	(
	IDDesdobramentoTipoDefault
	) REFERENCES dbo.Fin_DesdobramentoTipo
	(
	IDDesdobramentoTipo
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.Fin_DesdobramentoTipo WITH NOCHECK ADD CONSTRAINT
	FK_DocumentoTipo_DesdobramentoTipo_IDDocumentoTipo FOREIGN KEY
	(
	IDDocumentoTipo
	) REFERENCES dbo.Fin_DocumentoTipo
	(
	IDDocumentoTipo
	) NOT FOR REPLICATION
GO

