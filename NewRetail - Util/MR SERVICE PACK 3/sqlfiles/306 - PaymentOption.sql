ALTER TABLE MeioPag
	ADD UsePaymentProcessor  Boolean
GO

ALTER TABLE MeioPag
	ADD Processor int NULL
GO

ALTER TABLE MeioPag
	ADD MercantNumber varchar(40) NULL
GO

UPDATE MeioPag SET UsePaymentProcessor = 0
WHERE Tipo = 2
GO
