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

CREATE TABLE dbo.Tmp_Sis_Departamento
	(
	IDDepartamento int NOT NULL,
	IDEmpresa int NULL,
	CodigoDepartamento TCodigoGeral NOT NULL,
	Departamento TDescricao NOT NULL,
	Hidden TControlField NOT NULL,
	Desativado TControlField NOT NULL,
	System TControlField NOT NULL
	)  ON [PRIMARY]
GO

IF EXISTS(SELECT * FROM dbo.Sis_Departamento)
	 EXEC('INSERT INTO dbo.Tmp_Sis_Departamento (IDDepartamento, IDEmpresa, CodigoDepartamento, Departamento, Hidden, Desativado, System)
		SELECT IDDepartamento, IDEmpresa, CodigoDepartamento, Departamento, Hidden, Desativado, System FROM dbo.Sis_Departamento TABLOCKX')
GO

DROP TABLE dbo.Sis_Departamento
GO

EXECUTE sp_rename N'dbo.Tmp_Sis_Departamento', N'Sis_Departamento', 'OBJECT'
GO

CREATE CLUSTERED INDEX XIE_SDep_Departamento ON dbo.Sis_Departamento
	(
	Departamento
	) ON [PRIMARY]
GO

ALTER TABLE dbo.Sis_Departamento ADD CONSTRAINT
	PK__Sis_Departamento__1E3A7A34 PRIMARY KEY NONCLUSTERED 
	(
	IDDepartamento
	) ON [PRIMARY]

GO

CREATE NONCLUSTERED INDEX XIF80Sis_Departamento ON dbo.Sis_Departamento
	(
	IDEmpresa
	) ON [PRIMARY]
GO

ALTER TABLE dbo.Sis_Departamento WITH NOCHECK ADD CONSTRAINT
	FK_SisEmpresa_SisDepartamento_IDEmpresa FOREIGN KEY
	(
	IDEmpresa
	) REFERENCES dbo.Sis_Empresa
	(
	IDEmpresa
	) NOT FOR REPLICATION
GO

