CREATE TABLE Inv_ModelStateTax (
       IDModel              int NOT NULL
                                   CONSTRAINT DEF_Bit1252
                                          DEFAULT 0,
       IDEstado             char(3) NOT NULL,
       IDTaxCategory        int NOT NULL
                                   CONSTRAINT DEF_Bit1253
                                          DEFAULT 0
)
GO

ALTER TABLE Inv_ModelStateTax
       ADD CONSTRAINT XPKInv_ModelStateTax PRIMARY KEY (IDModel, 
              IDEstado, IDTaxCategory)
GO

ALTER TABLE Inv_ModelStateTax
       ADD CONSTRAINT PK_InvModelStateTax_TaxCategory_IDTaxCategory
              FOREIGN KEY (IDTaxCategory)
                             REFERENCES TaxCategory
GO

ALTER TABLE Inv_ModelStateTax
       ADD CONSTRAINT PK_InvModelStateTax_Estado_IDEstado
              FOREIGN KEY (IDEstado)
                             REFERENCES Estado
GO

ALTER TABLE Inv_ModelStateTax
       ADD CONSTRAINT PK_InvModelStateTax_Model_IDModel
              FOREIGN KEY (IDModel)
                             REFERENCES Model
GO

