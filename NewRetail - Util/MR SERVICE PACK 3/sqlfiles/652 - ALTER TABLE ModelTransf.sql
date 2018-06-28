ALTER TABLE ModelTransf ADD
	PrintDate datetime NULL
GO

UPDATE
	ModelTransf
SET
	PrintDate = Data
GO
