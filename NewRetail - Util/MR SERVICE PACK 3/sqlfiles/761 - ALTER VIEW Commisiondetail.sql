IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[vw_Rep_CommissionDetails]') and OBJECTPROPERTY(id, N'IsView') = 1)
DROP VIEW [dbo].[vw_Rep_CommissionDetails]
GO

CREATE VIEW dbo.vw_Rep_CommissionDetails AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO
		- View criada para ser utilizada no relatório Agency & Agent Invoices by Date

	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
 	08 Jan 2004		Marcello Felipelli	Criação;
	05 Dec 2005		Leonardo Riego		Modificada para listar múltiplos comissionados
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

SELECT
	ME.PayComission,
	IMV.MovDate,
	ET.CommissionOnProfit,
	IMV.Discount,
	IMV.IDDocument as Invoice,
	IMV.Qty,
	IMV.CostPrice,
	IMV.SalePrice,
	IMV.ExchangeInvoice as InvoiceExchanged,
	IMV.QtyExchanged,
	IMV.SalesTax,
	CUS.LastName as CustomerLastName,
	CUS.FirstName as CustomerFirstName,
	CUS.FullName as CustomerFullName,
	I.ZIP as CustomerZip,
	I.SaleCode,
	I.InvoiceCode,
	I.Canceled,
	I.CupomFiscal,
	I.IDPreSale, 
	I.IDInvoice, 
	(CASE IsNull(I.CupomFiscal,0) WHEN 0 THEN 0 ELSE 1 END) AS IsFiscal,
	M.Model,
	M.Description,
	M.FreightCost as Freight,
	M.OtherCost,
	M.VendorCost,
	M.DateLastCost as LastPurchaseDate,
	M.MarkUp,
	M.SellingPrice as OurPrice,
	M.DateLastSellingPrice as LastSaleDate,
	M.SuggRetail as MSRP,
	M.TotQtyOnHand,
	M.LastMovDate,
	M.AvgCost,
	M.FinalCost as NetCost,
	C.Category,
	ME.Media,
	S.Store,
	S.Address as StoreAddress,
	S.Telephone as StorePhone,
	S.IDState as State,
	S.City as StoreCity,
	S.Zip as StoreZip,
	S.Fax as StoreFax,
	S.Contact as StoreContact,
	COM.FirstName as SalesPersonFName,
	COM.LastName as SalesPersonLName,
	COM.FullName as SalesPersonFullName,
	INVC.ColorCode,
	INVC.Color,
	INVS.CodSize,
	INVS.SizeName,
	GCT.Commission as PercentCommis,
	(IMV.CostPrice * IMV.Qty) as ExtCostPrice,
	(IMV.SalePrice * IMV.Qty) as ExtSalePrice,
	(IMV.Discount * -1) as DiscountCalc,
	(IMV.SalePrice - IMV.Discount) as SubTotal,
	(IMV.SalePrice - IMV.Discount) + ROUND(((IMV.SalePrice - IMV.Discount) * IMV.SalesTax),2) as GrandTotal,
	((IMV.SalePrice * IMV.Qty) - IMV.Discount) as ExtSubTotal,
	((IMV.SalePrice * IMV.Qty) - IMV.Discount) + ROUND((((IMV.SalePrice * IMV.Qty) - IMV.Discount) * IMV.SalesTax),2) as ExtGrandTotal,
	(((IMV.SalePrice * IMV.Qty)- IMV.Discount) - IMV.CostPrice) as Profit,
	CASE WHEN ET.CommissionOnProfit = 0 THEN 'OnSale' ELSE 'OnProfit' END as CommissionType,
	((((IMV.SalePrice - (IMV.CostPrice * ET.CommissionOnProfit)) * IMV.Qty - IMV.Discount)) * ( GCT.Commission / ((100 / SIC.CommissionPercent) * 100) )) * ME.PayComission as Commission,
	SIC.IDCommission as IDCommission,
	ET.IDPersonType,
	ET.PersonType,
	IMV.IDUser,
	SIC.CommissionPercent as CommissionPercent
FROM	
	vw_Rep_Invoice I (NOLOCK)
	JOIN vw_Rep_Entity CUS (NOLOCK) ON (CUS.IDPerson = I.IDCustomer)
	JOIN vw_Rep_Media ME (NOLOCK) ON (ME.IDMedia = I.IDMedia)
	JOIN vw_Rep_InventoryMov IMV (NOLOCK) ON (I.IDInvoice = IMV.IDDocument)
	LEFT JOIN SaleItemCommission SIC (NOLOCK) ON (IMV.IDInventoryMov = SIC.IDInventoryMov)
	JOIN vw_Rep_Entity COM (NOLOCK) ON (COM.IDPerson = SIC.IDCommission)
	JOIn vw_Rep_EntityType ET (NOLOCK) ON (ET.IDPersonType = COM.IDPersonType)
	JOIN vw_Rep_Store S (NOLOCK) ON (S.IDStore = IMV.IDStore)
	JOIN vw_Rep_Model M (NOLOCK) ON (IMV.IDModel = M.IDModel)
	JOIN vw_Rep_Category C (NOLOCK) ON (M.GroupID = C.IDCategory)
	JOIN vw_Rep_GroupToCommissionType GCT (NOLOCK) ON (GCT.IDPersonType = COM.IDPersonType AND GCT.IDGroup = M.GroupID)
	LEFT OUTER JOIN vw_Rep_InvColor INVC (NOLOCK) ON (M.IDColor = INVC.IDColor)
	LEFT OUTER JOIN vw_Rep_InvSize INVS (NOLOCK) ON (INVS.IDSize = M.IDSize)
WHERE
	IMV.IDInventMovType = 1
GROUP BY
	IMV.IDInventoryMov,
	ME.PayComission,
	IMV.MovDate,
	ET.CommissionOnProfit,
	IMV.Discount,
	IMV.IDDocument,
	IMV.Qty,
	IMV.CostPrice,
	IMV.SalePrice,
	IMV.ExchangeInvoice,
	IMV.QtyExchanged,
	IMV.SalesTax,
	CUS.LastName,
	CUS.FirstName,
	CUS.FullName,
	I.ZIP,
	I.SaleCode,
	I.InvoiceCode,
	I.Canceled,
	I.CupomFiscal,
	I.IDPreSale, 
	I.IDInvoice, 
	I.CupomFiscal,
	M.Model,
	M.Description,
	M.FreightCost,
	M.OtherCost,
	M.VendorCost,
	M.DateLastCost,
	M.MarkUp,
	M.SellingPrice,
	M.DateLastSellingPrice,
	M.SuggRetail,
	M.TotQtyOnHand,
	M.LastMovDate,
	M.AvgCost,
	M.FinalCost,
	C.Category,
	ME.Media,
	S.Store,
	S.Address,
	S.Telephone,
	S.IDState,
	S.City,
	S.Zip,
	S.Fax,
	S.Contact,
	COM.FirstName,
	COM.LastName,
	COM.FullName,
	INVC.ColorCode,
	INVC.Color,
	INVS.CodSize,
	INVS.SizeName,
	GCT.Commission,
	SIC.IDCommission,
	ET.IDPersonType,
	ET.PersonType,
	IMV.IDUser,
	SIC.CommissionPercent
GO
