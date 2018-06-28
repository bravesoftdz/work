CREATE TABLE ServiceRange (
       IDServiceRange       int NOT NULL,
       IDGroup              int NULL,
       IDModel              int NULL,
       BeginAmount          money NULL,
       EndAmount            money NULL
)
GO

CREATE UNIQUE CLUSTERED INDEX XPKServiceRange ON ServiceRange (IDServiceRange)
GO

CREATE INDEX XIF1ServiceRange ON ServiceRange (IDGroup)
GO

CREATE INDEX XIF2ServiceRange ON ServiceRange(IDModel)
GO

ALTER TABLE ServiceRange ADD CONSTRAINT FK_Model_ServiceRange_IDModel
FOREIGN KEY (IDModel) REFERENCES Model
GO

ALTER TABLE ServiceRange ADD CONSTRAINT FK_TabGroup_ServiceRange_IDGroup
FOREIGN KEY (IDGroup) REFERENCES TabGroup
GO

ALTER TABLE InventoryMov ADD IDModelService int NULL
GO

ALTER TABLE PreInventoryMov ADD IDModelService int NULL
GO

ALTER TABLE TabGroup ADD Service bit NULL CONSTRAINT TabGroup_Service_Zero863 DEFAULT 0
GO

CREATE TABLE VendorTax (
       IDVendorTax          int NOT NULL,
       IDPessoa             int NULL,
       IDGroup              int NULL,
       IDTaxCategory        int NULL
)
GO

ALTER TABLE VendorTax ADD CONSTRAINT XPKVendorTax PRIMARY KEY (IDVendorTax)
GO

ALTER TABLE VendorTax ADD CONSTRAINT FK_TaxCategory_VendorTax_IDTaxCategory
FOREIGN KEY (IDTaxCategory) REFERENCES TaxCategory
GO

ALTER TABLE VendorTax ADD CONSTRAINT FK_TabGroup_VendorTax_IDGroup
FOREIGN KEY (IDGroup) REFERENCES TabGroup
GO

ALTER TABLE VendorTax ADD CONSTRAINT FK_Pessoa_VendorTax_IDPessoa
FOREIGN KEY (IDPessoa) REFERENCES Pessoa
GO

CREATE TABLE Pur_PurchaseItemTax (
       IDPurchaseItemTax    int NOT NULL,
       IDPurchaseItem       int NULL,
       IDVendorTax          int NULL,
       TaxValue             money NULL,
       TaxPercentage        money NULL
)
GO

ALTER TABLE Pur_PurchaseItemTax ADD CONSTRAINT XPKPur_PurchaseItemTax 
PRIMARY KEY (IDPurchaseItemTax)
GO

ALTER TABLE Pur_PurchaseItemTax ADD CONSTRAINT FK_VendorTax_Pur_PurchaseItemTax_IDVendorTax
FOREIGN KEY (IDVendorTax) REFERENCES VendorTax
GO

ALTER TABLE Pur_PurchaseItemTax ADD CONSTRAINT FK_PurchaseItem_PurchaseItemTax_IDPurchaseItem
FOREIGN KEY (IDPurchaseItem) REFERENCES Pur_PurchaseItem
GO