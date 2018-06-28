CREATE TABLE Inv_DescriptionPrice (
	IDDescriptionPrice int NOT NULL,
	DescriptionPrice varchar(20) NOT NULL
)
GO

ALTER TABLE Inv_DescriptionPrice ADD CONSTRAINT
	XPKInv_DescriptionPrice PRIMARY KEY (IDDescriptionPrice)
GO

CREATE TABLE Inv_ModelPrice (
	IDModel int NOT NULL,
	IDDescriptionPrice int NOT NULL,
	CostPrice money NOT NULL CONSTRAINT DF_InvModelPrice_CostPrice_Zero DEFAULT 0,
	SuggPrice money NOT NULL CONSTRAINT DF_InvModelPrice_SuggPrice_Zero DEFAULT 0,
	IDVendor int NULL,
	SalePrice money NOT NULL CONSTRAINT DF_InvModelPrice_SalePrice_Zero DEFAULT 0
)
GO

ALTER TABLE Inv_ModelPrice ADD CONSTRAINT
	XPKInv_ModelPrice PRIMARY KEY (IDModel, IDDescriptionPrice)
GO

ALTER TABLE Inv_ModelPrice ADD CONSTRAINT
	FK_Pessoa_InvModelPrice_IDVendor FOREIGN KEY (IDVendor) REFERENCES Pessoa
GO

ALTER TABLE Inv_ModelPrice ADD CONSTRAINT
	FK_InvDescriptionPrice_InvModelPrice_IDDescriptionPrice FOREIGN KEY (IDDescriptionPrice) REFERENCES Inv_DescriptionPrice
GO

ALTER TABLE Inv_ModelPrice ADD CONSTRAINT
	FK_Model_InvModelPrice_IDModel FOREIGN KEY (IDModel) REFERENCES Model
GO

CREATE TABLE Inv_StorePrice (
	IDStore int NOT NULL,
	IDModel int NOT NULL,
	IDDescriptionPrice int NOT NULL,
	IDVendor int NULL,
	CostPrice money NOT NULL CONSTRAINT DF_InvStorePrice_CostPrice_Zero DEFAULT 0,
	SuggPrice money NOT NULL CONSTRAINT DF_InvStorePrice_SuggPrice_Zero DEFAULT 0,
	SalePrice money NOT NULL CONSTRAINT DF_InvStorePrice_SalePrice_Zero DEFAULT 0
)
GO

ALTER TABLE Inv_StorePrice ADD CONSTRAINT
	XPKInv_StorePrice PRIMARY KEY (IDStore, IDModel, IDDescriptionPrice)
GO

ALTER TABLE Inv_StorePrice ADD CONSTRAINT
	FK_InvDescriptionPrice_InvStorePrice_IDDescriptionPrice FOREIGN KEY (IDDescriptionPrice) REFERENCES Inv_DescriptionPrice
GO

ALTER TABLE Inv_StorePrice ADD CONSTRAINT
	FK_Pessoa_InvStorePrice_IDVendor FOREIGN KEY (IDVendor) REFERENCES Pessoa
GO

ALTER TABLE Inv_StorePrice ADD CONSTRAINT
	FK_Model_InvStorePrice_IDModel FOREIGN KEY (IDModel) REFERENCES Model
GO

ALTER TABLE Inv_StorePrice ADD CONSTRAINT
	FK_Store_InvStorePrice_IDStore FOREIGN KEY (IDStore) REFERENCES Store
GO

CREATE TABLE Inv_MovPrice (
	IDMovPrice int NOT NULL,
	IDPreInventoryMov int NULL,
	IDInventoryMov int NULL,
	IDDescriptionPrice int NOT NULL,
	IDVendor int NULL,
	SuggPrice money NOT NULL CONSTRAINT DF_InvMovPrice_SuggPrice_Zero DEFAULT 0
)
GO

ALTER TABLE Inv_MovPrice ADD CONSTRAINT
	XPKInv_MovPrice PRIMARY KEY (IDMovPrice)
GO

ALTER TABLE Inv_MovPrice ADD CONSTRAINT
	FK_Pessoa_InvMovPrice_IDVendor FOREIGN KEY (IDVendor) REFERENCES Pessoa
GO

ALTER TABLE Inv_MovPrice ADD CONSTRAINT
	FK_InvDescriptionPrice_InvMovPrice_IDDescriptionPrice FOREIGN KEY (IDDescriptionPrice) REFERENCES Inv_DescriptionPrice
GO

ALTER TABLE Inv_MovPrice ADD CONSTRAINT
	FK_InventoryMov_InvMovPrice_IDInventoryMov FOREIGN KEY (IDInventoryMov) REFERENCES InventoryMov
GO

ALTER TABLE Inv_MovPrice ADD CONSTRAINT
	FK_PreInventoryMov_InvMovPrice_IDPreInventoryMov FOREIGN KEY (IDPreInventoryMov) REFERENCES PreInventoryMov
GO

ALTER TABLE TabGroup ADD
	UsePriceTable bit NOT NULL CONSTRAINT DF_TabGroup_UsePriceTable_False DEFAULT 0
GO
