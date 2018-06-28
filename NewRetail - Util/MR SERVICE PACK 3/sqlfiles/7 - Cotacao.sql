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

CREATE TABLE dbo.Tmp_Cotacao
	(
	IDCotacao int NOT NULL,
	Cotacao varchar(50) NOT NULL,
	IDStore int NOT NULL,
	UltimaEmissao smalldatetime NULL,
	Desativado int NULL,
	Hidden bit NULL,
	DataCotacao smalldatetime NULL
	)  ON [PRIMARY]
GO

IF EXISTS(SELECT * FROM dbo.Cotacao)
	 EXEC('INSERT INTO dbo.Tmp_Cotacao (IDCotacao, Cotacao, IDStore, UltimaEmissao, Desativado, Hidden, DataCotacao)
		SELECT IDCotacao, Cotacao, IDStore, UltimaEmissao, Desativado, Hidden, DataCotacao FROM dbo.Cotacao TABLOCKX')
GO

DECLARE @temp Varchar (8000)
SET @temp = ''
SELECT @temp = @temp + 'ALTER TABLE ' + TabelaDerivada+ CHAR (13)+
+ CHAR(9)+'DROP CONSTRAINT ' + ConstraintName + CHAR (13)
FROM vw_Sis_ChaveEstrangeira
WHERE TabelaOriginal = 'Cotacao'
EXEC(@temp)
GO

DROP TABLE dbo.Cotacao
GO

ALTER TABLE dbo.Tmp_Cotacao ADD CONSTRAINT
	DF_Zero125 DEFAULT (0) FOR Desativado
GO

ALTER TABLE dbo.Tmp_Cotacao ADD CONSTRAINT
	DF_Zero126 DEFAULT (0) FOR Hidden
GO

EXECUTE sp_rename N'dbo.Tmp_Cotacao', N'Cotacao', 'OBJECT'
GO

ALTER TABLE dbo.Cotacao ADD CONSTRAINT
	PK__Cotacao__7C1A6C5A PRIMARY KEY CLUSTERED 
	(
	IDCotacao
	) ON [PRIMARY]
GO

CREATE UNIQUE NONCLUSTERED INDEX UK_Cotacao_Cotacao ON dbo.Cotacao
	(
	Cotacao
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX XIF159Cotacao ON dbo.Cotacao
	(
	IDStore
	) ON [PRIMARY]
GO

ALTER TABLE dbo.Cotacao WITH NOCHECK ADD CONSTRAINT
	FK_Store_Cotacao_IDStore FOREIGN KEY
	(
	IDStore
	) REFERENCES dbo.Store
	(
	IDStore
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.CotacaoToModel WITH NOCHECK ADD CONSTRAINT
	FK_Cotacao_CotacaoToModel_IDCotacao FOREIGN KEY
	(
	IDCotacao
	) REFERENCES dbo.Cotacao
	(
	IDCotacao
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.CotacaoResult WITH NOCHECK ADD CONSTRAINT
	FK_Cotacao_CotacaoResult_IDCotacao FOREIGN KEY
	(
	IDCotacao
	) REFERENCES dbo.Cotacao
	(
	IDCotacao
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.CotacaoToFornec WITH NOCHECK ADD CONSTRAINT
	FK_Cotacao_CotacaoToFornec_IDCotacao FOREIGN KEY
	(
	IDCotacao
	) REFERENCES dbo.Cotacao
	(
	IDCotacao
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.Request WITH NOCHECK ADD CONSTRAINT
	FK_Cotacao_Request_IDCotacao FOREIGN KEY
	(
	IDCotacao
	) REFERENCES dbo.Cotacao
	(
	IDCotacao
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.PreInventoryMov WITH NOCHECK ADD CONSTRAINT
	FK_Cotacao_PreInventoryMov_IDCotacao FOREIGN KEY
	(
	IDCotacao
	) REFERENCES dbo.Cotacao
	(
	IDCotacao
	) NOT FOR REPLICATION

GO

