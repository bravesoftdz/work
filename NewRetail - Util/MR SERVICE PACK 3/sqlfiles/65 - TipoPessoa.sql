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

CREATE TABLE dbo.Tmp_TipoPessoa
	(
	IDTipoPessoa int NOT NULL,
	Path varchar(150) NOT NULL,
	TipoPessoa varchar(50) NOT NULL,
	PathName varchar(255) NOT NULL,
	DefaultDiaPag int NULL,
	ComissionOnProfit bit NULL,
	System bit NULL,
	Desativado bit NULL,
	Hidden bit NULL,
	LastCode int NULL
	)  ON [PRIMARY]
GO

IF EXISTS(SELECT * FROM dbo.TipoPessoa)
	 EXEC('INSERT INTO dbo.Tmp_TipoPessoa (IDTipoPessoa, Path, TipoPessoa, PathName, DefaultDiaPag, ComissionOnProfit, System, Desativado, Hidden, LastCode)
		SELECT IDTipoPessoa, Path, TipoPessoa, PathName, DefaultDiaPag, ComissionOnProfit, System, Desativado, Hidden, LastCode FROM dbo.TipoPessoa TABLOCKX')
GO

DECLARE @temp Varchar (8000)
SET @temp = ''
SELECT @temp = @temp + 'ALTER TABLE ' + TabelaDerivada+ CHAR (13)+
+ CHAR(9)+'DROP CONSTRAINT ' + ConstraintName + CHAR (13)
FROM vw_Sis_ChaveEstrangeira
WHERE TabelaOriginal = 'TipoPessoa'
EXEC(@temp)
GO

DROP TABLE dbo.TipoPessoa
GO

ALTER TABLE dbo.Tmp_TipoPessoa ADD CONSTRAINT
	DF_Zero18 DEFAULT (0) FOR ComissionOnProfit
GO

ALTER TABLE dbo.Tmp_TipoPessoa ADD CONSTRAINT
	DF_Zero19 DEFAULT (0) FOR System
GO

ALTER TABLE dbo.Tmp_TipoPessoa ADD CONSTRAINT
	DF_Zero20 DEFAULT (0) FOR Desativado
GO

ALTER TABLE dbo.Tmp_TipoPessoa ADD CONSTRAINT
	DF_Zero21 DEFAULT (0) FOR Hidden
GO

EXECUTE sp_rename N'dbo.Tmp_TipoPessoa', N'TipoPessoa', 'OBJECT'
GO

ALTER TABLE dbo.TipoPessoa ADD CONSTRAINT
	PK__TipoPessoa__33D4B598 PRIMARY KEY CLUSTERED 
	(
	IDTipoPessoa
	) ON [PRIMARY]

GO

CREATE NONCLUSTERED INDEX PI_TipoPessoa_Path ON dbo.TipoPessoa
	(
	Path
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX PI_TipoPessoa_PathName ON dbo.TipoPessoa
	(
	PathName
	) ON [PRIMARY]
GO

CREATE TRIGGER tr_TipoPessoa_Delete ON dbo.TipoPessoa
FOR DELETE
NOT FOR REPLICATION
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Deleto de GroupToComissionType


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

IF @@RowCount = 0
   RETURN

SET NOCOUNT ON

DELETE
	GroupToComissionType
FROM
	TabGroup,
	Deleted
WHERE
	GroupToComissionType.IDTipoComissionado = Deleted.IDTipoPessoa

GO

CREATE TRIGGER tr_TipoPessoa_InsUpt ON dbo.TipoPessoa
FOR INSERT,UPDATE
NOT FOR REPLICATION
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Testo a existencia do TipoPessoa
		- Incluo em GroupToComissionType


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

SET NOCOUNT ON

if	EXISTS 	(
		SELECT
			INSERTED.IDTipoPessoa
		FROM
			INSERTED,
			TipoPessoa
		WHERE
			INSERTED.TipoPessoa = TipoPessoa.TipoPessoa
			AND
			INSERTED.Path = TipoPessoa.Path
			AND
			TipoPessoa.IDTipoPessoa <> INSERTED.IDTipoPessoa
			AND
			INSERTED.Desativado = 0
			AND
			TipoPessoa.Desativado = 0
		)

	BEGIN
		RAISERROR ('DUP_TipoPessoa_TipoPessoa can not be duplicated',16,-1)
		ROLLBACK TRANSACTION
		RETURN
	END

/* So faz na inclusao  */
if 	NOT EXISTS
		(
		SELECT
			Deleted.IDTipoPessoa
		FROM
			Deleted
		)
	BEGIN
		INSERT
			GroupToComissionType
		SELECT
			Inserted.IDTipoPessoa,
			TabGroup.IDGroup,
			0
		FROM
			TabGroup,
			Inserted
		WHERE
			(TabGroup.Desativado = 0)
			AND (INSERTED.Path like '.003.%')
			AND NOT (INSERTED.Path like '.003.003%')
	END
GO

ALTER TABLE dbo.Fin_LancamentoTipo WITH NOCHECK ADD CONSTRAINT
	FK_TipoPessoa_LancamentoTipo_IDPessoaTipo FOREIGN KEY
	(
	IDPessoaTipo
	) REFERENCES dbo.TipoPessoa
	(
	IDTipoPessoa
	) NOT FOR REPLICATION

GO

ALTER TABLE dbo.Fin_Lancamento WITH NOCHECK ADD CONSTRAINT
	FK_TipoPessoa_Lancamento_IDPessoaTipo FOREIGN KEY
	(
	IDPessoaTipo
	) REFERENCES dbo.TipoPessoa
	(
	IDTipoPessoa
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.DiscRange WITH NOCHECK ADD CONSTRAINT
	FK_TipoPessoa_DiscRange_IDTipoComissionado FOREIGN KEY
	(
	IDTipoComissionado
	) REFERENCES dbo.TipoPessoa
	(
	IDTipoPessoa
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.Pessoa WITH NOCHECK ADD CONSTRAINT
	FK_TipoPessoa_Pessoa_IDTipoPessoaRoot FOREIGN KEY
	(
	IDTipoPessoaRoot
	) REFERENCES dbo.TipoPessoa
	(
	IDTipoPessoa
	) NOT FOR REPLICATION

GO

ALTER TABLE dbo.Pessoa WITH NOCHECK ADD CONSTRAINT
	FK_TipoPessoa_Pessoa_IDTipoPessoaFilho FOREIGN KEY
	(
	IDTipoPessoaFilho
	) REFERENCES dbo.TipoPessoa
	(
	IDTipoPessoa
	) NOT FOR REPLICATION

GO

ALTER TABLE dbo.Pessoa WITH NOCHECK ADD CONSTRAINT
	FK_TipoPessoa_Pessoa_IDTipoPessoa FOREIGN KEY
	(
	IDTipoPessoa
	) REFERENCES dbo.TipoPessoa
	(
	IDTipoPessoa
	) NOT FOR REPLICATION

GO

ALTER TABLE dbo.GroupToComissionType WITH NOCHECK ADD CONSTRAINT
	FK_TipoPessoa_GroupToComissionType_IDTipoComissionado FOREIGN KEY
	(
	IDTipoComissionado
	) REFERENCES dbo.TipoPessoa
	(
	IDTipoPessoa
	) NOT FOR REPLICATION

GO

