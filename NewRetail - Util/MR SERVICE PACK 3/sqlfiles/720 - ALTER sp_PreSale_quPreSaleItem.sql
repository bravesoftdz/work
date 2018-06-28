IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[sp_PreSale_quPreSaleItem]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[sp_PreSale_quPreSaleItem]
GO

CREATE PROCEDURE sp_PreSale_quPreSaleItem
	(
		@DocumentID	int,
		@IsPreSale	bit,
		@Date		DateTime
	)
AS

/* ---------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

	- Retorna itens de um determinado PreSale

	TABELA DE ERROS PARA RETURN_VALUE

		000  Ok
		-201  Erro no 1o select
		-202  Erro no 2o select

	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	-----------------------	-----------------------	----------------------------------------------------------------------------------
	15 May	2000		Eduardo Costa		Criacao;
	15 Aug	2000		Rodrigo Costa		Feito o Join com a Tbl TaxCategory para pegar a tax do Item;
	26 Jun	2001		Davi Gouveia		Log de Return Values;
	26 May	2004		Rodrigo Costa		Not display Item Packs;
	18 Aug	2004		Rodrigo Costa		Gravar error log;
	21 Oct	2004		Rodrigo Costa		Criado PIM.InventMovTypeID IN (1,25) para mostrar itens cancelados;
	07 Dez	2004		Rodrigo Costa		Novo calculo das taxas;
	01 Dez	2005		Leonardo Riego		Modificado para pegar o nome do Comissionado da função;
	17 Apr	2006		Leonardo Riego		Novo campo IDDepartment;
	26 Feb	2007		Rodrigo Costa		Selecionar imposto definido no PreInventoryMov;
	26 Mar	2007		Maic Nogueira		Adicionado o campo "CaseQty" da tabela "Model";
	10 Aug	2007		Maximiliano Muniz	Adicionado o campo "Department" da tabela "Inv_Department";
	---------------------------------------------------------------------------------------------------------------------------------- */

DECLARE @ErrorLevel int
DECLARE @SysError int

SET @ErrorLevel = 0

if @IsPreSale = 1
begin
	SELECT
		ModelID,
		M.CaseQty,
		M.Model,
		Description,
		(SELECT dbo.SalesPersonPreInvMov(IDPreInventoryMov)) AS SalesPerson,
		M.SuggRetail,
		SU.IDUser,
		0 as IDComission,
		Qty,
		ExchangeInvoice,
		SalePrice,
		CostPrice,
		Discount,
		PIM.IDPreInventoryMov IDInventoryMov,
		TG.SerialNumber,
		(CASE
			WHEN (TC.SpecialDateStart <=  @Date) AND (TC.SpecialDateEnd >= @Date) AND ( ISNULL((( ISNULL(PIM.SalePrice, 0) - ISNULL(PIM.Discount, 0)) / PIM.Qty), 0) < ISNULL(TC.MaxItemValue, 0)) THEN (IsNull(TC.SpecialTax,0) + IsNull(TCI.Tax, 0))
			ELSE (IsNull(TC.Tax,0) + IsNull(TCI.Tax,0))
		END) as Tax, -- Tax
		SZ.CodSize,
		SZ.SizeName,
		CL.CodColor,
		CL.Color,
		M.NotVerifyQty,
		PIM.IDDepartment,
		TG.RequestCustomer,
		TG.PuppyTracker,
		PIM.Promo,
		M.SellingPrice,
		PIM.IDPreInventoryMovParent as IDMovParent,
		D.Department
	FROM
		PreInventoryMov PIM
		JOIN Model M ON ( PIM.ModelID = M.IDModel )
		LEFT OUTER JOIN InvSize SZ ON (M.IDSize = SZ.IDSize)
		LEFT OUTER JOIN InvColor CL ON (M.IDColor = CL.IDColor)
		JOIN SystemUser SU ON ( SU.IDUser = PIM.UserID )
		JOIN TabGroup TG ON ( M.GroupID = TG.IDGroup )
		JOIN StoreToTabGroup STC ON ( STC.IDStore = PIM.StoreID AND STC.IDGroup = TG.IDGroup )
		LEFT OUTER JOIN TaxCategory TC ON ( TC.IDTaxCategory = STC.IDTaxCategory AND TC.IDTaxCategory = IsNull(PIM.IDTaxCategory, TC.IDTaxCategory))
		LEFT OUTER JOIN TaxCategory TCI ON ( TCI.IDTaxCategory = STC.IDSaleTax )
		LEFT OUTER JOIN Inv_Department D ON (PIM.IDDepartment = D.IDDepartment)
	WHERE
		PIM.DocumentID  = @DocumentID
		AND PIM.InventMovTypeID IN (1,25) --Sale and Canceled
		AND PIM.IDParentPack Is Null

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
		ModelID,
		M.CaseQty,
		M.Model,
		Description,
		(SELECT dbo.SalesPersonInvMov(IM.IDInventoryMov)) AS SalesPerson,
		M.SuggRetail,
		SU.IDUser,
		0 AS IDComission,
		Qty,
		ExchangeInvoice,
		SalePrice,
		CostPrice,
		Discount,
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
		TG.PuppyTracker,
		IM.Promo,
		M.SellingPrice,
		0 as IDMovParent,
		D.Department
	FROM
		InventoryMov IM
		JOIN Model M ON ( IM.ModelID = M.IDModel )
		LEFT OUTER JOIN InvSize SZ ON (M.IDSize = SZ.IDSize)
		LEFT OUTER JOIN InvColor CL ON (M.IDColor = CL.IDColor)
		JOIN SystemUser SU ON ( SU.IDUser = IM.IDUser )
		JOIN TabGroup TG ON ( M.GroupID = TG.IDGroup )
		JOIN StoreToTabGroup STC ON ( STC.IDStore = IM.StoreID AND STC.IDGroup = TG.IDGroup )
		LEFT JOIN TaxCategory TC ON ( TC.IDTaxCategory = STC.IDTaxCategory )
		LEFT JOIN Inv_Department D ON (IM.IDDepartment = D.IDDepartment)
WHERE
		IM.DocumentID  = @DocumentID
		AND IM.InventMovTypeID = 1
		AND IM.IDParentPack Is Null

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
