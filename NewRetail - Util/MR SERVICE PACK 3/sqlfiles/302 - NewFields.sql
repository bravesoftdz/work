ALTER TABLE Invoice
	ADD NumeroSeriePrinter varchar(20)
GO

ALTER TABLE TaxCategory
	ADD SituacaoTributaria int
GO

UPDATE TaxCategory
SET SituacaoTributaria = 0
WHERE OperationType = 1 AND SaleTaxType = 2
GO
