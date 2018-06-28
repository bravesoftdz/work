CREATE TABLE Pur_PurchaseVerify (
       IDPurchaseVerify     int NOT NULL,
       IDPurchase           int NULL,
       IDUser               int NOT NULL,
       IDModel              int NULL,
       IDBarcode            varchar(20) NULL,
       QtyReceiving         decimal(38,4) NULL,
       QtyCounted           decimal(38,4) NULL,
       EnterDate            datetime NULL
)
GO

CREATE INDEX XIE1Pur_PurchaseVerify ON Pur_PurchaseVerify
(
       IDBarcode
)
GO

ALTER TABLE Pur_PurchaseVerify
       ADD CONSTRAINT XPKPur_PurchaseVerify PRIMARY KEY (
              IDPurchaseVerify)
GO

ALTER TABLE Pur_PurchaseVerify
       ADD CONSTRAINT FK_Purchase_PurchaseVerify_IDPurchase
              FOREIGN KEY (IDPurchase)
                             REFERENCES Pur_Purchase
GO

ALTER TABLE Pur_PurchaseVerify
       ADD CONSTRAINT FK_Model_PurchaseVerify_IDModel
              FOREIGN KEY (IDModel)
                             REFERENCES Model
GO

ALTER TABLE Pur_PurchaseVerify
       ADD CONSTRAINT FK_SystemUSer_PurchaseVerify_IDUser
              FOREIGN KEY (IDUser)
                             REFERENCES SystemUser
GO
