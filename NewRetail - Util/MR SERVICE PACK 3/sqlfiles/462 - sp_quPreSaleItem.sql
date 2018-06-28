if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_quPreSaleItem]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_quPreSaleItem]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_CalcSalePrice]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_CalcSalePrice]
GO

CREATE PROCEDURE sp_PreSale_quPreSaleItem
	(
		@DocumentID      	int,
		@IsPreSale		bit,
		@Date			DateTime
	)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Retorna itens de um determinado PreSale

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro no 1o select
		-202  Erro no 2o select


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
	15 Aug  2000		Rodrigo Costa		Feito o Join com a Tbl TaxCategory para pegar a tax do Item
	26 June 2001		Davi Gouveia		Log de Return Values
	26 May 2004		Rodrigo Costa		Not display Item Packs
	18 Aug 2004		Rodrigo Costa		Gravar error log
	21 Oct 2004		Rodrigo Costa		Criado PIM.InventMovTypeID IN (1,25) para mostrar itens cancelados
	07 Dez 2004		Rodrigo Costa		Novo calculo das taxas
	01 Dez 2005		Leonardo Riego		Modificado para pegar o nome do Comissionado da função.
	17 Apr 2006		Leonardo Riego		Novo campo IDDepartment.
	05 June 2006		Leonardo Riego		Novos campos RequestCustomer e PuppyTracker.
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

DECLARE @ErrorLevel	int
DECLARE @SysError	int

SET @ErrorLevel = 0

if @IsPreSale = 1
begin
	SELECT
		ModelID ,
		M.Model,
		Description ,
		(SELECT dbo.SalesPersonPreInvMov(IDPreInventoryMov)) AS SalesPerson ,
		M.SuggRetail ,
		SU.IDUser ,
		0 as IDComission,
		Qty ,
		ExchangeInvoice,
		SalePrice ,
		CostPrice,
		Discount ,
		PIM.IDPreInventoryMov IDInventoryMov,
		TG.SerialNumber,
	 	 (CASE WHEN (TC.SpecialDateStart <=  @Date) AND (TC.SpecialDateEnd >= @Date) AND ( ISNULL((( ISNULL(PIM.SalePrice, 0) - ISNULL(PIM.Discount, 0)) / PIM.Qty), 0) < ISNULL(TC.MaxItemValue, 0))
			 THEN (IsNull(TC.SpecialTax,0) + IsNull(TCI.Tax, 0)) ELSE (IsNull(TC.Tax,0) + IsNull(TCI.Tax,0)) END) as Tax, -- Tax
		SZ.CodSize,
		SZ.SizeName,
		CL.CodColor,
		CL.Color,
		M.NotVerifyQty,
		PIM.IDDepartment,
		TG.RequestCustomer,
		TG.PuppyTracker
	FROM
		PreInventoryMov PIM
		JOIN Model M ON ( PIM.ModelID = M.IDModel )
		LEFT OUTER JOIN InvSize SZ ON (M.IDSize = SZ.IDSize)
		LEFT OUTER JOIN InvColor CL ON (M.IDColor = CL.IDColor)
		JOIN SystemUser SU ON ( SU.IDUser = PIM.UserID )
		JOIN TabGroup TG ON ( M.GroupID = TG.IDGroup )
	             JOIN StoreToTabGroup STC ON ( STC.IDStore = PIM.StoreID AND STC.IDGroup = TG.IDGroup )
		LEFT OUTER JOIN TaxCategory TC ON ( TC.IDTaxCategory = STC.IDTaxCategory )
		LEFT OUTER JOIN TaxCategory TCI ON ( TCI.IDTaxCategory = STC.IDSaleTax )
	WHERE
		PIM.DocumentID  = @DocumentID
		AND
		PIM.InventMovTypeID IN (1,25) --Sale and Canceled
		AND
		PIM.IDParentPack Is Null

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		SET @ErrorLevel = -201
		GOTO ERRO
	END
end
else
begin
	SELECT
		ModelID ,
		M.Model,
		Description ,
		(SELECT dbo.SalesPersonInvMov(IM.IDInventoryMov)) AS SalesPerson ,
		M.SuggRetail ,
		SU.IDUser ,
		0 AS IDComission,
		Qty ,
		ExchangeInvoice,
		SalePrice ,
		CostPrice,
		Discount ,
		IM.IDInventoryMov IDInventoryMov,
		TG.SerialNumber,
	 	IM.SalesTax as Tax, -- Tax
		SZ.CodSize,
		SZ.SizeName,
		CL.CodColor,
		CL.Color,
		M.NotVerifyQty,
		IM.IDDepartment,
		TG.RequestCustomer,
		TG.PuppyTracker
	FROM
		InventoryMov IM
		JOIN Model M ON ( IM.ModelID = M.IDModel )
		LEFT OUTER JOIN InvSize SZ ON (M.IDSize = SZ.IDSize)
		LEFT OUTER JOIN InvColor CL ON (M.IDColor = CL.IDColor)
		JOIN SystemUser SU ON ( SU.IDUser = IM.IDUser )
		JOIN TabGroup TG ON ( M.GroupID = TG.IDGroup )
		JOIN StoreToTabGroup STC ON ( STC.IDStore = IM.StoreID AND STC.IDGroup = TG.IDGroup )
		JOIN TaxCategory TC ON ( TC.IDTaxCategory = STC.IDTaxCategory )
	WHERE
		IM.DocumentID  = @DocumentID
		AND
		IM.InventMovTypeID = 1
		AND
		IM.IDParentPack Is Null

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		SET @ErrorLevel = -202
		GOTO ERRO
	END
end

OK:
	RETURN 0
ERRO:
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PreSale_quPreSaleItem', @ErrorLevelStr

	RETURN @ErrorLevel

GO

CREATE PROCEDURE sp_PreSale_CalcSalePrice

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
		@StoreAvgCost		money OutPut
		)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Calculo do valor no modelo e seu custo
		- Calculo o valor do grupo e do modelo
		- Calculo o desconto pelo tipo de cliente

	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
	16 Mar	2005		RodrigoCosta 		Inclusao do campo ReplacementCost
	28 Jul	2005		Rodrigo Costa		Inclusao do campo StoreSellingPrice
	30 Oct	2005		Rodrigo	Costa		Inclusao dos campos StoreCost and Store Avg
	21 Feb	2006		Maximiliano Muniz	Chamada da sp_PreSale_CalcCustomerDiscount
	05 June 2006		Leonardo Riego		Não é mais necessário listar os campos de RequestCustomer e PuppyTracker do item. 
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */


DECLARE @Model	money
DECLARE @ModelSP 	money
DECLARE @GroupSP 	money

SET @Model = Null
SET @ModelSP = Null
SET @GroupSP = Null


---------------------------------------------------------------------------------------------------
-- Calculo do valor no modelo e seu custo

SELECT
	@CostPrice = (IsNull(M.VendorCost,0) + IsNull(M.OtherCost,0) + IsNull(M.FreightCost, 0)),
	@Model = CASE WHEN IsNull(I.SellingPrice, 0) = 0 THEN IsNull(M.SellingPrice, 0) ELSE I.SellingPrice END,
	@AvgCostPrice = IsNull(M.AvgCost,0),
	@ReplacementCost = IsNull(ReplacementCost,0),
	@StoreSalePrice = IsNull(I.SellingPrice,0),
	@StoreCostPrice = IsNull(I.StoreCostPrice,0),
	@StoreAvgCost = IsNull(I.StoreAvgPrice,0)
FROM
	Model M
	LEFT OUTER JOIN Inventory I ON (I.ModelID = M.IDModel AND I.StoreID = @IDStore)
WHERE
	M.IDModel = @ModelID

---------------------------------------------------------------------------------------------------
-- Calculo o valor do grupo e do modelo

IF IsNull(@SpecialPriceID,0) > 0
BEGIN


	SELECT
		@GroupSP = (1+(SP.SpecialMarkUp/100) ) * (MO.VendorCost+MO.OtherCost+MO.FreightCost)
	FROM
		Model MO
		JOIN SpecialPriceByGroup SP
			ON (MO.GroupID = SP.GroupID)
	WHERE
		MO.IDModel = @ModelID
		AND
		SP.SpecialPriceID = @SpecialPriceID


	SELECT
		@ModelSP = (1+(MTSP.MarkUp/100)) * (MO.VendorCost+MO.OtherCost+MO.FreightCost)
	FROM
		Model MO
		JOIN ModelToSpecialPrice MTSP
			ON (MO.IDModel = MTSP.IDModel)
	WHERE
		MO.IDModel = @ModelID
		AND
		MTSP.IDSpecialPrice = @SpecialPriceID
 END


SET @SalePrice = IsNull(@ModelSP, IsNull(@GroupSP, @Model))

---------------------------------------------------------------------------------------------------
-- Calculo o desconto pelo tipo de Cliente

EXEC sp_PreSale_CalcCustomerDiscount @IDCustomer, @ModelID, 1, @SalePrice, @Discount OUTPUT
GO
