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

CREATE TABLE dbo.Tmp_Sis_Feriado
	(
	IDFeriado int NOT NULL,
	Feriado TDescricao NULL,
	Data datetime NULL,
	Hidden TBit NULL,
	Desativado TBit NULL,
	System TBit NULL
	)  ON [PRIMARY]
GO

EXECUTE sp_bindefault N'dbo.DEF_Bit', N'Tmp_Sis_Feriado.Hidden'
GO

EXECUTE sp_bindefault N'dbo.DEF_Bit', N'Tmp_Sis_Feriado.Desativado'
GO

EXECUTE sp_bindefault N'dbo.DEF_Bit', N'Tmp_Sis_Feriado.System'
GO

IF EXISTS(SELECT * FROM dbo.Sis_Feriado)
	 EXEC('INSERT INTO dbo.Tmp_Sis_Feriado (IDFeriado, Feriado, Data, Hidden, Desativado, System)
		SELECT IDFeriado, Feriado, Data, Hidden, Desativado, System FROM dbo.Sis_Feriado TABLOCKX')
GO

DROP TABLE dbo.Sis_Feriado
GO

EXECUTE sp_rename N'dbo.Tmp_Sis_Feriado', N'Sis_Feriado', 'OBJECT'
GO

ALTER TABLE dbo.Sis_Feriado ADD CONSTRAINT
	PK__Sis_Feriado__5D60DB10 PRIMARY KEY CLUSTERED 
	(
	IDFeriado
	) ON [PRIMARY]

GO

