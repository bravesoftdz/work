CREATE TABLE Inv_ModelStoreBalance (
	IDStore int NOT NULL,
	IDModel int NOT NULL,
	BalanceDate datetime NOT NULL,
	Qty float NOT NULL,
	AvgCostOut money NOT NULL,
	BalanceTotal money NOT NULL
)
GO

ALTER TABLE Inv_ModelStoreBalance ADD CONSTRAINT
	XPKInv_ModelStoreBalance PRIMARY KEY (IDStore, IDModel, BalanceDate)
GO

ALTER TABLE Inv_ModelStoreBalance ADD CONSTRAINT
	FK_Store_InvModelStoreBalance_IDStore FOREIGN KEY (IDStore) REFERENCES Store
GO

ALTER TABLE Inv_ModelStoreBalance ADD CONSTRAINT
	FK_Model_InvModelStoreBalance_IDModel FOREIGN KEY (IDModel) REFERENCES Model
GO
