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

CREATE TABLE dbo.Tmp_CashRegTipoLog
	(
	IDCashRegTipoLog int NOT NULL,
	CashRegTipoLog varchar(30) NOT NULL,
	Entrando bit NULL,
	Movimenta bit NULL,
	PettyCash bit NULL
	)  ON [PRIMARY]
GO

IF EXISTS(SELECT * FROM dbo.CashRegTipoLog)
	 EXEC('INSERT INTO dbo.Tmp_CashRegTipoLog (IDCashRegTipoLog, CashRegTipoLog, Entrando, Movimenta, PettyCash)
		SELECT IDCashRegTipoLog, CashRegTipoLog, Entrando, Movimenta, PettyCash FROM dbo.CashRegTipoLog TABLOCKX')
GO

DECLARE @temp Varchar (8000)
SET @temp = ''
SELECT @temp = @temp + 'ALTER TABLE ' + TabelaDerivada+ CHAR (13)+
+ CHAR(9)+'DROP CONSTRAINT ' + ConstraintName + CHAR (13)
FROM vw_Sis_ChaveEstrangeira
WHERE TabelaOriginal = 'CashRegTipoLog'
EXEC(@temp)
GO

DROP TABLE dbo.CashRegTipoLog
GO

EXECUTE sp_rename N'dbo.Tmp_CashRegTipoLog', N'CashRegTipoLog', 'OBJECT'
GO

ALTER TABLE dbo.CashRegTipoLog ADD CONSTRAINT
	PK__CashRegTipoLog__4B7734FF PRIMARY KEY CLUSTERED 
	(
	IDCashRegTipoLog
	) ON [PRIMARY]
GO

ALTER TABLE dbo.CashRegLog WITH NOCHECK ADD CONSTRAINT
	FK_CashRegTipoLog_CashRegLog_IDCashRegTipoLog FOREIGN KEY
	(
	IDCashRegTipoLog
	) REFERENCES dbo.CashRegTipoLog
	(
	IDCashRegTipoLog
	) NOT FOR REPLICATION
GO

