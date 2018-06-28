ALTER TABLE Pur_PurchaseItem ADD
     Discount             money NULL,
     DiscountRet          money NULL
GO

ALTER TABLE Pur_Purchase ADD
       Discount             money NULL
GO
