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

CREATE TABLE dbo.Tmp_SYS_Relatorio
	(
	IDRelatorio int NOT NULL,
	IDMenu int NULL,
	Relatorio varchar(50) NOT NULL,
	Descricao varchar(255) NULL,
	CreateIndex int NOT NULL,
	OrderClause varchar(50) NULL
	)  ON [PRIMARY]
GO

IF EXISTS(SELECT * FROM dbo.SYS_Relatorio)
	 EXEC('INSERT INTO dbo.Tmp_SYS_Relatorio (IDRelatorio, IDMenu, Relatorio, Descricao, CreateIndex, OrderClause)
		SELECT IDRelatorio, IDMenu, Relatorio, Descricao, CreateIndex, OrderClause FROM dbo.SYS_Relatorio TABLOCKX')
GO

DECLARE @temp Varchar (8000)
SET @temp = ''
SELECT @temp = @temp + 'ALTER TABLE ' + TabelaDerivada+ CHAR (13)+
+ CHAR(9)+'DROP CONSTRAINT ' + ConstraintName + CHAR (13)
FROM vw_Sis_ChaveEstrangeira
WHERE TabelaOriginal = 'SYS_Relatorio'
EXEC(@temp)
GO

DROP TABLE dbo.SYS_Relatorio
GO

EXECUTE sp_rename N'dbo.Tmp_SYS_Relatorio', N'SYS_Relatorio', 'OBJECT'
GO

ALTER TABLE dbo.SYS_Relatorio ADD CONSTRAINT
	PK_SYS_Relatorio_1__14 PRIMARY KEY CLUSTERED 
	(
	IDRelatorio
	) ON [PRIMARY]

GO

CREATE NONCLUSTERED INDEX XIF435SYS_Relatorio ON dbo.SYS_Relatorio
	(
	IDMenu
	) ON [PRIMARY]
GO

ALTER TABLE dbo.SYS_Relatorio WITH NOCHECK ADD CONSTRAINT
	FK_MenuMain_SYSRelatorio_IDMenu FOREIGN KEY
	(
	IDMenu
	) REFERENCES dbo.MenuMain
	(
	IDMenu
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.SYS_RelParametro WITH NOCHECK ADD CONSTRAINT
	FK_SYSRelatorio_SYSRelParametro_IDRelatorio FOREIGN KEY
	(
	IDRelatorio
	) REFERENCES dbo.SYS_Relatorio
	(
	IDRelatorio
	) NOT FOR REPLICATION
GO

