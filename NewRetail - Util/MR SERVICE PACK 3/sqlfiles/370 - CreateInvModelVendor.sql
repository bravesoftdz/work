CREATE TABLE Inv_ModelVendor (
       IDPessoa             int NOT NULL,
       IDModel              int NOT NULL,
       VendorOrder          int NOT NULL
)
GO

CREATE INDEX XIF2Inv_ModelVendor ON Inv_ModelVendor
(
       IDPessoa
)
GO

CREATE INDEX XIF3Inv_ModelVendor ON Inv_ModelVendor
(
       IDModel
)
GO


ALTER TABLE Inv_ModelVendor
       ADD CONSTRAINT XPKInv_ModelVendor PRIMARY KEY (IDPessoa, 
              IDModel)
GO


ALTER TABLE Inv_ModelVendor
       ADD CONSTRAINT FK_Model_InvModelVendor_IDModel
              FOREIGN KEY (IDModel)
                             REFERENCES Model
GO


ALTER TABLE Inv_ModelVendor
       ADD CONSTRAINT FK_Pessoa_InvModelVendor_IDFabricante
              FOREIGN KEY (IDPessoa)
                             REFERENCES Pessoa
GO
