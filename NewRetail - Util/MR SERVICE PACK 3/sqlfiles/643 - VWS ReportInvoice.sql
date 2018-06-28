IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[vw_Rep_Invoice]') AND OBJECTPROPERTY(id, N'IsView') = 1)
DROP VIEW [dbo].[vw_Rep_Invoice]
GO

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[vw_Rep_InvoiceDate]') AND OBJECTPROPERTY(id, N'IsView') = 1)
DROP VIEW [dbo].[vw_Rep_InvoiceDate]
GO

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[vw_Rep_OpenLayawayHold]') AND OBJECTPROPERTY(id, N'IsView') = 1)
DROP VIEW [dbo].[vw_Rep_OpenLayawayHold]
GO

CREATE VIEW vw_Rep_Invoice AS

/* ---------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO
		- View criada para dar suporte à relatório
 
	LOG DE MODIFICAÇÕES
 
	Data			Programador			Modificação
	-----------------------	-------------------------------	--------------------------------------------------------------------------
	08 Jan	2004		Marcello Felipelli		Criação;
	11 Apr	2007		Maximiiano Muniz		Novo campo InvoiceDiscount;
	---------------------------------------------------------------------------------------------------------------------------------- */

SELECT
	I.IDPreSale,
	I.IDInvoice,
	I.IDPreSaleParent,
	I.CashRegMovID as IDCashRegMov,
	I.IDMeioPag,
	I.MediaID as IDMedia,
	I.IDTouristGroup,
	I.OtherComissionID as IDOtherComission,
	I.IDCustomer,
	I.IDStore,
	I.IDLancPagOtherCom,
	I.DeliverTypeID as  IDDeliverType,
	I.SpecialPriceID as IDSpecialPrice,
	I.PreSaleDate,
	I.InvoiceDate,
	I.DeliverDate,
	I.DeliverAddress,
	I.Passport,
	I.PassportDate,
	I.Ticket,
	I.AirLine,
	I.CompanyName,
	I.CompanyCGC,
	I.DepositDate,
	I.Tax,
	I.SubTotal,
	I.Note,
	I.ItemDiscount,
	I.TaxIsent,
	I.nOpenUser,
	I.RefreshInvoice,
	I.Printed,
	I.CashReceived,
	I.EstimatedPay,
	I.CardNumber,
	I.OtherExpences,
	I.Address,
	I.TaxIsemptValue,
	I.TaxIsemptItemDiscount,
	I.Layaway,
	I.FirstName,
	I.LastName,
	I.ZIP,
	I.nOpenHoldCaixa,
	I.SaleCode,
	I.InvoiceCode,
	I.AditionalExpenses,
	I.InvoiceDiscount,
	I.Canceled,
	I.CupomFiscal,
	(CASE IsNull(I.CupomFiscal,0) WHEN 0 THEN 0 ELSE 1 END) AS IsFiscal
FROM 
	Invoice I
GO

CREATE VIEW vw_Rep_InvoiceDate AS

/* ---------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO
		- View criada para dar suporte à relatório
 
	LOG DE MODIFICAÇÕES
 
	Data			Programador			Modificação
	-----------------------	-------------------------------	--------------------------------------------------------------------------
	08 Jan	2004		Marcello Felipelli		Criação;
	11 Apr	2007		Maximiiano Muniz		Novo campo InvoiceDiscount;
	---------------------------------------------------------------------------------------------------------------------------------- */
 
SELECT
	IMV.IDInventoryMov,
	IMV.MovDate,
	IMV.IDDocument as Invoice,
	IMV.Qty,
	IMV.CostPrice,
	(IMV.CostPrice * IMV.Qty) as ExtCostPrice,
	IMV.AvgCost as ItemAvgCost,
	(IMV.AvgCost * IMV.Qty) as ExtAvgCost,
	IMV.SalePrice,
	(IMV.SalePrice * IMV.Qty) as ExtSalePrice,
	(IMV.Discount * -1) as Discount,
	(IMV.SalePrice - IMV.Discount) as SubTotal,
	(IMV.SalePrice - IMV.Discount) + ROUND(((IMV.SalePrice - IMV.Discount) * IMV.SalesTax),2) as GrandTotal,
	((IMV.SalePrice * IMV.Qty) - IMV.Discount) as ExtSubTotal,
	((IMV.SalePrice * IMV.Qty) - IMV.Discount) + (CASE WHEN TaxIsent = 0 THEN ROUND((((IMV.SalePrice * IMV.Qty) - IMV.Discount) * IMV.SalesTax),2) ELSE 0 END) as ExtGrandTotal,
	IMV.ExchangeInvoice as InvoiceExchanged,
	IMV.QtyExchanged,
	(CASE WHEN I.TaxIsent = 0 THEN IMV.SalesTax ELSE 0 END) as SalesTax,
	I.LastName as CustomerLastName,
	I.FirstName as CustomerFirstName,
	I.ZIP as CustomerZip,
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
	TRG.TipTouristGroup,
	TRG.NumTourist,
	TRG.EnterDate as GroupDate,
	AGN.FullName as Agency,
	AGT.FullName as Agent,
	I.Canceled,
	I.IDPreSale,
	I.IDInvoice,
	I.SaleCode,
	I.InvoiceCode,
	I.CupomFiscal,
	(CASE IsNull(I.CupomFiscal,0) WHEN 0 THEN 0 ELSE 1 END) AS IsFiscal,
	I.IDCashRegMov,
	I.IDSpecialPrice,
	I.IDTouristGroup,
	I.IDDeliverType,
	I.IDMedia,
	I.IDCustomer,
	I.IDStore,
	I.IDOtherComission,
	I.IDPreSaleParent,
	I.AditionalExpenses,
	I.InvoiceDiscount,
	M.IDModel,
	C.IDCategory,
	CUS.FullName as CustomerFullName,
	(I.SubTotal - I.InvoiceDiscount - I.ItemDiscount + I.Tax + I.AditionalExpenses) as InvoiceGrandTotal,
	I.ItemDiscount,
	I.Tax
FROM 
	vw_Rep_InventoryMov IMV
	JOIN vw_Rep_Entity COM ON (COM.IDPerson = IMV.IDComission)
	JOIN vw_Rep_Store S ON (S.IDStore = IMV.IDStore)
	JOIN vw_Rep_Model M ON (IMV.IDModel = M.IDModel)
	JOIN vw_Rep_Category C ON (M.GroupID = C.IDCategory)
	LEFT OUTER JOIN vw_Rep_InvColor INVC ON (M.IDColor = INVC.IDColor)
	LEFT OUTER JOIN vw_Rep_InvSize INVS ON (INVS.IDSize = M.IDSize)
	JOIN vw_Rep_Invoice I ON (I.IDInvoice = IMV.IDDocument)
	JOIN vw_Rep_Media ME ON (ME.IDMedia = I.IDMedia)
	LEFT OUTER JOIN vw_Rep_TouristGroup TRG ON (TRG.IDTouristGroup = I.IDTouristGroup)
	LEFT OUTER JOIN vw_Rep_Entity AGN ON (AGN.IDPerson = TRG.IDAgency)
	LEFT OUTER JOIN vw_Rep_Entity AGT ON (AGT.IDPerson = TRG.IDGuide)
	LEFT OUTER JOIN vw_Rep_Entity CUS ON (CUS.IDPerson = I.IDCustomer)
WHERE
	IMV.IDInventMovType = 1
GO

CREATE VIEW vw_Rep_OpenLayawayHold AS

/* ---------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO
		- View criada para dar suporte à relatório
 
	LOG DE MODIFICAÇÕES
 
	Data			Programador			Modificação
	-----------------------	-------------------------------	--------------------------------------------------------------------------
	08 Jan	2004		Marcello Felipelli		Criação;
	11 Apr	2007		Maximiiano Muniz		Novo campo InvoiceDiscount;
	---------------------------------------------------------------------------------------------------------------------------------- */

SELECT
	PIMV.IDPreInventoryMov,
	PIMV.MovDate,
	PIMV.IDDocument as HoldLayaway,
	PIMV.Qty,
	PIMV.CostPrice,
	(PIMV.CostPrice * PIMV.Qty) as ExtCostPrice,
	PIMV.SalePrice,
	(PIMV.SalePrice * PIMV.Qty) as ExtSalePrice,
	(PIMV.Discount * -1) as Discount,
	(PIMV.SalePrice - PIMV.Discount) as SubTotal,
	((PIMV.SalePrice * PIMV.Qty) - PIMV.Discount) as ExtSubTotal,
	I.LastName as CustomerLastName,
	I.FirstName as CustomerFirstName,
	I.ZIP as CustomerZip,
	CASE WHEN (I.Layaway = 0) THEN 'Hold #' ELSE 'Layaway #' END AS Layaway,
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
	C.IDCategory,
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
	TRG.TipTouristGroup,
	TRG.NumTourist,
	TRG.EnterDate as GroupDate,
	AGN.FullName as Agency,
	AGT.FullName as Agent,
	I.Canceled,
	I.CupomFiscal,
	I.SaleCode,
	I.AditionalExpenses,
	I.SubTotal as InvoiceSubTotal,
	I.ItemDiscount,
	I.InvoiceDiscount,
 	(I.SubTotal - I.InvoiceDiscount - I.ItemDiscount + I.Tax + I.AditionalExpenses) as InvoiceGrandTotal,
	(CASE IsNull(I.CupomFiscal,0) WHEN 0 THEN 0 ELSE 1 END) AS IsFiscal
FROM	
	vw_Rep_PreInventoryMov PIMV
	JOIN SaleItemCommission SIC ON (SIC.IDPreInventoryMov = PIMV.IDPreInventoryMov)
	JOIN vw_Rep_Entity COM ON (COM.IDPerson = SIC.IDCommission)
	JOIN vw_Rep_Store S ON (S.IDStore = PIMV.IDStore)
	JOIN vw_Rep_Model M ON (PIMV.IDModel = M.IDModel)
	JOIN vw_Rep_Category C ON (M.GroupID = C.IDCategory)
	LEFT OUTER JOIN vw_Rep_InvColor INVC ON (M.IDColor = INVC.IDColor)
	LEFT OUTER JOIN vw_Rep_InvSize INVS ON (INVS.IDSize = M.IDSize)
	JOIN vw_Rep_Invoice I ON (I.IDPreSale = PIMV.IDDocument)
	JOIN vw_Rep_Media ME ON (ME.IDMedia = I.IDMedia)
	LEFT OUTER JOIN vw_Rep_Entity CUS ON (CUS.IDPerson = PIMV.IDPerson)
	LEFT OUTER JOIN vw_Rep_TouristGroup TRG ON (TRG.IDTouristGroup = I.IDTouristGroup)
	LEFT OUTER JOIN vw_Rep_Entity AGN ON (AGN.IDPerson = TRG.IDAgency)
	LEFT OUTER JOIN vw_Rep_Entity AGT ON (AGT.IDPerson = TRG.IDGuide)
WHERE
	PIMV.IDInventMovType = 1
GO
