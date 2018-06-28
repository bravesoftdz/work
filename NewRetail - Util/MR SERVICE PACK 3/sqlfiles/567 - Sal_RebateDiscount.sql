DROP TABLE Sal_RebateDiscount
GO

CREATE TABLE Sal_RebateDiscount (
	IDPreSaleCreated int NOT NULL,
	IDPreSaleUsed int NULL,
	DiscountValue money NOT NULL
)
GO

ALTER TABLE Sal_RebateDiscount ADD CONSTRAINT
	XPKSal_RebateDiscount PRIMARY KEY (IDPreSaleCreated)
GO

ALTER TABLE Sal_RebateDiscount ADD CONSTRAINT
	FK_Invoice_SalRebateDiscount_IDPreSaleUsed FOREIGN KEY (IDPreSaleUsed) REFERENCES Invoice
GO

ALTER TABLE Sal_RebateDiscount ADD CONSTRAINT
	FK_Invoice_SalRebateDiscount_IDPreSaleCreated FOREIGN KEY (IDPreSaleCreated) REFERENCES Invoice
GO
