ALTER TABLE Model ADD
	AvgCostTotal money NOT NULL CONSTRAINT DF_Model_AvgCostTotal_Zero DEFAULT 0
GO

ALTER TABLE Inventory ADD
	AvgCostTotal money NOT NULL CONSTRAINT DF_Inventory_AvgCostTotal_Zero DEFAULT 0
GO

ALTER TABLE ModelTransfDet ADD
	AvgCost money NOT NULL DEFAULT 0
GO
