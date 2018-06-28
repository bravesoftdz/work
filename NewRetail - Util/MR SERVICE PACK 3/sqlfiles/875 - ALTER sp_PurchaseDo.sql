if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Purchase_AtuPurchaseSubTotal]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Purchase_AtuPurchaseSubTotal]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Purchase_Do]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Purchase_Do]
GO


CREATE   PROCEDURE sp_Purchase_AtuPurchaseSubTotal
	(
	@IDPurchase	int,
	@TaxInCost	bit
	)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Teste se ja existe a tabela de SubTotal
		- Atualizo o SubTotal do Purchase

	OBS
		Devido a um BUG do BDE, tenho que guardar o total do purchase em uma tabela separada,
		espero um dia, quando o bug for resolvido, voltar ao código original e remover a tabela desnecessaria.

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Teste se o purchase ja esta na tabela
		-202  Erro em Atualizo o SubTotal


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	04 Dec	2000		Eduardo Costa		Criação;
	26 Jun	2001		Davi Gouveia		Log de Return Values
	18 Aug	2004		Rodrigo Costa		Gravar error log
	05 Jan	2005		Rodrigo Costa		Somar os impostos totais que tem a opcao adcionar
	22 Mar	2006		Maximiliano Muniz	Somar os fretes totais
	03 Aug  2006		Leonardo Riego		Soma do valor total do Purchase não é feita direto na tabela de itens. 
							(Quando o Purchase não tinha mais itens o retorno do select era nulo)
							(o que gerava erro no Purchase com valor no SubTotal sem itens )	
	24 Aug	2007		Rodrigo Costa		Estava somando o campo de custo errado no total da compra.
							Somando NewCostPrice * Qty ... tinha que somar o CostPrice
	26 Set	2009		Rodrigo Costa		Calcular o Desconto do item
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

DECLARE @ErrorLevel		int
DECLARE @SysError		int
DECLARE @TaxTotal		float
DECLARE @TaxTotalRet		float

SET @ErrorLevel = 0

BEGIN TRAN


------------------------------------------------------------------------------
-- Teste se o purchase ja esta na tabela

IF NOT EXISTS (SELECT SubTotal FROM Pur_PurchaseTotal (NOLOCK)  WHERE IDPurchase = @IDPurchase)
	INSERT Pur_PurchaseTotal (IDPurchase, SubTotal, SubTotalRet) VALUES (@IDPurchase, 0, 0)

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END


------------------------------------------------------------------------------
-- Atualizo o SubTotal
IF (@TaxInCost=1)
BEGIN

	--Somar os impostos totais que tem a opcao adcionar
	
	SELECT 
		@TaxTotal = SUM(IsNull(PIT.TaxValue,0))
	FROM 
		Pur_PurchaseItemTax PIT (NOLOCK) 
		LEFT OUTER JOIN VendorTax VT (NOLOCK) ON (VT.IDVendorTax = PIT.IDVendorTax)
		LEFT OUTER JOIN TaxCategory CT (NOLOCK) ON (CT.IDTaxCategory = VT.IDTaxCategory)
	WHERE
		PIT.IDPurchase = @IDPurchase
		AND
		CT.Debit = 0

	--Somar os impostos totais que tem a opcao adcionar de Retorno
	SELECT 
		@TaxTotalRet = SUM(IsNull(PIT.TaxValue,0))
	FROM 
		Pur_PurchaseItemTaxRet PIT (NOLOCK) 
		LEFT OUTER JOIN VendorTax VT (NOLOCK) ON (VT.IDVendorTax = PIT.IDVendorTax)
		LEFT OUTER JOIN TaxCategory CT (NOLOCK) ON (CT.IDTaxCategory = VT.IDTaxCategory)
	WHERE
		PIT.IDPurchase = @IDPurchase
		AND
		CT.Debit = 0

	
	UPDATE
		P
	SET
		P.SubTotal = (PT.SubTotal + IsNull(@TaxTotal,0)),
		P.SubTotalRet = (PT.SubTotalRet + IsNull(@TaxTotalRet,0))
	FROM
		Pur_PurchaseTotal P -- Quando o bug for resolvido trocar a tabela e remover o codigo acima
		JOIN (
			SELECT
				PU.IDPurchase,
				SUM(IsNull(PPI.CostPrice,0)) as SubTotal,
				SUM(IsNull(PPI.CostPriceRet,0)) as SubTotalRet
			FROM
				Pur_Purchase PU (NOLOCK) 
				LEFT JOIN Pur_PurchaseItem PPI (NOLOCK) ON (PU.IDPurchase = PPI.IDPurchase)
			WHERE
				PU.IDPurchase = @IDPurchase
			GROUP BY
				PU.IDPurchase
		) as PT ON (P.IDPurchase = PT.IDPurchase)


	UPDATE
		P
	SET
		P.Freight = PT.Freight,
		P.OtherCharges = PT.Other,
		P.FreightRet = PT.FreightRet,
		P.OtherChargesRet = PT.OtherRet,
		P.Discount = (PT.Discount - PT.DiscountRet)
	FROM
		Pur_Purchase P -- Quando o bug for resolvido trocar a tabela e remover o codigo acima
		JOIN (
			SELECT
				PPI.IDPurchase,
				SUM(IsNull(PPI.FreightCost, 0)) as Freight,
				SUM(IsNull(PPI.OtherCost, 0)) as Other,
				SUM(IsNull(PPI.FreightCostRet, 0)) as FreightRet,
				SUM(IsNull(PPI.OtherCostret, 0)) as OtherRet,
				SUM(IsNull(PPI.Discount, 0)) as Discount,
				SUM(IsNull(PPI.DiscountRet, 0)) as DiscountRet
			FROM
				Pur_PurchaseItem PPI (NOLOCK) 
			WHERE
				PPI.IDPurchase = @IDPurchase
			GROUP BY
				PPI.IDPurchase
		) as PT ON (P.IDPurchase = PT.IDPurchase)

END
ELSE

BEGIN
	UPDATE
		P
	SET
		P.SubTotal = PT.SubTotal,
		P.SubTotalRet = PT.SubTotalRet 
	FROM
		Pur_PurchaseTotal P -- Quando o bug for resolvido trocar a tabela e remover o codigo acima
		JOIN (
	
			SELECT
				PU.IDPurchase,
				SUM(IsNull(PPI.NewCostPrice * PPI.Qty, 0)) as SubTotal,
				SUM(IsNull(PPI.NewCostPriceRet * PPI.Qty, 0)) as SubTotalRet
			FROM
				Pur_Purchase PU (NOLOCK) 
				LEFT JOIN Pur_PurchaseItem PPI (NOLOCK) ON (PU.IDPurchase = PPI.IDPurchase)
			WHERE
				PU.IDPurchase = @IDPurchase
			GROUP BY
				PU.IDPurchase
	
		) as PT ON (P.IDPurchase = PT.IDPurchase)
END

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -202
	GOTO ERRO
END



OK:
	COMMIT TRAN
	RETURN 0

ERRO:
	ROLLBACK TRAN
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_Purchase_AtuPurchaseSubTotal', @ErrorLevelStr

	RETURN @ErrorLevel


GO

CREATE  PROCEDURE sp_Purchase_Do
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
		-225  Erro em remover produtos com IDModel NULL
	
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
	25 Jun		2009	Rodrigo Costa		Salvar custo do fornecedor sem impostos
	26 Set		2009	Rodrigo Costa		Deletar itens com valores NULL
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
DECLARE @VendorCost			money 
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
	SET @ErrorLevel = -225
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
-- Deleto os produtos com IDModel NULL
DELETE
	PPI
FROM
	Pur_PurchaseItem PPI
WHERE
	PPI.IDPurchase = @IDPurchase
	AND
	PPI.IDModel IS NULL

IF @@ERROR <> 0
BEGIN
	SET @ErrorLevel = -225
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
	PPI.CostPrice,
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

Select * from Pur_PurchaseItem

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
	@VendorCost,
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
	
	IF (@TaxInCost=1)
		SET @VendorCost = (@VendorCost / @Qty) --Custo Unitario - BR
	ELSE
		SET @VendorCost = @CostPrice --Custo Unitario - USA

	IF NOT EXISTS (SELECT IDModel FROM Inv_ModelVendor WHERE IDModel = @ModelID AND IDPessoa = @IDPessoa)
	BEGIN
		INSERT
			Inv_ModelVendor (IDModel, IDPessoa, VendorOrder, VendorCost, CostLastChange)
		SELECT
			@ModelID,
			@IDPessoa,
			IsNull(MAX(IMV.VendorOrder),0) + 1,
			@VendorCost,
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
			VendorCost = @VendorCost,
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
		@VendorCost,
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
