if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vwCommission]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vwCommission]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vwSaleItem]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vwSaleItem]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_InventoryMov]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_InventoryMov]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_SalesBySalesPerson]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_SalesBySalesPerson]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_SalesPersonCommission]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_SalesPersonCommission]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_SalesPersonResult]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_SalesPersonResult]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_CommissionDetails]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_CommissionDetails]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vwInvoiceComission]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vwInvoiceComission]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vwSplit_ListItems]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vwSplit_ListItems]
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
	I.AvgCost
FROM 
	InventoryMov I
	JOIN SaleItemCommission SIC ON (SIC.IDInventoryMov = I.IDInventoryMov)
GO

CREATE VIEW vwInvoiceComission AS
SELECT 
	Invoice.IDInvoice,
	TouristGroup.IDTouristGroup,
	SUM( InvMov.CostPrice * InvMov.Qty) AS Cost,
	SUM(( InvMov.SalePrice * InvMov.Qty) - InvMov.Discount) AS Sales,
	SUM((( (IsNull(InvMov.SalePrice, 0) - (TipoCom.ComissionOnProfit*IsNull(InvMov.CostPrice, 0))) * InvMov.Qty) - InvMov.Discount) * ( Comission / ((100 / SIC.CommissionPercent) * 100) )) AS ComisGuide, 
	SUM(((( (IsNull(InvMov.SalePrice, 0) - (TipoCom.ComissionOnProfit*IsNull(InvMov.CostPrice, 0))) * InvMov.Qty) - InvMov.Discount) * ( Comission / ((100 / SIC.CommissionPercent) * 100) )) * (TouristGroup.ComissaoSobreGuia / 100 )) AS ComisAgency
FROM 
	Invoice
	JOIN TouristGroup ON ( Invoice.IDTouristGroup = TouristGroup.IDTouristGroup )
	JOIN InventoryMov InvMov ON ( InvMov.DocumentID = Invoice.IDInvoice )
	JOIN vwComissionado Comi ON ( Comi.IDComissionado = TouristGroup.IDGuide )
	JOIN GroupToComissionType GTC ON ( Comi.IDTipoComissionado = GTC.IDTipoComissionado ) 
	JOIN Model ON ( GTC.GroupID = Model.GroupID ) 
	JOIN vwTipoComissionado TipoCom ON ( TipoCom.IDTipoComissionado = Comi.IDTipoComissionado )
	LEFT JOIN SaleItemCommission SIC ON (InvMov.IDInventoryMov = SIC.IDInventoryMov)
WHERE  
	( Invoice.IDInvoice IS NOT NULL )
     	AND
	( InvMov.InventMovTypeID = 1 )
     	AND
     	( InvMov.ModelID = Model.IDModel )
GROUP BY
	Invoice.IDInvoice, 
	TouristGroup.IDTouristGroup
GO

CREATE  VIEW dbo.vw_Rep_CommissionDetails AS

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
	I.LastName as CustomerLastName,
	I.FirstName as CustomerFirstName,
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
	ROUND(((((IMV.SalePrice - (IMV.CostPrice * ET.CommissionOnProfit)) * IMV.Qty - IMV.Discount)) * ( GCT.Commission / ((100 / SIC.CommissionPercent) * 100) )),2) * ME.PayComission as Commission,
	SIC.IDCommission as IDCommission,
	ET.IDPersonType,
	ET.PersonType,
	IMV.IDUser,
	SIC.CommissionPercent as CommissionPercent
FROM	
	vw_Rep_Invoice I 
	JOIN vw_Rep_Media ME ON (ME.IDMedia = I.IDMedia)
	JOIN vw_Rep_InventoryMov IMV ON (I.IDInvoice = IMV.IDDocument)
	LEFT JOIN SaleItemCommission SIC ON (IMV.IDInventoryMov = SIC.IDInventoryMov)
	JOIN vw_Rep_Entity COM ON (COM.IDPerson = SIC.IDCommission)
	JOIn vw_Rep_EntityType ET ON (ET.IDPersonType = COM.IDPersonType)
	JOIN vw_Rep_Store S ON (S.IDStore = IMV.IDStore)
	JOIN vw_Rep_Model M ON (IMV.IDModel = M.IDModel)
	JOIN vw_Rep_Category C ON (M.GroupID = C.IDCategory)
	JOIN vw_Rep_GroupToCommissionType GCT ON (GCT.IDPersonType = COM.IDPersonType AND GCT.IDGroup = M.GroupID)
	LEFT OUTER JOIN vw_Rep_InvColor INVC ON (M.IDColor = INVC.IDColor)
	LEFT OUTER JOIN vw_Rep_InvSize INVS ON (INVS.IDSize = M.IDSize)
WHERE
	IMV.IDInventMovType = 1
GROUP BY
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
	I.LastName,
	I.FirstName,
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
	SIC.IDCommission AS ComissionID, 
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
	((((IM.SalePrice - (IM.CostPrice * TP.ComissionOnProfit)) * IM.Qty - IM.Discount)) * (GTCT.Comission / ((100 / SIC.CommissionPercent) * 100) )) as MovCommission, 
	PreInventoryMovID as IDPreInventoryMov, 
	IM.DesiredMarkup
FROM 
	TipoPessoa TP
	JOIN GroupToComissionType GTCT ON (TP.IDTipoPessoa = GTCT.IDTipoComissionado)
	JOIN Model M ON (M.GroupID = GTCT.GroupID)
	JOIN InventoryMov IM ON (IM.ModelID = M.IDModel)
	LEFT JOIN SaleItemCommission SIC ON (IM.IDInventoryMov = SIC.IDInventoryMov)
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
	SIC.IDCommission AS ComissionID,
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
	(IM.CostPrice * IM.Qty) as ItemCostTotal,
	((IM.SalePrice * IM.Qty) - IM.Discount) as ItemSaleTotal,
	((((IM.SalePrice - (IM.CostPrice * TP.ComissionOnProfit)) * IM.Qty - IM.Discount)) * (GTCT.Comission / ((100 / SIC.CommissionPercent) * 100))) as ItemCommis,
	IM.DesiredMarkup,
	I.IDPreSale,
	SX.Tax,
	(((IM.SalePrice * IM.Qty) - IM.Discount) * SX.Tax) as TaxValue,
	(((IM.SalePrice * IM.Qty) - IM.Discount) - (IM.CostPrice * IM.Qty) - (((IM.SalePrice * IM.Qty) - IM.Discount) * SX.Tax)) as ItemNetValue
FROM
	InventoryMov IM
	JOIN Model M ON (IM.ModelID = M.IDModel)
	JOIN GroupToComissionType GTCT ON (M.GroupID = GTCT.GroupID)
	JOIN TipoPessoa TP ON (TP.IDTipoPessoa = GTCT.IDTipoComissionado)
	JOIN Invoice I ON (IM.DocumentID = I.IDInvoice AND IM.InventMovTypeID = 1)
	JOIN vwSaleItemTax SX ON (IM.IDInventoryMov = SX.IDMov AND SX.IsInvoice = 1) 
	LEFT JOIN SaleItemCommission SIC ON (SIC.IDInventoryMov = IM.IDInventoryMov)

UNION ALL
 
SELECT
	0 as Invoice,
	PIM.IDPreInventoryMov,
	PIM.InventMovTypeID,
	PIM.DocumentID,
	PIM.StoreID,
	PIM.Qty,
	PIM.CostPrice,
	PIM.SalePrice,
	PIM.Discount,
	SIC.IDCommission AS ComissionID,
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
	(PIM.CostPrice * PIM.Qty) as ItemCostTotal,
	((PIM.SalePrice * PIM.Qty) - PIM.Discount) as ItemSaleTotal,
	((((PIM.SalePrice - (PIM.CostPrice * TP.ComissionOnProfit)) * PIM.Qty - PIM.Discount)) * (GTCT.Comission / ((100 / SIC.CommissionPercent) * 100))) as ItemCommis,
	PIM.DesiredMarkup,
	I.IDPreSale,
	SX.Tax,
	(((PIM.SalePrice * PIM.Qty) - PIM.Discount) * SX.Tax) as TaxValue,
	(((PIM.SalePrice * PIM.Qty) - PIM.Discount) - (PIM.CostPrice * PIM.Qty) - ((PIM.SalePrice * PIM.Qty) - PIM.Discount) * SX.Tax) as ItemNetValue
FROM
	PreInventoryMov PIM
	JOIN Model M ON (PIM.ModelID = M.IDModel)
	JOIN GroupToComissionType GTCT ON (M.GroupID = GTCT.GroupID)
	JOIN TipoPessoa TP ON (TP.IDTipoPessoa = GTCT.IDTipoComissionado)
	JOIN Invoice I ON (PIM.DocumentID = I.IDPreSale AND PIM.InventMovTypeID = 1)
	JOIN vwSaleItemTax SX ON (PIM.IDPreInventoryMov = SX.IDMov AND SX.IsInvoice = 0) 
	LEFT JOIN SaleItemCommission SIC ON (SIC.IDPreInventoryMov = PIM.IDPreInventoryMov)
GO

CREATE VIEW vw_Rep_SalesBySalesPerson AS
SELECT 
	SIC.IDComMission AS ComissionID,
	Pessoa.Pessoa,
	InventoryMov.MovDate,
	Model.Model,
	Model.Description,
	Model.SellingPrice,
	InventoryMov.Qty, 
	((SalePrice - Discount) / Qty) AS SalePrice, 
	InventoryMov.CostPrice AS CostPrice,
	(InventoryMov.Discount) AS Discount, 
	((InventoryMov.Discount / Qty)) AS TotalDiscount,	
	((((InventoryMov.SalePrice - (InventoryMov.CostPrice * TipoPessoa.ComissionOnProfit)) * InventoryMov.Qty - InventoryMov.Discount)) * (Comission / ((100 / SIC.CommissionPercent) * 100)))  * Media.PayComission AS Comissao
FROM 
	Model
	JOIN InventoryMov ON (Model.IDModel = InventoryMov.ModelID)
	LEFT JOIN SaleItemCommission SIC ON (InventoryMov.IDInventoryMov = SIC.IDInventoryMov)
	JOIN GroupToComissionType ON (GroupToComissionType.GroupID = Model.GroupID)
	JOIN Pessoa ON (SIC.IDCommission = Pessoa.IDPessoa) AND (Pessoa.IDTipoPessoa = GroupToComissionType.IDTipoComissionado)
	JOIN TipoPessoa ON (Pessoa.IDTipoPessoa = TipoPessoa.IDTipoPessoa)
	JOIN Invoice ON (InventoryMov.DocumentID = Invoice.IDInvoice)
	JOIN Media ON (Invoice.MediaID = Media.IDMedia)
WHERE
	(InventoryMov.InventMovTypeID = 1)
	AND
	(InventoryMov.Discount <> 0)
GO

CREATE VIEW vw_Rep_SalesPersonCommission AS
SELECT
	TourGrp.TipTouristGroup,
	Invo.IDInvoice, 
	Invo.InvoiceDate,
	Invo.Tax,
	Media.Media,
	Model.Model,
	Model.Description,
	InvMov.Qty,
	Pes.Pessoa AS Customer,
	Invo.SubTotal - Invo.ItemDiscount AS InvoiceTotal,
	InvMov.CostPrice * InvMov.Qty AS ItemCost,
	InvMov.SalePrice * InvMov.Qty - InvMov.Discount AS ItemValue,
	InvMov.SalePrice * InvMov.Qty - InvMov.Discount - InvMov.CostPrice * InvMov.Qty AS ItemProfit,
	((InvMov.SalePrice - InvMov.CostPrice * TipoPes.ComissionOnProfit) * InvMov.Qty - InvMov.Discount) * GrpComisType.Comission / ((100 / SIC.CommissionPercent) * 100) * Media.PayComission  AS Commission,
	 SalesPerson.Pessoa AS SalesPerson,
	Invo.IDStore AS IDStore,
	TG.Path AS Category
FROM
	Invoice Invo
	LEFT JOIN TouristGroup TourGrp ON (Invo.IDTouristGroup = TourGrp.IDTouristGroup )
	JOIN InventoryMov InvMov ON (InvMov.DocumentID = Invo.IDInvoice)
	JOIN Model ON (InvMov.ModelID = Model.IDModel)
	JOIN TabGroup TG ON (Model.GroupID = TG.IDGroup)
	JOIN Media ON (Invo.MediaID = Media.IDMedia)
	JOIN Pessoa Pes ON (Invo.IDCustomer = Pes.IDPessoa)
	LEFT JOIN SaleItemCommission SIC ON (InvMov.IDInventoryMov = SIC.IDInventoryMov)
	JOIN GroupToComissionType GrpComisType ON (GrpComisType.GroupID = Model.GroupID )
	JOIN Pessoa SalesPerson ON (SIC.IDCommission = SalesPerson.IDPessoa) AND (SalesPerson.IDTipoPessoa = GrpComisType.IDTipoComissionado)
	JOIN TipoPessoa TipoPes ON (SalesPerson.IDTipoPessoa = TipoPes.IDTipoPessoa)
WHERE
	InvMov.InventMovTypeID = 1
GO

CREATE VIEW vw_Rep_SalesPersonResult AS
SELECT
	Pes.Pessoa AS SalesPerson,
	TpPes.TipoPessoa AS SalesPersonType,
	SUM(InvMov.SalePrice * InvMov.Qty - InvMov.Discount) AS SumSales,
	SUM(InvMov.CostPrice * InvMov.Qty) AS SumCost,
	SUM((InvMov.SalePrice - InvMov.CostPrice) * InvMov.Qty - InvMov.Discount) AS SumProfit,
	SUM(((ISNULL(InvMov.SalePrice, 0) - ISNULL(InvMov.CostPrice, 0) * ISNULL(TpPes.ComissionOnProfit, 1)) * 
               ISNULL(InvMov.Qty, 0) - ISNULL(InvMov.Discount, 0)) * ISNULL(GTC.Comission, 0) / ((100 / SIC.CommissionPercent) * 100) * ISNULL(Media.PayComission, 1)) AS SumCommission,
	Inv.IDStore AS IDStore,
	TG.Path AS Category,
	Media.Media,
	Inv.InvoiceDate
FROM
	InventoryMov InvMov
	JOIN Invoice Inv ON (InvMov.DocumentID = Inv.IDInvoice )
	JOIN Model Mod ON (InvMov.ModelID = Mod.IDModel )
	JOIN TabGroup TG ON (Mod.GroupID = TG.IDGroup )
	LEFT JOIN SaleItemCommission SIC ON (InvMov.IDInventoryMov = SIC.IDInventoryMov)
	JOIN GroupToComissionType GTC ON (Mod.GroupID = GTC.GroupID )
	JOIN Pessoa Pes ON (SIC.IDCommission = Pes.IDPessoa )
	JOIN TipoPessoa TpPes ON (Pes.IDTipoPessoa = TpPes.IDTipoPessoa ) AND (Pes.IDTipoPessoa = GTC.IDTipoComissionado)
	JOIN Media ON (Inv.MediaID = Media.IDMedia)
WHERE
	InvMov.InventMovTypeID = 1
GROUP BY 
	Pes.Pessoa, 
	TpPes.TipoPessoa, 
	Inv.IDStore, 
	Media.Media, 
	TG.Path, 
	Inv.InvoiceDate
GO

CREATE VIEW vwSplit_ListItems AS
SELECT
	PIM.IDPreInventoryMov,
	PIM.DocumentID, 
	PIM.Marked,
	M.Model,
	M.Description,
	C.Comissionado AS SalesPerson,
	PIM.MovDate,
	PIM.Discount,
	(PIM.Qty - IsNull(PIM.QtyExchanged,0)) as Qty, 
	(PIM.SalePrice - PIM.Discount) * PIM.Qty AS Total, 
	PIM.QtyRealMov,
	M.IDModel,
	IsNull(M.NotVerifyQty,0) as NotVerifyQty
FROM         
	PreInventoryMov PIM
	INNER JOIN Model M ON (PIM.ModelID = M.IDModel)
	LEFT JOIN SaleItemCommission SIC ON (SIC.IDPreInventoryMov = PIM.IDPreInventoryMov )
	INNER JOIN vwComissionado C ON (SIC.IDCommission = C.IDComissionado)
WHERE   
	(PIM.InventMovTypeID IN (1,25) --Sale and Canceled
	AND
	PIM.IDParentPack Is Null)
GO
