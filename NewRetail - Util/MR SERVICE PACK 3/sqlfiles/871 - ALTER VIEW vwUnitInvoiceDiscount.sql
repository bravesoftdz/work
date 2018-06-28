if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vwCommission]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vwCommission]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vwSaleItem]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vwSaleItem]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vwUnitInvoiceDiscount]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vwUnitInvoiceDiscount]
GO

CREATE VIEW vwUnitInvoiceDiscount  AS
SELECT
	(I.InvoiceDiscount / COUNT(IM.IDInventoryMov)) as UnitDiscount,
	I.IDInvoice as DocumentID
FROM
	InventoryMov IM (NOLOCK)
	JOIN Invoice I (NOLOCK) ON (I.IDInvoice = IM.DocumentID AND IM.InventMovTypeID = 1)
GROUP BY
	I.InvoiceDiscount,
	I.IDInvoice

UNION ALL

SELECT
	(I.InvoiceDiscount / COUNT(PIM.IDPreInventoryMov)) as UnitDiscount,
	I.IDPreSale as DocumentID
FROM
	PreInventoryMov PIM (NOLOCK)
	JOIN Invoice I (NOLOCK) ON (I.IDInvoice = PIM.DocumentID AND PIM.InventMovTypeID = 1)
GROUP BY
	I.InvoiceDiscount,
	I.IDPreSale
GO

CREATE   VIEW vwCommission  AS
SELECT 
	IM.IDInventoryMov, 
	IM.InventMovTypeID, 
	IM.DocumentID, 
	IM.StoreID, 
	IM.Qty, 
	IM.CostPrice, 
	IM.SalePrice, 
	(IM.Discount + IVD.UnitDiscount) as Discount, 
	SIC.IDCommission AS ComissionID, 
	IM.MovDate, 
	M.IDModel, 
	M.GroupID, 
	M.Model, 
	M.Description, 
	TP.TipoPessoa, 
	TP.IDTipoPessoa, 
	GTCT.Comission, 
	TP.ComissionOnProfit, 
	M.SellingPrice, 
	M.SuggRetail, 
	Round(IM.CostPrice * IM.Qty, 2, 1) as MovCost, 
	(Round(IM.SalePrice * IM.Qty, 2, 1) - (IM.Discount + IVD.UnitDiscount)) as MovSale, 
	((((IM.SalePrice - (IM.CostPrice * TP.ComissionOnProfit)) * IM.Qty - (IM.Discount + IVD.UnitDiscount))) * (GTCT.Comission / ((100 / SIC.CommissionPercent) * 100) )) as MovCommission, 
	PreInventoryMovID as IDPreInventoryMov, 
	IM.DesiredMarkup
FROM 
	TipoPessoa TP (NOLOCK)
	JOIN GroupToComissionType GTCT (NOLOCK) ON (TP.IDTipoPessoa = GTCT.IDTipoComissionado)
	JOIN Model M (NOLOCK) ON (M.GroupID = GTCT.GroupID)
	JOIN InventoryMov IM (NOLOCK) ON (IM.ModelID = M.IDModel)
	LEFT JOIN SaleItemCommission SIC (NOLOCK) ON (IM.IDInventoryMov = SIC.IDInventoryMov)
	JOIN Invoice I (NOLOCK) ON(I.IDInvoice = IM.DocumentID AND IM.InventMovTypeID = 1)
	JOIN vwUnitInvoiceDiscount IVD (NOLOCK) ON (IVD.DocumentID = I.IDInvoice)

GO

CREATE   VIEW vwSaleItem AS
SELECT
	1 as Invoice,
	IM.IDInventoryMov,
	IM.InventMovTypeID,
	IM.DocumentID,
	IM.StoreID,
	IM.Qty,
	IM.CostPrice,
	IM.SalePrice,
	(IM.Discount + IVD.UnitDiscount) as Discount,
	SIC.IDCommission AS ComissionID,
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
	NULL AS Notes,
	IM.IDParentPack,
	IM.IDModelService,
	IM.IDPreInvMovExchange,
	IM.AvgCost,
	Round(IM.CostPrice * IM.Qty, 2, 1) as ItemCostTotal,
	(Round(IM.SalePrice * IM.Qty, 2, 1) - (IM.Discount + IVD.UnitDiscount)) as ItemSaleTotal,
	((((IM.SalePrice - (IM.CostPrice * TP.ComissionOnProfit)) * IM.Qty - (IM.Discount + IVD.UnitDiscount))) * (GTCT.Comission / ((100 / SIC.CommissionPercent) * 100))) as ItemCommis,
	IM.DesiredMarkup,
	I.IDPreSale,
	I.PreSaleDate,
	SX.Tax,
	((Round(IM.SalePrice * IM.Qty, 2, 1) - (IM.Discount + IVD.UnitDiscount)) * SX.Tax) as TaxValue,
	((Round(IM.SalePrice * IM.Qty, 2, 1) - (IM.Discount + IVD.UnitDiscount)) - (IM.CostPrice * IM.Qty) - ((Round(IM.SalePrice * IM.Qty, 2, 1) - (IM.Discount + IVD.UnitDiscount)) * SX.Tax)) as ItemNetValue
FROM
	InventoryMov IM (NOLOCK)
	JOIN Model M (NOLOCK) ON (IM.ModelID = M.IDModel)
	JOIN GroupToComissionType GTCT (NOLOCK) ON (M.GroupID = GTCT.GroupID)
	JOIN TipoPessoa TP (NOLOCK) ON (TP.IDTipoPessoa = GTCT.IDTipoComissionado)
	JOIN Invoice I (NOLOCK) ON (IM.DocumentID = I.IDInvoice AND IM.InventMovTypeID = 1)
	JOIN vwSaleItemTax SX (NOLOCK) ON (IM.IDInventoryMov = SX.IDMov AND SX.IsInvoice = 1) 
	LEFT JOIN SaleItemCommission SIC (NOLOCK) ON (SIC.IDInventoryMov = IM.IDInventoryMov)
	JOIN vwUnitInvoiceDiscount IVD (NOLOCK) ON (IVD.DocumentID = I.IDInvoice)

UNION ALL
 
SELECT
	0 as Invoice,
	PIM.IDPreInventoryMov,
	PIM.InventMovTypeID,
	PIM.DocumentID,
	PIM.StoreID,
	PIM.Qty,
	PIM.CostPrice,
	PIM.SalePrice,
	(PIM.Discount + IVD.UnitDiscount) as Discount,
	SIC.IDCommission AS ComissionID,
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
	Round(PIM.CostPrice * PIM.Qty, 2, 1) as ItemCostTotal,
	(Round(PIM.SalePrice * PIM.Qty, 2, 1) - (PIM.Discount + IVD.UnitDiscount)) as ItemSaleTotal,
	((((PIM.SalePrice - (PIM.CostPrice * TP.ComissionOnProfit)) * PIM.Qty - (PIM.Discount + IVD.UnitDiscount))) * (GTCT.Comission / ((100 / SIC.CommissionPercent) * 100))) as ItemCommis,
	PIM.DesiredMarkup,
	I.IDPreSale,
	I.PreSaleDate,
	SX.Tax,
	((Round(PIM.SalePrice * PIM.Qty, 2, 1) - (PIM.Discount + IVD.UnitDiscount)) * SX.Tax) as TaxValue,
	((Round(PIM.SalePrice * PIM.Qty, 2, 1) - (PIM.Discount + IVD.UnitDiscount)) - Round(PIM.CostPrice * PIM.Qty, 2, 1) - (Round(PIM.SalePrice * PIM.Qty, 2, 1) - (PIM.Discount + IVD.UnitDiscount)) * SX.Tax) as ItemNetValue
FROM
	PreInventoryMov PIM (NOLOCK)
	JOIN Model M (NOLOCK) ON (PIM.ModelID = M.IDModel)
	JOIN GroupToComissionType GTCT (NOLOCK) ON (M.GroupID = GTCT.GroupID)
	JOIN TipoPessoa TP (NOLOCK) ON (TP.IDTipoPessoa = GTCT.IDTipoComissionado)
	JOIN Invoice I (NOLOCK) ON (PIM.DocumentID = I.IDPreSale AND PIM.InventMovTypeID = 1)
	JOIN vwSaleItemTax SX (NOLOCK) ON (PIM.IDPreInventoryMov = SX.IDMov AND SX.IsInvoice = 0) 
	LEFT JOIN SaleItemCommission SIC (NOLOCK) ON (SIC.IDPreInventoryMov = PIM.IDPreInventoryMov)
	JOIN vwUnitInvoiceDiscount IVD (NOLOCK) ON (IVD.DocumentID = I.IDPreSale)

GO
