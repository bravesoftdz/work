ALTER TABLE Store ADD Franchise BIT Default 0
GO

ALTER TABLE Inventory ADD StoreCostPrice money, StoreAvgPrice money
GO

UPDATE Store SET Franchise = 0
GO
