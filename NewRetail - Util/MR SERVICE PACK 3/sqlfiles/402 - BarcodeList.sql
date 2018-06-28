CREATE TABLE Inv_BarcodePrint (
       IDBarcode            TBarCode NOT NULL,
       Date                 datetime NOT NULL,
       Qtd                  int NOT NULL,
       IDUser               int NOT NULL
)
GO

ALTER TABLE Inv_BarcodePrint
       ADD CONSTRAINT XPKBarcodePrint PRIMARY KEY (IDBarcode)
GO

ALTER TABLE Inv_BarcodePrint
       ADD CONSTRAINT FK_SystemUser_BarcodePrint_IDUser
              FOREIGN KEY (IDUser)
                             REFERENCES SystemUser
GO

ALTER TABLE Inv_BarcodePrint
       ADD CONSTRAINT FK_Barcode_BarcodePrint_IDBarcode
              FOREIGN KEY (IDBarcode)
                             REFERENCES Barcode
GO

ALTER TABLE VendorModelCode
	ALTER COLUMN VendorCode varchar(35)
GO
