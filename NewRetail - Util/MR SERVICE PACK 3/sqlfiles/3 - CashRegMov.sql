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


CREATE TABLE dbo.Tmp_CashRegMov
	(
	IDCashRegMov int NOT NULL,
	IDCashRegister int NOT NULL,
	IDOpenUser int NOT NULL,
	IDCashRegStatus int NOT NULL,
	OpenTime smalldatetime NOT NULL,
	TotalDeposit money NULL,
	TotalSales money NULL,
	TotalWidraw money NULL,
	OpenDeposit money NULL,
	FinalWidraw money NULL,
	TotalSaleCash money NULL,
	TotalPetty money NULL,
	FinalCount money NULL,
	ManagerCount money NULL
	)  ON [PRIMARY]
GO

IF EXISTS(SELECT * FROM dbo.CashRegMov)
	 EXEC('INSERT INTO dbo.Tmp_CashRegMov (IDCashRegMov, IDCashRegister, IDOpenUser, IDCashRegStatus, OpenTime, TotalDeposit, TotalSales, TotalWidraw, OpenDeposit, FinalWidraw, TotalSaleCash, TotalPetty, FinalCount, ManagerCount)
		SELECT IDCashRegMov, IDCashRegister, IDOpenUser, IDCashRegStatus, OpenTime, TotalDeposit, TotalSales, TotalWidraw, OpenDeposit, FinalWidraw, TotalSaleCash, TotalPetty, FinalCount, ManagerCount FROM dbo.CashRegMov TABLOCKX')
GO

DECLARE @temp Varchar (8000)
SET @temp = ''
SELECT @temp = @temp + 'ALTER TABLE ' + TabelaDerivada+ CHAR (13)+
+ CHAR(9)+'DROP CONSTRAINT ' + ConstraintName + CHAR (13)
FROM vw_Sis_ChaveEstrangeira
WHERE TabelaOriginal = 'CashRegMov'
EXEC(@temp)
GO

DROP TABLE dbo.CashRegMov
GO

ALTER TABLE dbo.Tmp_CashRegMov ADD CONSTRAINT
	DF_Zero73 DEFAULT (0) FOR TotalDeposit
GO

ALTER TABLE dbo.Tmp_CashRegMov ADD CONSTRAINT
	DF_Zero74 DEFAULT (0) FOR TotalSales
GO

ALTER TABLE dbo.Tmp_CashRegMov ADD CONSTRAINT
	DF_Zero75 DEFAULT (0) FOR TotalWidraw
GO

ALTER TABLE dbo.Tmp_CashRegMov ADD CONSTRAINT
	DF_Zero76 DEFAULT (0) FOR OpenDeposit
GO

ALTER TABLE dbo.Tmp_CashRegMov ADD CONSTRAINT
	DF_Zero77 DEFAULT (0) FOR FinalWidraw
GO

ALTER TABLE dbo.Tmp_CashRegMov ADD CONSTRAINT
	DF_Zero78 DEFAULT (0) FOR TotalSaleCash
GO

ALTER TABLE dbo.Tmp_CashRegMov ADD CONSTRAINT
	DF_Zero79 DEFAULT (0) FOR TotalPetty
GO

ALTER TABLE dbo.Tmp_CashRegMov ADD CONSTRAINT
	DF_Zero80 DEFAULT (0) FOR FinalCount
GO

ALTER TABLE dbo.Tmp_CashRegMov ADD CONSTRAINT
	DF_Zero81 DEFAULT (0) FOR ManagerCount
GO

EXECUTE sp_rename N'dbo.Tmp_CashRegMov', N'CashRegMov', 'OBJECT'
GO

ALTER TABLE dbo.CashRegMov ADD CONSTRAINT
	PK_CashRegMov_IDCashRegMov PRIMARY KEY NONCLUSTERED 
	(
	IDCashRegMov
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX XIF181CashRegMov ON dbo.CashRegMov
	(
	IDCashRegister
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX XIF399CashRegMov ON dbo.CashRegMov
	(
	IDOpenUser
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX XIF400CashRegMov ON dbo.CashRegMov
	(
	IDCashRegStatus
	) ON [PRIMARY]
GO

ALTER TABLE dbo.CashRegMov WITH NOCHECK ADD CONSTRAINT
	FK_CashReg_CashRegMov_IDCashRegister FOREIGN KEY
	(
	IDCashRegister
	) REFERENCES dbo.CashRegister
	(
	IDCashRegister
	) NOT FOR REPLICATION
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

ALTER TABLE dbo.CashRegMov WITH NOCHECK ADD CONSTRAINT
	FK_SystemUser_CashRegMov_IDOpenUser FOREIGN KEY
	(
	IDOpenUser
	) REFERENCES dbo.SystemUser
	(
	IDUser
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

ALTER TABLE dbo.Invoice WITH NOCHECK ADD CONSTRAINT
	FK_CashRegMov_Invoice_CashRegMovID FOREIGN KEY
	(
	CashRegMovID
	) REFERENCES dbo.CashRegMov
	(
	IDCashRegMov
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.CashRegLog WITH NOCHECK ADD CONSTRAINT
	FK_CashRegMov_CashRegLog_IDCashRegMov FOREIGN KEY
	(
	IDCashRegMov
	) REFERENCES dbo.CashRegMov
	(
	IDCashRegMov
	) NOT FOR REPLICATION
GO
