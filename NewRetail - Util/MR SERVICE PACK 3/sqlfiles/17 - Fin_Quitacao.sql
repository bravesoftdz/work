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

CREATE TABLE dbo.Tmp_Fin_Quitacao
	(
	IDQuitacao int NOT NULL,
	IDTransferencia int NULL,
	IDQuitacaoMeio int NOT NULL,
	IDBancoAgencia int NULL,
	IDBanco int NULL,
	IDContaCorrente int NOT NULL,
	IDUsuarioQuitacao int NOT NULL,
	IDUsuarioReconciliacao int NULL,
	Pagando TBit NULL,
	ValorQuitacao TValor NOT NULL,
	ValorJuros TValor NOT NULL,
	DataQuitacao smalldatetime NOT NULL,
	DataDesbloqueio smalldatetime NULL,
	NumeroMeioQuit TCodigoGeral NULL,
	Desativado TControlField NOT NULL,
	String varchar(100) NULL,
	Hidden TControlField NOT NULL,
	System TControlField NOT NULL,
	Favorecido varchar(100) NULL,
	SparrowInt int NULL,
	AReconciliar TBit NULL,
	DataReconciliacao datetime NULL
	)  ON [PRIMARY]
GO

EXECUTE sp_bindefault N'dbo.DEF_VALOR', N'Tmp_Fin_Quitacao.ValorQuitacao'
GO

EXECUTE sp_bindefault N'dbo.DEF_VALOR', N'Tmp_Fin_Quitacao.ValorJuros'
GO

IF EXISTS(SELECT * FROM dbo.Fin_Quitacao)
	 EXEC('INSERT INTO dbo.Tmp_Fin_Quitacao (IDQuitacao, IDTransferencia, IDQuitacaoMeio, IDBancoAgencia, IDBanco, IDContaCorrente, IDUsuarioQuitacao, IDUsuarioReconciliacao, Pagando, ValorQuitacao, ValorJuros, DataQuitacao, DataDesbloqueio, NumeroMeioQuit, Desativado, String, Hidden, System, Favorecido, SparrowInt, AReconciliar, DataReconciliacao)
		SELECT IDQuitacao, IDTransferencia, IDQuitacaoMeio, IDBancoAgencia, IDBanco, IDContaCorrente, IDUsuarioQuitacao, IDUsuarioReconciliacao, Pagando, ValorQuitacao, ValorJuros, DataQuitacao, DataDesbloqueio, NumeroMeioQuit, Desativado, String, Hidden, System, Favorecido, SparrowInt, AReconciliar, DataReconciliacao FROM dbo.Fin_Quitacao TABLOCKX')
GO

DECLARE @temp Varchar (8000)
SET @temp = ''
SELECT @temp = @temp + 'ALTER TABLE ' + TabelaDerivada+ CHAR (13)+
+ CHAR(9)+'DROP CONSTRAINT ' + ConstraintName + CHAR (13)
FROM vw_Sis_ChaveEstrangeira
WHERE TabelaOriginal = 'Fin_Quitacao'
EXEC(@temp)
GO

DROP TABLE dbo.Fin_Quitacao
GO

EXECUTE sp_rename N'dbo.Tmp_Fin_Quitacao', N'Fin_Quitacao', 'OBJECT'
GO

ALTER TABLE dbo.Fin_Quitacao ADD CONSTRAINT
	PK__Fin_Quitacao__0D44F85C PRIMARY KEY CLUSTERED 
	(
	IDQuitacao
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX XIF212Fin_Quitacao ON dbo.Fin_Quitacao
	(
	IDQuitacaoMeio
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX XIF213Fin_Quitacao ON dbo.Fin_Quitacao
	(
	IDUsuarioQuitacao
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX XIF214Fin_Quitacao ON dbo.Fin_Quitacao
	(
	IDContaCorrente
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX XIF215Fin_Quitacao ON dbo.Fin_Quitacao
	(
	IDTransferencia
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX XIF216Fin_Quitacao ON dbo.Fin_Quitacao
	(
	IDBancoAgencia
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX XIF217Fin_Quitacao ON dbo.Fin_Quitacao
	(
	IDBanco
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX XIF406Fin_Quitacao ON dbo.Fin_Quitacao
	(
	IDUsuarioReconciliacao
	) ON [PRIMARY]
GO

ALTER TABLE dbo.Fin_Quitacao WITH NOCHECK ADD CONSTRAINT
	FK_Banco_Quitacao_IDBanco FOREIGN KEY
	(
	IDBanco
	) REFERENCES dbo.Fin_Banco
	(
	IDBanco
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.Fin_Quitacao WITH NOCHECK ADD CONSTRAINT
	FK_BancoAgencia_Quitacao_IDBancoAgencia FOREIGN KEY
	(
	IDBancoAgencia
	) REFERENCES dbo.Fin_BancoAgencia
	(
	IDBancoAgencia
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

ALTER TABLE dbo.Fin_Quitacao WITH NOCHECK ADD CONSTRAINT
	FK_SystemUser_Quitacao_IDUsuarioReconciliacao FOREIGN KEY
	(
	IDUsuarioReconciliacao
	) REFERENCES dbo.SystemUser
	(
	IDUser
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.Fin_Quitacao WITH NOCHECK ADD CONSTRAINT
	FK_Transferencia_Quitacao_IDTransferencia FOREIGN KEY
	(
	IDTransferencia
	) REFERENCES dbo.Fin_Transferencia
	(
	IDTransferencia
	) NOT FOR REPLICATION
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

ALTER TABLE dbo.Fin_Quitacao WITH NOCHECK ADD CONSTRAINT
	FK_SystemUser_Fin_Quitacao_IDUsuarioQuitacao FOREIGN KEY
	(
	IDUsuarioQuitacao
	) REFERENCES dbo.SystemUser
	(
	IDUser
	)
GO

CREATE TRIGGER tr_Fin_Quitacao_All ON dbo.Fin_Quitacao
FOR INSERT,UPDATE,DELETE
NOT FOR REPLICATION
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Atualizo o saldo de ContaCorrente


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

SET NOCOUNT ON

/* -----------------------------------------------------------------
	Comum 
  ----------------------------------------------------------------- */



/*
-- Confirma a existencia da linha da saldo
INSERT	
	Fin_ContaCorrenteSaldo 
	(
	IDContaCorrente, 
	Data, 
	Saldo
	)
	SELECT 	TQ.IDContaCorrente,
			TQ.Data,
			IsNull(
				( 
				SELECT  Saldo
				FROM	(
					SELECT 	MAX(FCC.Data) Data
					FROM	Fin_ContaCorrenteSaldo FCC
					WHERE	
						FCC.IDContaCorrente = TQ.IDContaCorrente
						AND
						FCC.Data < TQ.Data
					) SaldoAnterior	
					JOIN Fin_ContaCorrenteSaldo CCS
						ON (CCS.Data = SaldoAnterior.Data AND CCS.IDContaCorrente=TQ.IDContaCorrente )
				), 0)  

	FROM	
		(
		SELECT
			I.IDContaCorrente,
			Convert(DateTime, Convert(Char(20), I.DataQuitacao, 102)) as Data
		FROM
			Inserted I 
		GROUP BY 
			I.IDContaCorrente,
			Convert(DateTime, Convert(Char(20), I.DataQuitacao, 102)) 
		) AS TQ
		LEFT OUTER JOIN Fin_ContaCorrenteSaldo CCS 
			ON (CCS.IDContaCorrente = TQ.IDContaCorrente  
				AND
				CCS.Data = TQ.Data)
	WHERE	
		CCS.IDContaCorrente IS NULL

*/


/* 
   -----------------------------------------------------------------
	DELECAO 
   ----------------------------------------------------------------- 
*/

/*
UPDATE 	
	Fin_ContaCorrenteSaldo
SET	
	Saldo = Saldo - ((D.ValorQuitacao + D.ValorJuros) * (1 - D.Pagando * 2))
FROM	
	Deleted D 
WHERE	
	D.IDContaCorrente <> 0
	AND
	Fin_ContaCorrenteSaldo.IDContaCorrente = D.IDContaCorrente
	AND
	Fin_ContaCorrenteSaldo.Data >= Convert(DateTime, Convert(Char(20), D.DataQuitacao, 102))

*/

UPDATE 	
	Fin_ContaCorrente
SET	
	SaldoAtual = IsNull(SaldoAtual,0) - ((D.ValorQuitacao + D.ValorJuros) * (1 - D.Pagando * 2))
FROM	
	Deleted D 
WHERE	
	D.IDContaCorrente <> 0
	AND
	Fin_ContaCorrente.IDContaCorrente = D.IDContaCorrente

/* 
   -----------------------------------------------------------------
	Inclusao 
   ----------------------------------------------------------------- 
*/

/*
UPDATE 	
	Fin_ContaCorrenteSaldo
SET	
	Saldo = Saldo + ((I.ValorQuitacao + I.ValorJuros) * (1 - I.Pagando * 2))
FROM	
	Inserted I 
WHERE	
	I.IDContaCorrente <> 0
	AND
	Fin_ContaCorrenteSaldo.IDContaCorrente = I.IDContaCorrente
	AND
	Fin_ContaCorrenteSaldo.Data >= Convert(DateTime, Convert(Char(20), I.DataQuitacao, 102))

*/

UPDATE 	
	Fin_ContaCorrente
SET	
	SaldoAtual = IsNull(SaldoAtual, 0) + ((I.ValorQuitacao + I.ValorJuros) * (1 - I.Pagando * 2))
FROM	
	Inserted I 
WHERE	
	I.IDContaCorrente <> 0
	AND
	Fin_ContaCorrente.IDContaCorrente = I.IDContaCorrente
GO

ALTER TABLE dbo.Fin_LancQuit WITH NOCHECK ADD CONSTRAINT
	FK_Quitacao_LancQuit_IDQuitacao FOREIGN KEY
	(
	IDQuitacao
	) REFERENCES dbo.Fin_Quitacao
	(
	IDQuitacao
	) NOT FOR REPLICATION

GO

