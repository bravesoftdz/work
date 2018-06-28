if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_Invoice]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_Invoice]
GO

CREATE VIEW vw_Rep_Invoice (IDPreSale, IDInvoice, IDCashRegMov, IDMeioPag, IDMedia, IDTouristGroup, IDOtherComission, IDCustomer, IDStore, IDLancPagOtherCom, PreSaleDate, InvoiceDate, DeliverDate, DeliverAddress, Passport, PassportDate, Ticket, AirLine, CompanyName, CompanyCGC, DepositDate, Tax, SubTotal, Note, ItemDiscount, TaxIsent, nOpenUser, RefreshInvoice, Printed, CashReceived, EstimatedPay, CardNumber, OtherExpences, Address, TaxIsemptValue, TaxIsemptItemDiscount, Layaway, FirstName, LastName, ZIP, nOpenHoldCaixa, SaleCode, InvoiceCode, AditionalExpenses, Canceled)  AS
       SELECT I.IDPreSale, I.IDInvoice, I.CashRegMovID, I.IDMeioPag, I.MediaID, I.IDTouristGroup, I.OtherComissionID, I.IDCustomer, I.IDStore, I.IDLancPagOtherCom, I.PreSaleDate, I.InvoiceDate, I.DeliverDate, I.DeliverAddress, I.Passport, I.PassportDate, I.Ticket, I.AirLine, I.CompanyName, I.CompanyCGC, I.DepositDate, I.Tax, I.SubTotal, I.Note, I.ItemDiscount, I.TaxIsent, I.nOpenUser, I.RefreshInvoice, I.Printed, I.CashReceived, I.EstimatedPay, I.CardNumber, I.OtherExpences, I.Address, I.TaxIsemptValue, I.TaxIsemptItemDiscount, I.Layaway, I.FirstName, I.LastName, I.ZIP, I.nOpenHoldCaixa, I.SaleCode, I.InvoiceCode, I.AditionalExpenses, I.Canceled
       FROM Invoice I
GO

Insert into Rep_Field (TableName, FieldName, FieldAlias, Selectable, Searchable, Sortable, DataType, AutoSearch, Mandatory) 
Values ('vw_Rep_Invoice', 'SaleCode', 'SaleCode', 'T', 'T', 'T', 'dtString', 'F', 'F')
GO

Insert into Rep_Field (TableName, FieldName, FieldAlias, Selectable, Searchable, Sortable, DataType, AutoSearch, Mandatory) 
Values ('vw_Rep_Invoice', 'InvoiceCode', 'InvoiceCode', 'T', 'T', 'T', 'dtString', 'F', 'F')
GO

Insert into Rep_Field (TableName, FieldName, FieldAlias, Selectable, Searchable, Sortable, DataType, AutoSearch, Mandatory) 
Values ('vw_Rep_Invoice', 'AditionalExpenses', 'AditionalExpenses', 'T', 'T', 'T', 'dtCurrency', 'F', 'F')
GO

Insert into Rep_Field (TableName, FieldName, FieldAlias, Selectable, Searchable, Sortable, DataType, AutoSearch, Mandatory) 
Values ('vw_Rep_Invoice', 'Canceled', 'Canceled', 'T', 'T', 'T', 'dtBoolean', 'F', 'F')
GO
