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

CREATE TABLE dbo.Tmp_Sis_Grupo
	(
	IDGrupo int NOT NULL,
	Grupo TDescricao NOT NULL,
	Hidden TControlField NOT NULL,
	Desativado TControlField NOT NULL,
	System TControlField NOT NULL
	)  ON [PRIMARY]
GO

IF EXISTS(SELECT * FROM dbo.Sis_Grupo)
	 EXEC('INSERT INTO dbo.Tmp_Sis_Grupo (IDGrupo, Grupo, Hidden, Desativado, System)
		SELECT IDGrupo, Grupo, Hidden, Desativado, System FROM dbo.Sis_Grupo TABLOCKX')
GO

DECLARE @temp Varchar (8000)
SET @temp = ''
SELECT @temp = @temp + 'ALTER TABLE ' + TabelaDerivada+ CHAR (13)+
+ CHAR(9)+'DROP CONSTRAINT ' + ConstraintName + CHAR (13)
FROM vw_Sis_ChaveEstrangeira
WHERE TabelaOriginal = 'Sis_Grupo'
EXEC(@temp)
GO

DROP TABLE dbo.Sis_Grupo
GO

EXECUTE sp_rename N'dbo.Tmp_Sis_Grupo', N'Sis_Grupo', 'OBJECT'
GO

ALTER TABLE dbo.Sis_Grupo ADD CONSTRAINT
	PK__Sis_Grupo__0C1BC9F9 PRIMARY KEY CLUSTERED 
	(
	IDGrupo
	) ON [PRIMARY]

GO

CREATE TRIGGER tr_Sis_Grupo_All ON dbo.Sis_Grupo
FOR INSERT,UPDATE,DELETE
NOT FOR REPLICATION
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		Este novo trigger devera manter a integridade entre as seguintes tabelas
		-- Sis_GrupoMainMenu
		-- Sis_GrupoMainMenuPagina
		-- Sis_GrupoMainMenuOperacao
		-- Sis_GrupoEmpresa


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

SET NOCOUNT ON

/* ---------------------------------------------------
	Delecao
   --------------------------------------------------- */ 
DELETE 	Sis_GrupoMainMenu 
FROM 	Deleted D 
WHERE 	Sis_GrupoMainMenu.IDGrupo = D.IDGrupo

DELETE 	Sis_GrupoMainMenuPagina
FROM 	Deleted D 
WHERE 	Sis_GrupoMainMenuPagina.IDGrupo = D.IDGrupo

DELETE 	Sis_GrupoMainMenuOperacao
FROM 	Deleted D 
WHERE 	Sis_GrupoMainMenuOperacao.IDGrupo = D.IDGrupo

DELETE 	Sis_GrupoEmpresa
FROM 	Deleted D 
WHERE 	Sis_GrupoEmpresa.IDGrupo = D.IDGrupo


/* ---------------------------------------------------
	Insercao
   --------------------------------------------------- */
INSERT	Sis_GrupoMainMenu ( IDGrupo, IDMenuItem )
	( 
	SELECT	I.IDGrupo, 
		MM.IDMenuItem
	FROM	Inserted I,
		Sis_MainMenu MM
	)
	
INSERT	Sis_GrupoMainMenuPagina ( IDGrupo, IDMenuItem, PaginaNome )
	(
	SELECT	I.IDGrupo, 
		MMP.IDMenuItem,
		MMP.PaginaNome
	FROM	Inserted I,
		Sis_MainMenuPagina MMP
	)
INSERT	Sis_GrupoMainMenuOperacao ( IDGrupo, IDMenuItem, IDOperacao )
	(
	SELECT	I.IDGrupo,
		MMO.IDMenuItem,
		MMO.IDOperacao
	FROM	Inserted I,
		Sis_MainMenuOperacao MMO
	)
INSERT	Sis_GrupoEmpresa ( IDGrupo, IDEmpresa )
	(
	SELECT	I.IDGrupo, 
		E.IDEmpresa
	FROM	Inserted I,
		Sis_Empresa E
	)
GO

ALTER TABLE dbo.Sis_GrupoMainMenuOperacao WITH NOCHECK ADD CONSTRAINT
	FK_SisGrupo_SisGrupoMainMenuOperacao_IDGrupo FOREIGN KEY
	(
	IDGrupo
	) REFERENCES dbo.Sis_Grupo
	(
	IDGrupo
	) NOT FOR REPLICATION

GO

ALTER TABLE dbo.Sis_GrupoMainMenuPagina WITH NOCHECK ADD CONSTRAINT
	FK_SisGrupo_SisGrupoMainMenuPagina_IDGrupo FOREIGN KEY
	(
	IDGrupo
	) REFERENCES dbo.Sis_Grupo
	(
	IDGrupo
	) NOT FOR REPLICATION

GO

ALTER TABLE dbo.Sis_GrupoMainMenu WITH NOCHECK ADD CONSTRAINT
	FK_SisGrupo_SisGrupoMainMenu_IDGrupo FOREIGN KEY
	(
	IDGrupo
	) REFERENCES dbo.Sis_Grupo
	(
	IDGrupo
	) NOT FOR REPLICATION

GO

ALTER TABLE dbo.Sis_GrupoEmpresa WITH NOCHECK ADD CONSTRAINT
	FK_SisGrupo_SisGrupoEmpresa_IDGrupo FOREIGN KEY
	(
	IDGrupo
	) REFERENCES dbo.Sis_Grupo
	(
	IDGrupo
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.Sis_UsuarioGrupo WITH NOCHECK ADD CONSTRAINT
	FK__Sis_Usuar__IDGru__100C566E FOREIGN KEY
	(
	IDGrupo
	) REFERENCES dbo.Sis_Grupo
	(
	IDGrupo
	)
GO

