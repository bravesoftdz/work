DROP TABLE Inv_MovDocument
GO

DROP TABLE Mnt_Document
GO

CREATE TABLE Mnt_DocumentType (
	IDDocumentType int NOT NULL,
	DocumentType varchar(40) NOT NULL
)
GO

ALTER TABLE Mnt_DocumentType ADD CONSTRAINT
	XPKMnt_DocumentType PRIMARY KEY (IDDocumentType)
GO

CREATE TABLE Inv_MovDocument (
	IDMovDocument int NOT NULL,
	IDPreInventoryMov int NULL,
	IDInventoryMov int NULL,
	DocumentNumber varchar(20) NOT NULL,
	DocumentDate datetime NOT NULL,
	DocumentStatus int NOT NULL,
	IDDocumentType int NOT NULL,
	OBS varchar(255) NULL
)
GO

ALTER TABLE Inv_MovDocument ADD CONSTRAINT
	XPKInv_MovDocument PRIMARY KEY (IDMovDocument)
GO

ALTER TABLE Inv_MovDocument ADD CONSTRAINT
	FK_PreInventoryMov_InvMovDocument_IDPreInventoryMov FOREIGN KEY (IDPreInventoryMov) REFERENCES PreInventoryMov
GO

ALTER TABLE Inv_MovDocument ADD CONSTRAINT
	FK_InventoryMov_InvMovDocument_IDInventoryMov FOREIGN KEY (IDInventoryMov) REFERENCES InventoryMov
GO

ALTER TABLE Inv_MovDocument ADD CONSTRAINT
	FK_MntDocument_InvMovDocument_IDDocument FOREIGN KEY (IDDocumentType) REFERENCES Mnt_DocumentType
GO

ALTER TABLE TabGroup ADD
	UseDocumentOnSale Boolean NOT NULL CONSTRAINT DF_TabGroup_UseDocumentOnSale_Zero DEFAULT 0
GO
