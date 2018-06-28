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

CREATE TABLE dbo.Tmp_Sis_MainMenu
	(
	IDMenuItem int NOT NULL,
	IDMenuItemParent int NULL,
	FormID int NULL,
	MenuItem varchar(55) NOT NULL,
	LoaderType int NULL,
	Parametro char(18) NULL,
	MenuBarBefore TBit NULL,
	Priority int NULL,
	ImageIndex int NULL,
	Obs varchar(255) NULL,
	ClassName varchar(50) NULL
	)  ON [PRIMARY]
GO

IF EXISTS(SELECT * FROM dbo.Sis_MainMenu)
	 EXEC('INSERT INTO dbo.Tmp_Sis_MainMenu (IDMenuItem, IDMenuItemParent, FormID, MenuItem, LoaderType, Parametro, MenuBarBefore, Priority, ImageIndex, Obs, ClassName)
		SELECT IDMenuItem, IDMenuItemParent, FormID, MenuItem, LoaderType, Parametro, MenuBarBefore, Priority, ImageIndex, Obs, ClassName FROM dbo.Sis_MainMenu TABLOCKX')
GO

DECLARE @temp Varchar (8000)
SET @temp = ''
SELECT @temp = @temp + 'ALTER TABLE ' + TabelaDerivada+ CHAR (13)+
+ CHAR(9)+'DROP CONSTRAINT ' + ConstraintName + CHAR (13)
FROM vw_Sis_ChaveEstrangeira
WHERE TabelaOriginal = 'Sis_MainMenu'
EXEC(@temp)
GO

DROP TABLE dbo.Sis_MainMenu
GO

ALTER TABLE dbo.Tmp_Sis_MainMenu ADD CONSTRAINT
	DF_Zero185 DEFAULT (0) FOR Priority
GO

EXECUTE sp_rename N'dbo.Tmp_Sis_MainMenu', N'Sis_MainMenu', 'OBJECT'
GO

ALTER TABLE dbo.Sis_MainMenu ADD CONSTRAINT
	PK__Sis_MainMenu__1A69E950 PRIMARY KEY CLUSTERED 
	(
	IDMenuItem
	) ON [PRIMARY]

GO

CREATE NONCLUSTERED INDEX XIF86Sis_MainMenu ON dbo.Sis_MainMenu
	(
	IDMenuItemParent
	) ON [PRIMARY]
GO

ALTER TABLE dbo.Sis_MainMenu WITH NOCHECK ADD CONSTRAINT
	FK_SisMainMenu_SisMainMenu_IDMenuItemParent FOREIGN KEY
	(
	IDMenuItemParent
	) REFERENCES dbo.Sis_MainMenu
	(
	IDMenuItem
	) NOT FOR REPLICATION

GO

CREATE TRIGGER tr_Sis_MainMenu_Insert ON dbo.Sis_MainMenu
FOR INSERT
NOT FOR REPLICATION
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		Deve manter integridade com
		-- Sis_GrupoMainMenu


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

SET NOCOUNT ON

/*
  -----------------------------------------------------------
	INSERSAO
  -----------------------------------------------------------
*/
DELETE 	Sis_GrupoMainMenu
FROM	Deleted D
WHERE	Sis_GrupoMainMenu.IDMenuItem = D.IDMenuItem
/*
  -----------------------------------------------------------
	DELECAO
  ----------------------------------------------------------- 
*/
INSERT 	Sis_GrupoMainMenu (IDGrupo, IDMenuItem, Acessa)
	(
	SELECT 	G.IDGrupo,
		I.IDMenuItem,
		CASE IDGrupo
			WHEN C.Valor THEN 1
			ELSE 0
		END
	FROM	Inserted I,
		Sis_Grupo G,
		Sis_Constante C
	WHERE	C.Constante = 'Grupo_Administradores'
	)
GO

ALTER TABLE dbo.Sis_GrupoMainMenu WITH NOCHECK ADD CONSTRAINT
	FK_SisMainMenu_SisGrupoMainMenu_IDMenuItem FOREIGN KEY
	(
	IDMenuItem
	) REFERENCES dbo.Sis_MainMenu
	(
	IDMenuItem
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.Sis_MainMenuPagina WITH NOCHECK ADD CONSTRAINT
	FK_SisMainMenu_SisMainMenuPagina_IDMenuItem FOREIGN KEY
	(
	IDMenuItem
	) REFERENCES dbo.Sis_MainMenu
	(
	IDMenuItem
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.Sis_MainMenuOperacao WITH NOCHECK ADD CONSTRAINT
	FK_SisMainMenu_SisMainMenuOperacao_IDMenuItem FOREIGN KEY
	(
	IDMenuItem
	) REFERENCES dbo.Sis_MainMenu
	(
	IDMenuItem
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.Sis_MainMenuLanguage WITH NOCHECK ADD CONSTRAINT
	FK_Sis_MainMenu_Sis_MainMenuLanguage_IDMenuItem FOREIGN KEY
	(
	IDMenuItem
	) REFERENCES dbo.Sis_MainMenu
	(
	IDMenuItem
	)
GO

