CREATE TABLE Inv_ModelBalance (
	IDModel int NOT NULL,
	BalanceDate datetime NOT NULL,
	Qty float NOT NULL,
	AvgCostOut money NOT NULL,
	BalanceTotal money NOT NULL
)
GO

ALTER TABLE Inv_ModelBalance ADD CONSTRAINT
	XPKInv_ModelBalance PRIMARY KEY (IDModel, BalanceDate)
GO

ALTER TABLE Inv_ModelBalance ADD CONSTRAINT
	R_236 FOREIGN KEY (IDModel) REFERENCES Model
GO
