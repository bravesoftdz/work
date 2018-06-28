SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[sp_Purchase_Remove]
		(
 		@IDPurchase	 	 int
		)
AS 

/* ----------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Atualizo o QtyOnPreReceive no Inventory
		- Deleto os InventoryMov
		- Deleto os PreInventoryMov
		- Deleto os PurchaseItemSerial
		- Deleto os PurchaseItem
		- Deleto os PurchaseDueDate
		- Deleto o Term do Financeiro
		- Deleto o Term da Purchase
 		- Deleto o Contas a Pagar, caso exista
		- Deleto a total de purhcase (o bacalhau do BugBDE)
		- Deleto o Purchase
		- Deletar a TBL Pur_PurchaseQtyPreSale
		- Deletar a TBL Pur_PurchaseItemTax
		- Deletar Pur_PurchaseItemTaxRet
		- Atualizar o fechamento do PO
		- Atualizar os valores do PO
		- Movimentar quantidade de lote

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Deleto qtyOnPrePurchase do Inventory
		-202  Erro em Deleto qtyOnOrder do Inventory
		-203  Erro em Deleto os PreInventoryMov
		-204  Erro em Deleto os InventoryMov
		-205  Erro em Deleto os PurchaseItemSerial
		-206  Erro em Deleto o PurchaseDueDate
		-207  Erro em Deleto o Term do Fin
		-208  Erro em Deleto o Term do Purchase
		-209  Erro em Deleto as contas a pagar
		-210  Erro em Deleto os PurchaseTotal
		-211  Erro em Deleto os Purchase
		-212  Erro em Deletar Pur_PurchaseItemTax
		-213  Erro em Deletar Pur_PurchaseItemTaxRet
		-214  Erro em Atualizar o fechamento do PO
		-215  Erro em Atualizar os valores do PO
		-216  Erro em Atualizar o Custo Medio
		-217  Erro em Deletar Pur_PurchaseVerify
		-218  Erro em Movimentar Qtd Lote

	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	-----------------------	-----------------------	--------------------------------------------------------------------------------
	04 Dec	2000		Eduardo Costa		Criação;
	18 Dec	2001		Rodrigo Costa		Atualizacao;
	08 Jun	2001		Rodrigo Costa		Deletar o Term do Fin_Lancamento & Purchase;
	26 Jun	2001		Davi Gouveia		Log de Return Values;
	18 Aug	2004		Rodrigo Costa		Gravar error log;
	14 Dez	2004		Rodrigo Costa		Deletar os Pur_PurchaseItemTax;
	11 Mar	2005		Carlos Lima		Deletar os Pur_PurchaseItemTaxRet;
	11 Mar	2005		Rodrigo Costa		Alteracao do PO;
	01 Dec	2005		Carlos Lima		Atualizar Totais e Condição de fechamento do PO;
	09 Dec	2005		Rodrigo Costa		Atualizar o Custo Medio;
	11 Jan	2006		Rodrigo Costa		Remover o Custo Medio;
	23 Feb	2006		Maximiliano Muniz	Deletar os PurchaseDueDate;
	06 Jun  2006		Carlos Lima		Deleção do InvMov em um cursor, para atualizar o AvgCost
	31 Jul  2008		Rodrigo Costa		Deleção do Pur_PurchaseVerify
	31 Mar	2009		Rodrigo Costa		Movimentar Quantidade de Lote
	----------------------------------------------------------------------------------------------------------------- */

DECLARE @ErrorLevel	int
DECLARE @SysError	int
DECLARE @IDPO		int
DECLARE @IDInventoryMov	int

SET @ErrorLevel = 0

BEGIN TRAN

---------------------------------------------------------------------------- ##Carlos
-- Obtenho o ID do PO

SELECT
	@IDPO = IDPO
FROM
	Pur_Purchase (NOLOCK) 
WHERE
	IDPurchase = @IDPurchase

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -208
	GOTO ERRO
END

---------------------------------------------------------------------------- ##Rodrigo
-- Deleto qtyOnPrePurchase do Inventory
DELETE
	PUQ
FROM
	Pur_PurchaseQtyPrePurchase PUQ (NOLOCK) 
WHERE
	PUQ.IDPurchase =  @IDPurchase

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END


---------------------------------------------------------------------------- ##Rodrigo
-- Deleto qtyOnOrder do Inventory
DELETE
	PUQ
FROM
	Pur_PurchaseQtyOrder PUQ (NOLOCK) 
WHERE
	PUQ.IDPurchase =  @IDPurchase

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -202
	GOTO ERRO
END

------------------------------------------------------------------------------
-- Deleto os PreInventoryMov

DELETE
	PIM
FROM
	PreInventoryMov PIM (NOLOCK) 
WHERE
	PIM.DocumentID = @IDPurchase
	AND
	PIM.InventMovTypeID = 2

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -203
	GOTO ERRO
END

------------------------------------------------------------------------------
-- Deleto os InventoryMov

DECLARE InventoryMov_Cursor CURSOR FOR

SELECT
	IM.IDInventoryMov
FROM
	InventoryMov IM (NOLOCK) 
WHERE
	IM.DocumentID = @IDPurchase
	AND
	IM.InventMovTypeID = 2


OPEN InventoryMov_Cursor


FETCH NEXT FROM InventoryMov_Cursor INTO
	@IDInventoryMov

WHILE @@FETCH_STATUS = 0
BEGIN
	EXEC sp_Inventory_Del_Moviment @IDInventoryMov
	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		CLOSE InventoryMov_Cursor
		DEALLOCATE InventoryMov_Cursor
		SET @ErrorLevel = -204
		GOTO ERRO
	END

	FETCH NEXT FROM InventoryMov_Cursor INTO
		@IDInventoryMov
END

CLOSE InventoryMov_Cursor
DEALLOCATE InventoryMov_Cursor

/*
DELETE
	IM
FROM
	InventoryMov IM
WHERE
	IM.DocumentID = @IDPurchase
	AND
	IM.InventMovTypeID = 2

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -204
	GOTO ERRO
END

*/

------------------------------------------------------------------------------
-- Deleto os PurchaseItemSerial

DELETE
	PIS
FROM
	Pur_PurchaseItemSerial PIS (NOLOCK) 
WHERE
	PIS.IDPurchase = @IDPurchase

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -205
	GOTO ERRO
END

------------------------------------------------------------------------------
-- Deleto os PurchaseItemTax

DELETE
	PIT
FROM
	Pur_PurchaseItemtax PIT (NOLOCK) 
WHERE
	PIT.IDPurchase = @IDPurchase

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -212
	GOTO ERRO
END

------------------------------------------------------------------------------
-- Deleto os PurchaseItemTaxRet

DELETE
	PIT
FROM
	Pur_PurchaseItemtaxRet PIT (NOLOCK) 
WHERE
	PIT.IDPurchase = @IDPurchase

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -213
	GOTO ERRO
END

------------------------------------------------------------------------------
-- Deleto os PurchaseItem
-- Atualizo Quantidade Lote
UPDATE
	L
SET
	L.Qty = (L.Qty - PPI.Qty)
FROM
	Pur_PurchaseItem PPI (NOLOCK)
	JOIN Pur_Purchase P (NOLOCK) ON (P.IDPurchase = PPI.IDPurchase)
	JOIN Inv_StoreModelLot L (NOLOCK) ON (L.IDModel = PPI.IDModel AND L.IDStore = P.IDStore AND L.IDLote = PPI.IDLote)
WHERE
	PPI.IDPurchase = @IDPurchase
	AND
	PPI.IDLote IS NOT NULL

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -218
	GOTO ERRO
END

------------------------------------------------------------------------------
-- Deleto os PurchaseItem
DELETE
	PPI
FROM
	Pur_PurchaseItem PPI (NOLOCK) 
WHERE
	PPI.IDPurchase = @IDPurchase

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -206
	GOTO ERRO
END

------------------------------------------------------------------------------
-- Deleto os PurchaseDueDate

DELETE
	PDD
FROM
	Pur_PurchaseDueDate PDD (NOLOCK) 
WHERE
	PDD.IDPurchase = @IDPurchase

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -207
	GOTO ERRO
END

------------------------------------------------------------------------------
-- Deleto o Term do Fin 

DELETE
	Fin_LancamentoTerm
WHERE	IDLancamento IN (SELECT L.IDLancamento FROM Fin_Lancamento L (NOLOCK) WHERE L.IDPurchase = @IDPurchase)

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -207
	GOTO ERRO
END


------------------------------------------------------------------------------
-- Deleto o Term do Purchase 

DELETE
	Pur_PurchaseTerm
WHERE
	IDPurchase = @IDPurchase

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -208
	GOTO ERRO
END


------------------------------------------------------------------------------
-- Deleto as contas a pagar

DELETE
	L
FROM
	Fin_Lancamento L (NOLOCK) 
WHERE
	L.IDPurchase = @IDPurchase

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -209
	GOTO ERRO
END


------------------------------------------------------------------------------
-- Deleto os PurchaseTotal

DELETE
	PT
FROM 
	Pur_PurchaseTotal PT (NOLOCK) 
WHERE
	PT.IDPurchase = @IDPurchase

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -210
	GOTO ERRO
END

------------------------------------------------------------------------------
-- Deleto os Pur_PurchaseVerify

DELETE
	PV
FROM
	Pur_PurchaseVerify PV (NOLOCK) 
WHERE
	PV.IDPurchase = @IDPurchase

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -217
	GOTO ERRO
END


------------------------------------------------------------------------------
-- Deleto os Purchase

DELETE
	P
FROM
	Pur_Purchase P (NOLOCK) 
WHERE
	P.IDPurchase = @IDPurchase

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -211
	GOTO ERRO
END

IF @IDPO IS NOT NULL
BEGIN
------------------------------------------------------------------------------
-- Call sp_PO_CalcTotalQty
	
	EXEC sp_PO_CalcTotalQty @IDPO
	
	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		SET @ErrorLevel = -214
		GOTO ERRO
	END

------------------------------------------------------------------------------
-- Call sp_PO_AtuPOTotal

	EXEC sp_PO_AtuPOTotal @IDPO
	
	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		SET @ErrorLevel = -215
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
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_Purchase_Remove', @ErrorLevelStr

	RETURN @ErrorLevel
GO
