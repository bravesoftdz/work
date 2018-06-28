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

CREATE TABLE dbo.Tmp_Sis_Empresa
	(
	IDEmpresa int NOT NULL,
	CodigoEmpresa TCodigoGeral NOT NULL,
	Empresa TDescricao NOT NULL,
	RazaoSocial varchar(100) NULL,
	CGC varchar(20) NULL,
	InscricaoEstadual varchar(20) NULL,
	InscricaoMunicipal varchar(20) NULL,
	Endereco TEndereco NULL,
	Coplemento varchar(20) NULL,
	Bairro TBairro NULL,
	Cidade varchar(30) NULL,
	CEP varchar(10) NULL,
	Pais varchar(20) NULL,
	Desativado TControlField NOT NULL,
	ISS TPercentual NOT NULL,
	Hidden TControlField NOT NULL,
	Confins TPercentual NOT NULL,
	System TControlField NOT NULL,
	PIS TPercentual NOT NULL,
	ContribuicaoSocial TPercentual NOT NULL,
	UltimaFatura int NULL,
	PercRetencaoINSS TPercentual NOT NULL,
	UltimoNumeroFormulario int NULL,
	NFModeloFormulario varchar(20) NULL,
	Porta varchar(20) NULL,
	NFSModeloFormulario varchar(20) NULL,
	NFSPorta varchar(20) NULL
	)  ON [PRIMARY]
GO

IF EXISTS(SELECT * FROM dbo.Sis_Empresa)
	 EXEC('INSERT INTO dbo.Tmp_Sis_Empresa (IDEmpresa, CodigoEmpresa, Empresa, RazaoSocial, CGC, InscricaoEstadual, InscricaoMunicipal, Endereco, Coplemento, Bairro, Cidade, CEP, Pais, Desativado, ISS, Hidden, Confins, System, PIS, ContribuicaoSocial, UltimaFatura, PercRetencaoINSS, UltimoNumeroFormulario, NFModeloFormulario, Porta, NFSModeloFormulario, NFSPorta)
		SELECT IDEmpresa, CodigoEmpresa, Empresa, RazaoSocial, CGC, InscricaoEstadual, InscricaoMunicipal, Endereco, Coplemento, Bairro, Cidade, CEP, Pais, Desativado, ISS, Hidden, Confins, System, PIS, ContribuicaoSocial, UltimaFatura, PercRetencaoINSS, UltimoNumeroFormulario, NFModeloFormulario, Porta, NFSModeloFormulario, NFSPorta FROM dbo.Sis_Empresa TABLOCKX')
GO

DECLARE @temp Varchar (8000)
SET @temp = ''
SELECT @temp = @temp + 'ALTER TABLE ' + TabelaDerivada+ CHAR (13)+
+ CHAR(9)+'DROP CONSTRAINT ' + ConstraintName + CHAR (13)
FROM vw_Sis_ChaveEstrangeira
WHERE TabelaOriginal = 'Sis_Empresa'
EXEC(@temp)
GO

DROP TABLE dbo.Sis_Empresa
GO

EXECUTE sp_rename N'dbo.Tmp_Sis_Empresa', N'Sis_Empresa', 'OBJECT'
GO

ALTER TABLE dbo.Sis_Empresa ADD CONSTRAINT
	PK__Sis_Empresa__44FF419A PRIMARY KEY CLUSTERED 
	(
	IDEmpresa
	) ON [PRIMARY]

GO

CREATE UNIQUE NONCLUSTERED INDEX XAK1Sis_Empresa ON dbo.Sis_Empresa
	(
	Empresa
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX XIE1Sis_Empresa ON dbo.Sis_Empresa
	(
	CodigoEmpresa
	) ON [PRIMARY]
GO

CREATE TRIGGER tr_Sis_Empresa_All ON dbo.Sis_Empresa
FOR INSERT
NOT FOR REPLICATION
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Insiro em Sis_GrupoEmpresa


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

SET NOCOUNT ON

/*
   ------------------------------------------------------------------------------
	INSERCAO
   ------------------------------------------------------------------------------
*/
INSERT	Sis_GrupoEmpresa (IDGrupo, IDEmpresa, Permissao)
	(
	SELECT 	G.IDGrupo,
		I.IDEmpresa,
		CASE IDGrupo
			WHEN C.Valor THEN 1
			ELSE 0
		END
	FROM	Sis_Grupo G,
		Inserted I,
		Sis_Constante C
	WHERE	C.Constante = 'Grupo_Administradores'
	)
GO

ALTER TABLE dbo.Fin_ContaCorrente WITH NOCHECK ADD CONSTRAINT
	FK_SisEmpresa_ContaCorrente_IDEmpresa FOREIGN KEY
	(
	IDEmpresa
	) REFERENCES dbo.Sis_Empresa
	(
	IDEmpresa
	) NOT FOR REPLICATION
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

ALTER TABLE dbo.Sis_GrupoEmpresa WITH NOCHECK ADD CONSTRAINT
	FK_SisEmpresa_SisGrupoEmpresa_IDEmpresa FOREIGN KEY
	(
	IDEmpresa
	) REFERENCES dbo.Sis_Empresa
	(
	IDEmpresa
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.Store WITH NOCHECK ADD CONSTRAINT
	FK_SisEmpresa_Store_IDEmpresa FOREIGN KEY
	(
	IDEmpresa
	) REFERENCES dbo.Sis_Empresa
	(
	IDEmpresa
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.Fin_Lancamento WITH NOCHECK ADD CONSTRAINT
	FK_SisEmpresa_Lancamento_IDEmpresa FOREIGN KEY
	(
	IDEmpresa
	) REFERENCES dbo.Sis_Empresa
	(
	IDEmpresa
	) NOT FOR REPLICATION

GO

