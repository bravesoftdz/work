if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_OpenLayawayHold]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_OpenLayawayHold]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_SalesProfit]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_SalesProfit]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_InvoiceDate]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_InvoiceDate]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_MarketingCustomerPurchaseHist]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_MarketingCustomerPurchaseHist]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_CustomerPurchaseHistory_Sub]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_CustomerPurchaseHistory_Sub]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_Entity]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_Entity]
GO

CREATE VIEW vw_Rep_Entity (IDPerson, IDAgency, IDAgenty, IDCustomer, IDVendor, IDCommission, IDManufactore,  IDPersonType, IDStore, IDState, IDUser, IDCountry, Code, FullName, FirstName, LastName, DBA, Address, City, Zip, Phone, Cellular, Fax, Beeper, Contact, Email, Limit, BirthDate, PaymentDay, BirthState, SocialSecurity, FederalID, SalesTax, HomePage, DriveLicense, GuideCommission, CoordDiscount, CommissAjust, CustomerCard)  AS
       SELECT P.IDPessoa, P.IDPessoa, P.IDPessoa, P.IDPessoa, P.IDPessoa, P.IDPessoa, P.IDPessoa, P.IDTipoPessoa, P.IDStore, P.IDEstado, P.IDUser, P.IDPais, P.Code, P.Pessoa, P.PessoaFirstName, P.PessoaLastName, P.NomeJuridico, P.Endereco, P.Cidade, P.CEP, P.Telefone, P.Cellular, P.Fax, P.Beeper, P.Contatos, P.Email, P.Limite, P.Nascimento, P.DiaQuitacao, P.CPF, P.CartTrabalho, P.InscEstadual, P.InscMunicipal, P.HomePage, P.OrgaoEmissor, P.ComissaoSobreGuia, P.DescontaCoordenacao, P.AjusteComiss, P.CustomerCard
       FROM Pessoa P
GO

CREATE VIEW dbo.vw_Rep_OpenLayawayHold
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
	AGT.FullName as Agent
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
GROUP BY
	vw_Rep_InventoryMov.IDStore,
	CONVERT(varchar(10), vw_Rep_InventoryMov.MovDate, 101), 
	DatePart(year, vw_Rep_InventoryMov.MovDate),
	Convert(Varchar(10),DateName(month, vw_Rep_InventoryMov.MovDate)),
	DatePart(month, vw_Rep_InventoryMov.MovDate),
	DatePart(day, vw_Rep_InventoryMov.MovDate)

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
	AGT.FullName as Agent
	

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

CREATE VIEW dbo.vw_Rep_MarketingCustomerPurchaseHist
AS
/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO
		- View criada para dar suporte à relatório

	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
 	08 Jan 2004		Marcello Felipelli	Criação;
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */


/*vw_Rep_MarketingCustomerPurchaseHist*/

SELECT
	PU.IDPurchase,
	PU.DatePreReceiving,
	PU.DateFinalReceiving,
	PU.Freight,
	PU.OtherCharges,
	PU.DocumentType,
	PU.DocumentNumber,
	PU.DocumentDate,
	PU.DocumentDueDate,
	PU.DocumentTotal,
	PU.IDFornecedor as IDVendor,
	PU.IDStore as IDStore,
	(PT.SubTotal + PU.OtherCharges + PU.Freight )  as Total,
	PT.SubTotal,
	V.FullName as Vendor,
	V.Address as VendorAddress,
	V.City as VendorCity,
	V.Zip as VendorZip,
	V.Phone as VendorPhone,
	V.Fax as VendorFax,
	V.Contact as VendorContact,
	V.Email as VendorEmail,
	V.HomePage as VendorHomePage,
	S.Store,
	S.Telephone as StorePhone,
	S.Fax as StoreFax,
	S.Contact as StoreContact,
	SUP.SystemUser as ReceivedBy,
	SUF.SystemUser as FinalRecBy,
	PUI.Barcode,
	PUI.Qty,
	PUI.NewCostPrice,
	PUI.NewSalePrice,
	PUI.NewSuggRetail,
	(PUI.Qty * PUI.NewCostPrice) as ExtNewCostPrice,
	(PUI.Qty * PUI.NewSalePrice) as ExtNewSalePrice,
	(PUI.Qty * PUI.NewSuggRetail) as ExtNewSuggRetail,
	M.Model,
	M.Description,
	M.IDFabricante as IDManufacture,
	C.Category,
	MAN.FullName as Manufacture
FROM
	Pur_Purchase PU
	JOIN vw_Rep_Entity V ON (PU.IDFornecedor = V.IDPerson)
	JOIN vw_Rep_Store S ON (S.IDStore = PU.IDStore)
	LEFT OUTER JOIN vw_Rep_SystemUser SUP ON ( PU.IDUserPreReceiving = SUP.IDUser )
	LEFT OUTER JOIN vw_Rep_SystemUser SUF ON ( PU.IDUserFinalReceiving = SUF.IDUser )
	LEFT OUTER JOIN Pur_PurchaseTotal PT ON (PU.IDPurchase = PT.IDPurchase)
	JOIN Pur_PurchaseItem PUI ON (PU.IDPurchase = PUI.IDPurchase)
	JOIN vw_Rep_Model M ON (M.IDModel = PUI.IDModel)
	LEFT OUTER JOIN vw_Rep_Entity MAN ON (MAN.IDPerson = M.IDFabricante)
	JOIN vw_Rep_Category C ON (M.GroupID = C.IDCategory)

GO

CREATE VIEW vw_Rep_CustomerPurchaseHistory_Sub AS
SELECT vw_Rep_InventoryMov.MovDate, 
       vw_Rep_InventoryMov.IDDocument, 
       vw_Rep_InventoryMov.Qty, 
       vw_Rep_Invoice.LastName, 
       vw_Rep_Invoice.FirstName, 
       vw_Rep_Invoice.ZIP, 
       vw_Rep_Invoice.InvoiceDate, 
       vw_Rep_Model.Model, 
       vw_Rep_Model.Description, 
       vw_Rep_Model.FreightCost, 
       vw_Rep_Model.OtherCost, 
       vw_Rep_Model.VendorCost, 
       vw_Rep_Model.DateLastCost, 
       vw_Rep_Model.MarkUp, 
       vw_Rep_Model.SellingPrice, 
       vw_Rep_Model.DateLastSellingPrice, 
       vw_Rep_Model.SuggRetail, 
       vw_Rep_Model.TotQtyOnHand, 
       vw_Rep_Model.LastMovDate, 
       vw_Rep_Model.AvgCost, 
       vw_Rep_Model.FinalCost, 
       vw_Rep_Media.Media, vw_Rep_Store.Store, 
       vw_Rep_Entity.IDCustomer, 
       vw_Rep_Entity.FullName, 
       vw_Rep_Entity.Address, vw_Rep_Entity.City, 
       vw_Rep_Entity.IDState, 
       vw_Rep_Entity.Zip Zip_2, 
       vw_Rep_Entity.Phone, vw_Rep_Entity.Fax, 
       vw_Rep_Entity.Email,
       vw_Rep_Model.IDFabricante
FROM vw_Rep_InventoryMov vw_Rep_InventoryMov
      INNER JOIN vw_Rep_Store vw_Rep_Store ON 
     (vw_Rep_Store.IDStore = vw_Rep_InventoryMov.IDStore)
      INNER JOIN vw_Rep_Model vw_Rep_Model ON 
     (vw_Rep_Model.IDModel = vw_Rep_InventoryMov.IDModel)
      INNER JOIN vw_Rep_Invoice vw_Rep_Invoice ON 
     (vw_Rep_Invoice.IDInvoice = vw_Rep_InventoryMov.IDDocument)
      INNER JOIN vw_Rep_Media vw_Rep_Media ON 
     (vw_Rep_Media.IDMedia = vw_Rep_Invoice.IDMedia)
      INNER JOIN vw_Rep_Entity vw_Rep_Entity ON 
     (vw_Rep_Entity.IDCustomer = vw_Rep_Invoice.IDCustomer)
WHERE ( vw_Rep_InventoryMov.IDInventMovType = 1 )
       AND ( vw_Rep_Model.IDFabricante IS NOT NULL  )
       AND ( vw_Rep_Invoice.IDCustomer <> 1 )

GO
