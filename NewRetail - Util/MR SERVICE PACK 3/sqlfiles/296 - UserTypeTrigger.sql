if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tr_UserType_delete]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[tr_UserType_delete]
GO

CREATE TRIGGER tr_UserType_delete ON dbo.UserType
FOR DELETE 
NOT FOR REPLICATION
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Deleto de UserRights
		- Deleto de UserTypeToSysFunction
		- Delete de UserTypeToRep_Item

	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
	11 Oct	2005		Rodrigo Costa		Alteracao em UserTypeToRep_Item 
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

DELETE
	UserTypeToRep_Item 
FROM
	Deleted
WHERE
	UserTypeToRep_Item.IDUserType = Deleted.IDUserType

GO

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
		- Insiro em UserTypeToRep_Item


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
	11 Oct	2005		Rodrigo Costa		Inserir UserTypeToRep_Item
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
if NOT EXISTS (	SELECT Deleted.IDUserType FROM Deleted )
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

		INSERT
			UserTypeToRep_Item
		(
			IDUserType,
			ItemID,
			Access
		)
		SELECT
			Inserted.IDUserType,
			R.ItemId,
			0
		FROM
			Inserted,
			Rep_Item R

	END

GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tr_RepItem_Insert]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[tr_RepItem_Insert]
GO

CREATE TRIGGER tr_RepItem_Insert ON dbo.Rep_Item
FOR INSERT, UPDATE
NOT FOR REPLICATION
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Insiro em UserTypeToRep_Item


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	11 Oct	2005		Rodrigo Costa		Criacao
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

IF @@RowCount = 0
   RETURN

SET NOCOUNT ON

/* So faz na inclusao  */
if NOT EXISTS (	SELECT Deleted.ItemId FROM Deleted )
	BEGIN

		INSERT
			UserTypeToRep_Item
		(
			IDUserType,
			ItemId,
			Access
		) 
		SELECT
			UT.IDUserType,
			Inserted.ItemId,
			0
		FROM
			UserType UT,
			Inserted


	END

GO

INSERT
	UserTypeToRep_Item
	(
	IDUserType,
	ItemID,
	Access,
	Edit
	)
SELECT
	UT.IDUserType,
	R.ItemId,
	1,
	1
FROM
	UserType UT,
	Rep_Item R
GO

