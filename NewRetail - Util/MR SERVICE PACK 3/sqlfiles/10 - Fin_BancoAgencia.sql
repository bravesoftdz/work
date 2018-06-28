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


CREATE TABLE dbo.Tmp_Fin_BancoAgencia
	(
	IDBancoAgencia int NOT NULL,
	CodigoBancoAgencia TCodigoGeral NOT NULL,
	BancoAgencia TDescricao NOT NULL,
	IDBanco int NOT NULL,
	Endereco TEndereco NULL,
	Bairro TBairro NULL,
	System TControlField NOT NULL,
	Hidden TControlField NOT NULL,
	Desativado TControlField NOT NULL
	)  ON [PRIMARY]
GO

IF EXISTS(SELECT * FROM dbo.Fin_BancoAgencia)
	 EXEC('INSERT INTO dbo.Tmp_Fin_BancoAgencia (IDBancoAgencia, CodigoBancoAgencia, BancoAgencia, IDBanco, Endereco, Bairro, System, Hidden, Desativado)
		SELECT IDBancoAgencia, CodigoBancoAgencia, BancoAgencia, IDBanco, Endereco, Bairro, System, Hidden, Desativado FROM dbo.Fin_BancoAgencia TABLOCKX')
GO

DECLARE @temp Varchar (8000)
SET @temp = ''
SELECT @temp = @temp + 'ALTER TABLE ' + TabelaDerivada+ CHAR (13)+
+ CHAR(9)+'DROP CONSTRAINT ' + ConstraintName + CHAR (13)
FROM vw_Sis_ChaveEstrangeira
WHERE TabelaOriginal = 'Fin_BancoAgencia'
EXEC(@temp)
GO


DROP TABLE dbo.Fin_BancoAgencia
GO

EXECUTE sp_rename N'dbo.Tmp_Fin_BancoAgencia', N'Fin_BancoAgencia', 'OBJECT'
GO

ALTER TABLE dbo.Fin_BancoAgencia ADD CONSTRAINT
	PK__Fin_BancoAgencia__7E37BEF6 PRIMARY KEY CLUSTERED 
	(
	IDBancoAgencia
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX XIF211Fin_BancoAgencia ON dbo.Fin_BancoAgencia
	(
	IDBanco
	) ON [PRIMARY]
GO

ALTER TABLE dbo.Fin_BancoAgencia WITH NOCHECK ADD CONSTRAINT
	FK_Banco_BancoAgencia_IDBanco FOREIGN KEY
	(
	IDBanco
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

ALTER TABLE dbo.Fin_ContaCorrente WITH NOCHECK ADD CONSTRAINT
	FK_BancoAgencia_ContaCorrente_IDBancoAgencia FOREIGN KEY
	(
	IDBancoAgencia
	) REFERENCES dbo.Fin_BancoAgencia
	(
	IDBancoAgencia
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

