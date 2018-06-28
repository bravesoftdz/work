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

CREATE TABLE dbo.Tmp_Fin_LancamentoTipo
	(
	IDLancamentoTipo int NOT NULL,
	IDPessoa int NULL,
	IDPessoaTipo int NULL,
	IDContaCorrenteDefault int NULL,
	IDLancamentoTipoParent int NULL,
	LancamentoTipo varchar(65) NULL,
	Path TPath NULL,
	PathName varchar(255) NULL,
	Pagando TBit NULL,
	System TControlField NOT NULL,
	Hidden TControlField NOT NULL,
	Desativado TControlField NOT NULL,
	PermitePessoaNula TBit NULL,
	SugerePessoa TBit NULL,
	PessoaFixa TBit NULL,
	SugereContaCorrente TBit NULL,
	ContaCorrenteFixa TBit NULL,
	CodigoContabil varchar(35) NULL,
	Sintetico TBit NULL
	)  ON [PRIMARY]
GO

IF EXISTS(SELECT * FROM dbo.Fin_LancamentoTipo)
	 EXEC('INSERT INTO dbo.Tmp_Fin_LancamentoTipo (IDLancamentoTipo, IDPessoa, IDPessoaTipo, IDContaCorrenteDefault, IDLancamentoTipoParent, LancamentoTipo, Path, PathName, Pagando, System, Hidden, Desativado, PermitePessoaNula, SugerePessoa, PessoaFixa, SugereContaCorrente, ContaCorrenteFixa, CodigoContabil, Sintetico)
		SELECT IDLancamentoTipo, IDPessoa, IDPessoaTipo, IDContaCorrenteDefault, IDLancamentoTipoParent, LancamentoTipo, Path, PathName, Pagando, System, Hidden, Desativado, PermitePessoaNula, SugerePessoa, PessoaFixa, SugereContaCorrente, ContaCorrenteFixa, CodigoContabil, Sintetico FROM dbo.Fin_LancamentoTipo TABLOCKX')
GO

DECLARE @temp Varchar (8000)
SET @temp = ''
SELECT @temp = @temp + 'ALTER TABLE ' + TabelaDerivada+ CHAR (13)+
+ CHAR(9)+'DROP CONSTRAINT ' + ConstraintName + CHAR (13)
FROM vw_Sis_ChaveEstrangeira
WHERE TabelaOriginal = 'Fin_LancamentoTipo'
EXEC(@temp)
GO

DROP TABLE dbo.Fin_LancamentoTipo
GO

EXECUTE sp_rename N'dbo.Tmp_Fin_LancamentoTipo', N'Fin_LancamentoTipo', 'OBJECT'
GO

ALTER TABLE dbo.Fin_LancamentoTipo ADD CONSTRAINT
	PK__Fin_LancamentoTi__32AB8735 PRIMARY KEY CLUSTERED 
	(
	IDLancamentoTipo
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX XIF229Fin_LancamentoTipo ON dbo.Fin_LancamentoTipo
	(
	IDPessoa
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX XIF230Fin_LancamentoTipo ON dbo.Fin_LancamentoTipo
	(
	IDContaCorrenteDefault
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX XIF231Fin_LancamentoTipo ON dbo.Fin_LancamentoTipo
	(
	IDPessoaTipo
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX XIF405Fin_LancamentoTipo ON dbo.Fin_LancamentoTipo
	(
	IDLancamentoTipoParent
	) ON [PRIMARY]
GO

ALTER TABLE dbo.Fin_LancamentoTipo WITH NOCHECK ADD CONSTRAINT
	FK_ContaCorrente_LancamentoTipo_IDContaCorrenteDefault FOREIGN KEY
	(
	IDContaCorrenteDefault
	) REFERENCES dbo.Fin_ContaCorrente
	(
	IDContaCorrente
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.Fin_LancamentoTipo WITH NOCHECK ADD CONSTRAINT
	FK_LancamentoTipo_LancamentoTipo_IDLancamentoTipoParent FOREIGN KEY
	(
	IDLancamentoTipoParent
	) REFERENCES dbo.Fin_LancamentoTipo
	(
	IDLancamentoTipo
	) NOT FOR REPLICATION
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

ALTER TABLE dbo.Fin_LancamentoTipo WITH NOCHECK ADD CONSTRAINT
	FK_Pessoa_LancamentoTipo_IDPessoa FOREIGN KEY
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

ALTER TABLE dbo.Fin_Lancamento WITH NOCHECK ADD CONSTRAINT
	FK_LancamentoTipo_Lancamento_IDLancamentoTipo FOREIGN KEY
	(
	IDLancamentoTipo
	) REFERENCES dbo.Fin_LancamentoTipo
	(
	IDLancamentoTipo
	) NOT FOR REPLICATION
GO

