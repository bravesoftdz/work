if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vwInvoiceParents]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vwInvoiceParents]
GO

CREATE VIEW vwInvoiceParents AS
SELECT
	ISNULL(IP.IDPreSale, I.IDPreSale) AS InvoicePreSale,
	I.IDPreSale DocumentID,
	CASE WHEN I.IDInvoice IS NULL THEN 0 ELSE 1 END AS IsInvoice,
	I.PreSaleDate,
	I.IDInvoice,
	I.SaleCode,
	I.InvoiceCode,
	I.FirstName,
	I.LastName,
	I.InvoiceDate,
	I.MediaID,
	I.CashRegMovID, 
	I.SpecialPriceID,
	I.IDMeioPag,
	I.IDTouristGroup,
	I.DeliverTypeID,
	I.IDCustomer,
	I.IDStore,
	I.OtherComissionID,
	I.IDLancPagOtherCom,
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
	I.EstimatedPay,
	I.CardNumber,
	I.OtherExpences,
	I.Address,
	I.TaxIsemptValue,
	I.TaxIsemptItemDiscount,
	I.Layaway,
	I.ZIP,
	I.PrintNotes,
	I.DeliverOBS,
	I.DeliverConfirmation,
	I.IDFormOfPayment, 
	I.AditionalExpenses,
	I.Canceled
FROM 
	Invoice I LEFT JOIN Invoice IP ON (I.IDPreSaleParent = IP.IDPreSale)
WHERE
	IP.IDPreSaleParent IS NULL

GO
