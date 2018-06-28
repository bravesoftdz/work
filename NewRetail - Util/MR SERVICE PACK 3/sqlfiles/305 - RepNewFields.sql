if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_InventoryMov]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_InventoryMov]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_InvoiceDate]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_InvoiceDate]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_Invoice]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_Invoice]
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
	I.Canceled,
	I.CupomFiscal,
	(CASE IsNull(I.CupomFiscal,0) WHEN 0 THEN 0 ELSE 1 END) AS IsFiscal
FROM 
	Invoice I
GO

CREATE VIEW vw_Rep_InventoryMov  AS
SELECT 
	I.IDInventoryMov, 
	I.InventMovTypeID as IDInventMovType, 
	I.DocumentID as IDDocument, 
	I.IDPessoa, 
	I.ModelID as IDModel, 
	I.StoreID as IDStore, 
	I.ComissionID as IDComission, 
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
	I.AvgCost
FROM 
	InventoryMov I
GO

CREATE VIEW dbo.vw_Rep_InvoiceDate
AS
/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO
		- View criada para dar suporte à relatório

	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
 	08 Jan 2004		Marcello Felipelli	Criação;
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

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
	I.IDPreSaleParent
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

DELETE FROM Rep_Field WHERE TableName = 'vw_Rep_InventoryMov' AND FieldName = 'AvgCost'
GO

DELETE FROM Rep_Field WHERE TableName = 'vw_Rep_Invoice' AND FieldName IN ('IDDeliverType', 'IDSpecialPrice')
GO

DELETE FROM Rep_Field WHERE TableName = 'vw_Rep_InvoiceDate' AND FieldName IN 
('ItemAvgCost', 'ExtAvgCost', 'IDCashRegMov', 'IDSpecialPrice',
'IDTouristGroup','IDDeliverType','IDMedia','IDCustomer','IDStore','IDOtherComission',
'IDPreSaleParent')
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
WHERE TABLE_NAME = 'vw_Rep_InventoryMov'
AND COLUMN_NAME IN ('AvgCost')
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
WHERE TABLE_NAME = 'vw_Rep_Invoice'
AND COLUMN_NAME IN ('IDDeliverType', 'IDSpecialPrice')
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
AND COLUMN_NAME IN ('ItemAvgCost', 'ExtAvgCost', 'IDCashRegMov', 'IDSpecialPrice',
'IDTouristGroup','IDDeliverType','IDMedia','IDCustomer','IDStore','IDOtherComission',
'IDPreSaleParent')
GO

UPDATE Rep_Field SET DataModule = 'DM', DataSet = 'quLookUpStore', ListField = 'Name'
where FieldName = 'IDStore'
GO

UPDATE Rep_Field SET DataModule = 'DM', DataSet = 'quLookUpCustomer', ListField = 'Pessoa'
where FieldName = 'IDCustomer'
GO

UPDATE Rep_Field SET DataModule = 'DM', DataSet = 'quLookUpMedia', ListField = 'Media'
where FieldName = 'IDMedia'
GO

UPDATE Rep_Field SET DataModule = 'DM', DataSet = 'quLookUpCashReg', ListField = 'Name'
where FieldName = 'IDCashRegMov'
GO
