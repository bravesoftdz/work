ALTER TABLE EstimatedItem ADD
	IDDepartment int NULL
GO

ALTER TABLE EstimatedItem ADD CONSTRAINT
	FK_InvDepartment_EstimatedItem_IDDepartment FOREIGN KEY (IDDepartment) REFERENCES Inv_Department
GO
