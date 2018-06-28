SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_PreSale_CalcSalePrice]

		(
		@ModelID		int,
		@IDStore		int,
		@IDCustomer		int,
		@SpecialPriceID		int,
		@SalePrice		money Output,
		@CostPrice		money Output,
		@Discount		money Output,
		@AvgCostPrice		money Output,
		@ReplacementCost	money Output,
		@StoreSalePrice		money Output,
		@RequestCustomer	bit Output,
		@PuppyTracker		bit Output,
		@StoreCostPrice		money OutPut,
		@StoreAvgCost		money OutPut,
		@AddKitItems		bit OutPut,
		@PromotionPrice		money output
		)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Calculo do valor no modelo e seu custo
		- Calculo o valor do grupo e do modelo
		- Calculo o desconto pelo tipo de cliente

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro no 1o select
		-202  Erro no 2o select
		-203  Erro ao Executar sp_PreSale_CalcCustomerDiscount

	LOG DE MODIFICAES

	Data			Programador		Modificao
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
	16 Mar	2005		RodrigoCosta 		Inclusao do campo ReplacementCost
	28 Jul	2005		Rodrigo Costa		Inclusao do campo StoreSellingPrice
	30 Oct	2005		Rodrigo	Costa		Inclusao dos campos StoreCost and Store Avg
	21 Feb	2006		Maximiliano Muniz	Chamada da sp_PreSale_CalcCustomerDiscount
	16 Abr  2008		Ike Javarine		Inclusao de novo parametro para Preco Promocional
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

DECLARE @ErrorLevel	int
DECLARE @SysError	int
DECLARE @Model	money
DECLARE @ModelSP 	money
DECLARE @GroupSP 	money
 

SET @Model = Null
SET @ModelSP = Null
SET @GroupSP = Null
SET @ErrorLevel = 0


---------------------------------------------------------------------------------------------------
-- Calculo do valor no modelo e seu custo

SELECT
	@CostPrice = (IsNull(M.VendorCost,0) + IsNull(M.OtherCost,0) + IsNull(M.FreightCost, 0)),
	@Model = CASE WHEN IsNull(I.SellingPrice, 0) = 0 THEN IsNull(M.SellingPrice, 0) ELSE I.SellingPrice END,
	@AvgCostPrice = IsNull(M.AvgCost,0),
	@ReplacementCost = IsNull(ReplacementCost,0),
	@StoreSalePrice = IsNull(I.SellingPrice,0),
	@StoreCostPrice = IsNull(I.StoreCostPrice,0),
	@StoreAvgCost = IsNull(I.StoreAvgPrice,0),
	@AddKitItems = IsNull(TG.PackModelAddItems,0),
	@PromotionPrice = IsNull(M.PromotionPrice,0)
FROM
	Model M (NOLOCK) 
	JOIN TabGroup TG (NOLOCK) ON (M.GroupID = TG.IDGroup)
	LEFT OUTER JOIN Inventory I (NOLOCK) ON (I.ModelID = M.IDModel AND I.StoreID = @IDStore)
WHERE
	M.IDModel = @ModelID

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		SET @ErrorLevel = -201
		GOTO ERRO
	END

---------------------------------------------------------------------------------------------------
-- Calculo o valor do grupo e do modelo

IF IsNull(@SpecialPriceID,0) > 0
BEGIN
	SELECT
		@GroupSP = (1+(SP.SpecialMarkUp/100) ) * (MO.VendorCost+MO.OtherCost+MO.FreightCost)
	FROM
		Model MO (NOLOCK) 
		JOIN SpecialPriceByGroup SP (NOLOCK)  ON (MO.GroupID = SP.GroupID)
	WHERE
		MO.IDModel = @ModelID
		AND
		SP.SpecialPriceID = @SpecialPriceID


	SELECT
		@ModelSP = (1+(MTSP.MarkUp/100)) * (MO.VendorCost+MO.OtherCost+MO.FreightCost)
	FROM
		Model MO (NOLOCK) 
		JOIN ModelToSpecialPrice MTSP (NOLOCK) ON (MO.IDModel = MTSP.IDModel)
	WHERE
		MO.IDModel = @ModelID
		AND
		MTSP.IDSpecialPrice = @SpecialPriceID

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		SET @ErrorLevel = -202
		GOTO ERRO
	END

END

SET @SalePrice = IsNull(@ModelSP, IsNull(@GroupSP, @Model))

---------------------------------------------------------------------------------------------------
-- Calculo o desconto pelo tipo de Cliente

EXEC sp_PreSale_CalcCustomerDiscount @IDCustomer, @ModelID, 1, @SalePrice, @Discount OUTPUT


	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		SET @ErrorLevel = -203
		GOTO ERRO
	END


OK:
	RETURN 0
ERRO:
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PreSale_CalcSalePrice', @ErrorLevelStr

	RETURN @ErrorLevel
GO
