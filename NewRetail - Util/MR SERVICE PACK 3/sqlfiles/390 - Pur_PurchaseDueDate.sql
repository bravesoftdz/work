CREATE TABLE Pur_PurchaseDueDate (
       IDPurchaseDueDate    varchar(20) NOT NULL,
       Date                 datetime NULL,
       Amount               TValor,
       IDPurchase           int NULL
)
GO

ALTER TABLE Pur_PurchaseDueDate
       ADD CONSTRAINT XPKPur_PurchaseDueDate PRIMARY KEY (
              IDPurchaseDueDate)
GO

ALTER TABLE Pur_PurchaseDueDate
       ADD CONSTRAINT FK_Pur_Purchase_Pur_PurchaseDueDate_IDPurchase
              FOREIGN KEY (IDPurchase)
                             REFERENCES Pur_Purchase
GO
