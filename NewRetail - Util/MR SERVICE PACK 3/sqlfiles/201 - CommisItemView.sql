if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vwCommission]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vwCommission]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vwSaleItem]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vwSaleItem]
GO

CREATE VIEW vwCommission (IDInventoryMov, InventMovTypeID, DocumentID, StoreID, Qty, CostPrice, SalePrice, Discount, ComissionID, MovDate, IDModel, GroupID, Model, Description, TipoPessoa, IDTipoPessoa, Comission, ComissionOnProfit, SellingPrice, SuggRetail, MovCost, MovSale, MovCommission, IDPreInventoryMov, DesiredMarkup)  AS
       SELECT IM.IDInventoryMov, IM.InventMovTypeID, IM.DocumentID, IM.StoreID, IM.Qty, IM.CostPrice, IM.SalePrice, IM.Discount, IM.ComissionID, IM.MovDate, M.IDModel, M.GroupID, M.Model, M.Description, TP.TipoPessoa, TP.IDTipoPessoa, GTCT.Comission, TP.ComissionOnProfit, M.SellingPrice, M.SuggRetail, (IM.CostPrice * IM.Qty), ((IM.SalePrice * IM.Qty) - IM.Discount), ((((IM.SalePrice - (IM.CostPrice * TP.ComissionOnProfit)) * IM.Qty - IM.Discount)) * (GTCT.Comission / 100)), PreInventoryMovID, IM.DesiredMarkup
       FROM TipoPessoa TP, InventoryMov IM, Model M, GroupToComissionType GTCT
       WHERE IM.ModelID = M.IDModel 
AND
M.GroupID = GTCT.GroupID 
AND
TP.IDTipoPessoa = GTCT.IDTipoComissionado

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
	(IM.CostPrice * IM.Qty) as ItemSubtotal,
	((IM.SalePrice * IM.Qty) - IM.Discount) as ItemTotal,
	((((IM.SalePrice - (IM.CostPrice * TP.ComissionOnProfit)) * IM.Qty - IM.Discount)) * (GTCT.Comission / 100)) as ItemCommis,
	IM.DesiredMarkup
FROM
	InventoryMov IM
	JOIN Model M ON (IM.ModelID = M.IDModel)
	JOIN GroupToComissionType GTCT ON (M.GroupID = GTCT.GroupID)
	JOIN TipoPessoa TP ON (TP.IDTipoPessoa = GTCT.IDTipoComissionado)
WHERE
	IM.InventMovTypeID = 1
 
Union All
 
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
	(PIM.CostPrice * PIM.Qty) as ItemSubtotal,
	((PIM.SalePrice * PIM.Qty) - PIM.Discount) as ItemTotal,
	((((PIM.SalePrice - (PIM.CostPrice * TP.ComissionOnProfit)) * PIM.Qty - PIM.Discount)) * (GTCT.Comission / 100)) as ItemCommis,
	PIM.DesiredMarkup
FROM
	PreInventoryMov PIM
	JOIN Model M ON (PIM.ModelID = M.IDModel)
	JOIN GroupToComissionType GTCT ON (M.GroupID = GTCT.GroupID)
	JOIN TipoPessoa TP ON (TP.IDTipoPessoa = GTCT.IDTipoComissionado)
WHERE
	PIM.InventMovTypeID = 1

GO
