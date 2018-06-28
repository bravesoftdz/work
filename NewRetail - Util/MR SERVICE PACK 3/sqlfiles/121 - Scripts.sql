ALTER TABLE DeliverType ADD MaxDeliverDelay int NOT NULL DEFAULT 0
GO

ALTER TABLE INVOICE ADD SaleCode varchar(20) NULL
GO

ALTER TABLE Invoice ADD InvoiceCode varchar(20) NULL
GO

UPDATE Invoice SET InvoiceCode = IDInvoice
GO

UPDATE Invoice SET SaleCode = IDPreSale
GO
