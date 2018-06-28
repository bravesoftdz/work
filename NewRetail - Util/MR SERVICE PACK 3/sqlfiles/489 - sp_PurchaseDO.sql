if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Purchase_Do]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Purchase_Do]
GO

CREATE PROCEDURE sp_Purchase_Do
	(
	@IDPurchase	int,
	@Date 		DateTime,
	@TaxInCost	Bit
	)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO
		
		- Deleto os InventoryMov
		- Incluo no Inventario os barcodes que ainda nao existam
		- Altero o Category no Model quando diferente
		- Atualizo o AvgCost no Model
		- Atualizo o AvgCost no Inventory
		- Incluo o InventoryMov se necessario
		- Se necessario crio os lancamentos no contas a pagar
		- Deleto as Qty do Pur_PurchaseQtyPreSale ##Rodrigo
		- Incluo as Qty do Pur_PurchaseQtyPreSale ##Rodrigo
		- Incluo os serial Numbers no inventory
		- Crio os lancamentos de retorno no contas a pagar, se necessario


	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Deleto as Qty do Pur_PurchaseQtyPreSale
		-202  Erro em Deleto as Qty do Pur_PurchaseQtyOrder
		-203  Erro em Deleto os PreInventoryMov
		-204  Erro em Deleto os InventoryMov
		-205  Erro em Incluo no Inventario os barcodes que ainda nao exitam
		-206  Erro em Atualizo a informa??o de category
		-207  Erro em Atualizar a TBL de Model com os valores se for Final
		-208  Erro em Incluo o InventoryMov se necessario
		-209  Erro em Insiro as Qty do Pur_PurchaseQtyPrePurchase se for PreReceiving para atualizar o qtyOnPreReceive na TBL Inventory
		-210  Erro em Insiro as Qty do Pur_PurchaseQtyOrder - Atualizar as qty no PO
		-211  Erro em Atualiza o total do PO
		-212  Erro em Crio os Serial Numbers no inventory se for final
		-213  Erro em Delete os Serial Numbers do Purchase
		-214  Erro em Deleto o Term do Fin >>> Os termos so serao deletados se o Purchase Type for do tipo Invoice
		-215  Erro em Crio os lancamentos no contas a pagar, se necessario
		-216  Erro em Incluio novamente o Term do Fin >>> Os termos so serao incluidos se o Purchase Type for do typo Invoice
		-217  Erro em Deletetar o InventoryMovTax
		-218  Erro em atualizar o PO
		-219  Erro em Crio os lancamentos de retorno no contas a pagar, se necessario
		-220  Erro em Inserir na ModelVendor
		-221  Erro em Atualizo o AvgCost no Model
		-222  Erro em Atualizo o AvgCost no Inventory

	LOG DE MODIFICA??ES

	Data			Programador		Modifica??o
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	04 dezembro 	2000	Eduardo Costa		Cria??o;
	18 dezembro 	2000	Rodrigo Costa		Complemento;
	06 junho        	2001	Davi Gouveia	Variavel @ErrorLevel/Lista de Return_Values
	07 junho        	2001	Rodrigo Costa	Insert no Fin_LancamentoTerm
	07 dezembro 	2001	Rodrigo Costa		Nao pode deletar p PreInventoryMov, pois os item nao sao salvos la.
	13 May	        	2002	Rodrigo Costa	Criacao Lancamento Termo para os Disbursements 
	29 Oct		2003	Rodrigo Costa		Criado Cuersor para InvMov, Pur_PurchaseQtyPrePurchase, Pur_PurchaseQtyOrder_Cursor;
							Chamado da sp_GetNextCode;
	13 Feb		2004	Rodrigo Costa		Deletar o InventoryMovTax da Compra
	18 Aug		2004	Rodrigo Costa		Gravar error log
	14 Dez		2004	Rodrigo Costa		Cricao do campo @TaxInCost para incluir o preco do item; Retirado o update NewSalePrice
	11 Mar		2005	Carlos Lima		Tratamento das quantidades devolvidas
	11 Mar		2005	Rodrigo Costa		Atualizacao das quantidades no PO
	14 Mar		2005	Carlos Lima		Criação da Devolução no Contas a Pagar
	26 Abr		2005	Rodrigo Costa		Incluir impostos de devolucao caso necessario; Nao alterar categoria dos produtos
	02 Jan		2006	Carlos Lima		Retirada do update do AvgCost em Model e Inventory ( feito agora pela trigger do InventoryMov )
	12 Jan		2006	Carlos Lima		Update do AvgCost em InventoryMov
	22 Jan		2006	Rodrigo Costa		Atualizar o DateLastSellingPrice quando fizer a compra
	25 Jan		2006	Rodrigo Costa		Inserir na tabela de Inv_ModelVendor
	01 Jun		2006	Carlos Lima		O calculo do custo medio volta para a procedure ( espero q seja a ultima vez !!! )
	06 Jun		2006	Carlos Lima		Cursor para excluir o inventorymov e atualizar o custo médio
	19 Jun		2006	Leonardo Riego		Verificação se atualiza DateLastSellingPrice e DateLastCost na tabela de Model.
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

DECLARE @IDPO 			int
DECLARE @ErrorLevel 			int
DECLARE @SysError			int

--Declara??o de vari?veis para o Cursor de InventoryMov
DECLARE @StoreID 			int 
DECLARE @IDPessoa 			int 
DECLARE @InventMovTypeID 		int 
DECLARE @DocumentID 		int 
DECLARE @ModelID 			int 
DECLARE @Qty 			float 
DECLARE @CostPrice 			money 
DECLARE @SalePrice 			money 
DECLARE @BarCodeID 			char(20)
DECLARE @MovDate 			smalldatetime 
DECLARE @IDUser 			int 
DECLARE @IDInventoryMov		int
DECLARE @HasRet				int

--Declara??o de vari?veis para o Cursor de Pur_PurchaseQtyPrePurchase
DECLARE @IDModel 			int 
DECLARE @IDStore 			int 
DECLARE @IDPurchaseQtyPreSale	float

--Declara??o de vari?veis para o Cursor de Pur_PurchaseQtyOrder
DECLARE @IDPOItem 			int 
DECLARE @IDPurchaseQtyOrder	float
DECLARE @AvgCost		float

DECLARE @IDInventory		int

BEGIN TRAN


-----------------------------------------------------------
-- Deleto as Qty do Pur_PurchaseQtyPreSale
DELETE
	PQP
FROM
	Pur_PurchaseQtyPrePurchase PQP
WHERE
	PQP.IDPurchase = @IDPurchase

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END

-----------------------------------------------------------
-- Deleto as Qty do Pur_PurchaseQtyOrder
DELETE
	PQP
FROM
	Pur_PurchaseQtyOrder PQP
WHERE
	PQP.IDPurchase = @IDPurchase

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -202
	GOTO ERRO
END

------------------------------------------------------------------------------
-- Deleto os PreInventoryMov
/*
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
*/

------------------------------------------------------------------------------
-- Deleto os InventoryMovTax

DELETE
	IMT
FROM
	InventoryMovTax IMT
WHERE
	IMT.IDInventoryMov IN (	SELECT IDInventoryMov
			       	FROM InventoryMov IM
				WHERE IM.DocumentID = @IDPurchase AND
				IM.InventMovTypeID = 2
				)

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -217
	GOTO ERRO
END

------------------------------------------------------------------------------
-- Deleto os InventoryMov

DECLARE InventoryMov_Cursor CURSOR FOR

SELECT
	IM.IDInventoryMov
FROM
	InventoryMov IM
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

------------------------------------------------------------------------------
-- Incluo no Inventario os barcodes que ainda nao exitam

INSERT
	BarCode (IDBarCode, IDModel, Data, BarcodeOrder)
SELECT
	PPI.BarCode,
	PPI.IDModel,
	@Date,
	IsNull(Max(BarcodeOrder), 0) + 1
FROM
	Pur_PurchaseItem PPI
	LEFT OUTER JOIN BarCode BC ON (PPI.IDModel = BC.IDModel)
WHERE
	PPI.BarCode IS NOT NULL
	AND
	PPI.IDPurchase = @IDPurchase
GROUP BY
	PPI.BarCode,
	PPI.IDModel

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -205
	GOTO ERRO
END

------------------------------------------------------------------------------
-- Atualizo a informacao de category

UPDATE
	M
SET
	M.GroupID = PPI.IDGroup
FROM
	Model M
	JOIN Pur_PurchaseItem PPI ON (M.IDModel = PPI.IDModel)
WHERE
	M.GroupID <> PPI.IDGroup
	AND
	PPI.IDPurchase = @IDPurchase

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -206
	GOTO ERRO
END


--------------------------------------------------------------------------------------------------
---Atualizar a TBL de Model com os valores se for Final
---Imposto nao esta incluido no Custo do produto
IF (@TaxInCost=1)
BEGIN
	UPDATE
		Model
	SET
		Model.Desativado     	= 0,
		Model.DateLastSellingPrice = CASE IsNull(PUI.NewSalePrice, 0) WHEN 0 THEN Model.DateLastSellingPrice WHEN Model.SellingPrice THEN Model.DateLastSellingPrice ELSE @Date END,
		Model.DateLastCost   	= CASE WHEN (Model.LastCost = Model.VendorCost) THEN Model.DateLastCost ELSE @Date END,
		Model.LastCost       	= IsNull(Model.VendorCost,0),
		Model.VendorCost     	= IsNull(PUI.NewCostPrice,0),
		Model.SellingPrice 	= CASE IsNull(PUI.NewSalePrice,0) WHEN 0 THEN Model.SellingPrice ELSE PUI.NewSalePrice END,
		Model.SuggRetail 	= CASE IsNull(PUI.NewSuggRetail,0) WHEN 0 THEN Model.SuggRetail ELSE PUI.NewSuggRetail END,
		Model.OtherCost		= 0, --OtherCost ja esta incluido no custo
		Model.FreightCost    	= 0 --Freight ja esta incluido no custo
		
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
END
ELSE
BEGIN

	UPDATE
		Model
	SET
		Model.Desativado	= 0,
		Model.DateLastSellingPrice = CASE IsNull(PUI.NewSalePrice, 0) WHEN 0 THEN Model.DateLastSellingPrice WHEN Model.SellingPrice THEN Model.DateLastSellingPrice ELSE @Date END,
		Model.DateLastCost	= CASE WHEN (Model.LastCost = Model.VendorCost) THEN Model.DateLastCost ELSE @Date END,
		Model.SellingPrice 	= IsNull(PUI.NewSalePrice,0),
		Model.SuggRetail 	= IsNull(PUI.NewSuggRetail,0),
		Model.LastCost		= IsNull(Model.VendorCost,0),
		Model.VendorCost	= IsNull(PUI.NewCostPrice,0),
				
		Model.OtherCost 	= ROUND(
					CASE	WHEN 	PUT.SubTotal = 0 THEN 0
						ELSE	( IsNull((PU.OtherCharges / PUT.SubTotal)  * (PUI.NewCostPrice)  , 0 ) )
					END
	
				      	,2),
	
	
		Model.FreightCost 	= ROUND(
					  CASE	WHEN 	PUT.SubTotal = 0 THEN 0
						ELSE	( IsNull(	(PU.Freight / PUT.SubTotal)  * (PUI.NewCostPrice) , 0 ) )
					  END
				      	,2)
			
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

END


SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -207
	GOTO ERRO
END


------------------------------------------------------------------------------
-- Incluo o InventoryMov se necessario
--Declara??o do Cursor de InventoryMov
DECLARE InventoryMov_Cursor CURSOR FOR

SELECT
	PP.IDStore,
	PP.IDFornecedor,
	2, -- Compra
	PP.IDPurchase,
	PPI.IDModel,
	PPI.Qty - IsNull(PPI.QtyRet, 0) AS Qty,
	PPI.NewCostPrice,
	PPI.NewSalePrice,
	PPI.BarCode,
	PP.DateFinalReceiving,
	PP.IDUserFinalReceiving
FROM
	Pur_Purchase PP
	JOIN Pur_PurchaseItem PPI ON (PP.IDPurchase = PPI.IDPurchase)
WHERE
	PP.IDPurchase = @IDPurchase
	AND
	DateFinalReceiving IS NOT NULL



OPEN InventoryMov_Cursor

--Inicializacao de InventoryMov_Cursor
FETCH NEXT FROM InventoryMov_Cursor INTO
	@StoreID,
	@IDPessoa,
	@InventMovTypeID,
	@DocumentID,
	@ModelID,
	@Qty,
	@CostPrice,
	@SalePrice,
	@BarCodeID,
	@MovDate,
	@IDUser
--Enquanto tem registros
WHILE
@@FETCH_STATUS = 0
BEGIN

	-- Atualiza o saldo em valor do Model

	UPDATE
		Model
	SET
		Model.AvgCostTotal = IsNull(Model.AvgCostTotal, 0) + (@CostPrice * @Qty),
		Model.AvgCost = CASE WHEN (IsNull(Model.TotQtyOnHand, 0) + @Qty) = 0 
					THEN 0 
					ELSE (IsNull(Model.AvgCostTotal, 0) + (@CostPrice * @Qty)) / (IsNull(Model.TotQtyOnHand, 0) + @Qty) 
				END
	WHERE
		Model.IDModel = @ModelID

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		CLOSE InventoryMov_Cursor
		DEALLOCATE InventoryMov_Cursor
		SET @ErrorLevel = -221
		GOTO ERRO
	END

	IF NOT EXISTS(SELECT ModelID FROM Inventory WHERE ModelID = @ModelID AND StoreID = @StoreID)
	BEGIN
		EXEC sp_Sis_GetNextCode'Inventory.IDInventory', @IDInventory OUTPUT
	
		INSERT Inventory
			(
			IDInventory,
			StoreID,
			ModelID
			)
		VALUES
			(
			@IDInventory,
			@StoreID,
			@ModelID
			)
	END


	-- Atualiza o saldo em valor do inventory

	SELECT
		@AvgCost = 
			CASE WHEN (IsNull(Inventory.QtyOnHand, 0) + @Qty) = 0 
				THEN 0 
				ELSE (IsNull(Inventory.AvgCostTotal, 0) + (@CostPrice * @Qty)) / (IsNull(Inventory.QtyOnHand, 0) + @Qty) 
			END
	FROM
		Inventory
	WHERE
		Inventory.ModelID = @ModelID
		AND
		Inventory.StoreID = @StoreID



	UPDATE
		Inventory
	SET
		Inventory.AvgCostTotal = IsNull(Inventory.AvgCostTotal, 0) + (@CostPrice * @Qty),
		Inventory.StoreAvgPrice = @AvgCost
	WHERE
		Inventory.ModelID = @ModelID
		AND
		Inventory.StoreID = @StoreID

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		CLOSE InventoryMov_Cursor
		DEALLOCATE InventoryMov_Cursor
		SET @ErrorLevel = -222
		GOTO ERRO
	END
	

	EXEC sp_Sis_GetNextCode 'InventoryMov.IDInventoryMov', @IDInventoryMov OUTPUT

	INSERT InventoryMov
		(
		IDInventoryMov,
		StoreID,
		IDPessoa,
		InventMovTypeID,
		DocumentID,
		ModelID,
		Qty,
		CostPrice,
		SalePrice,
		BarCodeID,
		MovDate,
		IDUser,
		AvgCost
		)
	VALUES
		(
		@IDInventoryMov,
		@StoreID,
		@IDPessoa,
		@InventMovTypeID,
		@DocumentID,
		@ModelID,
		@Qty,
		@CostPrice,
		@SalePrice,
		@BarCodeID,
		@MovDate,
		@IDUser,
		@AvgCost
		)

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		CLOSE InventoryMov_Cursor
		DEALLOCATE InventoryMov_Cursor
		SET @ErrorLevel = -208
		GOTO ERRO
	END
	

	IF NOT EXISTS (SELECT IDModel FROM Inv_ModelVendor WHERE IDModel = @ModelID AND IDPessoa = @IDPessoa)
	BEGIN
		INSERT
			Inv_ModelVendor (IDModel, IDPessoa, VendorOrder)
		SELECT
			@ModelID,
			@IDPessoa,
			IsNull(MAX(IMV.VendorOrder),0) + 1
		FROM
			Inv_ModelVendor IMV
		WHERE
			IMV.IDModel = @ModelID
	END

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		PRINT 'ERROR AQUI'
		CLOSE InventoryMov_Cursor
		DEALLOCATE InventoryMov_Cursor
		SET @ErrorLevel = -220
		GOTO ERRO
	END


	FETCH NEXT FROM InventoryMov_Cursor INTO

		@StoreID,
		@IDPessoa,
		@InventMovTypeID,
		@DocumentID,
		@ModelID,
		@Qty,
		@CostPrice,
		@SalePrice,
		@BarCodeID,
		@MovDate,
		@IDUser
END
--fechamento do cursor
CLOSE InventoryMov_Cursor
--Destrui??o do cursor
DEALLOCATE InventoryMov_Cursor

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -208
	GOTO ERRO
END


-----------------------------------------------------------
-- Insiro as Qty do Pur_PurchaseQtyPrePurchase se for PreReceiving para atualizar o qtyOnPreReceive na TBL Inventory
--Declara??o do Cursor de Pur_PurchaseQtyPrePurchase
DECLARE Pur_PurchaseQtyPrePurchase_Cursor CURSOR FOR


SELECT
	PUI.IDModel,
	PU.IDStore,
	SUM(PUI.Qty - IsNull(PUI.QtyRet, 0))
FROM
	Pur_Purchase PU
	JOIN Pur_PurchaseItem PUI ON (PU.IDPurchase = PUI.IDPurchase)
WHERE
	PU.IDPurchase = @IDPurchase
	AND
	PU.DateFinalReceiving IS NULL
GROUP BY
	PUI.IDModel,
	PU.IDStore,
	PUI.IDPOItem


OPEN Pur_PurchaseQtyPrePurchase_Cursor

--Inicializa??o de Pur_PurchaseQtyPrePurchase_Cursor
FETCH NEXT FROM Pur_PurchaseQtyPrePurchase_Cursor INTO
	@IDModel,
	@IDStore,
	@Qty
--Enquanto tem registros
WHILE
@@FETCH_STATUS = 0
BEGIN
	EXEC sp_Sis_GetNextCode'Pur_PurchaseQtyPrePurchase.IDPurchaseQtyPreSale', @IDPurchaseQtyPreSale OUTPUT
	INSERT Pur_PurchaseQtyPrePurchase
		(
		IDPurchaseQtyPreSale,
		IDPurchase,
		IDModel,
		IDStore,
		Qty
		)
	VALUES
		(
		@IDPurchaseQtyPreSale,
		@IDPurchase,
		@IDModel,
		@IDStore,
		@Qty
		)

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		CLOSE Pur_PurchaseQtyPrePurchase_Cursor
		DEALLOCATE Pur_PurchaseQtyPrePurchase_Cursor
		SET @ErrorLevel = -209
		GOTO ERRO
	END

	FETCH NEXT FROM Pur_PurchaseQtyPrePurchase_Cursor INTO
		@IDModel,
		@IDStore,
		@Qty
END
--fechamento do cursor
CLOSE Pur_PurchaseQtyPrePurchase_Cursor
--Destrui??o do cursor
DEALLOCATE Pur_PurchaseQtyPrePurchase_Cursor


SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -209
	GOTO ERRO
END


-----------------------------------------------------------
-- Insiro as Qty do Pur_PurchaseQtyOrder - Atualizar as qty no PO
--Declara??o do Cursor de Pur_PurchaseQtyOrder

DECLARE Pur_PurchaseQtyOrder_Cursor CURSOR FOR

SELECT
	PUI.IDModel,
	PU.IDStore,
	PUI.IDPOItem,
	SUM(PUI.Qty - IsNull(PUI.QtyRet, 0))
FROM
	Pur_Purchase PU
	JOIN Pur_PurchaseItem PUI ON (PU.IDPurchase = PUI.IDPurchase)
WHERE
	PU.IDPurchase = @IDPurchase
GROUP BY
	PUI.IDModel,
	PU.IDStore,
	PUI.IDPOItem

OPEN Pur_PurchaseQtyOrder_Cursor

--Inicializa??o de Pur_PurchaseQtyOrder_Cursor
FETCH NEXT FROM Pur_PurchaseQtyOrder_Cursor INTO
	@IDModel,
	@IDStore,
	@IDPOItem,
	@Qty
--Enquanto tem registros
WHILE
@@FETCH_STATUS = 0
BEGIN
	EXEC sp_Sis_GetNextCode'Pur_PurchaseQtyOrder.IDPurchaseQtyOrder', @IDPurchaseQtyOrder OUTPUT
	INSERT Pur_PurchaseQtyOrder
		(
		IDPurchaseQtyOrder,
		IDPurchase,
		IDModel,
		IDStore,
		IDPOItem,
		Qty
		)
	VALUES
		(
		@IDPurchaseQtyOrder,
		@IDPurchase,
		@IDModel,
		@IDStore,
		@IDPOItem,
		@Qty
		)

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		CLOSE Pur_PurchaseQtyOrder_Cursor
		DEALLOCATE Pur_PurchaseQtyOrder_Cursor
		SET @ErrorLevel = -210
		GOTO ERRO
	END

	FETCH NEXT FROM Pur_PurchaseQtyOrder_Cursor INTO
		@IDModel,
		@IDStore,
		@IDPOItem,
		@Qty
END
--fechamento do cursor
CLOSE Pur_PurchaseQtyOrder_Cursor
--Destrui??o do cursor
DEALLOCATE Pur_PurchaseQtyOrder_Cursor


SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -210
	GOTO ERRO
END

------------------------------------------------------------------------------
-- Atualiza o total do PO

SELECT
	@IDPO = PIM.DocumentID
FROM
	PreInventoryMov PIM
	JOIN Pur_PurchaseQtyOrder PQO ON (PIM.IDPreInventoryMov = PQO.IDPOItem)

EXEC sp_PO_AtuPOTotal @IDPO

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -211
	GOTO ERRO
END

------------------------------------------------------------------------------
-- Atualizo os totais da PO, se necessario
SELECT
	@IDPO = P.IDPO
FROM
	Pur_Purchase P
WHERE
	IDPurchase = @IDPurchase

EXEC sp_PO_CalcTotalQty @IDPO

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -218
	GOTO ERRO
END


------------------------------------------------------------------------------
-- Crio os Serial Numbers no inventory se for final
INSERT
	InventorySerial
	(
	StoreID,
	ModelID,
	Serial
	)
SELECT
	PU.IDStore,
	PUI.IDModel,
	PIS.SerialNumber
FROM
	Pur_Purchase PU
	JOIN Pur_PurchaseItemSerial PIS ON (PU.IDPurchase = PIS.IDPurchase)
	JOIN Pur_PurchaseItem PUI ON (PU.IDPurchase = PUI.IDPurchase)
WHERE
	PIS.IDPurchase = @IDPurchase
	AND
	PU.DateFinalReceiving IS NOT NULL

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -212
	GOTO ERRO
END


------------------------------------------------------------------------------
-- Delete os Serail Numbers do Purchase
DELETE
	PIS
FROM
	Pur_PurchaseItemSerial PIS
	JOIN Pur_Purchase PU ON (PU.IDPurchase = PIS.IDPurchase)
WHERE
	PIS.IDPurchase = @IDPurchase
	AND
	PU.DateFinalReceiving IS NOT NULL

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -213
	GOTO ERRO
END


------------------------------------------------------------------------------
-- Deleto o Term do Fin >>> Os termos so serao deletados se o Purchase Type for do typo Invoice


DELETE
	Fin_LancamentoTerm
WHERE
	IDLancamento IN (SELECT L.IDLancamento FROM Fin_Lancamento L WHERE L.IDPurchase = @IDPurchase)

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -214
	GOTO ERRO
END


------------------------------------------------------------------------------
-- Crio os lancamentos no contas a pagar, se necessario
IF (@TaxInCost=1)
	EXEC sp_Purchase_CriaPagamentoComImposto @IDPurchase
ELSE
	EXEC sp_Purchase_CriaPagamento @IDPurchase


SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -215
	GOTO ERRO
END


------------------------------------------------------------------------------
-- Crio os lancamentos de retorno no contas a pagar, se necessario

SELECT
	@HasRet = SUM(ABS(IsNull(PPI.QtyRet, 0)))
FROM
	Pur_Purchase PP
	JOIN Pur_PurchaseItem PPI ON (PP.IDPurchase = PPI.IDPurchase)
WHERE
	PP.IDPurchase = @IDPurchase
	AND
	DateFinalReceiving IS NOT NULL

IF ((@TaxInCost=1) AND (@HasRet>0))
	EXEC sp_Purchase_CriaPagamentoComImpostoRet @IDPurchase

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -219
	GOTO ERRO
END

------------------------------------------------------------------------------
-- Incluio novamente o Term do Fin >>> Os termos so serao incluidos se o Purchase Type for do typo Invoice

INSERT
	Fin_LancamentoTerm (IDLancamento, DueDateShift, Discount)
SELECT
	L.IDLancamento, PT.DueDateShift, PT.Discount
FROM
	Pur_PurchaseTerm PT
	JOIN Fin_Lancamento L ON (L.IDPurchase = PT.IDPurchase)
WHERE
	L.IDPurchase = @IDPurchase

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -216
	GOTO ERRO
END


OK:
	COMMIT TRAN
	RETURN 0

ERRO:
	ROLLBACK TRAN

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_Purchase_Do', @ErrorLevelStr

	RETURN @ErrorLevel
GO
