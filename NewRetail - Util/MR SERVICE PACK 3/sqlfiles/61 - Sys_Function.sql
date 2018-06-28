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

CREATE TABLE dbo.Tmp_SysFunction
	(
	IDSysFunction int NOT NULL,
	IDMenu int NOT NULL,
	IDSubMenu int NOT NULL,
	SysFunction varchar(100) NOT NULL
	)  ON [PRIMARY]
GO

IF EXISTS(SELECT * FROM dbo.SysFunction)
	 EXEC('INSERT INTO dbo.Tmp_SysFunction (IDSysFunction, IDMenu, IDSubMenu, SysFunction)
		SELECT IDSysFunction, IDMenu, IDSubMenu, SysFunction FROM dbo.SysFunction TABLOCKX')
GO

DECLARE @temp Varchar (8000)
SET @temp = ''
SELECT @temp = @temp + 'ALTER TABLE ' + TabelaDerivada+ CHAR (13)+
+ CHAR(9)+'DROP CONSTRAINT ' + ConstraintName + CHAR (13)
FROM vw_Sis_ChaveEstrangeira
WHERE TabelaOriginal = 'SysFunction'
EXEC(@temp)
GO

DROP TABLE dbo.SysFunction
GO

EXECUTE sp_rename N'dbo.Tmp_SysFunction', N'SysFunction', 'OBJECT'
GO

ALTER TABLE dbo.SysFunction ADD CONSTRAINT
	PK__SysFunction__3BFFE745 PRIMARY KEY CLUSTERED 
	(
	IDSysFunction
	) ON [PRIMARY]

GO

CREATE NONCLUSTERED INDEX XIF240SysFunction ON dbo.SysFunction
	(
	IDMenu,
	IDSubMenu
	) ON [PRIMARY]
GO

ALTER TABLE dbo.SysFunction WITH NOCHECK ADD CONSTRAINT
	FK_MenuItem_SysFunction_IDMenuIDSubMenu FOREIGN KEY
	(
	IDMenu,
	IDSubMenu
	) REFERENCES dbo.MenuItem
	(
	IDMenu,
	IDSubMenu
	) NOT FOR REPLICATION

GO

CREATE TRIGGER tr_SysFunction_Delete ON dbo.SysFunction
FOR DELETE
NOT FOR REPLICATION
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Deleto de UserTypeToSysFunction


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

SET NOCOUNT ON

DELETE
	UserTypeToSysFunction
FROM
	DELETED
WHERE
	UserTypeToSysFunction.IDSysFunction = DELETED.IDSysFunction

GO

CREATE TRIGGER tr_SysFunction_Insert ON dbo.SysFunction
FOR INSERT
NOT FOR REPLICATION
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Insiro em UserTypeToSysFunction


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

SET NOCOUNT ON

INSERT
	UserTypeToSysFunction
	SELECT
		UserType.IDUserType,
		Inserted.IDSysFunction,
		0
	FROM
		UserType,
		Inserted
GO

ALTER TABLE dbo.SysFunctionLanguage WITH NOCHECK ADD CONSTRAINT
	FK_SysFunction_SysFunctionLanguage_IDSysFunction FOREIGN KEY
	(
	IDSysFunction
	) REFERENCES dbo.SysFunction
	(
	IDSysFunction
	)
GO

