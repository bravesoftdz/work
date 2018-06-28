if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Purchase_Remove]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Purchase_Remove]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Purchase_RemoveItem]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Purchase_RemoveItem]
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
		- Deletar a TBL Pur_PurchaseItemTax
		- Deletar Pur_PurchaseItemTaxRet
		- Atualizar o fechamento do PO
		- Atualizar os valores do PO

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
		-212  Erro em Deletar Pur_PurchaseItemTax
		-213  Erro em Deletar Pur_PurchaseItemTaxRet
		-214  Erro em Atualizar o fechamento do PO
		-215  Erro em Atualizar os valores do PO
		-216  Erro em Atualizar o Custo Medio
		

	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	04 dezembro 2000	Eduardo Costa		Criação;
	18 dez 200		Rodrigo Costa		Atualizacao;
	08 junho 2001		Rodrigo Costa		Deletar o Term do Fin_Lancamento & Purchase;
	26 June 2001		Davi Gouveia		Log de Return Values
	18 Aug 2004		Rodrigo Costa		Gravar error log
	14 Dez 2004		Rodrigo Costa		Deletar os Pur_PurchaseItemTax
	11 Mar 2005		Carlos Lima		Deletar os Pur_PurchaseItemTaxRet
	11 Mar 2005		Rodrigo Costa		Alteracao do PO
	01 Dec 2005		Carlos Lima		Atualizar Totais e Condição de fechamento do PO
	09 Dec	2005		Rodrigo Costa		Atualizar o Custo Medio
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

DECLARE @ErrorLevel	int
DECLARE @SysError	int
DECLARE @IDPO	int

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
-- Atualizao o Custo Medio

UPDATE
	Model
SET
	VendorCost 		= LastCost,
	Model.AvgCost  		= ROUND(IsNull(	(

					SELECT 	(
							CASE WHEN	SUM(IsNull(Inv.QtyOnHand,0)) - (PUI.Qty - IsNull(PUI.QtyRet, 0)) <= 0 THEN 0
							ELSE		(
										(
										( IsNull(Model.AvgCost,0) * SUM(IsNull(Inv.QtyOnHand,0))) -
										(PUI.NewCostPrice * (PUI.Qty - IsNull(PUI.QtyRet, 0)))
										)
										/
					       			               	(
										SUM(IsNull(Inv.QtyOnHand,0)) - (PUI.Qty - IsNull(PUI.QtyRet, 0))
										)
									)
							END
						)

					FROM	
						Inventory Inv
						JOIN Model ON (Inv.ModelId = Model.IDModel)
					WHERE
						Inv.ModelID = PUI.IDModel
					GROUP BY  
						Model.AvgCost 

					), Model.FinalCost ),2)
FROM
	Pur_Purchase PU
	JOIN Pur_PurchaseItem PUI ON (PU.IDPurchase = PUI.IDPurchase)
	JOIN Pur_PurchaseTotal PUT ON (PU.IDPurchase = PUT.IDPurchase)
WHERE
	PU.IDPurchase = @IDPurchase
	AND
	DateFinalReceiving IS NOT NULL
	AND
	Model.IDModel = PUI.IDModel


SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -216
	GOTO ERRO
END

---------------------------------------------------------------------------- ##Rodrigo
-- Deleto qtyOnPrePurchase do Inventory
DELETE
	PUQ
FROM
	Pur_PurchaseQtyPrePurchase PUQ
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
	Pur_PurchaseQtyOrder PUQ
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
	PreInventoryMov PIM
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


------------------------------------------------------------------------------
-- Deleto os PurchaseItemSerial

DELETE
	PIS
FROM
	Pur_PurchaseItemSerial PIS
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
	Pur_PurchaseItemtax PIT
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
	Pur_PurchaseItemtaxRet PIT
WHERE
	PIT.IDPurchase = @IDPurchase

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -212
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

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -206
	GOTO ERRO
END


------------------------------------------------------------------------------
-- Deleto o Term do Fin 

DELETE
	Fin_LancamentoTerm
WHERE	IDLancamento IN (SELECT L.IDLancamento FROM Fin_Lancamento L WHERE L.IDPurchase = @IDPurchase)

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
	Fin_Lancamento L
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
	Pur_PurchaseTotal PT
WHERE
	PT.IDPurchase = @IDPurchase

SET @SysError = @@ERROR
IF @SysError <> 0
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

CREATE PROCEDURE sp_Purchase_RemoveItem
		(
 		@IDPurchase	 	 int,
		@IDPurchaseItem	 int,
		@TaxInCost		 bit
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
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

DECLARE @ErrorLevel	int
DECLARE @SysError	int
DECLARE @IDPO	int

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
-- Atualizao o Custo Medio

UPDATE
	Model
SET
	VendorCost 		= LastCost,
	Model.AvgCost  		= ROUND(IsNull(	(

					SELECT 	(
							CASE WHEN	SUM(IsNull(Inv.QtyOnHand,0)) - (PUI.Qty - IsNull(PUI.QtyRet, 0)) <= 0 THEN 0
							ELSE		(
										(
										( IsNull(Model.AvgCost,0) * SUM(IsNull(Inv.QtyOnHand,0))) -
										(PUI.NewCostPrice * (PUI.Qty - IsNull(PUI.QtyRet, 0)))
										)
										/
					       			               	(
										SUM(IsNull(Inv.QtyOnHand,0)) - (PUI.Qty - IsNull(PUI.QtyRet, 0))
										)
									)
							END
						)

					FROM	
						Inventory Inv
						JOIN Model ON (Inv.ModelId = Model.IDModel)
					WHERE
						Inv.ModelID = PUI.IDModel
					GROUP BY  
						Model.AvgCost 

					), Model.FinalCost ),2)
FROM
	Pur_Purchase PU
	JOIN Pur_PurchaseItem PUI ON (PU.IDPurchase = PUI.IDPurchase)
	JOIN Pur_PurchaseTotal PUT ON (PU.IDPurchase = PUT.IDPurchase)
WHERE
	PUI.IDPurchaseItem = @IDPurchaseItem
	AND
	DateFinalReceiving IS NOT NULL
	AND
	Model.IDModel = PUI.IDModel


SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -211
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
