if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tr_UserType_insert]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[tr_UserType_insert]
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
		(
			UserTypeID,
			MenuID,
			SubMenuID,
			CanAccess,
			CanInsert,
			CanDelete,
			CanUpdate,
			CanPrint
		) 
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
		(
			IDUserType,
			IDSysFunction,
			Acesso
		)
		SELECT
			Inserted.IDUserType,
			SysFunction.IDSysFunction,
			0
		FROM
			SysFunction,
			Inserted
	END
GO
