CREATE TABLE Mnt_Document (
	IDDocument int NOT NULL,
	Document varchar(40) NOT NULL
)
GO

ALTER TABLE Mnt_Document ADD CONSTRAINT
	XPKMnt_Document PRIMARY KEY (IDDocument)
GO

CREATE TABLE Inv_MovDocument (
	IDInventoryMov int NOT NULL,
	DocumentDate datetime NULL,
	DocumentStatus int NULL,
	IDDocument int NULL,
	OBS varchar(255) NULL
)
GO

ALTER TABLE Inv_MovDocument ADD CONSTRAINT
	XPKInv_MovDocument PRIMARY KEY (IDInventoryMov)
GO

ALTER TABLE Inv_MovDocument ADD CONSTRAINT
	FK_MntDocument_InvMovDocument_IDDocument FOREIGN KEY (IDDocument) REFERENCES Mnt_Document
GO

ALTER TABLE Inv_MovDocument ADD CONSTRAINT
	FK_InventoryMov_InvMovDocument_IDInventoryMov FOREIGN KEY (IDInventoryMov) REFERENCES InventoryMov
GO
