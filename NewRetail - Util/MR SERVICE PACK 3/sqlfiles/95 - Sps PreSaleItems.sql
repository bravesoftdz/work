if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_quPreSaleItem]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_quPreSaleItem]
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
	26 May 	2004		Rodrigo Costa		Not display Item Packs
	18 Aug 	2004		Rodrigo Costa		Gravar error log
	27 Set 	2004		Rodrigo Costa		Incluido as tabelas InvSize e InvoColor no select
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
		SalesPerson ,
		M.SuggRetail ,
		SU.IDUser ,
		IDSalesPerson as IDComission,
		Qty ,
		ExchangeInvoice,
		SalePrice ,
		CostPrice,
		Discount ,
		PIM.IDPreInventoryMov IDInventoryMov,
		TG.SerialNumber,
	 	 (CASE WHEN (TC.SpecialDateStart <= @Date) AND (TC.SpecialDateEnd >= @Date) AND ( ISNULL((( ISNULL(PIM.SalePrice, 0) - ISNULL(PIM.Discount, 0)) / PIM.Qty), 0) < ISNULL(TC.MaxItemValue, 0))
			 THEN TC.SpecialTax ELSE TC.Tax END) as Tax, -- Tax
		SZ.CodSize,
		SZ.SizeName,
		CL.CodColor,
		CL.Color
	FROM
		PreInventoryMov PIM
		JOIN vwSalesPerson SP ON ( PIM.ComissionID = SP.IDSalesPerson )
		JOIN Model M ON ( PIM.ModelID = M.IDModel )
		LEFT OUTER JOIN InvSize SZ ON (M.IDSize = SZ.IDSize)
		LEFT OUTER JOIN InvColor CL ON (M.IDColor = CL.IDColor)
		JOIN SystemUser SU ON ( SU.IDUser = PIM.UserID )
		JOIN TabGroup TG ON ( M.GroupID = TG.IDGroup )
	             JOIN StoreToTabGroup STC ON ( STC.IDStore = PIM.StoreID AND STC.IDGroup = TG.IDGroup )
		LEFT OUTER JOIN TaxCategory TC ON ( TC.IDTaxCategory = STC.IDTaxCategory )
	WHERE
		PIM.DocumentID  = @DocumentID
		AND
		PIM.InventMovTypeID = 1
		AND
		PIM.IDParentPack Is Null
	ORDER BY
		SU.IDUser, Model

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
		SalesPerson ,
		M.SuggRetail ,
		SU.IDUser ,
		IDSalesPerson as IDComission,
		Qty ,
		ExchangeInvoice,
		SalePrice ,
		CostPrice,
		Discount ,
		IDInventoryMov IDInventoryMov,
		TG.SerialNumber,
	 	IM.SalesTax as Tax, -- Tax
		SZ.CodSize,
		SZ.SizeName,
		CL.CodColor,
		CL.Color
	FROM
		InventoryMov IM
		JOIN vwSalesPerson SP ON ( IM.ComissionID = SP.IDSalesPerson )
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
	ORDER BY
		SU.IDUser, M.Model

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
