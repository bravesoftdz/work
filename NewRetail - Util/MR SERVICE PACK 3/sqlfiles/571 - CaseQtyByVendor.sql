ALTER TABLE Inv_ModelVendor ADD
	CaseQty Float NULL CONSTRAINT DF_InvModelVendor_CaseQty_Zero DEFAULT 0
GO

UPDATE Inv_ModelVendor
SET CaseQty = 0
GO
