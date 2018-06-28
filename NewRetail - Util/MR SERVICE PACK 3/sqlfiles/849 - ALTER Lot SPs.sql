if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Inventory_Lot_Adjust]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Inventory_Lot_Adjust]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Purchase_Do]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Purchase_Do]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Purchase_Remove]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Purchase_Remove]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Purchase_RemoveItem]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Purchase_RemoveItem]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Inventory_Tranfer_IN]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Inventory_Tranfer_IN]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Inventory_Tranfer_OUT]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Inventory_Tranfer_OUT]
GO

CREATE PROCEDURE sp_Inventory_Lot_Adjust
	(
	@IDModel	int,
	@IDStore	int,
	@IDLot		int,
	@Qty		decimal(38, 4),
	@Type		int
	)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		@Type = 1 (Novo), 2 (Adicionar), 3 (Subtrair)
		- Movimentar quantidade de  lote

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em criar ModelStoreLot
		-202  Erro em atualizar ModelStoreLot
	
	LOG DE MODIFICACOES

	Data			Programador		Modifica??o
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	31 Mar		2009	Rodrigo Costa	Criacao
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

DECLARE @IDPO 			int
DECLARE @ErrorLevel 		int
DECLARE @SysError		int
DECLARE @QtyLot			decimal(38, 4)

IF NOT EXISTS(SELECT Qty FROM Inv_StoreModelLot WHERE IDModel = @IDModel AND IDStore = @IDStore AND IDLote = @IDLot)
BEGIN
	INSERT Inv_StoreModelLot (IDModel, IDStore, IDLote, Qty)
	VALUES (@IDModel, @IDStore, @IDLot, 0)
END

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END

SELECT 
	@QtyLot = Qty 
FROM
	Inv_StoreModelLot
WHERE 
	IDModel = @IDModel 
	AND 
	IDStore = @IDStore 
	AND 
	IDLote = @IDLot

--Type
IF @Type = 2
	SET @Qty = @QtyLot + @Qty
IF @Type = 3
	SET @Qty = @QtyLot - @Qty

UPDATE Inv_StoreModelLot
SET Qty = @Qty
WHERE IDModel = @IDModel AND IDStore = @IDStore AND IDLote = @IDLot

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -202
	GOTO ERRO
END

OK:
	RETURN 0

ERRO:
	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_Inventory_Lot_Adjust', @ErrorLevelStr

	RETURN @ErrorLevel

GO

CREATE   PROCEDURE sp_Purchase_Do
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
		- Movimentar quantidade de  lote

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
		-223  Erro em Inserir Case Barcode
		-224  Erro em movimentar quantidade Lote
	
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
	07 Jul		2006	Rodrigo Costa		Adicionado o Trim no CodBarra do item da compra
	07 Fev		2006	Rodrigo Costa		Inserir Case Barcode
	24 Oct		2008	Rodrigo Costa		Atualizar preco de custo do fornecedor em Inv_ModelVendor
	31 Mar		2009	Rodrigo Costa		Movimentar quantidade de lote
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

DECLARE @IDPO 			int
DECLARE @ErrorLevel 			int
DECLARE @SysError			int

--Declaracao de variaveis para o Cursor de InventoryMov
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
DECLARE @IDLot				int

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
	Pur_PurchaseQtyPrePurchase PQP (NOLOCK) 
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
	Pur_PurchaseQtyOrder PQP (NOLOCK) 
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
	InventoryMovTax IMT (NOLOCK) 
WHERE
	IMT.IDInventoryMov IN (	SELECT IDInventoryMov
			       	FROM InventoryMov IM (NOLOCK) 
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
	Pur_PurchaseItem PPI (NOLOCK) 
	LEFT OUTER JOIN BarCode BC (NOLOCK) ON (PPI.IDModel = BC.IDModel)
WHERE
	(PPI.BarCode IS NOT NULL AND (RTRIM(LTRIM(PPI.BarCode)) <> ''))
	AND PPI.IDPurchase = @IDPurchase
	AND NOT EXISTS (SELECT * FROM Barcode (NOLOCK) WHERE IDBarcode = PPI.BarCode)
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
-- Incluo no Inventario o barcode de embalagem

INSERT
	BarCode (IDBarCode, IDModel, Data, BarcodeOrder, Qty)
SELECT
	PPI.BarcodeCase,
	PPI.IDModel,
	@Date,
	IsNull(Max(BarcodeOrder), 0) + 1,
	(PPI.Qty / IsNull(PPI.CaseQty,1))
FROM
	Pur_PurchaseItem PPI (NOLOCK) 
	LEFT OUTER JOIN Barcode BC (NOLOCK) ON (PPI.IDModel = BC.IDModel)
WHERE
	(PPI.BarcodeCase IS NOT NULL AND (RTRIM(LTRIM(PPI.BarcodeCase)) <> ''))
	AND PPI.IDPurchase = @IDPurchase
	AND NOT EXISTS (SELECT * FROM Barcode (NOLOCK) WHERE IDBarcode = PPI.BarcodeCase)
	AND IsNull(PPI.CaseQty,0) >= 1
GROUP BY
	PPI.BarcodeCase,
	PPI.IDModel,
	PPI.CaseQty,
	PPI.Qty

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -223
	GOTO ERRO
END
------------------------------------------------------------------------------
-- Atualizo a informacao de category

UPDATE
	M
SET
	M.GroupID = PPI.IDGroup
FROM
	Model M (NOLOCK) 
	JOIN Pur_PurchaseItem PPI (NOLOCK) ON (M.IDModel = PPI.IDModel)
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
		Model.DateLastSellingPrice = CASE PUI.IsPromo WHEN 0 THEN (CASE IsNull(PUI.NewSalePrice, 0) WHEN 0 THEN Model.DateLastSellingPrice WHEN Model.SellingPrice THEN Model.DateLastSellingPrice ELSE @Date END) ELSE Model.DateLastSellingPrice END,
		Model.DateLastCost   	= CASE PUI.IsPromo WHEN 0 THEN (CASE WHEN (Model.LastCost = Model.VendorCost) THEN Model.DateLastCost ELSE @Date END) ELSE Model.DateLastCost END ,
		Model.LastCost       	= CASE PUI.IsPromo WHEN 0 THEN IsNull(Model.VendorCost,0) ELSE Model.LastCost END,
		Model.VendorCost     	= CASE PUI.IsPromo WHEN 0 THEN IsNull(PUI.NewCostPrice,0) ELSE Model.VendorCost END,
		Model.SellingPrice 	= CASE PUI.IsPromo WHEN 0 THEN (CASE IsNull(PUI.NewSalePrice,0) WHEN 0 THEN Model.SellingPrice ELSE PUI.NewSalePrice END) ELSE Model.SellingPrice END,
		Model.SuggRetail 	= CASE PUI.IsPromo WHEN 0 THEN (CASE IsNull(PUI.NewSuggRetail,0) WHEN 0 THEN Model.SuggRetail ELSE PUI.NewSuggRetail END) ELSE Model.SuggRetail END,
		Model.OtherCost		= 0, --OtherCost ja esta incluido no custo
		Model.FreightCost    	= 0 --Freight ja esta incluido no custo
		
	FROM
		Pur_Purchase PU (NOLOCK) 
		JOIN Pur_PurchaseItem PUI (NOLOCK) ON (PU.IDPurchase = PUI.IDPurchase)
		JOIN Pur_PurchaseTotal PUT (NOLOCK) ON (PU.IDPurchase = PUT.IDPurchase)
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
		Model.DateLastSellingPrice = CASE PUI.IsPromo WHEN 0 THEN (CASE IsNull(PUI.NewSalePrice, 0) WHEN 0 THEN Model.DateLastSellingPrice WHEN Model.SellingPrice THEN Model.DateLastSellingPrice ELSE @Date END) ELSE Model.DateLastSellingPrice END,
		Model.DateLastCost	= CASE PUI.IsPromo WHEN 0 THEN (CASE WHEN (Model.LastCost = Model.VendorCost) THEN Model.DateLastCost ELSE @Date END) ELSE Model.DateLastCost END,
		Model.SellingPrice 	= CASE PUI.IsPromo WHEN 0 THEN IsNull(PUI.NewSalePrice,0) ELSE Model.SellingPrice END,
		Model.SuggRetail 	= CASE PUI.IsPromo WHEN 0 THEN IsNull(PUI.NewSuggRetail,0)ELSE Model.SuggRetail END,
		Model.LastCost		= CASE PUI.IsPromo WHEN 0 THEN IsNull(Model.VendorCost,0) ELSE Model.LastCost END,
		Model.VendorCost	= CASE PUI.IsPromo WHEN 0 THEN IsNull(PUI.NewCostPrice,0) ELSE Model.VendorCost END,
				
		Model.OtherCost 	= CASE PUI.IsPromo WHEN 0 THEN ( ROUND(
										CASE	WHEN 	PUT.SubTotal = 0 THEN 0
											ELSE	( IsNull((PU.OtherCharges / PUT.SubTotal)  * (PUI.NewCostPrice)  , 0 ) )
										END
	
				      					,2)) ELSE Model.OtherCost END,
	
	
		Model.FreightCost 	= CASE PUI.IsPromo WHEN 0 THEN ( ROUND(
					 					 CASE	WHEN 	PUT.SubTotal = 0 THEN 0
											ELSE	( IsNull(	(PU.Freight / PUT.SubTotal)  * (PUI.NewCostPrice) , 0 ) )
					 					 END
				      					,2)) ELSE Model.FreightCost END
			
	FROM
		Pur_Purchase PU (NOLOCK) 
		JOIN Pur_PurchaseItem PUI (NOLOCK) ON (PU.IDPurchase = PUI.IDPurchase)
		JOIN Pur_PurchaseTotal PUT (NOLOCK) ON (PU.IDPurchase = PUT.IDPurchase)
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
	PP.IDUserFinalReceiving,
	IsNull(PPI.IDLote, 0) as IDLote
FROM
	Pur_Purchase PP (NOLOCK) 
	JOIN Pur_PurchaseItem PPI (NOLOCK) ON (PP.IDPurchase = PPI.IDPurchase)
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
	@IDUser,
	@IDLot
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
	
	--Atualizo o Lote
	IF @IDLot <> 0
		EXEC sp_Inventory_Lot_Adjust @ModelID, @StoreID, @IDLot, @Qty, 1

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
			Inv_ModelVendor (IDModel, IDPessoa, VendorOrder, VendorCost, CostLastChange)
		SELECT
			@ModelID,
			@IDPessoa,
			IsNull(MAX(IMV.VendorOrder),0) + 1,
			@CostPrice,
			GetDate()
		FROM
			Inv_ModelVendor IMV (NOLOCK) 
		WHERE
			IMV.IDModel = @ModelID
	END
	ELSE
	BEGIN

		UPDATE 
			MV
		SET
			VendorCost = @CostPrice,
			CostLastChange = @MovDate
		FROM 
			Inv_ModelVendor MV
		WHERE 
			IDModel = @ModelID 
			AND 
			IDPessoa = @IDPessoa
			AND
			IsNull(CostLastChange, 0) < @MovDate
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
		@IDUser,
		@IDLot
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
	Pur_Purchase PU (NOLOCK) 
	JOIN Pur_PurchaseItem PUI (NOLOCK) ON (PU.IDPurchase = PUI.IDPurchase)
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
	Pur_Purchase PU (NOLOCK) 
	JOIN Pur_PurchaseItem PUI (NOLOCK) ON (PU.IDPurchase = PUI.IDPurchase)
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
	PreInventoryMov PIM (NOLOCK) 
	JOIN Pur_PurchaseQtyOrder PQO (NOLOCK) ON (PIM.IDPreInventoryMov = PQO.IDPOItem)
WHERE
	PQO.IDPurchase = @IDPurchase	

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
	Pur_Purchase P (NOLOCK) 
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
	Pur_Purchase PU (NOLOCK) 
	JOIN Pur_PurchaseItemSerial PIS (NOLOCK) ON (PU.IDPurchase = PIS.IDPurchase)
	JOIN Pur_PurchaseItem PUI (NOLOCK) ON (PU.IDPurchase = PUI.IDPurchase)
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
	Pur_PurchaseItemSerial PIS (NOLOCK) 
	JOIN Pur_Purchase PU (NOLOCK) ON (PU.IDPurchase = PIS.IDPurchase)
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
	Pur_Purchase PP (NOLOCK) 
	JOIN Pur_PurchaseItem PPI (NOLOCK) ON (PP.IDPurchase = PPI.IDPurchase)
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
	Pur_PurchaseTerm PT (NOLOCK) 
	JOIN Fin_Lancamento L (NOLOCK) ON (L.IDPurchase = PT.IDPurchase)
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

CREATE  PROCEDURE sp_Purchase_Remove
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

CREATE  PROCEDURE sp_Purchase_RemoveItem
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
		- Movimentar quantidade de lote

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
		-213 Erro ao remover quantidade de Lote

	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	04 Dec	2000		Eduardo Costa		Criação;
	18 Dec	2000		Rodrigo Costa		Atualizacao;
	26 Jun	2001		Davi Gouveia		Log de Return Values
	18 Aug	2004		Rodrigo Costa		Gravar error log
	14 Dec	2004		Rodrigo Costa		Deletar os Pur_PurchaseItemTax
	11 Mar	2005		Carlos Lima		Deletar os Pur_PurchaseItemTaxRet
	01 Dec	2005		Carlos Lima		Verificar a Condição de fechamento do PO e atualizar
	07 Dec	2005		Rodrigo Costa		Atualizar o AvgCost no Model
	11 Jan	2006		Rodrigo Costa		Remover o Custo Medio
	20 Jul	2006		Leonardo Riego		Caso Purchase nao possua mais itens do PO desvincular o Purchase do PO.
	31 Mar	2009		Rodrigo Costa		Movimentar quantidade de lote
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
-- Deleto AsQty o item no Pur_PurchaseQtyPrePurchase

DELETE
	PUQ
FROM
	Pur_PurchaseQtyPrePurchase PUQ (NOLOCK) 
WHERE
	PUQ.IDModel = (
			SELECT
				PUI.IDModel
			FROM
				Pur_PurchaseItem PUI (NOLOCK) 
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
	Pur_PurchaseQtyOrder PUQ (NOLOCK) 
WHERE
	PUQ.IDModel = (
			SELECT
				PUI.IDModel
			FROM
				Pur_PurchaseItem PUI (NOLOCK) 
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
	Pur_PurchaseItemSerial PIS (NOLOCK) 
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
	Pur_PurchaseItemTax PIT (NOLOCK) 
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
	Pur_PurchaseItemTaxRet PIT (NOLOCK) 
WHERE
	PIT.IDPurchaseItem = @IDPurchaseItem

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -207
	GOTO ERRO
END


------------------------------------------------------------------------------
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
	PPI.IDPurchaseItem = @IDPurchaseItem
	AND
	PPI.IDLote IS NOT NULL

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -213
	GOTO ERRO
END

------------------------------------------------------------------------------
-- Deleto o PurchaseItem
DELETE
	PPI
FROM
	Pur_PurchaseItem PPI (NOLOCK) 
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
		Pur_Purchase PP (NOLOCK) 
		JOIN PreInventoryMov PIM (NOLOCK) ON(PIM.DocumentID = PP.IDPO)
		JOIN Pur_PurchaseItem PPI (NOLOCK) ON (PPI.IDPOItem = PIM.IDPreInventoryMov AND PPI.IDPurchase = PP.IDPurchase)
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

CREATE  PROCEDURE sp_Inventory_Tranfer_IN
	(
	@IDModelTransf	int
	)
 AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Delecao do InventoryMov
		- Atualizo o model
		- Atualizo o custo médio no Model
		- Insiro InventoryMov
		- Atualizo o custo médio no Inventory

	TABELA DE ERROS PARA RETURN_VALUE

	 000  Ok
	-201  Erro em Delecao do InventoryMov
	-202  Erro em Inserir Model
	-203  Erro em Atualizo o custo médio no Model
	-204  Erro em Insiro InventoryMov
	-205  Erro em Atualizo o custo médio no Inventory

	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------------------------------------------------------------------------------------------------------------
	16 Jul 2005		Rodrigo Costa		Criação;
	05 Jun 2006		Carlos Lima		Adicionado Custo médio na inserção de InventoryMov
	16 Jun 2006		Carlos Lima		Atualização do custo médio
        22 Jan 2007             Maic Nogueira           Adicionado Kit na transferência de itens.
	01 Abr 2009		Rodrigo Costa		Atualizar Lote
        ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

DECLARE @ErrorLevel		int
DECLARE @SysError		int

--Declaração de variáveis para o Cursor de InventoryMov
DECLARE @DocumentID		int
DECLARE @ModelID		int
DECLARE @Qty			float
DECLARE @TransfDate		datetime
DECLARE @CostPrice		money
DECLARE @IDUser 		int 
DECLARE @PreInventoryMovID 	int 
DECLARE @IDInventoryMov    	int
DECLARE @StoreIDOrigem 	int 
DECLARE @StoreIDDestino 	int 
DECLARE @AvgCost 		money 
DECLARE @AvgCostCalc		money
DECLARE @IDInventory		int
DECLARE @IDLote			int

BEGIN TRAN


/*--------------------------------------------------------------*/
/*		Parte da Delecao do InventoryMov        	*/
/*--------------------------------------------------------------*/

DECLARE InventoryMov_Cursor CURSOR FOR

SELECT
	IDInventoryMov
FROM
	InventoryMov (NOLOCK) 
WHERE	
	InventoryMov.InventMovTypeID = 8
	AND
	InventoryMov.DocumentID = @IDModelTransf



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
		SET @ErrorLevel = -201
		GOTO ERRO
	END

	FETCH NEXT FROM InventoryMov_Cursor INTO
		@IDInventoryMov
END

CLOSE InventoryMov_Cursor
DEALLOCATE InventoryMov_Cursor
--

/*--------------------------------------------------------------*/
/*		Parte da Insercao do InventoryMov        	*/
/*--------------------------------------------------------------*/

--Declaração do Cursor de InventoryMov
DECLARE TransferIN_Cursor CURSOR FOR
	SELECT
		MTD.IDModelTransf,
		MT.IDLojaOrigem,
		MT.IDLojaDestino,
		MTD.IDModel,
		MTD.Qty,
		MT.Data,
		MT.IDUser,
		MTD.IDModelTransfDet, /* guarda a linha correspondente a inserida */
		MTD.CostPrice,
		MTD.AvgCost,
		IsNull(MTD.IDLote, 0) as IDLote
	FROM
		ModelTransfDet MTD (NOLOCK) 
		INNER JOIN ModelTransf MT (NOLOCK) ON (MTD.IDModelTransf = MT.IDModelTransf)		
	WHERE
		MT.IDModelTransf = @IDModelTransf

OPEN TransferIN_Cursor

--Inicialização de TransferIN_Cursor
FETCH NEXT FROM TransferIN_Cursor INTO
	@DocumentID,
	@StoreIDOrigem,
	@StoreIDDestino,
	@ModelID,
	@Qty,
	@TransfDate,
	@IDUser,
	@PreInventoryMovID,
	@CostPrice,
	@AvgCost,
	@IDLote

--Enquanto tem registros
WHILE
@@FETCH_STATUS = 0
BEGIN

	--Atualizo o Lote
	IF @IDLote <> 0
		EXEC sp_Inventory_Lot_Adjust @ModelID, @StoreIDDestino, @IDLote, @Qty, 3


	--Inclusao da loja original
	UPDATE
		Model
	SET
		Model.AvgCostTotal = IsNull(Model.AvgCostTotal, 0) + (@AvgCost * @Qty),
		Model.AvgCost = CASE WHEN (IsNull(Model.TotQtyOnHand, 0) + @Qty) = 0 
					THEN 0 
					ELSE (IsNull(Model.AvgCostTotal, 0) + (@AvgCost * @Qty)) / (IsNull(Model.TotQtyOnHand, 0) + @Qty) 
				END
	WHERE
		Model.IDModel = @ModelID

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		CLOSE TransferIN_Cursor
		DEALLOCATE TransferIN_Cursor
		SET @ErrorLevel = -203
		GOTO ERRO
	END

	IF NOT EXISTS(SELECT ModelID FROM Inventory (NOLOCK) WHERE ModelID = @ModelID AND StoreID = @StoreIDDestino)
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
			@StoreIDDestino,
			@ModelID
			)

		SET @SysError = @@ERROR
		IF @SysError <> 0
		BEGIN
			CLOSE TransferIN_Cursor
			DEALLOCATE TransferIN_Cursor
			SET @ErrorLevel = -204
			GOTO ERRO
		END
	END

	-- Atualiza o saldo em valor do inventory

	SELECT
		@AvgCostCalc = 
			CASE WHEN (IsNull(Inventory.QtyOnHand, 0) + @Qty) = 0 
				THEN 0 
				ELSE (IsNull(Inventory.AvgCostTotal, 0) + (@AvgCost * @Qty)) / (IsNull(Inventory.QtyOnHand, 0) + @Qty) 
			END
	FROM
		Inventory (NOLOCK) 
	WHERE
		Inventory.ModelID = @ModelID
		AND
		Inventory.StoreID = @StoreIDDestino


	UPDATE
		Inventory
	SET
		Inventory.AvgCostTotal = IsNull(Inventory.AvgCostTotal, 0) + (@AvgCost * @Qty),
		Inventory.StoreAvgPrice = @AvgCost
	WHERE
		Inventory.ModelID = @ModelID
		AND
		Inventory.StoreID = @StoreIDDestino


	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		CLOSE TransferIN_Cursor
		DEALLOCATE TransferIN_Cursor
		SET @ErrorLevel = -205
		GOTO ERRO
	END

	EXEC sp_Sis_GetNextCode'InventoryMov.IDInventoryMov', @IDInventoryMov OUTPUT

	INSERT InventoryMov
		(
		IDInventoryMov,
		InventMovTypeID,
		DocumentID,
		StoreID,
		ModelID,
		IDPessoa,
		MovDate,
		Qty,
		IDUser,
		PreInventoryMovID,
		CostPrice,
		AvgCost 
		)
	VALUES
		(
		@IDInventoryMov,
		8,   /* entrada da loja destino */
		@DocumentID,
		@StoreIDDestino,
		@ModelID,
		0,
		@TransfDate,
		@Qty,
		@IDUser,
		@PreInventoryMovID, /* guarda a linha correspondente a inserida */
		@CostPrice,
		@AvgCost 
		)

	DECLARE TransferITEMS_Cursor CURSOR FOR
	SELECT
		P.IDModel,
		P.Qty * @Qty,
		M.VendorCost,
		M.AvgCost
	FROM
		PackModel P (NOLOCK) 
		JOIN Model M (NOLOCK) ON (P.IDModel = M.IDModel) 
	WHERE
		IDPackModel = @ModelID
	
	OPEN TransferITEMS_Cursor
	
	--Inicialização de TransferITEMS_Cursor
	FETCH NEXT FROM TransferITEMS_Cursor INTO
		@ModelID,
		@Qty,
		@CostPrice,
		@AvgCost
	
	--Enquanto tem registros
	WHILE @@FETCH_STATUS = 0
	BEGIN
		IF NOT EXISTS(SELECT ModelID FROM Inventory WHERE ModelID = @ModelID AND StoreID = @StoreIDDestino)
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
				@StoreIDDestino,
				@ModelID
				)
		END

		--Inclusao da loja original
		EXEC sp_Sis_GetNextCode 'InventoryMov.IDInventoryMov', @IDInventoryMov OUTPUT

		INSERT InventoryMov
			(
			IDInventoryMov,
			InventMovTypeID,
			DocumentID,
			StoreID,
			ModelID,
			IDPessoa,
			MovDate,
			Qty,
			IDUser,
			PreInventoryMovID,
			CostPrice,
			AvgCost
			)
		VALUES
			(
			@IDInventoryMov,
			8,   /* saida da loja original */
			@DocumentID,
			@StoreIDDestino,
			@ModelID,
			0,
			@TransfDate,
			@Qty,
			@IDUser,
			@PreInventoryMovID, /* guarda a linha correspondente a inserida */
			@CostPrice,
			@AvgCost
			)

		SET @SysError = @@ERROR
		IF @SysError <> 0
		BEGIN
			CLOSE TransferITEMS_Cursor
			DEALLOCATE TransferITEMS_Cursor
			CLOSE TransferIN_Cursor
			DEALLOCATE TransferIN_Cursor
			SET @ErrorLevel = -204
			GOTO ERRO
		END

		FETCH NEXT FROM TransferITEMS_Cursor INTO
			@ModelID,
			@Qty,
			@CostPrice,
			@AvgCost
	END

	--fechamento do cursor
	CLOSE TransferITEMS_Cursor
	--Destruição do cursor
	DEALLOCATE TransferITEMS_Cursor

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		CLOSE TransferIN_Cursor
		DEALLOCATE TransferIN_Cursor
		SET @ErrorLevel = -202
		GOTO ERRO
	END

	FETCH NEXT FROM TransferIN_Cursor INTO
		@DocumentID,
		@StoreIDOrigem,
		@StoreIDDestino,
		@ModelID,
		@Qty,
		@TransfDate,
		@IDUser,
		@PreInventoryMovID,
		@CostPrice,
		@AvgCost,
		@IDLote
END

--fechamento do cursor
CLOSE TransferIN_Cursor
--Destruição do cursor
DEALLOCATE TransferIN_Cursor

OK:
	COMMIT TRAN
	RETURN 0
ERRO:
	ROLLBACK TRAN
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_Inventory_Tranfer_IN', @ErrorLevelStr

	RETURN @ErrorLevel

GO

CREATE  PROCEDURE sp_Inventory_Tranfer_OUT
	(
	@IDModelTransf	int
	)
 AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Exclusão do InventoryMov
		- Salvar custo medio no detalhe da transferencia
		- Inserção do InventoryMov


	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Exclusão do InventoryMov
		-202  Erro em Inserção do InventoryMov
		-203  Erro em Salvar custo medio no detalhe da transferencia

	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------------------------------------------------------------------------------------------------------------
	16 Jul 2005		Rodrigo Costa		Criação;
	05 Jun 2006		Carlos Lima		Adicionado Custo médio na inserção de InventoryMov
        22 Jan 2007             Maic Nogueira           Adicionado Kit na transferência de itens.
	01 Abr 2009		Rodrigo Costa		Atualizar Lote
        ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

DECLARE @ErrorLevel		int
DECLARE @SysError		int

--Declaração de variáveis para o Cursor de InventoryMov
DECLARE @DocumentID		int
DECLARE @ModelID		int
DECLARE @Qty			float
DECLARE @TrasfDate		datetime
DECLARE @CostPrice		money
DECLARE @IDUser			int
DECLARE @PreInventoryMovID	int
DECLARE @IDInventoryMov		int
DECLARE @StoreIDOrigem		int
DECLARE @StoreIDDestino		int
DECLARE @AvgCost		money
DECLARE @IDLote			int

DECLARE @IDInventory		int

BEGIN TRAN


/*--------------------------------------------------------------*/
/*		Parte da Delecao do InventoryMov        	*/
/*--------------------------------------------------------------*/
DECLARE InventoryMov_Cursor CURSOR FOR

SELECT
	IDInventoryMov
FROM
	InventoryMov (NOLOCK) 
WHERE	
	InventoryMov.InventMovTypeID = 7
	AND
	InventoryMov.DocumentID = @IDModelTransf



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
		SET @ErrorLevel = -201
		GOTO ERRO
	END

	FETCH NEXT FROM InventoryMov_Cursor INTO
		@IDInventoryMov
END

CLOSE InventoryMov_Cursor
DEALLOCATE InventoryMov_Cursor

--------------------------------------------------------------------
--  Atualiza  Custo médio de transferencia  --
--------------------------------------------------------------------
UPDATE	ModelTransfDet
SET		AvgCost = IsNull(StoreAvgPrice, 0)
FROM
	ModelTransf (NOLOCK) , Inventory (NOLOCK) 
WHERE
	ModelTransfDet.IDModelTransf = ModelTransf.IDModelTransf
	AND
	ModelTransf.IDLojaOrigem = Inventory.StoreID
	AND
	ModelTransfDet.IDModel = Inventory.ModelID
	AND
	ModelTransfDet.IDModelTransf = @IDModelTransf

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -203
	GOTO   ERRO
END



/*--------------------------------------------------------------*/
/*		Parte da Insercao do InventoryMov        	*/
/*--------------------------------------------------------------*/

--Declaração do Cursor de InventoryMov
DECLARE TransferOUT_Cursor CURSOR FOR
	SELECT
		MTD.IDModelTransf,
		MT.IDLojaOrigem,
		MT.IDLojaDestino,
		MTD.IDModel,
		MTD.Qty,
		MT.Data,
		MT.IDUser,
		MTD.IDModelTransfDet, /* guarda a linha correspondente a inserida */
		MTD.CostPrice,
		Case WHEN (Inv.QtyOnHand - MTD.Qty) = 0 THEN 0 ELSE  Inv.StoreAvgPrice END,
		IsNull(MTD.IDLote, 0) as IDLote
	FROM
		ModelTransfDet MTD (NOLOCK) 
		INNER JOIN ModelTransf MT (NOLOCK) ON  (MTD.IDModelTransf = MT.IDModelTransf)
		LEFT JOIN Inventory Inv (NOLOCK) ON (MTD.IDModel = Inv.ModelID AND MT.IDLojaOrigem = Inv.StoreID)
	WHERE		
		MT.IDModelTransf = @IDModelTransf

OPEN TransferOUT_Cursor

--Inicialização de TransferOUT_Cursor
FETCH NEXT FROM TransferOUT_Cursor INTO
	@DocumentID,
	@StoreIDOrigem,
	@StoreIDDestino,
	@ModelID,
	@Qty,
	@TrasfDate,
	@IDUser,
	@PreInventoryMovID,
	@CostPrice,
	@AvgCost,
	@IDLote
--Enquanto tem registros
WHILE
@@FETCH_STATUS = 0
BEGIN
--Inclusao da loja original

	--Atualizo o Lote
	IF @IDLote <> 0
		EXEC sp_Inventory_Lot_Adjust @ModelID, @StoreIDOrigem, @IDLote, @Qty, 3


	EXEC sp_Sis_GetNextCode'InventoryMov.IDInventoryMov', @IDInventoryMov OUTPUT

	INSERT InventoryMov
		(
		IDInventoryMov,
		InventMovTypeID,
		DocumentID,
		StoreID,
		ModelID,
		IDPessoa,
		MovDate,
		Qty,
		IDUser,
		PreInventoryMovID,
		CostPrice,
		AvgCost
		)
	VALUES
		(
		@IDInventoryMov,
		7,   /* saida da loja original */
		@DocumentID,
		@StoreIDOrigem,
		@ModelID,
		0,
		@TrasfDate,
		@Qty,
		@IDUser,
		@PreInventoryMovID, /* guarda a linha correspondente a inserida */
		@CostPrice,
		@AvgCost
		)


	DECLARE TransferITEMS_Cursor CURSOR FOR
	SELECT
		P.IDModel,
		P.Qty * @Qty,
		M.VendorCost,
		M.AvgCost
	FROM
		PackModel P (NOLOCK) 
		JOIN Model M (NOLOCK) ON (P.IDModel = M.IDModel) 
	WHERE
		IDPackModel = @ModelID
	
	OPEN TransferITEMS_Cursor
	
	--Inicialização de TransferITEMS_Cursor
	FETCH NEXT FROM TransferITEMS_Cursor INTO
		@ModelID,
		@Qty,
		@CostPrice,
		@AvgCost
	
	--Enquanto tem registros
	WHILE @@FETCH_STATUS = 0
	BEGIN
		IF NOT EXISTS(SELECT ModelID FROM Inventory WHERE ModelID = @ModelID AND StoreID = @StoreIDDestino)
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
				@StoreIDDestino,
				@ModelID
				)
		END

		--Inclusao da loja original
		EXEC sp_Sis_GetNextCode 'InventoryMov.IDInventoryMov', @IDInventoryMov OUTPUT
	
		INSERT InventoryMov
			(
			IDInventoryMov,
			InventMovTypeID,
			DocumentID,
			StoreID,
			ModelID,
			IDPessoa,
			MovDate,
			Qty,
			IDUser,
			PreInventoryMovID,
			CostPrice,
			AvgCost
			)
		VALUES
			(
			@IDInventoryMov,
			7,   /* saida da loja original */
			@DocumentID,
			@StoreIDOrigem,
			@ModelID,
			0,
			@TrasfDate,
			@Qty,
			@IDUser,
			@PreInventoryMovID, /* guarda a linha correspondente a inserida */
			@CostPrice,
			@AvgCost
			)

		SET @SysError = @@ERROR
		IF @SysError <> 0
		BEGIN
			CLOSE TransferITEMS_Cursor
			DEALLOCATE TransferITEMS_Cursor
			CLOSE TransferIN_Cursor
			DEALLOCATE TransferIN_Cursor
			SET @ErrorLevel = -204
			GOTO ERRO
		END

		FETCH NEXT FROM TransferITEMS_Cursor INTO
			@ModelID,
			@Qty,
			@CostPrice,
			@AvgCost
	END

	--fechamento do cursor
	CLOSE TransferITEMS_Cursor
	--Destruição do cursor
	DEALLOCATE TransferITEMS_Cursor

	FETCH NEXT FROM TransferOUT_Cursor INTO
		@DocumentID,
		@StoreIDOrigem,
		@StoreIDDestino,
		@ModelID,
		@Qty,
		@TrasfDate,
		@IDUser,
		@PreInventoryMovID,
		@CostPrice,
		@AvgCost,
		@IDLote
END

--fechamento do cursor
CLOSE TransferOUT_Cursor
--Destruição do cursor
DEALLOCATE TransferOUT_Cursor

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -202
	GOTO   ERRO
END

OK:
	COMMIT TRAN
	RETURN 0
ERRO:
	ROLLBACK TRAN
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_Inventory_Tranfer_OUT', @ErrorLevelStr

	RETURN @ErrorLevel

GO
