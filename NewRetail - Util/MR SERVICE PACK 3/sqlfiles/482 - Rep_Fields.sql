if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_OpenLayawayHold]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_OpenLayawayHold]
GO

CREATE  VIEW dbo.vw_Rep_OpenLayawayHold AS
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
	I.SaleCode,
	I.AditionalExpenses,
	I.SubTotal as InvoiceSubTotal,
	I.ItemDiscount as InvoiceDiscount,
 	(I.SubTotal - I.ItemDiscount + I.Tax + I.AditionalExpenses) as InvoiceGrandTotal,
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

DELETE FROM Rep_Field WHERE TableName = 'vw_Rep_OpenLayawayHold' and FieldName IN 
('AditionalExpenses', 'SaleCode', 'InvoiceSubTotal', 'InvoiceDiscount', 'InvoiceGrandTotal')
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
AND COLUMN_NAME IN ('AditionalExpenses', 'SaleCode', 'InvoiceSubTotal', 'InvoiceDiscount', 'InvoiceGrandTotal')
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_AgedInventory]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_AgedInventory]
GO

CREATE VIEW dbo.vw_Rep_AgedInventory
AS
/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO
		- View criada para ser utilizada no relatório Aged Inventory by Date

	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
 	08 Jan 2004		Marcello Felipelli	Criação;
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */
SELECT
	I.IDModel,
	M.Model,
	M.Description,
	(CASE WHEN I.QtyOnHand > 0 THEN (I.QtyOnHand * M.SellingPrice) ELSE 0 END) AS ExtOurPrice,
	M.SellingPrice,
	M.FreightCost,
	M.OtherCost,
	(CASE WHEN I.QtyOnHand > 0 THEN (I.QtyOnHand * M.VendorCost) ELSE 0 END) AS ExtVendorCost,
	M.VendorCost,
	M.DateLastCost,
	M.MarkUp,
	M.DateLastSellingPrice as LastSoldDate,
	M.LastCost,
	(CASE WHEN I.QtyOnHand > 0 THEN (I.QtyOnHand * M.SuggRetail) ELSE 0 END) AS ExtSuggRetail,
	M.SuggRetail,
	M.LastMovDate,
	M.AvgCost,
	(CASE WHEN I.QtyOnHand > 0 THEN (I.QtyOnHand * M.FinalCost) ELSE 0 END) AS ExtFinalCost,
	M.FinalCost,
	CASE WHEN M.SellingPrice > 0 THEN M.SellingPrice - M.FinalCost END as RealMarkUpValue,
	CASE WHEN M.SellingPrice > 0 AND M.FinalCost <> 0 THEN ROUND(( (M.SellingPrice-M.FinalCost)/M.FinalCost * 100),2) END as RealMarkUpPercent,
	TG.Category,
	(CASE WHEN I.QtyOnHand > 0 THEN IsNull(I.QtyOnHand,0) ELSE 0 END) as PostiveQtyOnHand,
	IsNull(F.FullName,'Not Defined') as Manufacture,
	DATEDIFF(day, M.DateLastCost, getdate()) as Days,
	I.QtyOnHand,
	I.QtyOnPreSale,
	I.QtyOnOrder,
	I.QtyOnRepair,
	I.QtyInReceiving
FROM
	vw_Rep_Model M
	JOIN vw_Rep_Category TG ON (M.GroupID = TG.IDCategory)
	LEFT OUTER JOIN 
		(
		SELECT
			I.IDModel,
			SUM(IsNull(I.QtyOnHand,0)) as QtyOnHand,
			SUM(IsNull(I.QtyOnPreSale,0)) as QtyOnPreSale,
			SUM(IsNull(I.QtyOnOrder,0)) as QtyOnOrder,
			SUM(IsNull(I.QtyOnRepair,0)) as QtyOnRepair,
			SUM(IsNull(I.QtyOnPrePurchase,0)) as QtyInReceiving
		FROM			
			vw_Rep_Inventory I
		GROUP BY
			I.IDModel
		) I ON (M.IDModel = I.IDModel)
	LEFT OUTER JOIN vw_Rep_Entity F ON ( M.IDFabricante = F.IDPerson AND F.IDPersonType = 7 )
WHERE 
	M.Deleted = 0

GO
