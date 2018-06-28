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

CREATE TABLE dbo.Tmp_Fin_DocumentoTipo
	(
	IDDocumentoTipo int NOT NULL,
	IDDesdobramentoTipoDefault int NULL,
	CodigoDocumentoTipo TCodigoGeral NOT NULL,
	DocumentoTipo TDescricao NOT NULL,
	Hidden TBit NULL,
	PossuiDesdobramento TBit NULL,
	DataEmissaoObrigatoria TBit NULL,
	Desativado TBit NULL,
	NumDocumentoObrigatorio TBit NULL,
	System TBit NULL,
	DesdobramentoObrigatorio TBit NULL,
	IdentificadorDocumento TCodigoGeral NULL
	)  ON [PRIMARY]
GO

EXECUTE sp_bindefault N'dbo.DEF_Bit', N'Tmp_Fin_DocumentoTipo.Hidden'
GO

EXECUTE sp_bindefault N'dbo.DEF_Bit', N'Tmp_Fin_DocumentoTipo.PossuiDesdobramento'
GO

EXECUTE sp_bindefault N'dbo.DEF_Bit', N'Tmp_Fin_DocumentoTipo.DataEmissaoObrigatoria'
GO

EXECUTE sp_bindefault N'dbo.DEF_Bit', N'Tmp_Fin_DocumentoTipo.Desativado'
GO

EXECUTE sp_bindefault N'dbo.DEF_Bit', N'Tmp_Fin_DocumentoTipo.NumDocumentoObrigatorio'
GO

EXECUTE sp_bindefault N'dbo.DEF_Bit', N'Tmp_Fin_DocumentoTipo.System'
GO

EXECUTE sp_bindefault N'dbo.DEF_Bit', N'Tmp_Fin_DocumentoTipo.DesdobramentoObrigatorio'
GO

IF EXISTS(SELECT * FROM dbo.Fin_DocumentoTipo)
	 EXEC('INSERT INTO dbo.Tmp_Fin_DocumentoTipo (IDDocumentoTipo, IDDesdobramentoTipoDefault, CodigoDocumentoTipo, DocumentoTipo, Hidden, PossuiDesdobramento, DataEmissaoObrigatoria, Desativado, NumDocumentoObrigatorio, System, DesdobramentoObrigatorio, IdentificadorDocumento)
		SELECT IDDocumentoTipo, IDDesdobramentoTipoDefault, CodigoDocumentoTipo, DocumentoTipo, Hidden, PossuiDesdobramento, DataEmissaoObrigatoria, Desativado, NumDocumentoObrigatorio, System, DesdobramentoObrigatorio, IdentificadorDocumento FROM dbo.Fin_DocumentoTipo TABLOCKX')
GO

DECLARE @temp Varchar (8000)
SET @temp = ''
SELECT @temp = @temp + 'ALTER TABLE ' + TabelaDerivada+ CHAR (13)+
+ CHAR(9)+'DROP CONSTRAINT ' + ConstraintName + CHAR (13)
FROM vw_Sis_ChaveEstrangeira
WHERE TabelaOriginal = 'Fin_DocumentoTipo'
EXEC(@temp)
GO

DROP TABLE dbo.Fin_DocumentoTipo
GO

EXECUTE sp_rename N'dbo.Tmp_Fin_DocumentoTipo', N'Fin_DocumentoTipo', 'OBJECT'
GO

ALTER TABLE dbo.Fin_DocumentoTipo ADD CONSTRAINT
	PK__Fin_DocumentoTip__17036CC0 PRIMARY KEY CLUSTERED 
	(
	IDDocumentoTipo
	) ON [PRIMARY]

GO

CREATE NONCLUSTERED INDEX XIF403Fin_DocumentoTipo ON dbo.Fin_DocumentoTipo
	(
	IDDesdobramentoTipoDefault
	) ON [PRIMARY]
GO

ALTER TABLE dbo.Fin_Lancamento WITH NOCHECK ADD CONSTRAINT
	FK_DocumentoTipo_Lancamento_IDDocumentoTipo FOREIGN KEY
	(
	IDDocumentoTipo
	) REFERENCES dbo.Fin_DocumentoTipo
	(
	IDDocumentoTipo
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

