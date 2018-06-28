ALTER TABLE TabGroup
	ADD PuppyTracker bit NULL
		CONSTRAINT DF_Zero1353 DEFAULT 0
GO

ALTER TABLE TabGroup
	ADD RequestCustomer bit NULL
		CONSTRAINT DF_Zero1354 DEFAULT 0
GO

UPDATE TabGroup SET PuppyTracker = 0, RequestCustomer = 0
GO

ALTER TABLE Invoice
	ADD PuppyTracker bit NULL
GO

ALTER TABLE Model
	ADD CaseQty Float NULL
GO
