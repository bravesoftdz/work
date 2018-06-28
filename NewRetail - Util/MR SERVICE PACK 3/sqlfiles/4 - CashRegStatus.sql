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

CREATE TABLE dbo.Tmp_CashRegStatus
	(
	IDCashRegStatus int NOT NULL,
	CashRegStatus varchar(30) NOT NULL
	)  ON [PRIMARY]
GO

IF EXISTS(SELECT * FROM dbo.CashRegStatus)
	 EXEC('INSERT INTO dbo.Tmp_CashRegStatus (IDCashRegStatus, CashRegStatus)
		SELECT IDCashRegStatus, CashRegStatus FROM dbo.CashRegStatus TABLOCKX')
GO

DECLARE @temp Varchar (8000)
SET @temp = ''
SELECT @temp = @temp + 'ALTER TABLE ' + TabelaDerivada+ CHAR (13)+
+ CHAR(9)+'DROP CONSTRAINT ' + ConstraintName + CHAR (13)
FROM vw_Sis_ChaveEstrangeira
WHERE TabelaOriginal = 'CashRegStatus'
EXEC(@temp)
GO

DROP TABLE dbo.CashRegStatus
GO

EXECUTE sp_rename N'dbo.Tmp_CashRegStatus', N'CashRegStatus', 'OBJECT'
GO

ALTER TABLE dbo.CashRegStatus ADD CONSTRAINT
	PK__CashRegStatus__04E4BC85 PRIMARY KEY CLUSTERED 
	(
	IDCashRegStatus
	) ON [PRIMARY]
GO

ALTER TABLE dbo.CashRegMov WITH NOCHECK ADD CONSTRAINT
	FK_CashRegStatus_CashRegMov_IDCashRegStatus FOREIGN KEY
	(
	IDCashRegStatus
	) REFERENCES dbo.CashRegStatus
	(
	IDCashRegStatus
	) NOT FOR REPLICATION
GO