ALTER TABLE Inv_ModelVendor ADD
	MinQtyPO float NULL CONSTRAINT DF_InvModelVendor_MinQtyPO_Zero DEFAULT 0
GO

UPDATE Inv_ModelVendor
SET MinQtyPO = 0
GO

ALTER TABLE Inv_ModelVendor ALTER COLUMN
	MinQtyPO float NOT NULL
GO
