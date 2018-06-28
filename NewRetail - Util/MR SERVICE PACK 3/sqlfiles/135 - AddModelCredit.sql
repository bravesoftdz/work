if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_AddModelCredit]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_AddModelCredit]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_SubAddItem]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_SubAddItem]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_SubRemoveItem]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_SubRemoveItem]
GO

CREATE PROCEDURE sp_PreSale_AddModelCredit
		(
		@IDPreInventMov	int,
		@IDCliente		int,
		@IDUser		int,
		@IDStore		int,
		@MovDate		smalldatetime
 		)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Inserir no Customer Credit

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Inserir no Customer Credit


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	01 Dec 2004		Rodrigo Costa		Criacao;
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */


DECLARE @ErrorLevel		int
DECLARE @SysError		int
DECLARE @TotalCredit		Money
DECLARE @TotalCreditModel	Money
DECLARE @IDCustomerCredit	int

SET @ErrorLevel = 0


/*****************************************************************************************
	Inclusão dos Creditos para o modelo caso tenha
******************************************************************************************/
SELECT
	@TotalCredit = ((P.Qty * P.SalePrice)-P.Discount),
	@TotalCreditModel = (P.Qty * M.SellingPrice)
FROM
	PreInventoryMov P
	JOIN Model M ON (M.IDModel = P.ModelID)
	JOIN TabGroup TB ON (TB.IDGroup = M.GroupID)
WHERE
	TB.Credit = 1
	AND
	P.IDPreInventoryMov = @IDPreInventMov
	AND
	P.InventMovTypeID = 1

/*****************************************************************************************
	Testar o valor do PackModel
******************************************************************************************/
SELECT
	@TotalCredit = (CASE WHEN IDParentPack Is Null THEN @TotalCredit ELSE @TotalCreditModel END)
FROM
	PreInventoryMov
WHERE
	IDPreInventoryMov = @IDPreInventMov
	AND
	InventMovTypeID = 1

IF @TotalCredit > 0
BEGIN
	EXEC sp_Sis_GetNextCode 'CustomerCredit.IDCustomerCredit',  @IDCustomerCredit output

	INSERT CustomerCredit
	(
	IDCustomerCredit,
	IDPessoa,
	IDUser,
	IDStore,
	CreditDate,
	IsUsed,
	Amount,
	IDPreInventoryMov
	)
	VALUES
	(
	@IDCustomerCredit,
	@IDCliente,
	@IDUser,
	@IDStore,
	@MovDate,
	0,
	ABS(ISNULL(@TotalCredit, 0)),
	@IDPreInventMov
	)

END

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END


OK:
	RETURN 0

ERRO:
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PreSale_AddModelCredit', @ErrorLevelStr

	RETURN @ErrorLevel
GO

CREATE PROCEDURE sp_PreSale_SubAddItem
		(
		@PreSaleID      int,
		@IDCliente	int,
		@ModelID     	int,
		@StoreID     	int,
		@UserID      	int,
		@IDComission	int,
		@Qty         	int,
 		@SalePrice      money,
		@CostPrice      money = Null,
		@Discount    	money,
		@MovDate     	smalldatetime,
		@PreInventMovID int 		Output
 		)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Insert on Inventory Movement
		- Inserir no Customer Credit

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Insert on Inventory Movement
		-203  Erro em Inclusão de Models de PacketModel
		-204  Erro em Inserir no Customer Credit
		-205  Erro em Inserir no Customer Credit do PackModel


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
	26 June 2001		Davi Gouveia		Log de Return Values
	29 Oct	2003		Rodrigo Costa		Criado sp_Sis_GetNextCod;
	24 May	2004		André Bogado		Criado Cursor para KitModel 
	18 Aug 2004		Rodrigo Costa		Gravar error log
	01 Dec 2004		Rodrigo Costa		Gravar no Customer Credit
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */


DECLARE @ComissionID 	int
DECLARE @ErrorLevel		int
DECLARE @SysError		int

--Declaração de variáveis para o Cursor de ModelChild
DECLARE @ModelIDChild  	int 
DECLARE @QtyChild  		int 
DECLARE @PreInvMovIDPack	int

SET @ErrorLevel = 0

BEGIN TRAN

/*-------------------------------------------------------------*/
/*                  Insert on PreInventory Movement               */
/*-------------------------------------------------------------*/

EXEC sp_Sis_GetNextCode'PreInventoryMov.IDPreInventoryMov', @PreInventMovID OUTPUT
INSERT dbo.PreInventoryMov
	(
	IDPreInventoryMov,
	InventMovTypeID,
	IDPessoa,
	DocumentID,
	ModelID,
	StoreID,
	MovDate,
 	Qty,
	SalePrice,
	Discount,
	CostPrice,
	ComissionID,
	UserID
	)
	SELECT
		@PreInventMovID,
		1,
		@IDCliente,
 		@PreSaleID,
		@ModelID,
		@StoreID,
		@MovDate,
		@Qty,
		@SalePrice,
 		@Discount,
		IsNull(@CostPrice, (VendorCost+OtherCost+FreightCost)),
 		@IDComission,
		@UserID
	FROM
 		dbo.Model
 	WHERE
		dbo.Model.IDModel = @ModelID

SET @SysError = @@ERROR
IF @SysError <> 0 
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END

/*****************************************************************************************
	Inclusão dos Creditos para o modelo caso tenha
******************************************************************************************/
EXEC sp_PreSale_AddModelCredit
			@PreInventMovID,
			@IDCliente,
			@UserID,
			@StoreID,
			@MovDate


SET @SysError = @@ERROR
IF @SysError <> 0 
BEGIN
	SET @ErrorLevel = -204
	GOTO ERRO
END
 

/*****************************************************************************************
	Inclusão de Models de PacketModel
******************************************************************************************/

--Declaração do Cursor de ModelChild

DECLARE ModelChild_Cursor CURSOR FOR

	SELECT
		M.IDModel,
		P.Qty
	FROM
 		dbo.PackModel P
		JOIN dbo.Model M ON (P.IDModel= M.IDModel)
 	WHERE
		P.IDPackModel = @ModelID


OPEN ModelChild_Cursor

--Inicialização de ModelChild_Cursor
FETCH NEXT FROM ModelChild_Cursor INTO
	@ModelIDChild,
	@QtyChild

--Enquanto tem registros
WHILE
@@FETCH_STATUS = 0
BEGIN
	EXEC sp_Sis_GetNextCode'PreInventoryMov.IDPreInventoryMov', @PreInvMovIDPack OUTPUT

	INSERT dbo.PreInventoryMov
	(
	IDPreInventoryMov,
	InventMovTypeID,
	IDPessoa,
	DocumentID,
	ModelID,
	StoreID,
	MovDate,
 	Qty,
	SalePrice,
	Discount,
	CostPrice,
	ComissionID,
	UserID,
	IDParentPack
	)
	SELECT
		@PreInvMovIDPack,
		1,
		@IDCliente,
 		@PreSaleID,
		@ModelIDChild,
		@StoreID,
		@MovDate,
		@Qty * @QtyChild,--Qtde Comprada x Qtde do Kit
		0,
 		0,
		FinalCost,
 		@IDComission,
		@UserID,
		@PreInventMovID
	FROM
 		dbo.Model
 	WHERE
		dbo.Model.IDModel = @ModelIDChild


	SET @SysError = @@ERROR
	IF @SysError <> 0 
	BEGIN
		CLOSE ModelChild_Cursor
		DEALLOCATE ModelChild_Cursor
		SET @ErrorLevel = -203
		GOTO ERRO
	END

	/*****************************************************************************************
		Inclusão dos Creditos dos item do pack caso tenha
	******************************************************************************************/
	EXEC sp_PreSale_AddModelCredit
			@PreInvMovIDPack,
			@IDCliente,
			@UserID,
			@StoreID,
			@MovDate


	SET @SysError = @@ERROR
	IF @SysError <> 0 
	BEGIN
		SET @ErrorLevel = -205
		GOTO ERRO
	END

	--Leitura do Proximo 
	FETCH NEXT FROM ModelChild_Cursor INTO
		@ModelIDChild,
		@QtyChild

END
--fechamento do cursor
CLOSE ModelChild_Cursor

--Destruição do cursor
DEALLOCATE ModelChild_Cursor

SET @SysError = @@ERROR
IF @SysError <> 0 
BEGIN
	SET @ErrorLevel = -203
	GOTO ERRO
END



OK:
	COMMIT TRAN
	RETURN 0

ERRO:
	PRINT CAST(@ErrorLevel AS VARCHAR)
	ROLLBACK TRAN

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PreSale_SubAddItem', @ErrorLevelStr

	RETURN @ErrorLevel
GO

CREATE PROCEDURE sp_PreSale_SubRemoveItem
			(
			@PreInventMovID int
			)
AS 
/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Delete on Pre Inventory Movement Items Packages
		- Delete on Pre Inventory Movement

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro no Delete
		-202  Erro no Delete PackItems
		-203  Erro no Delete CustomerCredit
		-204  Erro no Delete CustomerCredit do PackModel


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
	26 June 2001		Davi Gouveia		Log de Return Values
	25 May 2004		Rodrigo Costa		Deletar os PackModels
	18 Aug 2004		Rodrigo Costa		Gravar error log
	01 Dec 2004		Rodrigo Costa		Deletar os Credits for Customer
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

DECLARE @ErrorLevel	int
DECLARE @SysError	int

SET @ErrorLevel = 0


/*-------------------------------------------------------------*/
/*                  Delete on os Customers Credit  do  PreInventoryMovPack        */
/*-------------------------------------------------------------*/
UPDATE
	CustomerCredit
SET
	IsUsed = 1
FROM
	PreInventoryMov PIM 
WHERE
	PIM.IDParentPack = @PreInventMovID
	AND
	CustomerCredit.IDPreInventoryMov = PIM.IDPreInventoryMov


SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -204
	GOTO ERRO
END

/*-------------------------------------------------------------*/
/*                  Delete on Pre Inventory Movement Pack           */
/*-------------------------------------------------------------*/

DELETE
	dbo.PreInventoryMov
WHERE
	dbo.PreInventoryMov.IDParentPack = @PreInventMovID

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -202
	GOTO ERRO
END


/*-------------------------------------------------------------*/
/*                  Delete os Customers Credit  do  PreInventoryMov        */
/*-------------------------------------------------------------*/
UPDATE
	CustomerCredit
SET
	IsUsed = 1
WHERE
	IDPreInventoryMov = @PreInventMovID

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -203
	GOTO ERRO
END


/*-------------------------------------------------------------*/
/*                  Delete on Pre Inventory Movement           */
/*-------------------------------------------------------------*/

DELETE
	dbo.PreInventoryMov
WHERE
	dbo.PreInventoryMov.IDPreInventoryMov = @PreInventMovID

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END

OK:
	RETURN 0
ERRO:
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PreSale_SubRemoveItem', @ErrorLevelStr

	RETURN @ErrorLevel
GO
