IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[tr_Ser_SOItemProduct_All]') AND OBJECTPROPERTY(id, N'IsTrigger') = 1)
DROP TRIGGER [dbo].[tr_Ser_SOItemProduct_All]
GO

CREATE TRIGGER tr_Ser_SOItemProduct_All ON Ser_SOItemProduct
FOR INSERT, UPDATE, DELETE
NOT FOR REPLICATION
AS

/* ----------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Delete InventoryMov
		- Insert InventoryMov

	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	-----------------------	-----------------------	-----------------------------------------------------------------
	23 Jan  2008		Rodrigo Costa		Criacao;
	----------------------------------------------------------------------------------------------------------------- */


IF @@rowcount = 0
	RETURN

IF ISNULL(APP_NAME (), '') = 'MRREPLICATION' 
	RETURN

SET NOCOUNT ON

DECLARE @IDInventoryMov	int
DECLARE @InsertedLines	int

----------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------
--	D E L E T E
----------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------


	DELETE
		IM
	FROM
		InventoryMov IM,
		Deleted D
	WHERE
		IM.DocumentID = D.IDSOItemProduct
		AND
		IM.InventMovTypeID = 50


----------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------
--	I N S E R T
----------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------

SELECT @InsertedLines = Count(*) FROM Inserted

IF (@InsertedLines > 0)
BEGIN
	EXEC sp_Sis_GetNextCode 'InventoryMov.IDInventoryMov', @IDInventoryMov OUTPUT

	INSERT InventoryMov
		(
		IDInventoryMov,
		InventMovTypeID,
		DocumentID,
		StoreID,
		ModelID,
		MovDate,
		Qty,
		CostPrice,
		SalePrice,
		IDUser,
		IDDepartment,
		IDPessoa
		)
	SELECT
		@IDInventoryMov,
		50,
		I.IDSOItemProduct,
		I.IDStore,
		I.IDModel,
		I.MovDate,
		I.Qty,
		I.CostPrice,
		I.SalePrice,
		I.IDUser,
		0,
		I.IDCustomer
	FROM
		Inserted I
		
END

GO
