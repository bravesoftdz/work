IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[sp_PreSale_SubRemoveItem]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[sp_PreSale_SubRemoveItem]
GO

CREATE PROCEDURE sp_PreSale_SubRemoveItem
	(
	@PreInventMovID int
	)
AS

/* ---------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Delete on Pre Inventory Movement Items Packages
		- Delete on Pre Inventory Movement

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro no Delete
		-202  Erro no Delete PackItems
		-203  Erro no Delete CustomerCredit
		-204  Erro no Delete CustomerCredit do PackModel
		-205  Erro em atulaizar qtyExchanged no Pre
		-206  Erro em atulaizar qtyExchanged no Inv
		-207  Erro no Delete SaleItemCommission
		-208  Erro ao deletar o comissionamento dos itens de Kit
		-209  Erro ao deletar Inv_MovPrice
		-210  Erro ao deletar Inv_MovPrice

	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	-----------------------	-----------------------	----------------------------------------------------------------------------------
	15 May	2000		Eduardo Costa		Criacao;
	26 Jun	2001		Davi Gouveia		Log de Return Values;
	25 May	2004		Rodrigo Costa		Deletar os PackModels;
	18 Aug	2004		Rodrigo Costa		Gravar error log;
	01 Dec	2004		Rodrigo Costa		Deletar os Credits for Customer;
	28 Nov	2005		Leonardo Riego		Deletar as linhas da SaleItemCommission;
	16 Jun	2006		Rodrigo Costa		Deletar as linhas do SaleItemCommission do item de Kit;
	16 Jun	2006		Rodrigo Costa		Adicionado os parametros para ErrorHistory;
	20 Jul	2007		Maximiliano Muniz	Deletar a linha da Inv_MovPrice;
	08 Aug	2007		Maximiliano Muniz	Deletar a linha da Inv_MovDocument;
	---------------------------------------------------------------------------------------------------------------------------------- */

DECLARE @ErrorLevel			int
DECLARE @SysError			int
DECLARE @IDPreInvMovExchange	int
DECLARE @Qty			float

SET @ErrorLevel = 0

/*--------------------------------------------------------------*/
/*	Delete on os Customers Credit do PreInventoryMovPack	*/
/*--------------------------------------------------------------*/
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

/*----------------------------------------------*/
/*	Deletar as quantidades para troca	*/
/*----------------------------------------------*/
SELECT
	@IDPreInvMovExchange = IDPreInvMovExchange,
	@Qty = Qty
FROM
	PreInventoryMov
WHERE
	IDPreInventoryMov = @PreInventMovID

IF (@IDPreInvMovExchange IS NOT Null)
BEGIN
	--Pre Inv Mov
	UPDATE
		PreInventoryMov
	SET 
		QtyExchanged = IsNull(QtyExchanged,0) - ABS(@Qty)
	WHERE 
		IDPreInventoryMov = @IDPreInvMovExchange
		AND 
		InventMovTypeID = 1
	
	SET @SysError = @@ERROR
	IF @SysError <> 0 
	BEGIN
		SET @ErrorLevel = -205
		GOTO ERRO
	END
	
	-- Inv Mov
	UPDATE
		InventoryMov
	SET 
		QtyExchanged = IsNull(QtyExchanged,0) - ABS(@Qty)
	WHERE 
		PreInventoryMovID = @IDPreInvMovExchange
		AND 
		InventMovTypeID = 1
	
	SET @SysError = @@ERROR
	IF @SysError <> 0 
	BEGIN
		SET @ErrorLevel = -206
		GOTO ERRO
	END
END

/*----------------------------------------------*/
/*	Delete os Commissions dos itens de Kit	*/
/*----------------------------------------------*/
DELETE
	SaleItemCommission
FROM
	PreInventoryMov PIM
	JOIN SaleItemCommission SIC ON (PIM.IDPreInventoryMov = SIC.IDPreInventoryMov)
WHERE
	PIM.IDParentPack = @PreInventMovID

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -208
	GOTO ERRO
END

/*------------------------------------------------------*/
/*	Delete os Commissions for SaleItemCommission	*/
/*------------------------------------------------------*/
DELETE
	SaleItemCommission
WHERE
	SaleItemCommission.IDPreInventoryMov = @PreInventMovID

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -207
	GOTO ERRO
END

/*----------------------------------------------*/
/*	Delete on Pre Inventory Movement Pack	*/
/*----------------------------------------------*/
DELETE
	PreInventoryMov
WHERE
	PreInventoryMov.IDParentPack = @PreInventMovID

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -202
	GOTO ERRO
END

/*------------------------------------------------------*/
/*	Delete os Customers Credit do PreInventoryMov	*/
/*------------------------------------------------------*/
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

/*----------------------------------------------*/
/*	Delete on Inv_MovPrice			*/
/*----------------------------------------------*/
DELETE
	Inv_MovPrice
WHERE
	IDPreInventoryMov = @PreInventMovID

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -209
	GOTO ERRO
END

/*----------------------------------------------*/
/*	Delete on Inv_MovDocument		*/
/*----------------------------------------------*/
DELETE
	Inv_MovDocument
WHERE
	IDPreInventoryMov = @PreInventMovID

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -210
	GOTO ERRO
END

/*----------------------------------------------*/
/*	Delete on Pre Inventory Movement	*/
/*----------------------------------------------*/
DELETE
	PreInventoryMov
WHERE
	PreInventoryMov.IDPreInventoryMov = @PreInventMovID

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

	DECLARE @ErrorLevelStr varchar(110)
	DECLARE @Params varchar(100)
	SET @Params = ' [ @PreInventMovID = ' + CAST(@PreInventMovID AS VARCHAR) + ' ] '
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR) + @Params

	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PreSale_SubRemoveItem', @ErrorLevelStr
	RETURN @ErrorLevel
GO
