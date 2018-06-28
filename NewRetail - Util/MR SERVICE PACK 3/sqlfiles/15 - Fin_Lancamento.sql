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

CREATE TABLE dbo.Tmp_Fin_Lancamento
	(
	IDLancamento int NOT NULL,
	IDPreSale int NULL,
	IDQuitacaoMeioPrevisto int NULL,
	IDPessoaTipo int NULL,
	IDBancoAgenciaQuitPrev int NULL,
	IDEmpresa int NOT NULL,
	IDPessoa int NULL,
	IDBancoQuitPrev int NULL,
	IDDesdobramentoTipo int NULL,
	IDMoedaCotacao int NULL,
	IDMoeda int NULL,
	IDUsuarioLancamento int NULL,
	IDCentroCusto int NULL,
	IDLancamentoTipo int NULL,
	IDDocumentoTipo int NULL,
	IDContaCorrentePrevista int NULL,
	IDUsuarioProtesto int NULL,
	IDUsuarioAprovacao int NULL,
	IDLancamentoOriginal int NULL,
	IDCashRegMov int NULL,
	IDPurchase int NULL,
	Previsao TBit NULL,
	DataAprovacao smalldatetime NULL,
	Situacao int NULL,
	DataLancamento smalldatetime NOT NULL,
	DataVencimento smalldatetime NOT NULL,
	DataVencimentoOriginal datetime NULL,
	DataInicioQuitacao smalldatetime NULL,
	DataFimQuitacao smalldatetime NULL,
	DataProtesto smalldatetime NULL,
	Pagando TBit NULL,
	ValorNominal TValor NOT NULL,
	TotalQuitado TValor NOT NULL,
	TotalJuros TValor NOT NULL,
	NumDocumento TCodigoGeral NULL,
	NumDesdobramento TCodigoGeral NULL,
	NumMeioQuitPrevisto TCodigoGeral NULL,
	Desativado TControlField NOT NULL,
	Hidden TControlField NOT NULL,
	System TControlField NOT NULL,
	NumeroDuplicata TCodigoGeral NULL,
	MoedaSigla varchar(35) NULL,
	NumeroRepeticoes int NULL,
	PeriodicidadeRepeticoes int NULL,
	DiaRepeticoes int NULL,
	DataPrimeiraRepeticao smalldatetime NULL,
	DataEmissao datetime NULL,
	DataFaturamento datetime NULL,
	Historico text NULL,
	FavorecidoPrevisto varchar(65) NULL,
	LancamentoType int NULL,
	IDLancamentoParent int NULL
	)  ON [PRIMARY]
	 TEXTIMAGE_ON [PRIMARY]
GO

EXECUTE sp_bindefault N'dbo.DEF_Bit_True', N'Tmp_Fin_Lancamento.Previsao'
GO

EXECUTE sp_bindefault N'dbo.DEF_VALOR', N'Tmp_Fin_Lancamento.ValorNominal'
GO

EXECUTE sp_bindefault N'dbo.DEF_VALOR', N'Tmp_Fin_Lancamento.TotalQuitado'
GO

EXECUTE sp_bindefault N'dbo.DEF_VALOR', N'Tmp_Fin_Lancamento.TotalJuros'
GO

IF EXISTS(SELECT * FROM dbo.Fin_Lancamento)
	 EXEC('INSERT INTO dbo.Tmp_Fin_Lancamento (IDLancamento, IDPreSale, IDQuitacaoMeioPrevisto, IDPessoaTipo, IDBancoAgenciaQuitPrev, IDEmpresa, IDPessoa, IDBancoQuitPrev, IDDesdobramentoTipo, IDMoedaCotacao, IDMoeda, IDUsuarioLancamento, IDCentroCusto, IDLancamentoTipo, IDDocumentoTipo, IDContaCorrentePrevista, IDUsuarioProtesto, IDUsuarioAprovacao, IDLancamentoOriginal, IDCashRegMov, IDPurchase, Previsao, DataAprovacao, Situacao, DataLancamento, DataVencimento, DataVencimentoOriginal, DataInicioQuitacao, DataFimQuitacao, DataProtesto, Pagando, ValorNominal, TotalQuitado, TotalJuros, NumDocumento, NumDesdobramento, NumMeioQuitPrevisto, Desativado, Hidden, System, NumeroDuplicata, MoedaSigla, NumeroRepeticoes, PeriodicidadeRepeticoes, DiaRepeticoes, DataPrimeiraRepeticao, DataEmissao, DataFaturamento, Historico, FavorecidoPrevisto, LancamentoType, IDLancamentoParent)
		SELECT IDLancamento, IDPreSale, IDQuitacaoMeioPrevisto, IDPessoaTipo, IDBancoAgenciaQuitPrev, IDEmpresa, IDPessoa, IDBancoQuitPrev, IDDesdobramentoTipo, IDMoedaCotacao, IDMoeda, IDUsuarioLancamento, IDCentroCusto, IDLancamentoTipo, IDDocumentoTipo, IDContaCorrentePrevista, IDUsuarioProtesto, IDUsuarioAprovacao, IDLancamentoOriginal, IDCashRegMov, IDPurchase, Previsao, DataAprovacao, Situacao, DataLancamento, DataVencimento, DataVencimentoOriginal, DataInicioQuitacao, DataFimQuitacao, DataProtesto, Pagando, ValorNominal, TotalQuitado, TotalJuros, NumDocumento, NumDesdobramento, NumMeioQuitPrevisto, Desativado, Hidden, System, NumeroDuplicata, MoedaSigla, NumeroRepeticoes, PeriodicidadeRepeticoes, DiaRepeticoes, DataPrimeiraRepeticao, DataEmissao, DataFaturamento, Historico, FavorecidoPrevisto, LancamentoType, IDLancamentoParent FROM dbo.Fin_Lancamento TABLOCKX')
GO

DECLARE @temp Varchar (8000)
SET @temp = ''
SELECT @temp = @temp + 'ALTER TABLE ' + TabelaDerivada+ CHAR (13)+
+ CHAR(9)+'DROP CONSTRAINT ' + ConstraintName + CHAR (13)
FROM vw_Sis_ChaveEstrangeira
WHERE TabelaOriginal = 'Fin_Lancamento'
EXEC(@temp)
GO

DROP TABLE dbo.Fin_Lancamento
GO

EXECUTE sp_rename N'dbo.Tmp_Fin_Lancamento', N'Fin_Lancamento', 'OBJECT'
GO

ALTER TABLE dbo.Fin_Lancamento ADD CONSTRAINT
	PK__Fin_Lancamento__47A6A41B PRIMARY KEY CLUSTERED 
	(
	IDLancamento
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX XIE_Lanc_DataVencimento ON dbo.Fin_Lancamento
	(
	DataVencimento
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX XIE_Lanc_DataLancamento ON dbo.Fin_Lancamento
	(
	DataLancamento
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX XIE_Lanc_DataInicioQuitacao ON dbo.Fin_Lancamento
	(
	DataInicioQuitacao
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX XIF187Fin_Lancamento ON dbo.Fin_Lancamento
	(
	IDQuitacaoMeioPrevisto
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX XIF188Fin_Lancamento ON dbo.Fin_Lancamento
	(
	IDUsuarioAprovacao
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX XIF189Fin_Lancamento ON dbo.Fin_Lancamento
	(
	IDUsuarioLancamento
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX XIF190Fin_Lancamento ON dbo.Fin_Lancamento
	(
	IDUsuarioProtesto
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX XIF191Fin_Lancamento ON dbo.Fin_Lancamento
	(
	IDEmpresa
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX XIF192Fin_Lancamento ON dbo.Fin_Lancamento
	(
	IDPessoa
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX XIF193Fin_Lancamento ON dbo.Fin_Lancamento
	(
	IDCentroCusto
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX XIF195Fin_Lancamento ON dbo.Fin_Lancamento
	(
	IDPessoaTipo
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX XIF196Fin_Lancamento ON dbo.Fin_Lancamento
	(
	IDLancamentoOriginal
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX XIF198Fin_Lancamento ON dbo.Fin_Lancamento
	(
	IDDocumentoTipo
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX XIF199Fin_Lancamento ON dbo.Fin_Lancamento
	(
	IDMoedaCotacao
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX XIF200Fin_Lancamento ON dbo.Fin_Lancamento
	(
	IDMoeda
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX XIF201Fin_Lancamento ON dbo.Fin_Lancamento
	(
	IDBancoAgenciaQuitPrev
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX XIF202Fin_Lancamento ON dbo.Fin_Lancamento
	(
	IDBancoQuitPrev
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX XIF203Fin_Lancamento ON dbo.Fin_Lancamento
	(
	IDLancamentoTipo
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX XIF204Fin_Lancamento ON dbo.Fin_Lancamento
	(
	IDPreSale
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX XIF205Fin_Lancamento ON dbo.Fin_Lancamento
	(
	IDDesdobramentoTipo
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX XIF404Fin_Lancamento ON dbo.Fin_Lancamento
	(
	IDCashRegMov
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX XIF461Fin_Lancamento ON dbo.Fin_Lancamento
	(
	IDContaCorrentePrevista
	) ON [PRIMARY]
GO

ALTER TABLE dbo.Fin_Lancamento WITH NOCHECK ADD CONSTRAINT
	FK_Banco_Lancamento_IDBancoQuitPrev FOREIGN KEY
	(
	IDBancoQuitPrev
	) REFERENCES dbo.Fin_Banco
	(
	IDBanco
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.Fin_Lancamento WITH NOCHECK ADD CONSTRAINT
	FK_BancoAgencia_Lancamento_IDBancoAgenciaQuitPrev FOREIGN KEY
	(
	IDBancoAgenciaQuitPrev
	) REFERENCES dbo.Fin_BancoAgencia
	(
	IDBancoAgencia
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

ALTER TABLE dbo.Fin_Lancamento WITH NOCHECK ADD CONSTRAINT
	FK_ContaCorrente_Lancamento_IDContaCorrentePrevista FOREIGN KEY
	(
	IDContaCorrentePrevista
	) REFERENCES dbo.Fin_ContaCorrente
	(
	IDContaCorrente
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.Fin_Lancamento WITH NOCHECK ADD CONSTRAINT
	FK_Fin_Lancamento_Fin_Lancamento_IDLancamentoParent FOREIGN KEY
	(
	IDLancamentoParent
	) REFERENCES dbo.Fin_Lancamento
	(
	IDLancamento
	)
GO

ALTER TABLE dbo.Fin_Lancamento WITH NOCHECK ADD CONSTRAINT
	FK_SystemUser_Fin_Lancamento_IDUsuarioAprovacao FOREIGN KEY
	(
	IDUsuarioAprovacao
	) REFERENCES dbo.SystemUser
	(
	IDUser
	)
GO

ALTER TABLE dbo.Fin_Lancamento WITH NOCHECK ADD CONSTRAINT
	FK_SystemUser_Fin_Lancamento_IDUsuarioLancamento FOREIGN KEY
	(
	IDUsuarioLancamento
	) REFERENCES dbo.SystemUser
	(
	IDUser
	)
GO

ALTER TABLE dbo.Fin_Lancamento WITH NOCHECK ADD CONSTRAINT
	FK_SystemUser_Fin_Lancamento_IDUsuarioProtesto FOREIGN KEY
	(
	IDUsuarioProtesto
	) REFERENCES dbo.SystemUser
	(
	IDUser
	)
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

ALTER TABLE dbo.Fin_Lancamento WITH NOCHECK ADD CONSTRAINT
	FK_Invoice_Lancamento_IDPreSale FOREIGN KEY
	(
	IDPreSale
	) REFERENCES dbo.Invoice
	(
	IDPreSale
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

ALTER TABLE dbo.Fin_Lancamento WITH NOCHECK ADD CONSTRAINT
	FK_SisMoeda_Lancamento_IDMoeda FOREIGN KEY
	(
	IDMoeda
	) REFERENCES dbo.Sis_Moeda
	(
	IDMoeda
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.Fin_Lancamento WITH NOCHECK ADD CONSTRAINT
	FK_SisMoedaCotacao_Lancamento_IDMoedaCotacao FOREIGN KEY
	(
	IDMoedaCotacao
	) REFERENCES dbo.Sis_MoedaCotacao
	(
	IDMoedaCotacao
	) NOT FOR REPLICATION
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

ALTER TABLE dbo.Fin_Lancamento WITH NOCHECK ADD CONSTRAINT
	FK_Lancamento_Lancamento_IDLancamentoOriginal FOREIGN KEY
	(
	IDLancamentoOriginal
	) REFERENCES dbo.Fin_Lancamento
	(
	IDLancamento
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

ALTER TABLE dbo.Fin_Lancamento WITH NOCHECK ADD CONSTRAINT
	FK_Pessoa_Lancamento_IDPessoa FOREIGN KEY
	(
	IDPessoa
	) REFERENCES dbo.Pessoa
	(
	IDPessoa
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.Fin_Lancamento WITH NOCHECK ADD CONSTRAINT
	FK_SisEmpresa_Lancamento_IDEmpresa FOREIGN KEY
	(
	IDEmpresa
	) REFERENCES dbo.Sis_Empresa
	(
	IDEmpresa
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.Fin_Lancamento WITH NOCHECK ADD CONSTRAINT
	FK_CashRegMov_Lancamento_IDCashRegMov FOREIGN KEY
	(
	IDCashRegMov
	) REFERENCES dbo.CashRegMov
	(
	IDCashRegMov
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

ALTER TABLE dbo.Fin_LancamentoTerm WITH NOCHECK ADD CONSTRAINT
	FK_Lancamento_LancamentoTerm_IDLancamento FOREIGN KEY
	(
	IDLancamento
	) REFERENCES dbo.Fin_Lancamento
	(
	IDLancamento
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.Fin_LancQuit WITH NOCHECK ADD CONSTRAINT
	FK_Lancamento_LancQuit_IDLancamento FOREIGN KEY
	(
	IDLancamento
	) REFERENCES dbo.Fin_Lancamento
	(
	IDLancamento
	) NOT FOR REPLICATION
GO
