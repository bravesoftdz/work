if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_Invoice]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_Invoice]
GO

CREATE VIEW vw_Rep_Invoice (IDPreSale, IDInvoice, IDPreSaleParent, IDCashRegMov, IDMeioPag, IDMedia, IDTouristGroup, IDOtherComission, IDCustomer, IDStore, IDLancPagOtherCom, PreSaleDate, InvoiceDate, DeliverDate, DeliverAddress, Passport, PassportDate, Ticket, AirLine, CompanyName, CompanyCGC, DepositDate, Tax, SubTotal, Note, ItemDiscount, TaxIsent, nOpenUser, RefreshInvoice, Printed, CashReceived, EstimatedPay, CardNumber, OtherExpences, Address, TaxIsemptValue, TaxIsemptItemDiscount, Layaway, FirstName, LastName, ZIP, nOpenHoldCaixa, SaleCode, InvoiceCode, AditionalExpenses, Canceled)  AS
       SELECT I.IDPreSale, I.IDInvoice, I.IDPreSaleParent, I.CashRegMovID, I.IDMeioPag, I.MediaID, I.IDTouristGroup, I.OtherComissionID, I.IDCustomer, I.IDStore, I.IDLancPagOtherCom, I.PreSaleDate, I.InvoiceDate, I.DeliverDate, I.DeliverAddress, I.Passport, I.PassportDate, I.Ticket, I.AirLine, I.CompanyName, I.CompanyCGC, I.DepositDate, I.Tax, I.SubTotal, I.Note, I.ItemDiscount, I.TaxIsent, I.nOpenUser, I.RefreshInvoice, I.Printed, I.CashReceived, I.EstimatedPay, I.CardNumber, I.OtherExpences, I.Address, I.TaxIsemptValue, I.TaxIsemptItemDiscount, I.Layaway, I.FirstName, I.LastName, I.ZIP, I.nOpenHoldCaixa, I.SaleCode, I.InvoiceCode, I.AditionalExpenses, I.Canceled
       FROM Invoice I
GO

DELETE Rep_Field WHERE tablename = 'vw_Rep_Invoice' AND fieldname = 'IDPreSaleParent'
GO

INSERT INTO Rep_Field (tablename, fieldname, fieldalias, datatype, selectable, searchable, sortable, autosearch, mandatory)
VALUES ('vw_Rep_Invoice', 'IDPreSaleParent', 'IDPreSaleParent', 'dtInteger', 'T', 'T', 'T', 'T', 'T')
GO
