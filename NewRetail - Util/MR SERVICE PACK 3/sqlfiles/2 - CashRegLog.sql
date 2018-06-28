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

DECLARE @temp Varchar (8000)
SET @temp = ''
SELECT @temp = @temp + 'ALTER TABLE ' + TabelaDerivada+ CHAR (13)+
+ CHAR(9)+'DROP CONSTRAINT ' + ConstraintName + CHAR (13)
FROM vw_Sis_ChaveEstrangeira
WHERE TabelaOriginal = 'CashRegLog'
EXEC(@temp)
GO

CREATE TABLE dbo.Tmp_CashRegLog
	(
	IDCashRegLog int NOT NULL,
	IDCashRegMov int NOT NULL,
	IDUser int NOT NULL,
	IDCashRegTipoLog int NOT NULL,
	LogTime smalldatetime NOT NULL,
	Bill100 int NOT NULL,
	Bill50 int NOT NULL,
	Bill20 int NOT NULL,
	Bill10 int NOT NULL,
	Bill5 int NOT NULL,
	Bill2 int NOT NULL,
	Bill1 int NOT NULL,
	Coin1 int NOT NULL,
	Coin050 int NOT NULL,
	Coin025 int NOT NULL,
	Coin010 int NOT NULL,
	Coin005 int NOT NULL,
	Coin001 int NOT NULL,
	TotalCard money NULL,
	TotalCheck money NULL,
	TotalOther money NULL,
	TotalCash money NULL,
	TotalCashConf money NULL,
	TotalOtherConf money NULL,
	TotalCheckConf money NULL,
	TotalCardConf money NULL,
	TotalCardPre money NULL,
	TotalCardPreConf money NULL,
	LogDocument varchar(20) NULL
	)  ON [PRIMARY]
GO


IF EXISTS(SELECT * FROM dbo.CashRegLog)
	 EXEC('INSERT INTO dbo.Tmp_CashRegLog (IDCashRegLog, IDCashRegMov, IDUser, IDCashRegTipoLog, LogTime, Bill100, Bill50, Bill20, Bill10, Bill5, Bill2, Bill1, Coin1, Coin050, Coin025, Coin010, Coin005, Coin001, TotalCard, TotalCheck, TotalOther, TotalCash, TotalCashConf, TotalOtherConf, TotalCheckConf, TotalCardConf, TotalCardPre, TotalCardPreConf, LogDocument)
		SELECT IDCashRegLog, IDCashRegMov, IDUser, IDCashRegTipoLog, LogTime, Bill100, Bill50, Bill20, Bill10, Bill5, Bill2, Bill1, Coin1, Coin050, Coin025, Coin010, Coin005, Coin001, TotalCard, TotalCheck, TotalOther, TotalCash, TotalCashConf, TotalOtherConf, TotalCheckConf, TotalCardConf, TotalCardPre, TotalCardPreConf, LogDocument FROM dbo.CashRegLog TABLOCKX')
GO

DROP TABLE dbo.CashRegLog
GO

ALTER TABLE dbo.Tmp_CashRegLog ADD CONSTRAINT
	DF_Zero153 DEFAULT (0) FOR Bill100
GO

ALTER TABLE dbo.Tmp_CashRegLog ADD CONSTRAINT
	DF_Zero154 DEFAULT (0) FOR Bill50
GO

ALTER TABLE dbo.Tmp_CashRegLog ADD CONSTRAINT
	DF_Zero155 DEFAULT (0) FOR Bill20
GO

ALTER TABLE dbo.Tmp_CashRegLog ADD CONSTRAINT
	DF_Zero156 DEFAULT (0) FOR Bill10
GO

ALTER TABLE dbo.Tmp_CashRegLog ADD CONSTRAINT
	DF_Zero157 DEFAULT (0) FOR Bill5
GO

ALTER TABLE dbo.Tmp_CashRegLog ADD CONSTRAINT
	DF_Zero158 DEFAULT (0) FOR Bill2
GO

ALTER TABLE dbo.Tmp_CashRegLog ADD CONSTRAINT
	DF_Zero159 DEFAULT (0) FOR Bill1
GO

ALTER TABLE dbo.Tmp_CashRegLog ADD CONSTRAINT
	DF_Zero160 DEFAULT (0) FOR Coin1
GO

ALTER TABLE dbo.Tmp_CashRegLog ADD CONSTRAINT
	DF_Zero161 DEFAULT (0) FOR Coin050
GO

ALTER TABLE dbo.Tmp_CashRegLog ADD CONSTRAINT
	DF_Zero162 DEFAULT (0) FOR Coin025
GO

ALTER TABLE dbo.Tmp_CashRegLog ADD CONSTRAINT
	DF_Zero163 DEFAULT (0) FOR Coin010
GO

ALTER TABLE dbo.Tmp_CashRegLog ADD CONSTRAINT
	DF_Zero164 DEFAULT (0) FOR Coin005
GO

ALTER TABLE dbo.Tmp_CashRegLog ADD CONSTRAINT
	DF_Zero165 DEFAULT (0) FOR Coin001
GO

ALTER TABLE dbo.Tmp_CashRegLog ADD CONSTRAINT
	DF_Zero166 DEFAULT (0) FOR TotalCard
GO

ALTER TABLE dbo.Tmp_CashRegLog ADD CONSTRAINT
	DF_Zero167 DEFAULT (0) FOR TotalCheck
GO

ALTER TABLE dbo.Tmp_CashRegLog ADD CONSTRAINT
	DF_Zero168 DEFAULT (0) FOR TotalOther
GO

ALTER TABLE dbo.Tmp_CashRegLog ADD CONSTRAINT
	DF_Zero169 DEFAULT (0) FOR TotalCash
GO

ALTER TABLE dbo.Tmp_CashRegLog ADD CONSTRAINT
	DF_Zero170 DEFAULT (0) FOR TotalCashConf
GO

ALTER TABLE dbo.Tmp_CashRegLog ADD CONSTRAINT
	DF_Zero171 DEFAULT (0) FOR TotalOtherConf
GO

ALTER TABLE dbo.Tmp_CashRegLog ADD CONSTRAINT
	DF_Zero172 DEFAULT (0) FOR TotalCheckConf
GO

ALTER TABLE dbo.Tmp_CashRegLog ADD CONSTRAINT
	DF_Zero173 DEFAULT (0) FOR TotalCardConf
GO

ALTER TABLE dbo.Tmp_CashRegLog ADD CONSTRAINT
	DF_Zero174 DEFAULT (0) FOR TotalCardPre
GO

ALTER TABLE dbo.Tmp_CashRegLog ADD CONSTRAINT
	DF_Zero175 DEFAULT (0) FOR TotalCardPreConf
GO


EXECUTE sp_rename N'dbo.Tmp_CashRegLog', N'CashRegLog', 'OBJECT'
GO

ALTER TABLE dbo.CashRegLog ADD CONSTRAINT
	PK__CashRegLog__753864A1 PRIMARY KEY CLUSTERED 
	(
	IDCashRegLog
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX XIF144CashRegLog ON dbo.CashRegLog
	(
	IDUser
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX XIF145CashRegLog ON dbo.CashRegLog
	(
	IDCashRegMov
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX XIF398CashRegLog ON dbo.CashRegLog
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

ALTER TABLE dbo.CashRegLog WITH NOCHECK ADD CONSTRAINT
	FK_CashRegMov_CashRegLog_IDCashRegMov FOREIGN KEY
	(
	IDCashRegMov
	) REFERENCES dbo.CashRegMov
	(
	IDCashRegMov
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.CashRegLog WITH NOCHECK ADD CONSTRAINT
	FK_SystemUser_CashRegLog_IDUser FOREIGN KEY
	(
	IDUser
	) REFERENCES dbo.SystemUser
	(
	IDUser
	) NOT FOR REPLICATION
GO
