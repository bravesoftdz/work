CREATE TABLE Sal_Discount (
       IDDiscount           int NOT NULL,
       IDPreSale            int NOT NULL,
       IDPreInventoryMov    int NOT NULL,
       Discount             money NULL
)
GO

ALTER TABLE Sal_Discount
       ADD CONSTRAINT XPKSal_Discount PRIMARY KEY (IDDiscount)
GO
