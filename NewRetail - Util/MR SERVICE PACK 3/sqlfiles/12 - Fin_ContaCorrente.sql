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

CREATE TABLE dbo.Tmp_Fin_ContaCorrente
	(
	IDContaCorrente int NOT NULL,
	CodigoContaCorrente TCodigoGeral NOT NULL,
	IDMoeda int NULL,
	IDCentroCusto int NULL,
	IDBanco int NOT NULL,
	IDEmpresa int NOT NULL,
	Tipo varchar(20) NULL,
	Numero TDescricao NOT NULL,
	Gerente TDescricao NULL,
	DataAbertura smalldatetime NULL,
	OBS text NULL,
	System TBit NULL,
	Desativado TBit NULL,
	IDBancoAgencia int NULL,
	Hidden TBit NULL,
	SaldoAtual TValor NULL,
	UltimoSaldoBancario TValor NULL,
	UltimaReconciliacao datetime NULL
	)  ON [PRIMARY]
	 TEXTIMAGE_ON [PRIMARY]
GO

EXECUTE sp_bindefault N'dbo.DEF_Bit', N'Tmp_Fin_ContaCorrente.System'
GO

EXECUTE sp_bindefault N'dbo.DEF_Bit', N'Tmp_Fin_ContaCorrente.Desativado'
GO

EXECUTE sp_bindefault N'dbo.DEF_Bit', N'Tmp_Fin_ContaCorrente.Hidden'
GO

IF EXISTS(SELECT * FROM dbo.Fin_ContaCorrente)
	 EXEC('INSERT INTO dbo.Tmp_Fin_ContaCorrente (IDContaCorrente, CodigoContaCorrente, IDMoeda, IDCentroCusto, IDBanco, IDEmpresa, Tipo, Numero, Gerente, DataAbertura, OBS, System, Desativado, IDBancoAgencia, Hidden, SaldoAtual, UltimoSaldoBancario, UltimaReconciliacao)
		SELECT IDContaCorrente, CodigoContaCorrente, IDMoeda, IDCentroCusto, IDBanco, IDEmpresa, Tipo, Numero, Gerente, DataAbertura, OBS, System, Desativado, IDBancoAgencia, Hidden, SaldoAtual, UltimoSaldoBancario, UltimaReconciliacao FROM dbo.Fin_ContaCorrente TABLOCKX')
GO

DECLARE @temp Varchar (8000)
SET @temp = ''
SELECT @temp = @temp + 'ALTER TABLE ' + TabelaDerivada+ CHAR (13)+
+ CHAR(9)+'DROP CONSTRAINT ' + ConstraintName + CHAR (13)
FROM vw_Sis_ChaveEstrangeira
WHERE TabelaOriginal = 'Fin_ContaCorrente'
EXEC(@temp)
GO


DROP TABLE dbo.Fin_ContaCorrente
GO

ALTER TABLE dbo.Tmp_Fin_ContaCorrente ADD CONSTRAINT
	DF_Zero68 DEFAULT (0) FOR SaldoAtual
GO

EXECUTE sp_rename N'dbo.Tmp_Fin_ContaCorrente', N'Fin_ContaCorrente', 'OBJECT'
GO

ALTER TABLE dbo.Fin_ContaCorrente ADD CONSTRAINT
	PK__Fin_ContaCorrent__02FC7413 PRIMARY KEY CLUSTERED 
	(
	IDContaCorrente
	) ON [PRIMARY]
GO

CREATE UNIQUE NONCLUSTERED INDEX UQ__Fin_ContaCorrent__32EB7E57 ON dbo.Fin_ContaCorrente
	(
	IDBanco,
	Numero,
	IDBancoAgencia
	) ON [PRIMARY]
GO

CREATE UNIQUE NONCLUSTERED INDEX UQ__Fin_ContaCorrent__33DFA290 ON dbo.Fin_ContaCorrente
	(
	CodigoContaCorrente
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX XIF182Fin_ContaCorrente ON dbo.Fin_ContaCorrente
	(
	IDEmpresa
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX XIF183Fin_ContaCorrente ON dbo.Fin_ContaCorrente
	(
	IDCentroCusto
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX XIF184Fin_ContaCorrente ON dbo.Fin_ContaCorrente
	(
	IDMoeda
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX XIF185Fin_ContaCorrente ON dbo.Fin_ContaCorrente
	(
	IDBancoAgencia
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX XIF186Fin_ContaCorrente ON dbo.Fin_ContaCorrente
	(
	IDBanco
	) ON [PRIMARY]
GO

ALTER TABLE dbo.Fin_ContaCorrente WITH NOCHECK ADD CONSTRAINT
	FK_Banco_ContaCorrente_IDBanco FOREIGN KEY
	(
	IDBanco
	) REFERENCES dbo.Fin_Banco
	(
	IDBanco
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.Fin_ContaCorrente WITH NOCHECK ADD CONSTRAINT
	FK_BancoAgencia_ContaCorrente_IDBancoAgencia FOREIGN KEY
	(
	IDBancoAgencia
	) REFERENCES dbo.Fin_BancoAgencia
	(
	IDBancoAgencia
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.Fin_ContaCorrente WITH NOCHECK ADD CONSTRAINT
	FK_SisMoeda_ContaCorrente_IDMoeda FOREIGN KEY
	(
	IDMoeda
	) REFERENCES dbo.Sis_Moeda
	(
	IDMoeda
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

ALTER TABLE dbo.Fin_ContaCorrente WITH NOCHECK ADD CONSTRAINT
	FK_SisEmpresa_ContaCorrente_IDEmpresa FOREIGN KEY
	(
	IDEmpresa
	) REFERENCES dbo.Sis_Empresa
	(
	IDEmpresa
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

ALTER TABLE dbo.MeioPag WITH NOCHECK ADD CONSTRAINT
	FK_ContaCorrente_MeioPag_IDContaCorrente FOREIGN KEY
	(
	IDContaCorrente
	) REFERENCES dbo.Fin_ContaCorrente
	(
	IDContaCorrente
	) NOT FOR REPLICATION
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

ALTER TABLE dbo.Fin_Quitacao WITH NOCHECK ADD CONSTRAINT
	FK_ContaCorrente_Quitacao_IDContaCorrente FOREIGN KEY
	(
	IDContaCorrente
	) REFERENCES dbo.Fin_ContaCorrente
	(
	IDContaCorrente
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.Fin_Transferencia WITH NOCHECK ADD CONSTRAINT
	FK_ContaCorrente_Transferencia_IDContaCorrenteDebito FOREIGN KEY
	(
	IDContaCorrenteDebito
	) REFERENCES dbo.Fin_ContaCorrente
	(
	IDContaCorrente
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.Fin_Transferencia WITH NOCHECK ADD CONSTRAINT
	FK_ContaCorrente_Transferencia_IDContaCorrenteCredito FOREIGN KEY
	(
	IDContaCorrenteCredito
	) REFERENCES dbo.Fin_ContaCorrente
	(
	IDContaCorrente
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.MeioPagToStore WITH NOCHECK ADD CONSTRAINT
	FK_ContaCorrente_MeioPagToStore_IDContaCorrente FOREIGN KEY
	(
	IDContaCorrente
	) REFERENCES dbo.Fin_ContaCorrente
	(
	IDContaCorrente
	) NOT FOR REPLICATION

GO

ALTER TABLE dbo.Fin_ContaCorrenteSaldo WITH NOCHECK ADD CONSTRAINT
	FK_ContaCorrente_ContaCorrenteSaldo_IDContaCorrente FOREIGN KEY
	(
	IDContaCorrente
	) REFERENCES dbo.Fin_ContaCorrente
	(
	IDContaCorrente
	) NOT FOR REPLICATION
GO

