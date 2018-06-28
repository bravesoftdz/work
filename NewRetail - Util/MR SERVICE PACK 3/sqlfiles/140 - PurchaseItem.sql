ALTER TABLE Pur_PurchaseItem ADD CostPrice Money null
GO

ALTER TABLE Pur_PurchaseItem ADD FreightCost Money null
GO

ALTER TABLE Pur_PurchaseItem ADD OtherCost Money null
GO

ALTER TABLE Pur_PurchaseItemTax ADD IDPurchase Int null
GO

ALTER TABLE Pur_PurchaseItemTax 
       ADD CONSTRAINT FK_Pur_Purchase_Pur_PurchaseItemTax_IDPurchase
              FOREIGN KEY (IDPurchase)
                             REFERENCES Pur_Purchase
GO

