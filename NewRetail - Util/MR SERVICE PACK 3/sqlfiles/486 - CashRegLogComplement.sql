CREATE TABLE CashRegLogComplement (
	IDCashRegLog int NOT NULL,
	Obs varchar(255) NOT NULL
)
GO

ALTER TABLE CashRegLogComplement ADD CONSTRAINT
	XPKCashRegLogComplement PRIMARY KEY (IDCashRegLog)
GO

ALTER TABLE CashRegLogComplement ADD CONSTRAINT
	FK_CashRegLog_CashRegLogComplement_IDCashRegLog FOREIGN KEY (IDCashRegLog) REFERENCES CashRegLog
GO
