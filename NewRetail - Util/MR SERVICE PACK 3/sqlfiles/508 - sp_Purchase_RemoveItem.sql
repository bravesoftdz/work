if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Purchase_RemoveItem]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Purchase_RemoveItem]
GO

CREATE PROCEDURE sp_Purchase_RemoveItem
		(
 		@IDPurchase		int,
		@IDPurchaseItem		int,
		@TaxInCost		bit
		)
AS 

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Obtenho o ID do PO
		- Atualizo o QtyOnPrePurchase no Inventory ### Rodrigo
		- Atualizo o QrtArrived no PreInvMov ## Rodrigo

		- Deleto os PurchaseItemSerial
		- Atualizao o Avg Cost no Model
		- Deleto o PurchaseItem
		- Call sp_Purchase_AtuPurchaseSubTotal
		- Deleto Pur_PurchaseItemTax
		- Deleto Pur_PurchaseItemTaxRet
		- Atualizo Total do PO
		- Atualizo condição de fechamento do PO

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Deleto AsQty o item no Pur_PurchaseQtyPrePurchase
		-202  Erro em Deleto AsQty o item no Pur_PurchaseQtyOrder
		-203  Erro em Deleto os PurchaseItemSerial
		-204  Erro em Deleto o PurchaseItem
		-205  Erro em Call sp_Purchase_AtuPurchaseSubTotal
		-206  Erro em Deletar Pur_PurchaseItemTax
		-207  Erro em Deletar Pur_PurchaseItemTaxRet
		-208  Obtenho o ID do PO
		-209  Atualizo Total do PO
		-210  Atualizo condição de fechamento do PO
		-211 Atualizao o Custo Medio
		-212 Erro ao desvincular Purchase do PO.


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	04 Dec 2000		Eduardo Costa		Criação;
	18 Dec 2000		Rodrigo Costa		Atualizacao;
	26 Jun 2001		Davi Gouveia		Log de Return Values
	18 Aug 2004		Rodrigo Costa		Gravar error log
	14 Dec 2004		Rodrigo Costa		Deletar os Pur_PurchaseItemTax
	11 Mar 2005		Carlos Lima		Deletar os Pur_PurchaseItemTaxRet
	01 Dec 2005		Carlos Lima		Verificar a Condição de fechamento do PO e atualizar
	07 Dec	2005		Rodrigo Costa		Atualizar o AvgCost no Model
	11 Jan	2006		Rodrigo Costa		Remover o Custo Medio
	20 Jul	2006		Leonardo Riego		Caso Purchase nao possua mais itens do PO desvincular o Purchase do PO.
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

DECLARE @ErrorLevel	int
DECLARE @SysError	int
DECLARE @IDPO	int
DECLARE @HavePOItens	int

SET @ErrorLevel = 0

BEGIN TRAN



---------------------------------------------------------------------------- ##Carlos
-- Obtenho o ID do PO

SELECT
	@IDPO = IDPO
FROM
	Pur_Purchase
WHERE
	IDPurchase = @IDPurchase

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -208
	GOTO ERRO
END

---------------------------------------------------------------------------- ##Rodrigo
-- Deleto AsQty o item no Pur_PurchaseQtyPrePurchase

DELETE
	PUQ
FROM
	Pur_PurchaseQtyPrePurchase PUQ
WHERE
	PUQ.IDModel = (
			SELECT
				PUI.IDModel
			FROM
				Pur_PurchaseItem PUI
			WHERE
				PUI.IDPurchaseItem = @IDPurchaseItem
				AND
				PUI.IDPurchase = @IDPurchase
		)

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END


---------------------------------------------------------------------------- ##Rodrigo
-- Deleto AsQty o item no Pur_PurchaseQtyOrder

DELETE
	PUQ
FROM
	Pur_PurchaseQtyOrder PUQ
WHERE
	PUQ.IDModel = (
			SELECT
				PUI.IDModel
			FROM
				Pur_PurchaseItem PUI
			WHERE
				PUI.IDPurchaseItem = @IDPurchaseItem
				AND
				PUI.IDPurchase = @IDPurchase
		)

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -202
	GOTO ERRO
END


------------------------------------------------------------------------------
-- Deleto os PurchaseItemSerial

DELETE
	PIS
FROM
	Pur_PurchaseItemSerial PIS
WHERE
	PIS.IDPurchaseItem = @IDPurchaseItem

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -203
	GOTO ERRO
END


------------------------------------------------------------------------------
-- Deleto os PurchaseItemTax

DELETE
	PIT
FROM
	Pur_PurchaseItemTax PIT
WHERE
	PIT.IDPurchaseItem = @IDPurchaseItem

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -206
	GOTO ERRO
END

------------------------------------------------------------------------------
-- Deleto os PurchaseItemTaxRet

DELETE
	PIT
FROM
	Pur_PurchaseItemTaxRet PIT
WHERE
	PIT.IDPurchaseItem = @IDPurchaseItem

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -207
	GOTO ERRO
END

------------------------------------------------------------------------------
-- Deleto o PurchaseItem

DELETE
	PPI
FROM
	Pur_PurchaseItem PPI
WHERE
	PPI.IDPurchaseItem = @IDPurchaseItem

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -204
	GOTO ERRO
END


------------------------------------------------------------------------------
-- Call sp_Purchase_AtuPurchaseSubTotal

EXEC sp_Purchase_AtuPurchaseSubTotal  @IDPurchase, @TaxInCost

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -205
	GOTO ERRO
END



IF @IDPO IS NOT NULL
BEGIN
------------------------------------------------------------------------------
-- Call sp_PO_AtuPOTotal

	EXEC sp_PO_AtuPOTotal @IDPO
	
	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		SET @ErrorLevel = -209
		GOTO ERRO
	END

------------------------------------------------------------------------------
-- Call sp_PO_CalcTotalQty
	
	EXEC sp_PO_CalcTotalQty @IDPO
	
	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		SET @ErrorLevel = -210
		GOTO ERRO
	END
------------------------------------------------------------------------------
-- Caso Purchase nao possua mais itens do PO desvincular o Purchase do PO.
	
	SELECT 
		@HavePOItens = COUNT(IDPurchaseItem)
	FROM
		Pur_Purchase PP
		JOIN PreInventoryMov PIM ON(PIM.DocumentID = PP.IDPO)
		JOIN Pur_PurchaseItem PPI ON (PPI.IDPOItem = PIM.IDPreInventoryMov AND PPI.IDPurchase = PP.IDPurchase)
	WHERE
		PP.IDPurchase = @IDPurchase 

	IF @HavePOItens = 0
	BEGIN
		UPDATE
			Pur_Purchase
		SET
			IDPO = NULL
		WHERE
			IDPurchase = @IDPurchase 		
	END
	
	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		SET @ErrorLevel = -212
		GOTO ERRO
	END
END


OK:
	COMMIT TRAN 
	RETURN 0
ERRO:
	ROLLBACK TRAN
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_Purchase_RemoveItem', @ErrorLevelStr

	RETURN @ErrorLevel
GO
