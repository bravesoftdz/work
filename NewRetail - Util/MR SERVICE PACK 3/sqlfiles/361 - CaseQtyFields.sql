ALTER TABLE PreInventoryMov
	ADD CaseQty float
GO

ALTER TABLE PreInventoryMov
	ADD CaseCost money
GO

ALTER TABLE Pur_PurchaseItem
	ADD CaseQty float
GO

ALTER TABLE Pur_PurchaseItem
	ADD CaseCost money
GO
