if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vwSaleItem]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vwSaleItem]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vwSaleItemTax]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vwSaleItemTax]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vwInvoiceParents]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vwInvoiceParents]
GO

CREATE VIEW vwInvoiceParents AS
SELECT
	ISNULL(IP.IDPreSale, I.IDPreSale) AS InvoicePreSale,
	I.IDPreSale DocumentID,
	CASE WHEN I.IDInvoice IS NULL THEN 0 ELSE 1 END AS IsInvoice
FROM 
	Invoice I LEFT JOIN Invoice IP ON (I.IDPreSaleParent = IP.IDPreSale)
WHERE
	IP.IDPreSaleParent IS NULL

GO

CREATE VIEW vwSaleItemTax AS

SELECT 
	PIM.IDPreInventoryMov as IDMov, 
 	SUM(ABS(((CASE WHEN (TC.SpecialDateStart <=  GETDATE()) AND (TC.SpecialDateEnd >= GETDATE()) AND ( ISNULL((( ISNULL(PIM.SalePrice, 0) - ISNULL(PIM.Discount, 0)) / PIM.Qty), 0) < ISNULL(TC.MaxItemValue, 0))
		 THEN (IsNull(TC.SpecialTax,0) + IsNull(TCI.Tax, 0)) ELSE (IsNull(TC.Tax,0) + IsNull(TCI.Tax,0)) END)/100))) as Tax,
	0 as IsInvoice
FROM 
	PreInventoryMov PIM
	JOIN Model M ON ( PIM.ModelID = M.IDModel )
	JOIN TabGroup TG ON ( M.GroupID = TG.IDGroup )
	JOIN StoreToTabGroup STC ON ( STC.IDStore = PIM.StoreID AND STC.IDGroup = TG.IDGroup )
	LEFT OUTER JOIN TaxCategory TC ON ( TC.IDTaxCategory = STC.IDTaxCategory )
	LEFT OUTER JOIN TaxCategory TCI ON ( TCI.IDTaxCategory = STC.IDSaleTax )
WHERE 
	PIM.InventMovTypeID IN (1,25)
	AND
	PIM.IDParentPack Is Null
GROUP BY
	PIM.IDPreInventoryMov

UNION ALL

SELECT 
	IM.IDInventoryMov as IDMov, 
	SUM(ABS(IMX.Tax)) as Tax,
	1 as IsInvoice
FROM 
	InventoryMov IM
	JOIN InventoryMovTax IMX ON (IM.IDInventoryMov = IMX.IDInventoryMov)
WHERE 
	IM.InventMovTypeID IN (1,25)
	AND
	IM.IDParentPack Is Null
GROUP BY
	IM.IDInventoryMov

GO

CREATE VIEW vwSaleItem AS
SELECT
	1 as Invoice,
	IM.IDInventoryMov,
	IM.InventMovTypeID,
	IM.DocumentID,
	IM.StoreID,
	IM.Qty,
	IM.CostPrice,
	IM.SalePrice,
	IM.Discount,
	IM.ComissionID,
	IM.MovDate,
	IM.ModelID,
	M.GroupID,
	M.Model,
	M.Description,
	TP.IDTipoPessoa,
	GTCT.Comission,
	TP.ComissionOnProfit,
	NULL AS IDCotacao,
	NULL AS IDPreInventoryMovParent,
	NULL AS DateEstimatedMov,
	NULL AS DateRealMov,
	NULL AS QtyRealMov,
	NULL AS Marked,
	NULL AS SuggRetail,
	IM.IDRepair,
	IM.IDPessoa,
	IM.IDAgrupaPag,
	IM.IDTemp,
	IM.IDLancPagCom,
	IM.IDUser,
	IM.BarCodeID,
	IM.PreInventoryMovID AS IDPreInventoryMov,
	IM.Freight,
	IM.OtherCost,
	IM.ExchangeInvoice,
	IM.QtyExchanged,
	IM.SalesTax,
	IM.Notes,
	IM.IDParentPack,
	IM.IDModelService,
	IM.IDPreInvMovExchange,
	IM.AvgCost,
	(IM.CostPrice * IM.Qty) as ItemCostTotal,
	((IM.SalePrice * IM.Qty) - IM.Discount) as ItemSaleTotal,
	((((IM.SalePrice - (IM.CostPrice * TP.ComissionOnProfit)) * IM.Qty - IM.Discount)) * (GTCT.Comission / 100)) as ItemCommis,
	IM.DesiredMarkup,
	I.IDPreSale,
	SX.Tax,
	(((IM.SalePrice * IM.Qty) - IM.Discount) * SX.Tax) as TaxValue,
	(((IM.SalePrice * IM.Qty) - IM.Discount) - (((IM.SalePrice * IM.Qty) - IM.Discount) * SX.Tax)) as ItemNetValue
FROM
	InventoryMov IM
	JOIN Model M ON (IM.ModelID = M.IDModel)
	JOIN GroupToComissionType GTCT ON (M.GroupID = GTCT.GroupID)
	JOIN TipoPessoa TP ON (TP.IDTipoPessoa = GTCT.IDTipoComissionado)
	JOIN Invoice I ON (IM.DocumentID = I.IDInvoice AND IM.InventMovTypeID = 1)
	JOIN vwSaleItemTax SX ON (IM.IDInventoryMov = SX.IDMov AND SX.IsInvoice = 1) 

UNION ALL
 
SELECT
	0 as Invoice,
	IDPreInventoryMov,
	PIM.InventMovTypeID,
	PIM.DocumentID,
	PIM.StoreID,
	PIM.Qty,
	PIM.CostPrice,
	PIM.SalePrice,
	PIM.Discount,
	PIM.ComissionID,
	PIM.MovDate,
	M.IDModel,
	M.GroupID,
	M.Model,
	M.Description,
	TP.IDTipoPessoa,
	GTCT.Comission,
	TP.ComissionOnProfit,
	PIM.IDCotacao,
	PIM.IDPreInventoryMovParent,
	PIM.DateEstimatedMov,
	PIM.DateRealMov,
	PIM.QtyRealMov,
	PIM.Marked,
	PIM.SuggRetail,
	NULL AS IDRepair,
	PIM.IDPessoa,
	NULL AS IDAgrupaPag,
	NULL AS IDTemp,
	NULL AS IDLancPagCom,
	PIM.UserID AS IDUser,
	PIM.BarCodeID,
	PIM.IDPreInventoryMov,
	NULL AS Freight,
	NULL AS OtherCost,
	PIM.ExchangeInvoice,
	PIM.QtyExchanged,
	NULL AS SalesTax,
	NULL AS Notes,
	PIM.IDParentPack,
	PIM.IDModelService,
	PIM.IDPreInvMovExchange,
	NULL AS AvgCost,
	(PIM.CostPrice * PIM.Qty) as ItemCostTotal,
	((PIM.SalePrice * PIM.Qty) - PIM.Discount) as ItemSaleTotal,
	((((PIM.SalePrice - (PIM.CostPrice * TP.ComissionOnProfit)) * PIM.Qty - PIM.Discount)) * (GTCT.Comission / 100)) as ItemCommis,
	PIM.DesiredMarkup,
	I.IDPreSale,
	SX.Tax,
	(((PIM.SalePrice * PIM.Qty) - PIM.Discount) * SX.Tax) as TaxValue,
	(((PIM.SalePrice * PIM.Qty) - PIM.Discount) - ((PIM.SalePrice * PIM.Qty) - PIM.Discount) * SX.Tax) as ItemNetValue
FROM
	PreInventoryMov PIM
	JOIN Model M ON (PIM.ModelID = M.IDModel)
	JOIN GroupToComissionType GTCT ON (M.GroupID = GTCT.GroupID)
	JOIN TipoPessoa TP ON (TP.IDTipoPessoa = GTCT.IDTipoComissionado)
	JOIN Invoice I ON (PIM.DocumentID = I.IDPreSale AND PIM.InventMovTypeID = 1)
	JOIN vwSaleItemTax SX ON (PIM.IDPreInventoryMov = SX.IDMov AND SX.IsInvoice = 0) 

GO
