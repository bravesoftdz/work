CREATE TABLE Inv_Department (
	IDDepartment int NOT NULL,
	Department varchar(50) NOT NULL,
	System Boolean NOT NULL CONSTRAINT DF_InvDepartment_System_Zero DEFAULT 0,
	Hidden Boolean NOT NULL	CONSTRAINT DF_InvDepartment_Hidden_Zero DEFAULT 0,
	Desativado Boolean NOT NULL CONSTRAINT DF_InvDepartment_Desativado_Zero DEFAULT 0
)
GO

ALTER TABLE Inv_Department
	ADD CONSTRAINT XPKInv_Department PRIMARY KEY (IDDepartment)
GO

INSERT INTO Inv_Department (IDDepartment, Department, System, Hidden, Desativado)
VALUES (0, 'System Department', 1, 0, 0)
GO

ALTER TABLE TabGroup ADD
	IDDepartment int NOT NULL CONSTRAINT DF_TabGroup_IDDepartment_Zero DEFAULT 0
GO

ALTER TABLE TabGroup
	ADD CONSTRAINT FK_InvDepartment_TabGroup_IDDepartment
		FOREIGN KEY (IDDepartment)
			REFERENCES Inv_Department
GO

CREATE TABLE Inv_ModelDepartment (
	StoreID int NOT NULL,
	ModelID int NOT NULL,
	IDDepartment int NOT NULL
)
GO

ALTER TABLE Inv_ModelDepartment
	ADD CONSTRAINT XPKInv_ModelDepartment
		PRIMARY KEY (StoreID, ModelID, IDDepartment)
GO

ALTER TABLE Inv_ModelDepartment
	ADD CONSTRAINT FK_InvDepartment_InvModelDepartment_IDDepartment
		FOREIGN KEY (IDDepartment)
			REFERENCES Inv_Department
GO

ALTER TABLE Inv_ModelDepartment
	ADD CONSTRAINT FK_Inventory_InvModelDepartment_IDStore_IDModel
		FOREIGN KEY (StoreID, ModelID)
			REFERENCES Inventory
GO

ALTER TABLE InventoryMov ADD
	IDDepartment int NOT NULL CONSTRAINT DF_InventoryMov_IDDepartment_Zero DEFAULT 0
GO

ALTER TABLE InventoryMov
	ADD CONSTRAINT FK_InvDepartment_InventoryMov_IDDepartment
		FOREIGN KEY (IDDepartment)
			REFERENCES Inv_Department
GO

ALTER TABLE PreInventoryMov ADD
	IDDepartment int NOT NULL CONSTRAINT DF_PreInventoryMov_IDDepartment_Zero DEFAULT 0
GO

ALTER TABLE PreInventoryMov
	ADD CONSTRAINT FK_InvDepartment_PreInventoryMov_IDDepartment
		FOREIGN KEY (IDDepartment)
			REFERENCES Inv_Department
GO
