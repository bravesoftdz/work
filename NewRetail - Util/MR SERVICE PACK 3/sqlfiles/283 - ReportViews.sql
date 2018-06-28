if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_CommissionDetails]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_CommissionDetails]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_Invoice]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_Invoice]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_Model]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_Model]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_Inventory]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_Inventory]
GO

CREATE VIEW vw_Rep_Inventory AS
SELECT 
	I.IDInventory, 
	I.StoreID as IDStore, 
	I.ModelID as IDModel, 
	I.QtyOnPreSale, 
	I.QtyOnHand, 
	I.QtyOnOrder, 
	I.QtyOnRepair, 
	I.MaxQty, 
	I.MinQty, 
	I.Location, 
	I.QtyContada as QtyCount, 
	I.DataContagem as CountDate, 
	I.UltimaMovimentacao as LastMov, 
	I.UltimaContagem as LastCount, 
	I.AuxCalculo, 
	I.Avaiable, 
	I.QtyOnPrePurchase, 
	I.LastPurchase, 
	I.FirstPurchase, 
	I.TotalPurchase,
	I.SellingPrice
FROM 
	Inventory I
GO

CREATE VIEW vw_Rep_Model AS
SELECT 
	M.IDModel, 
	M.GroupID, 
	M.IDUnidade, 
	M.IDFabricante, 
	M.IDSize, 
	M.IDColor, 
	M.Model, 
	M.Description, 
	M.FreightCost, 
	M.OtherCost, 
	M.VendorCost, 
	M.DateLastCost, 
	M.MarkUp, 
	M.SellingPrice, 
	M.DateLastSellingPrice, 
	M.Peso as Weight, 
	M.Avaiable, 
	M.LastCost, 
	M.SuggRetail, 
	M.VD, 
	M.SX, 
	M.TotQtyOnHand, 
	M.SX2, 
	M.LastMovDate, 
	M.PVD, 
	M.DP, 
	M.ES, 
	M.PP, 
	M.VP, 
	M.InicioPontoPedido, 
	M.ClasseABC, 
	M.AutomaticRequest, 
	M.TR, 
	M.ModelType, 
	M.CustomSalePrice, 
	M.CustomCostPrice, 
	M.CustomSpecialPrice, 
	M.CustomPromotion, 
	M.AvgCost, 
	M.FinalCost, 
	M.Desativado as Deleted, 
	M.ReplacementCost,
	M.LargeImage, 
	M.FloatPercent, 
	M.LargeImage2, 
	M.NotVerifyQty,
	M.IDSubGroup,
	M.PromotionPrice,
	M.DiscountPerc,
	M.CaseQty
FROM 
	Model M
GO

CREATE VIEW vw_Rep_Invoice AS

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
	I.Canceled,
	I.CupomFiscal,
	(CASE IsNull(I.CupomFiscal,0) WHEN 0 THEN 0 ELSE 1 END) AS IsFiscal
FROM 
	Invoice I
GO

CREATE VIEW dbo.vw_Rep_CommissionDetails AS
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
	I.LastName as CustomerLastName,
	I.FirstName as CustomerFirstName,
	I.ZIP as CustomerZip,
	I.SaleCode,
	I.InvoiceCode,
	I.Canceled,
	I.CupomFiscal,
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
	ROUND(((((IMV.SalePrice - (IMV.CostPrice * ET.CommissionOnProfit)) * IMV.Qty - IMV.Discount)) * ( GCT.Commission / 100 )),2) * ME.PayComission as Commission,
	IMV.IDComission as IDCommission,
	ET.IDPersonType,
	ET.PersonType,
	IMV.IDUser
FROM	
	vw_Rep_Invoice I 
	JOIN vw_Rep_Media ME ON (ME.IDMedia = I.IDMedia)
	JOIN vw_Rep_InventoryMov IMV ON (I.IDInvoice = IMV.IDDocument)
	JOIN vw_Rep_Entity COM ON (COM.IDPerson = IMV.IDComission)
	JOIn vw_Rep_EntityType ET ON (ET.IDPersonType = COM.IDPersonType)
	JOIN vw_Rep_Store S ON (S.IDStore = IMV.IDStore)
	JOIN vw_Rep_Model M ON (IMV.IDModel = M.IDModel)
	JOIN vw_Rep_Category C ON (M.GroupID = C.IDCategory)
	JOIN vw_Rep_GroupToCommissionType GCT ON (GCT.IDPersonType = COM.IDPersonType AND GCT.IDGroup = M.GroupID)
	LEFT OUTER JOIN vw_Rep_InvColor INVC ON (M.IDColor = INVC.IDColor)
	LEFT OUTER JOIN vw_Rep_InvSize INVS ON (INVS.IDSize = M.IDSize)
WHERE
	IMV.IDInventMovType = 1

GO