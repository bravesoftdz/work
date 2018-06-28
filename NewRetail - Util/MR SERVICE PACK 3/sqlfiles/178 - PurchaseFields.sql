ALTER TABLE Pur_PurchaseItem ADD
    QtyRet       int NULL,
    CostPriceRet    money NULL,
    FreightCostRet    money NULL,
    OtherCostRet    money NULL,
    NewCostPriceRet    money NULL,
    NewCostPriceResult money NULL
GO

ALTER TABLE Pur_Purchase ADD
    DocumentNumberRet    varchar(20)    NULL,
    OtherChargesRet        money        NULL,
    FreightRet        money        NULL
GO

CREATE TABLE Pur_PurchaseItemTaxRet (
       IDPurchaseItemTaxRet    int NOT NULL,
       IDPurchaseItem        int NULL,
       IDVendorTax        int NULL,
       TaxValue            money NULL,
       TaxPercentage        money NULL,
       IDPurchase        int NULL
)
GO

CREATE INDEX XIF1Pur_PurchaseItemTaxRet ON Pur_PurchaseItemTaxRet
(
       IDPurchase
)
GO

CREATE INDEX XIF2Pur_PurchaseItemTaxRet ON Pur_PurchaseItemTaxRet
(
       IDPurchaseItem
)
GO

CREATE INDEX XIF3Pur_PurchaseItemTaxRet ON Pur_PurchaseItemTaxRet
(
       IDVendorTax
)
GO

ALTER TABLE Pur_PurchaseItemTaxRet
       ADD CONSTRAINT XPKPur_PurchaseItemTaxRet PRIMARY KEY (
              IDPurchaseItemTaxRet)
GO

ALTER TABLE Pur_PurchaseItemTaxRet
       ADD CONSTRAINT FK_VendorTax_Pur_PurchaseItemTaxRet_IDVendorTax
              FOREIGN KEY (IDVendorTax)
                             REFERENCES VendorTax
GO

ALTER TABLE Pur_PurchaseItemTaxRet
       ADD CONSTRAINT Pur_PurchaseItem_Pur_PurchaseItemTaxRet_IDPurchaseItem
              FOREIGN KEY (IDPurchaseItem)
                             REFERENCES Pur_PurchaseItem
GO

ALTER TABLE Pur_PurchaseItemTaxRet
       ADD CONSTRAINT FK_Pur_Purchase_Pur_PurchaseItemTaxRet_IDPurchase
              FOREIGN KEY (IDPurchase)
                             REFERENCES Pur_Purchase
GO

ALTER TABLE Pur_PurchaseTotal ADD
    SubTotalRet money null
GO
