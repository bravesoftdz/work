if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vwCommission]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vwCommission]
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
	IM.ComissionID, 
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
	(IM.CostPrice * IM.Qty) as MovCost, 
	((IM.SalePrice * IM.Qty) - IM.Discount) as MovSale, 
	((((IM.SalePrice - (IM.CostPrice * TP.ComissionOnProfit)) * IM.Qty - IM.Discount)) * (GTCT.Comission / 100)) as MovCommission, 
	PreInventoryMovID as IDPreInventoryMov, 
	IM.DesiredMarkup
FROM 
	TipoPessoa TP
	JOIN GroupToComissionType GTCT ON (TP.IDTipoPessoa = GTCT.IDTipoComissionado)
	JOIN Model M ON (M.GroupID = GTCT.GroupID)
	JOIN InventoryMov IM ON (IM.ModelID = M.IDModel)  
	



GO
