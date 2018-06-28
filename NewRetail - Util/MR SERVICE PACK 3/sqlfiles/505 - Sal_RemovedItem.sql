CREATE TABLE Sal_RemovedItem (
	IDRemovedItem        int NOT NULL,
	IDCashRegister       int NOT NULL,
	IDModel              int NOT NULL,
	IDStore              int NOT NULL,
	IDDepartment         int NOT NULL,
	IDUserAuto           int NOT NULL,
	IDPessoa             int NOT NULL,
	IDUser               int NOT NULL,
	MovDate              datetime NOT NULL,
	Qty                  money NOT NULL,
	SalePrice            int NOT NULL,
	CostPrice            int NOT NULL,
	Discount             int NOT NULL,
	SaleCode             varchar(20) NULL
)
GO

ALTER TABLE Sal_RemovedItem ADD CONSTRAINT
	XPKSal_RemovedItem PRIMARY KEY (IDRemovedItem)
GO

ALTER TABLE Sal_RemovedItem ADD CONSTRAINT
	FK_SystemUser_SalRemovedItem_IDUser FOREIGN KEY (IDUser) REFERENCES SystemUser
GO

ALTER TABLE Sal_RemovedItem ADD CONSTRAINT
	FK_Pessoa_SalRemovedItem_IDCommission FOREIGN KEY (IDPessoa) REFERENCES Pessoa
GO

ALTER TABLE Sal_RemovedItem ADD CONSTRAINT
	FK_SystemUser_SalRemovedItem_IDUserAuto FOREIGN KEY (IDUserAuto) REFERENCES SystemUser
GO

ALTER TABLE Sal_RemovedItem ADD CONSTRAINT
	FK_InvDepartment_SalRemovedItem_IDDepartment FOREIGN KEY (IDDepartment) REFERENCES Inv_Department
GO

ALTER TABLE Sal_RemovedItem ADD CONSTRAINT
	FK_Store_SalRemovedItem_IDStore FOREIGN KEY (IDStore) REFERENCES Store
GO

ALTER TABLE Sal_RemovedItem ADD CONSTRAINT
	FK_Model_SalRemovedItem_IDModel FOREIGN KEY (IDModel) REFERENCES Model
GO

ALTER TABLE Sal_RemovedItem ADD CONSTRAINT
	FK_CashRegister_SalRemovedItem_IDCashRegister FOREIGN KEY (IDCashRegister) REFERENCES CashRegister
GO
