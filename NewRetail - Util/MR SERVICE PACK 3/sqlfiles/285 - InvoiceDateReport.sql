if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_InvoiceDate]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_InvoiceDate]
GO

CREATE VIEW dbo.vw_Rep_InvoiceDate
AS

SELECT
	IMV.IDInventoryMov,
	IMV.MovDate,
	IMV.IDDocument as Invoice,
	IMV.Qty,
	IMV.CostPrice,
	(IMV.CostPrice * IMV.Qty) as ExtCostPrice,
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
	I.CupomFiscal,
	(CASE IsNull(I.CupomFiscal,0) WHEN 0 THEN 0 ELSE 1 END) AS IsFiscal
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
WHERE
	IMV.IDInventMovType = 1

GO


INSERT INTO Rep_Field (
        tablename,
        fieldname,
        fieldalias,
        datatype,
        selectable,
        searchable,
        sortable,
        autosearch,
        mandatory)
SELECT
        TABLE_NAME,
        COLUMN_NAME AS fieldname,
        COLUMN_NAME AS fieldalias,
        CASE data_type
                WHEN 'INT' THEN 'dtInteger'
                WHEN 'DateTime' THEN 'dtDateTime'
                WHEN 'TBit' THEN 'dtBoolean'
                WHEN 'TControlField' THEN 'dtBoolean'
                WHEN 'Bit' THEN 'dtBoolean'
                WHEN 'Money' THEN 'dtCurrency'
                WHEN 'TValor' THEN 'dtCurrency'
                WHEN 'TValorNull' THEN 'dtCurrency'
                ELSE  'dtString' END AS data_type,
        'T' AS selectable,
        'T' AS searchable,
        'T' AS sortable,
        'T' AS autosearch,
        'T' AS mandatory
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'vw_Rep_InvoiceDate'
AND COLUMN_NAME IN ('Canceled' , 'CupomFiscal', 'IsFiscal')
GO


if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_OpenLayawayHold]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_OpenLayawayHold]
GO

CREATE VIEW dbo.vw_Rep_OpenLayawayHold
AS

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
	(CASE IsNull(I.CupomFiscal,0) WHEN 0 THEN 0 ELSE 1 END) AS IsFiscal
FROM	
	vw_Rep_PreInventoryMov PIMV
	JOIN vw_Rep_Entity COM ON (COM.IDPerson = PIMV.IDComission)
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

INSERT INTO Rep_Field (
        tablename,
        fieldname,
        fieldalias,
        datatype,
        selectable,
        searchable,
        sortable,
        autosearch,
        mandatory)
SELECT
        TABLE_NAME,
        COLUMN_NAME AS fieldname,
        COLUMN_NAME AS fieldalias,
        CASE data_type
                WHEN 'INT' THEN 'dtInteger'
                WHEN 'DateTime' THEN 'dtDateTime'
                WHEN 'TBit' THEN 'dtBoolean'
                WHEN 'TControlField' THEN 'dtBoolean'
                WHEN 'Bit' THEN 'dtBoolean'
                WHEN 'Money' THEN 'dtCurrency'
                WHEN 'TValor' THEN 'dtCurrency'
                WHEN 'TValorNull' THEN 'dtCurrency'
                ELSE  'dtString' END AS data_type,
        'T' AS selectable,
        'T' AS searchable,
        'T' AS sortable,
        'T' AS autosearch,
        'T' AS mandatory
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'vw_Rep_OpenLayawayHold'
AND COLUMN_NAME IN ('Canceled' , 'CupomFiscal', 'IsFiscal')
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_SalesProfit]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_SalesProfit]
GO

CREATE VIEW dbo.vw_Rep_SalesProfit
AS
/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO
		- View criada para ser utilizada no relatório Sales Profit by Date

	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
 	08 Jan 2004		Marcello Felipelli	Criação;
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

SELECT 
	vw_Rep_InventoryMov.IDStore,
	CONVERT(varchar(10), vw_Rep_InventoryMov.MovDate, 101) as MovDate,
	DatePart(year, vw_Rep_InventoryMov.MovDate) InvYear, 
	Convert(Varchar(10),DateName(month, vw_Rep_InventoryMov.MovDate)) MonthName, 
	DatePart(month, vw_Rep_InventoryMov.MovDate) InvMonth, 
	DatePart(day, vw_Rep_InventoryMov.MovDate) InvDay, 
	SUM(vw_Rep_InventoryMov.Qty) NumItems, 
	SUM(( vw_Rep_InventoryMov.SalePrice * vw_Rep_InventoryMov.Qty )  - vw_Rep_InventoryMov.Discount ) Sales, 
	SUM( vw_Rep_InventoryMov.CostPrice * vw_Rep_InventoryMov.Qty ) Cost, 
	SUM(( vw_Rep_InventoryMov.SalePrice - vw_Rep_InventoryMov.CostPrice )  * vw_Rep_InventoryMov.Qty - vw_Rep_InventoryMov.Discount ) Profit, 
	CASE WHEN SUM(( vw_Rep_InventoryMov.SalePrice * vw_Rep_InventoryMov.Qty )  - vw_Rep_InventoryMov.Discount ) = 0 THEN 0 ELSE (( SUM(( vw_Rep_InventoryMov.SalePrice - vw_Rep_InventoryMov.CostPrice )  * vw_Rep_InventoryMov.Qty - vw_Rep_InventoryMov.Discount )) / ( SUM(( vw_Rep_InventoryMov.SalePrice * vw_Rep_InventoryMov.Qty )  - vw_Rep_InventoryMov.Discount ))) * 100 END Percents
FROM vw_Rep_InventoryMov vw_Rep_InventoryMov
      INNER JOIN vw_Rep_Invoice vw_Rep_Invoice ON 
     (vw_Rep_Invoice.IDInvoice = vw_Rep_InventoryMov.IDDocument)
      INNER JOIN vw_Rep_Media vw_Rep_Media ON 
     (vw_Rep_Media.IDMedia = vw_Rep_Invoice.IDMedia)
      INNER JOIN vw_Rep_Model vw_Rep_Model ON 
     (vw_Rep_Model.IDModel = vw_Rep_InventoryMov.IDModel)
      INNER JOIN vw_Rep_Category vw_Rep_Category ON 
     (vw_Rep_Category.IDCategory = vw_Rep_Model.GroupID)
WHERE 
	( vw_Rep_InventoryMov.IDInventMovType = 1 )
	AND
	(vw_Rep_Invoice.Canceled = 0 )
GROUP BY
	vw_Rep_InventoryMov.IDStore,
	CONVERT(varchar(10), vw_Rep_InventoryMov.MovDate, 101), 
	DatePart(year, vw_Rep_InventoryMov.MovDate),
	Convert(Varchar(10),DateName(month, vw_Rep_InventoryMov.MovDate)),
	DatePart(month, vw_Rep_InventoryMov.MovDate),
	DatePart(day, vw_Rep_InventoryMov.MovDate)

GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_AgencyAgentInvoices]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_AgencyAgentInvoices]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vwGroupSales]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vwGroupSales]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vwGroupSalesGuide]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vwGroupSalesGuide]
GO

CREATE VIEW vwGroupSales AS
SELECT 
	TG.IDTouristGroup, 
	TG.NumTourist, 
	TG.IDAgency, 
	TG.EnterDate, 
	SUM(I.SubTotal - I.ItemDiscount + IsNull(I.AditionalExpenses,0)) as Sales, 
	COUNT (I.IDInvoice) as Invoices
FROM 
	TouristGroup TG, Invoice I
WHERE 
	(TG.IDTouristGroup = I.IDTouristGroup)
	AND
	I.Canceled = 0
GROUP BY 
	TG.IDTouristGroup,
	TG.NumTourist,
	TG.IDAgency,
	TG.EnterDate
	

GO

CREATE VIEW vwGroupSalesGuide  AS

SELECT 
	TG.IDTouristGroup, 
	TG.NumTourist, 
	TG.IDGuide, 
	TG.EnterDate, 
	SUM(I.SubTotal - I.ItemDiscount + IsNull(I.AditionalExpenses,0))  as Sales, 
	COUNT (I.IDInvoice) as Invoices
FROM 
	TouristGroup TG, Invoice I
WHERE 
	TG.IDTouristGroup = I.IDTouristGroup
	AND
	I.Canceled = 0
GROUP BY 
	TG.IDTouristGroup,
	TG.NumTourist,
	TG.IDGuide,
	TG.EnterDate



GO


CREATE VIEW dbo.vw_Rep_AgencyAgentInvoices
AS

SELECT
	IMV.MovDate,
	IMV.IDDocument as Invoice,
	IMV.Qty,
	IMV.CostPrice,
	(IMV.CostPrice * IMV.Qty) as ExtCostPrice,
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
	I.AditionalExpenses, 
	I.Canceled,
	I.CupomFiscal,
	(CASE IsNull(I.CupomFiscal,0) WHEN 0 THEN 0 ELSE 1 END) AS IsFiscal

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
--	JOIN #Ret_ReportSource on (#Ret_ReportSource.IDInventoryMov = IMV.IDInventoryMov AND #Ret_ReportSource.IDInvoice = I.IDInvoice)
WHERE
	IMV.IDInventMovType = 1
	AND
	I.IDTouristGroup IS NOT NULL
	AND
	I.IDInvoice IS NOT NULL

GO


INSERT INTO Rep_Field (
        tablename,
        fieldname,
        fieldalias,
        datatype,
        selectable,
        searchable,
        sortable,
        autosearch,
        mandatory)
SELECT
        TABLE_NAME,
        COLUMN_NAME AS fieldname,
        COLUMN_NAME AS fieldalias,
        CASE data_type
                WHEN 'INT' THEN 'dtInteger'
                WHEN 'DateTime' THEN 'dtDateTime'
                WHEN 'TBit' THEN 'dtBoolean'
                WHEN 'TControlField' THEN 'dtBoolean'
                WHEN 'Bit' THEN 'dtBoolean'
                WHEN 'Money' THEN 'dtCurrency'
                WHEN 'TValor' THEN 'dtCurrency'
                WHEN 'TValorNull' THEN 'dtCurrency'
                ELSE  'dtString' END AS data_type,
        'T' AS selectable,
        'T' AS searchable,
        'T' AS sortable,
        'T' AS autosearch,
        'T' AS mandatory
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'vw_Rep_AgencyAgentInvoices'
AND COLUMN_NAME IN ('Canceled' , 'CupomFiscal', 'IsFiscal'	, 'AditionalExpenses')
GO
