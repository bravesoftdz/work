if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_quPreSaleItemSplited]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_quPreSaleItemSplited]
GO

CREATE PROCEDURE sp_PreSale_quPreSaleItemSplited
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
		-201  Erro Criando TempTable
		-202  Erro no 1o select
		-203  Erro no 2o select
		-204  Erro no 1o select
		-205  Erro no 2o select
		-205  Erro no Select Fields

	LOG DE MODIFICA��ES

	Data			Programador		Modifica��o
	-----------------------	-----------------------	-----------------------------------------------------------------
	27 Oct	2004		Rodrigo Costa		Criacao;
	07 Dez	2004		Rodrigo Costa		Novo calculo das taxas
	01 Jul	2005		Rodrigo Costa		Exibir campo auto incremental do item servico
	01 Dez	2005		Leonardo Riego		Modificado para pegar o nome do Comissionado da fun��o.
	24 Feb	2006		Maximiliano Muniz	Ordena��o dos selects por IDInvMov
	27 Oct	2006		Rodrigo Costa		Adicionar as colunas de Promo e Model SellingPrice
	29 Dez	2006		Rodrigo Costa		Criacao do campo CupomFiscal
	----------------------------------------------------------------------------------------------------------------- */

DECLARE @ErrorLevel	int
DECLARE @SysError	int

SET @ErrorLevel = 0

-- Cria��o e carca da Tabela Tempor�ria e inclusao dos Items
CREATE TABLE #InventoryItems
	(
	IDItem 			int Null,
	IDModel 		int Null,
	IDSalesPerson		int Null,
	IDUser			int Null,
	IDStore			int Null,
	Qty			float Null,
	ExchangeInvoice		int Null,
	SalePrice		Money,
	CostPrice		Money,
	Discount		Money,
	Tax			Money,
	IsDelivered		bit,
	SaleCode		varchar(20),
	InvoiceCode		varchar(20),
	AutoServiceNum		int Null,
	SalesPerson		varchar(50),
	Promo			bit,
	CupomFiscal		varchar(8)
	)

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END

-- Inclusao dos item do PreInventoryMov Parent
INSERT
	#InventoryItems 
	(
	IDItem, 
	IDModel,
	IDSalesPerson,
	IDUser,
	IDStore,
	Qty, 
	ExchangeInvoice, 
	SalePrice, 
	CostPrice, 
	Discount, 
	Tax,
	IsDelivered,
	SaleCode,
	InvoiceCode,
	AutoServiceNum,
	SalesPerson,
	Promo,
	CupomFiscal
	)
SELECT 
	PIM.IDPreInventoryMov, 
	PIM.ModelID,
	0 AS ComissionID, 
	PIM.UserID,
	PIM.StoreID,
	PIM.Qty, 
	PIM.ExchangeInvoice, 
	PIM.SalePrice,
	PIM.CostPrice, 
	PIM.Discount, 
 	 (CASE WHEN (TC.SpecialDateStart <=  @Date) AND (TC.SpecialDateEnd >= @Date) AND ( ISNULL((( ISNULL(PIM.SalePrice, 0) - ISNULL(PIM.Discount, 0)) / PIM.Qty), 0) < ISNULL(TC.MaxItemValue, 0))
		 THEN (IsNull(TC.SpecialTax,0) + IsNull(TCI.Tax, 0)) ELSE (IsNull(TC.Tax,0) + IsNull(TCI.Tax,0)) END) as Tax, -- Tax
	0,
	I.SaleCode,
	I.InvoiceCode,
	0,
	(SELECT dbo.SalesPersonPreInvMov(PIM.IDPreInventoryMov)) AS SalesPerson,
	PIM.Promo,
	I.CupomFiscal
FROM 
	PreInventoryMov PIM
	JOIN Model M ON ( PIM.ModelID = M.IDModel )
	JOIN TabGroup TG ON ( M.GroupID = TG.IDGroup )
	JOIN StoreToTabGroup STC ON ( STC.IDStore = PIM.StoreID AND STC.IDGroup = TG.IDGroup )
	LEFT OUTER JOIN TaxCategory TC ON ( TC.IDTaxCategory = STC.IDTaxCategory )
	LEFT OUTER JOIN TaxCategory TCI ON ( TCI.IDTaxCategory = STC.IDSaleTax )
	JOIN Invoice I ON (I.IDPreSale = PIM.DocumentID AND PIM.InventMovTypeID IN (1,25) ) 
WHERE 
	PIM.DocumentID = @DocumentID
	AND
	PIM.InventMovTypeID IN (1,25) --Sale and Canceled
	AND
	PIM.IDParentPack Is Null
ORDER BY
	PIM.IDPreInventoryMov

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -202
	GOTO ERRO
END
	 
-- Inclusao dos PreInventoryMov Splits
INSERT
	#InventoryItems 
	(
	IDItem, 
	IDModel,
	IDSalesPerson, 
	IDUser,
	IDStore,
	Qty, 
	ExchangeInvoice, 
	SalePrice, 
	CostPrice, 
	Discount, 
	Tax,
	IsDelivered,
	SaleCode,
	InvoiceCode,
	AutoServiceNum,
	SalesPerson,
	Promo,
	CupomFiscal
	)
SELECT 
	PIM.IDPreInventoryMov, 
	PIM.ModelID,
	0 AS ComissionID, 
	PIM.UserID,
	PIM.StoreID,	PIM.Qty, 
	PIM.ExchangeInvoice, 
	PIM.SalePrice,
	PIM.CostPrice, 
	PIM.Discount, 
 	 (CASE WHEN (TC.SpecialDateStart <=  @Date) AND (TC.SpecialDateEnd >= @Date) AND ( ISNULL((( ISNULL(PIM.SalePrice, 0) - ISNULL(PIM.Discount, 0)) / PIM.Qty), 0) < ISNULL(TC.MaxItemValue, 0))
	 THEN (IsNull(TC.SpecialTax,0) + IsNull(TCI.Tax, 0)) ELSE (IsNull(TC.Tax,0) + IsNull(TCI.Tax,0)) END) as Tax, -- Tax
	0,
	I.SaleCode,
	I.InvoiceCode,
	0,
	(SELECT dbo.SalesPersonPreInvMov(PIM.IDPreInventoryMov)) AS SalesPerson,
	PIM.Promo,
	I.CupomFiscal
FROM 
	PreInventoryMov PIM
	JOIN Model M ON ( PIM.ModelID = M.IDModel )
	JOIN TabGroup TG ON ( M.GroupID = TG.IDGroup )
	JOIN StoreToTabGroup STC ON ( STC.IDStore = PIM.StoreID AND STC.IDGroup = TG.IDGroup )
	LEFT OUTER JOIN TaxCategory TC ON ( TC.IDTaxCategory = STC.IDTaxCategory )
	LEFT OUTER JOIN TaxCategory TCI ON ( TCI.IDTaxCategory = STC.IDSaleTax )
	JOIN Invoice I ON (I.IDPreSale = PIM.DocumentID AND PIM.InventMovTypeID IN (1,25) ) 
WHERE 
	PIM.DocumentID IN (SELECT IDPreSale FROM Invoice where IDPreSaleParent = @DocumentID) 
	AND
	PIM.InventMovTypeID IN (1,25) --Sale and Canceled
	AND
	PIM.IDParentPack Is Null
ORDER BY
	PIM.IDPreInventoryMov
	
SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -203
	GOTO ERRO
END

-- Inclusao dos item do InventoryMov Parent
INSERT
	#InventoryItems 
	(
	IDItem, 
	IDModel,
	IDSalesPerson, 
	IDUser,
	IDStore,
	Qty, 
	ExchangeInvoice, 
	SalePrice, 
	CostPrice, 
	Discount, 
	Tax,
	IsDelivered,
	SaleCode,
	InvoiceCode,
	AutoServiceNum,
	SalesPerson,
	Promo,
	CupomFiscal
	)
SELECT 
	IM.IDInventoryMov, 
	IM.ModelID,
	0 AS ComissionID,  
	IM.IDUser,
	IM.StoreID,
	IM.Qty, 
	IM.ExchangeInvoice, 
	IM.SalePrice,
	IM.CostPrice, 
	IM.Discount,
	IM.SalesTax,
	1,
	I.SaleCode,
	I.InvoiceCode,
	IM.SequencyNum,
	(SELECT dbo.SalesPersonInvMov(IM.IDInventoryMov)) AS SalesPerson,
	IM.Promo,
	I.CupomFiscal
FROM 
	InventoryMov IM
	JOIN Invoice I ON (I.IDInvoice = IM.DocumentID AND IM.InventMovTypeID IN (1,25) ) 
WHERE 
	IM.DocumentID IN (SELECT IDInvoice FROM Invoice where IDPreSale = @DocumentID AND IDInvoice IS NOT NULL) 
	AND
	IM.InventMovTypeID = 1
	AND
	IM.IDParentPack Is Null
ORDER BY
	IM.IDInventoryMov

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -204
	GOTO ERRO
END

-- Inclusao dos InventoryMov Splits
INSERT
	#InventoryItems 
	(
	IDItem, 
	IDModel,
	IDSalesPerson, 
	IDUser,
	IDStore,
	Qty, 
	ExchangeInvoice, 
	SalePrice, 
	CostPrice, 
	Discount, 
	Tax,
	IsDelivered,
	SaleCode,
	InvoiceCode,
	AutoServiceNum,
	SalesPerson,
	Promo,
	CupomFiscal
	)
SELECT 
	IM.IDInventoryMov, 
	IM.ModelID,
	0 AS ComissionID, 
	IM.IDUser,
	IM.StoreID,
	IM.Qty, 
	IM.ExchangeInvoice, 
	IM.SalePrice,
	IM.CostPrice, 
	IM.Discount,
	IM.SalesTax,
	1,
	I.SaleCode,
	I.InvoiceCode,
	IM.SequencyNum,
	(SELECT dbo.SalesPersonInvMov(IM.IDInventoryMov)) AS SalesPerson,
	IM.Promo,
	I.CupomFiscal
FROM 
	InventoryMov IM
	JOIN Invoice I ON (I.IDInvoice = IM.DocumentID AND IM.InventMovTypeID IN (1,25) ) 
WHERE 
	IM.DocumentID IN (SELECT IDInvoice FROM Invoice where IDPreSaleParent = @DocumentID AND IDInvoice IS NOT NULL) 
	AND
	IM.InventMovTypeID = 1
	AND
	IM.IDParentPack Is Null
ORDER BY
	IM.IDInventoryMov
	
SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -205
	GOTO ERRO
END

SELECT
	IM.IDModel as ModelID,
	M.Model,
	M.Description ,
	SalesPerson ,
	M.SuggRetail ,
	SU.IDUser ,
	IM.IDSalesPerson as IDComission,
	IM.Qty ,
	IM.ExchangeInvoice,
	IM.SalePrice ,
	IM.CostPrice,
	IM.Discount ,
	IDItem as  IDInventoryMov,
	TG.SerialNumber,
	IM.Tax as Tax,
	SZ.CodSize,
	SZ.SizeName,
	CL.CodColor,
	CL.Color,
	IM.IsDelivered,
	IM.SaleCode,
	IM.InvoiceCode,
	IM.AutoServiceNum,
	IM.Promo,
	M.SellingPrice,
	IM.CupomFiscal
FROM
	#InventoryItems IM
	JOIN Model M ON ( IM.IDModel = M.IDModel )
	LEFT OUTER JOIN InvSize SZ ON (M.IDSize = SZ.IDSize)
	LEFT OUTER JOIN InvColor CL ON (M.IDColor = CL.IDColor)
	JOIN SystemUser SU ON ( SU.IDUser = IM.IDUser )
	JOIN TabGroup TG ON ( M.GroupID = TG.IDGroup )
	JOIN StoreToTabGroup STC ON ( STC.IDStore = IM.IDStore AND STC.IDGroup = TG.IDGroup )
	LEFT JOIN TaxCategory TC ON ( TC.IDTaxCategory = STC.IDTaxCategory )
ORDER BY
	IM.IDItem

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -206
	GOTO ERRO
END

OK:
	RETURN 0
ERRO:
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PreSale_quPreSaleItemSplited', @ErrorLevelStr

	RETURN @ErrorLevel
GO