if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Purchase_Remove]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Purchase_Remove]
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

CREATE PROCEDURE sp_Purchase_Remove
		(
 		@IDPurchase	 	 int
		)
AS 

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Atualizo o QtyOnPreReceive no Inventory
		- Deleto os InventoryMov
		- Deleto os PreInventoryMov
		- Deleto os PurchaseItemSerial
		- Deleto os PurchaseItem
		- Deleto o Term do Financeiro
		- Deleto o Term da Purchase
 		- Deleto o Contas a Pagar, caso exista
		- Deleto a total de purhcase (o bacalhau do BugBDE)
		- Deleto o Purchase
		- Deletar a TBL Pur_PurchaseQtyPreSale

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Deleto qtyOnPrePurchase do Inventory
		-202  Erro em Deleto qtyOnOrder do Inventory
		-203  Erro em Deleto os PreInventoryMov
		-204  Erro em Deleto os InventoryMov
		-205  Erro em Deleto os PurchaseItemSerial
		-206  Erro em Deleto o Term do Fin
		-207  Erro em Deleto o Term do Fin
		-208  Erro em Deleto o Term do Purchase
		-209  Erro em Deleto as contas a pagar
		-210  Erro em Deleto os PurchaseTotal
		-211  Erro em Deleto os Purchase


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	04 dezembro 2000	Eduardo Costa		Criação;
	18 dez 200		Rodrigo Costa		Atualizacao;
	08 junho 2001		Rodrigo Costa		Deletar o Term do Fin_Lancamento & Purchase;
	26 June 2001		Davi Gouveia		Log de Return Values
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

DECLARE @ErrorLevel		int

SET @ErrorLevel = 0

BEGIN TRAN

---------------------------------------------------------------------------- ##Rodrigo
-- Deleto qtyOnPrePurchase do Inventory
DELETE
	PUQ
FROM
	Pur_PurchaseQtyPrePurchase PUQ
WHERE
	PUQ.IDPurchase =  @IDPurchase

IF @@ERROR <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END


---------------------------------------------------------------------------- ##Rodrigo
-- Deleto qtyOnOrder do Inventory
DELETE
	PUQ
FROM
	Pur_PurchaseQtyOrder PUQ
WHERE
	PUQ.IDPurchase =  @IDPurchase

IF @@ERROR <> 0
BEGIN
	SET @ErrorLevel = -202
	GOTO ERRO
END


------------------------------------------------------------------------------
-- Deleto os PreInventoryMov

DELETE
	PIM
FROM
	PreInventoryMov PIM
WHERE
	PIM.DocumentID = @IDPurchase
	AND
	PIM.InventMovTypeID = 2

IF @@ERROR <> 0
BEGIN
	SET @ErrorLevel = -203
	GOTO ERRO
END



------------------------------------------------------------------------------
-- Deleto os InventoryMov

DELETE
	IM
FROM
	InventoryMov IM
WHERE
	IM.DocumentID = @IDPurchase
	AND
	IM.InventMovTypeID = 2

IF @@ERROR <> 0
BEGIN
	SET @ErrorLevel = -204
	GOTO ERRO
END


------------------------------------------------------------------------------
-- Deleto os PurchaseItemSerial

DELETE
	PIS
FROM
	Pur_PurchaseItemSerial PIS
WHERE
	PIS.IDPurchase = @IDPurchase

IF @@ERROR <> 0
BEGIN
	SET @ErrorLevel = -205
	GOTO ERRO
END



------------------------------------------------------------------------------
-- Deleto os PurchaseItem

DELETE
	PPI
FROM
	Pur_PurchaseItem PPI
WHERE
	PPI.IDPurchase = @IDPurchase

IF @@ERROR <> 0
BEGIN
	SET @ErrorLevel = -206
	GOTO ERRO
END


------------------------------------------------------------------------------
-- Deleto o Term do Fin 

DELETE
	Fin_LancamentoTerm
WHERE
	IDLancamento IN (SELECT L.IDLancamento FROM Fin_Lancamento L WHERE L.IDPurchase = @IDPurchase)

IF @@ERROR <> 0
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

IF @@ERROR <> 0
BEGIN
	SET @ErrorLevel = -208
	GOTO ERRO
END


------------------------------------------------------------------------------
-- Deleto as contas a pagar

DELETE
	L
FROM
	Fin_Lancamento L
WHERE
	L.IDPurchase = @IDPurchase

IF @@ERROR <> 0
BEGIN
	SET @ErrorLevel = -209
	GOTO ERRO
END


------------------------------------------------------------------------------
-- Deleto os PurchaseTotal

DELETE
	PT
FROM
	Pur_PurchaseTotal PT
WHERE
	PT.IDPurchase = @IDPurchase

IF @@ERROR <> 0
BEGIN
	SET @ErrorLevel = -210
	GOTO ERRO
END


------------------------------------------------------------------------------
-- Deleto os Purchase

DELETE
	P
FROM
	Pur_Purchase P
WHERE
	P.IDPurchase = @IDPurchase

IF @@ERROR <> 0
BEGIN
	SET @ErrorLevel = -211
	GOTO ERRO
END


OK:
	COMMIT TRAN
	RETURN 0
ERRO:
	ROLLBACK TRAN
	PRINT CAST(@ErrorLevel AS VARCHAR)
	RETURN @ErrorLevel
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

