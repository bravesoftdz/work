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

CREATE TABLE dbo.Tmp_SYS_RelParametro
	(
	IDRelParametro int NOT NULL,
	Panel varchar(30) NOT NULL,
	Label varchar(30) NOT NULL,
	ValorDefault varchar(30) NULL,
	Campo varchar(30) NOT NULL,
	Operador varchar(30) NOT NULL,
	IDRelatorio int NULL
	)  ON [PRIMARY]
GO

IF EXISTS(SELECT * FROM dbo.SYS_RelParametro)
	 EXEC('INSERT INTO dbo.Tmp_SYS_RelParametro (IDRelParametro, Panel, Label, ValorDefault, Campo, Operador, IDRelatorio)
		SELECT IDRelParametro, Panel, Label, ValorDefault, Campo, Operador, IDRelatorio FROM dbo.SYS_RelParametro TABLOCKX')
GO

DROP TABLE dbo.SYS_RelParametro
GO

EXECUTE sp_rename N'dbo.Tmp_SYS_RelParametro', N'SYS_RelParametro', 'OBJECT'
GO

ALTER TABLE dbo.SYS_RelParametro ADD CONSTRAINT
	PK__SYS_RelParametro__36470DEF PRIMARY KEY CLUSTERED 
	(
	IDRelParametro
	) ON [PRIMARY]

GO

CREATE NONCLUSTERED INDEX XIF177SYS_RelParametro ON dbo.SYS_RelParametro
	(
	IDRelatorio
	) ON [PRIMARY]
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

