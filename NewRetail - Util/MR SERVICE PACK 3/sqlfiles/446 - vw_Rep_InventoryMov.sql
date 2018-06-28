if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_InventoryMov]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_InventoryMov]
GO

CREATE  VIEW vw_Rep_InventoryMov  AS
SELECT 
	I.IDInventoryMov, 
	I.InventMovTypeID as IDInventMovType, 
	I.DocumentID as IDDocument, 
	I.IDPessoa, 
	I.ModelID as IDModel, 
	I.StoreID as IDStore, 
	SIC.IDCommission AS IDComission, 
	I.IDLancPagCom, 
	I.IDUser, 
	I.IDAgrupaPag, 
	I.IDTemp, 
	I.MovDate, 
	I.Qty, 
	I.CostPrice, 
	I.SalePrice, 
	I.Discount, 
	I.Freight, 
	I.OtherCost, 
	I.ExchangeInvoice, 
	I.QtyExchanged, 
	I.SalesTax,
	I.AvgCost,
	TG.Service
FROM 
	InventoryMov I
	INNER JOIN Model M ON (I.ModelID = M.IDModel)
	INNER JOIN TabGroup TG ON (TG.IDGroup = M.GroupID)
	LEFT JOIN SaleItemCommission SIC ON (SIC.IDInventoryMov = I.IDInventoryMov)

GO
