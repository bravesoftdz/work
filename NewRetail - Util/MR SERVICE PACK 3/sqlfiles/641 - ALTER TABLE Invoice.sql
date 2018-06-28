ALTER TABLE Invoice ADD
	InvoiceDiscount money NULL DEFAULT 0
GO

UPDATE
	Invoice
SET
	InvoiceDiscount = 0
GO
