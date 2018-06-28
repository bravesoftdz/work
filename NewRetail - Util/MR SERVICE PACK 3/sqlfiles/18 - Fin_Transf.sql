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

CREATE TABLE dbo.Tmp_Fin_Transferencia
	(
	IDTransferencia int NOT NULL,
	IDContaCorrenteCredito int NULL,
	IDContaCorrenteDebito int NULL,
	IDUsuario int NOT NULL,
	Data datetime NULL,
	Valor TValor NULL,
	Obs text NULL
	)  ON [PRIMARY]
	 TEXTIMAGE_ON [PRIMARY]
GO

IF EXISTS(SELECT * FROM dbo.Fin_Transferencia)
	 EXEC('INSERT INTO dbo.Tmp_Fin_Transferencia (IDTransferencia, IDContaCorrenteCredito, IDContaCorrenteDebito, IDUsuario, Data, Valor, Obs)
		SELECT IDTransferencia, IDContaCorrenteCredito, IDContaCorrenteDebito, IDUsuario, Data, Valor, Obs FROM dbo.Fin_Transferencia TABLOCKX')
GO

DECLARE @temp Varchar (8000)
SET @temp = ''
SELECT @temp = @temp + 'ALTER TABLE ' + TabelaDerivada+ CHAR (13)+
+ CHAR(9)+'DROP CONSTRAINT ' + ConstraintName + CHAR (13)
FROM vw_Sis_ChaveEstrangeira
WHERE TabelaOriginal = 'Fin_Transferencia'
EXEC(@temp)
GO

DROP TABLE dbo.Fin_Transferencia
GO

EXECUTE sp_rename N'dbo.Tmp_Fin_Transferencia', N'Fin_Transferencia', 'OBJECT'
GO

ALTER TABLE dbo.Fin_Transferencia ADD CONSTRAINT
	PK__Fin_Transferenci__0B5CAFEA PRIMARY KEY CLUSTERED 
	(
	IDTransferencia
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX XIF208Fin_Transferencia ON dbo.Fin_Transferencia
	(
	IDContaCorrenteDebito
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX XIF209Fin_Transferencia ON dbo.Fin_Transferencia
	(
	IDContaCorrenteCredito
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX XIF407Fin_Transferencia ON dbo.Fin_Transferencia
	(
	IDUsuario
	) ON [PRIMARY]
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

ALTER TABLE dbo.Fin_Transferencia WITH NOCHECK ADD CONSTRAINT
	FK_SystemUser_Transferencia_IDUsuario FOREIGN KEY
	(
	IDUsuario
	) REFERENCES dbo.SystemUser
	(
	IDUser
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.Fin_Transferencia
	NOCHECK CONSTRAINT FK_SystemUser_Transferencia_IDUsuario
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

