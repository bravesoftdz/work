ALTER TABLE PreInventoryMov ADD
	IDTaxCategory int NULL
GO

ALTER TABLE PreInventoryMov ADD CONSTRAINT
	FK_TaxCategory_PreInventMov_IDTaxCategory FOREIGN KEY (IDTaxCategory) REFERENCES TaxCategory
GO
