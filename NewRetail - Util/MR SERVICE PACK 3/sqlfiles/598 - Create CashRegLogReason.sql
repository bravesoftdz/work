CREATE TABLE CashRegLogReason (
	IDCashRegLogReason int NOT NULL,
	Reason varchar(30) NOT NULL,
	System bit CONSTRAINT DF_Zero_CashRegLogReason_System DEFAULT 0,
	Hidden bit CONSTRAINT DF_Zero_CashRegLogReason_Hidden DEFAULT 0,
	Desativado bit CONSTRAINT DF_Zero_CashRegLogReason_Desativado DEFAULT 0
)
GO

ALTER TABLE CashRegLogReason ADD CONSTRAINT
	XPKCashRegLogReason PRIMARY KEY (IDCashRegLogReason)
GO

ALTER TABLE CashRegLogComplement ADD
	IDCashRegLogReason int NULL
GO

ALTER TABLE CashRegLogComplement ADD CONSTRAINT
	FK_CashRegLogComplement_CashRegLogReason_IDCashRegLogReason FOREIGN KEY (IDCashRegLogReason) REFERENCES CashRegLogReason
GO
