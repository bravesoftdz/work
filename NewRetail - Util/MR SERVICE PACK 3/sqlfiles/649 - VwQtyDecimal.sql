if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vwCommission]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vwCommission]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vwSaleItem]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vwSaleItem]
GO

CREATE VIEW vwCommission  AS
SELECT 
	IM.IDInventoryMov, 
	IM.InventMovTypeID, 
	IM.DocumentID, 
	IM.StoreID, 
	IM.Qty, 
	IM.CostPrice, 
	IM.SalePrice, 
	IM.Discount, 
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
	(Round(IM.SalePrice * IM.Qty, 2, 1) - IM.Discount) as MovSale, 
	((((IM.SalePrice - (IM.CostPrice * TP.ComissionOnProfit)) * IM.Qty - IM.Discount)) * (GTCT.Comission / ((100 / SIC.CommissionPercent) * 100) )) as MovCommission, 
	PreInventoryMovID as IDPreInventoryMov, 
	IM.DesiredMarkup
FROM 
	TipoPessoa TP
	JOIN GroupToComissionType GTCT ON (TP.IDTipoPessoa = GTCT.IDTipoComissionado)
	JOIN Model M ON (M.GroupID = GTCT.GroupID)
	JOIN InventoryMov IM ON (IM.ModelID = M.IDModel)
	LEFT JOIN SaleItemCommission SIC ON (IM.IDInventoryMov = SIC.IDInventoryMov)

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
	(Round(IM.SalePrice * IM.Qty, 2, 1) - IM.Discount) as ItemSaleTotal,
	((((IM.SalePrice - (IM.CostPrice * TP.ComissionOnProfit)) * IM.Qty - IM.Discount)) * (GTCT.Comission / ((100 / SIC.CommissionPercent) * 100))) as ItemCommis,
	IM.DesiredMarkup,
	I.IDPreSale,
	I.PreSaleDate,
	SX.Tax,
	((Round(IM.SalePrice * IM.Qty, 2, 1) - IM.Discount) * SX.Tax) as TaxValue,
	((Round(IM.SalePrice * IM.Qty, 2, 1) - IM.Discount) - (IM.CostPrice * IM.Qty) - ((Round(IM.SalePrice * IM.Qty, 2, 1) - IM.Discount) * SX.Tax)) as ItemNetValue
FROM
	InventoryMov IM
	JOIN Model M ON (IM.ModelID = M.IDModel)
	JOIN GroupToComissionType GTCT ON (M.GroupID = GTCT.GroupID)
	JOIN TipoPessoa TP ON (TP.IDTipoPessoa = GTCT.IDTipoComissionado)
	JOIN Invoice I ON (IM.DocumentID = I.IDInvoice AND IM.InventMovTypeID = 1)
	JOIN vwSaleItemTax SX ON (IM.IDInventoryMov = SX.IDMov AND SX.IsInvoice = 1) 
	LEFT JOIN SaleItemCommission SIC ON (SIC.IDInventoryMov = IM.IDInventoryMov)

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
	PIM.Discount,
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
	(Round(PIM.SalePrice * PIM.Qty, 2, 1) - PIM.Discount) as ItemSaleTotal,
	((((PIM.SalePrice - (PIM.CostPrice * TP.ComissionOnProfit)) * PIM.Qty - PIM.Discount)) * (GTCT.Comission / ((100 / SIC.CommissionPercent) * 100))) as ItemCommis,
	PIM.DesiredMarkup,
	I.IDPreSale,
	I.PreSaleDate,
	SX.Tax,
	((Round(PIM.SalePrice * PIM.Qty, 2, 1) - PIM.Discount) * SX.Tax) as TaxValue,
	((Round(PIM.SalePrice * PIM.Qty, 2, 1) - PIM.Discount) - Round(PIM.CostPrice * PIM.Qty, 2, 1) - (Round(PIM.SalePrice * PIM.Qty, 2, 1) - PIM.Discount) * SX.Tax) as ItemNetValue
FROM
	PreInventoryMov PIM
	JOIN Model M ON (PIM.ModelID = M.IDModel)
	JOIN GroupToComissionType GTCT ON (M.GroupID = GTCT.GroupID)
	JOIN TipoPessoa TP ON (TP.IDTipoPessoa = GTCT.IDTipoComissionado)
	JOIN Invoice I ON (PIM.DocumentID = I.IDPreSale AND PIM.InventMovTypeID = 1)
	JOIN vwSaleItemTax SX ON (PIM.IDPreInventoryMov = SX.IDMov AND SX.IsInvoice = 0) 
	LEFT JOIN SaleItemCommission SIC ON (SIC.IDPreInventoryMov = PIM.IDPreInventoryMov)

GO
