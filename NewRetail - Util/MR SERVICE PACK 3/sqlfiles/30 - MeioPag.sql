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

CREATE TABLE dbo.Tmp_MeioPag
	(
	IDMeioPag int NOT NULL,
	IDContaCorrente int NULL,
	IDLancamentoTipo int NULL,
	IDPessoa int NULL,
	IDMeioPagBatch int NULL,
	MeioPag varchar(50) NOT NULL,
	CodigoMeioPag TCodigoGeral NULL,
	TemDocumento bit NULL,
	PrazoRecebimento int NOT NULL,
	TaxaAdmin money NOT NULL,
	System bit NULL,
	Desativado bit NULL,
	Hidden bit NULL,
	IdentificadorDocumento varchar(20) NULL,
	TaxMode int NULL,
	Tipo int NULL,
	PossuiFavorecido TBit NULL,
	ObrigaFavorecido TBit NULL,
	PossuiNumero TBit NULL,
	ObrigaNumero TBit NULL,
	ParentType varchar(20) NULL,
	AutoDiscountFee TBit NULL
	)  ON [PRIMARY]
GO

IF EXISTS(SELECT * FROM dbo.MeioPag)
	 EXEC('INSERT INTO dbo.Tmp_MeioPag (IDMeioPag, IDContaCorrente, IDLancamentoTipo, IDPessoa, IDMeioPagBatch, MeioPag, CodigoMeioPag, TemDocumento, PrazoRecebimento, TaxaAdmin, System, Desativado, Hidden, IdentificadorDocumento, TaxMode, Tipo, PossuiFavorecido, ObrigaFavorecido, PossuiNumero, ObrigaNumero, ParentType, AutoDiscountFee)
		SELECT IDMeioPag, IDContaCorrente, IDLancamentoTipo, IDPessoa, IDMeioPagBatch, MeioPag, CodigoMeioPag, TemDocumento, PrazoRecebimento, TaxaAdmin, System, Desativado, Hidden, IdentificadorDocumento, TaxMode, Tipo, PossuiFavorecido, ObrigaFavorecido, PossuiNumero, ObrigaNumero, ParentType, AutoDiscountFee FROM dbo.MeioPag TABLOCKX')
GO

DECLARE @temp Varchar (8000)
SET @temp = ''
SELECT @temp = @temp + 'ALTER TABLE ' + TabelaDerivada+ CHAR (13)+
+ CHAR(9)+'DROP CONSTRAINT ' + ConstraintName + CHAR (13)
FROM vw_Sis_ChaveEstrangeira
WHERE TabelaOriginal = 'MeioPag'
EXEC(@temp)
GO

DROP TABLE dbo.MeioPag
GO

ALTER TABLE dbo.Tmp_MeioPag ADD CONSTRAINT
	DF_Zero95 DEFAULT (0) FOR TemDocumento
GO

ALTER TABLE dbo.Tmp_MeioPag ADD CONSTRAINT
	DF_Zero96 DEFAULT (0) FOR PrazoRecebimento
GO

ALTER TABLE dbo.Tmp_MeioPag ADD CONSTRAINT
	DF_Zero97 DEFAULT (0) FOR TaxaAdmin
GO

ALTER TABLE dbo.Tmp_MeioPag ADD CONSTRAINT
	DF_Zero98 DEFAULT (0) FOR System
GO

ALTER TABLE dbo.Tmp_MeioPag ADD CONSTRAINT
	DF_Zero99 DEFAULT (0) FOR Desativado
GO

ALTER TABLE dbo.Tmp_MeioPag ADD CONSTRAINT
	DF_Zero100 DEFAULT (0) FOR Hidden
GO


EXECUTE sp_rename N'dbo.Tmp_MeioPag', N'MeioPag', 'OBJECT'
GO

ALTER TABLE dbo.MeioPag ADD CONSTRAINT
	PK__MeioPag__3A4CA8FD PRIMARY KEY CLUSTERED 
	(
	IDMeioPag
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX PI_MeioPag_MeioPag ON dbo.MeioPag
	(
	MeioPag
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX XIF413MeioPag ON dbo.MeioPag
	(
	IDLancamentoTipo
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX XIF414MeioPag ON dbo.MeioPag
	(
	IDPessoa
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX XIF73MeioPag ON dbo.MeioPag
	(
	IDContaCorrente
	) ON [PRIMARY]
GO

ALTER TABLE dbo.MeioPag WITH NOCHECK ADD CONSTRAINT
	FK_ContaCorrente_MeioPag_IDContaCorrente FOREIGN KEY
	(
	IDContaCorrente
	) REFERENCES dbo.Fin_ContaCorrente
	(
	IDContaCorrente
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.MeioPag WITH NOCHECK ADD CONSTRAINT
	FK_Pessoa_MeioPag_IDPessoa FOREIGN KEY
	(
	IDPessoa
	) REFERENCES dbo.Pessoa
	(
	IDPessoa
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.MeioPag WITH NOCHECK ADD CONSTRAINT
	FK_LancamentoTipo_MeioPag_IDLancamentoTipo FOREIGN KEY
	(
	IDLancamentoTipo
	) REFERENCES dbo.Fin_LancamentoTipo
	(
	IDLancamentoTipo
	) NOT FOR REPLICATION
GO

CREATE TRIGGER tr_MeioPag_Del on dbo.MeioPag
FOR DELETE
NOT FOR REPLICATION
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Deleto de MeioPagToStore


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

IF @@ROWCOUNT = 0 RETURN

SET NOCOUNT ON

DELETE
	MeioPagToStore
FROM
	MeioPag,
	Deleted
WHERE
	MeioPagToStore.IDMeioPag = DELETED.IDMeioPag

GO

CREATE TRIGGER tr_MeioPag_InsUpt on dbo.MeioPag
FOR INSERT,UPDATE
NOT FOR REPLICATION
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Testo a existencia do MeioPag
		- Insiro MeioPagToStore


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

IF @@rowcount = 0 RETURN

SET NOCOUNT ON

IF	EXISTS 	(
		SELECT	INSERTED.IDMeioPag
		FROM	INSERTED, MeioPag
		WHERE 	INSERTED.MeioPag = MeioPag.MeioPag	  AND
			MeioPag.IDMeioPag <> INSERTED.IDMeioPag	  AND
			INSERTED.Desativado =0 		  AND
			MeioPag.Desativado = 0
		)
	
	BEGIN
		RAISERROR ('DUP_MeioPag_MeioPag can not be duplicated',16,-1)
		ROLLBACK TRANSACTION
		RETURN	
	END

/* So faz na inclusao  */

IF 	NOT EXISTS	
		(
		SELECT
			Deleted.IDMeioPag
		FROM	
			Deleted
		)
	BEGIN
		INSERT 
			MeioPagToStore (IDStore, IDMeioPag) 
		SELECT 
			Store.IDStore, Inserted.IDMeioPag 
		FROM
			Store, Inserted


		INSERT 
			MeioPagMinSale (IDMeioPag, DifDay, TotalSale) 
		SELECT 
			INSERTED.IDMeioPag, 0, 0 
		FROM 
			INSERTED
	END

GO

ALTER TABLE dbo.Fin_Quitacao WITH NOCHECK ADD CONSTRAINT
	FK_MeioPag_Quitacao_IDQuitacaoMeio FOREIGN KEY
	(
	IDQuitacaoMeio
	) REFERENCES dbo.MeioPag
	(
	IDMeioPag
	) NOT FOR REPLICATION

GO

ALTER TABLE dbo.Fin_Lancamento WITH NOCHECK ADD CONSTRAINT
	FK_MeioPag_Lancamento_IDQuitacaoMeioPrevisto FOREIGN KEY
	(
	IDQuitacaoMeioPrevisto
	) REFERENCES dbo.MeioPag
	(
	IDMeioPag
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.MeioPagMinSale WITH NOCHECK ADD CONSTRAINT
	FK_MeioPag_MeioPagMinSale_IDMeioPag FOREIGN KEY
	(
	IDMeioPag
	) REFERENCES dbo.MeioPag
	(
	IDMeioPag
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.Invoice WITH NOCHECK ADD CONSTRAINT
	FK_MeioPag_Invoice_IDMeioPag FOREIGN KEY
	(
	IDMeioPag
	) REFERENCES dbo.MeioPag
	(
	IDMeioPag
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.MeioPagToStore WITH NOCHECK ADD CONSTRAINT
	FK_MeioPag_MeioPagToStore_IDMeioPag FOREIGN KEY
	(
	IDMeioPag
	) REFERENCES dbo.MeioPag
	(
	IDMeioPag
	) NOT FOR REPLICATION
GO

