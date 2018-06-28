ALTER TABLE ModelTransfDet ADD
	SellingPrice Money NULL DEFAULT 0
GO

UPDATE ModelTransfDet
Set SellingPrice = 0
GO
