ALTER TABLE Inventory ADD
	ClassABC char(1) NULL DEFAULT 'C',
	DailySales money NULL,
	LeadTime money NULL,
	OrderPoint money NULL,
	SafetyMargin money NULL
GO
