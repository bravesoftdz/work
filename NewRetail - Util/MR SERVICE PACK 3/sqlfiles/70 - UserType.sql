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

CREATE TABLE dbo.Tmp_UserType
	(
	IDUserType int NOT NULL,
	Name varchar(30) NOT NULL,
	Desativado bit NULL,
	System bit NULL,
	Hidden bit NULL
	)  ON [PRIMARY]
GO

IF EXISTS(SELECT * FROM dbo.UserType)
	 EXEC('INSERT INTO dbo.Tmp_UserType (IDUserType, Name, Desativado, System, Hidden)
		SELECT IDUserType, Name, Desativado, System, Hidden FROM dbo.UserType TABLOCKX')
GO

DECLARE @temp Varchar (8000)
SET @temp = ''
SELECT @temp = @temp + 'ALTER TABLE ' + TabelaDerivada+ CHAR (13)+
+ CHAR(9)+'DROP CONSTRAINT ' + ConstraintName + CHAR (13)
FROM vw_Sis_ChaveEstrangeira
WHERE TabelaOriginal = 'UserType'
EXEC(@temp)
GO

DROP TABLE dbo.UserType
GO

ALTER TABLE dbo.Tmp_UserType ADD CONSTRAINT
	DF_Zero12 DEFAULT (0) FOR Desativado
GO

ALTER TABLE dbo.Tmp_UserType ADD CONSTRAINT
	DF_Zero13 DEFAULT (0) FOR System
GO

ALTER TABLE dbo.Tmp_UserType ADD CONSTRAINT
	DF_Zero14 DEFAULT (0) FOR Hidden
GO

EXECUTE sp_rename N'dbo.Tmp_UserType', N'UserType', 'OBJECT'
GO

ALTER TABLE dbo.UserType ADD CONSTRAINT
	PK_UserType_IDUserType PRIMARY KEY CLUSTERED 
	(
	IDUserType
	) ON [PRIMARY]

GO

CREATE NONCLUSTERED INDEX PI_UserType_Name ON dbo.UserType
	(
	Name
	) ON [PRIMARY]
GO

CREATE TRIGGER tr_UserType_delete ON dbo.UserType
FOR DELETE 
NOT FOR REPLICATION
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Deleto de UserRights
		- Deleto de UserTypeToSysFunction


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

IF @@RowCount = 0
   RETURN

SET NOCOUNT ON

DELETE
	UserRights
FROM
	Deleted
WHERE
	UserRights.UserTypeID = Deleted.IDUserType

DELETE
	UserTypeToSysFunction
FROM
	Deleted
WHERE
	UserTypeToSysFunction.IDUserType = Deleted.IDUserType

GO

CREATE TRIGGER tr_UserType_insert ON dbo.UserType
FOR INSERT, UPDATE
NOT FOR REPLICATION
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Testo a existencia do UserType
		- Insiro em UserRights
		- Insiro em UserTypeToSysFunction


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

IF @@RowCount = 0
   RETURN

SET NOCOUNT ON

if	EXISTS 	(
		SELECT
			INSERTED.IDUserType
		FROM
			INSERTED,
			UserType
		WHERE
			INSERTED.Name = UserType.Name
			AND
			UserType.IDUserType <> INSERTED.IDUserType
			AND
			INSERTED.Desativado = 0
			AND
			UserType.Desativado = 0
		)

	BEGIN
		RAISERROR ('DUP_UserType_Name can not be duplicated',16,-1)
		ROLLBACK TRANSACTION
		RETURN
	END

/* So faz na inclusao  */
if 	NOT EXISTS
		(
		SELECT
			Deleted.IDUserType
		FROM
			Deleted
		)
	BEGIN
		INSERT
			userrights
		SELECT
			Inserted.IDUserType,
			MenuItem.IDMenu,
			MenuItem.IDSubMenu,
			0,
			0,
			0,
			0,
			0
		FROM
			MenuItem,
			Inserted

		INSERT
			UserTypeToSysFunction
		SELECT
			Inserted.IDUserType,
			SysFunction.IDSysFunction,
			0
		FROM
			SysFunction,
			Inserted
	END

GO

ALTER TABLE dbo.SystemUser WITH NOCHECK ADD CONSTRAINT
	FK_UserType_SystemUser_UserTypeID FOREIGN KEY
	(
	UserTypeID
	) REFERENCES dbo.UserType
	(
	IDUserType
	) NOT FOR REPLICATION

GO

