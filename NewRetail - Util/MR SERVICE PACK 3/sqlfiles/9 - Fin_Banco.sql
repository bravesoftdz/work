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

CREATE TABLE dbo.Tmp_Fin_Banco
	(
	IDBanco int NOT NULL,
	CodigoBanco TCodigoGeral NOT NULL,
	Banco TDescricao NOT NULL,
	System TControlField NOT NULL,
	Hidden TControlField NOT NULL,
	Desativado TControlField NOT NULL
	)  ON [PRIMARY]
GO

IF EXISTS(SELECT * FROM dbo.Fin_Banco)
	 EXEC('INSERT INTO dbo.Tmp_Fin_Banco (IDBanco, CodigoBanco, Banco, System, Hidden, Desativado)
		SELECT IDBanco, CodigoBanco, Banco, System, Hidden, Desativado FROM dbo.Fin_Banco TABLOCKX')
GO

DECLARE @temp Varchar (8000)
SET @temp = ''
SELECT @temp = @temp + 'ALTER TABLE ' + TabelaDerivada+ CHAR (13)+
+ CHAR(9)+'DROP CONSTRAINT ' + ConstraintName + CHAR (13)
FROM vw_Sis_ChaveEstrangeira
WHERE TabelaOriginal = 'Fin_Banco'
EXEC(@temp)
GO

DROP TABLE dbo.Fin_Banco
GO

EXECUTE sp_rename N'dbo.Tmp_Fin_Banco', N'Fin_Banco', 'OBJECT'
GO

ALTER TABLE dbo.Fin_Banco ADD CONSTRAINT
	PK__Fin_Banco__7C4F7684 PRIMARY KEY CLUSTERED 
	(
	IDBanco
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

ALTER TABLE dbo.Fin_ContaCorrente WITH NOCHECK ADD CONSTRAINT
	FK_Banco_ContaCorrente_IDBanco FOREIGN KEY
	(
	IDBanco
	) REFERENCES dbo.Fin_Banco
	(
	IDBanco
	) NOT FOR REPLICATION
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

ALTER TABLE dbo.Fin_Quitacao WITH NOCHECK ADD CONSTRAINT
	FK_Banco_Quitacao_IDBanco FOREIGN KEY
	(
	IDBanco
	) REFERENCES dbo.Fin_Banco
	(
	IDBanco
	) NOT FOR REPLICATION
GO

