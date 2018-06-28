CREATE TABLE Pet_WarrantyReport (
       IDWarrantyReport     int NOT NULL,
       IDSpecies            int NOT NULL,
       Report               image NULL,
       ReportName           varchar(30) NULL,
       ReportDate           datetime NULL
)
GO

ALTER TABLE Pet_WarrantyReport
       ADD CONSTRAINT XPKPet_WarrantyReport PRIMARY KEY (
              IDWarrantyReport)
GO

ALTER TABLE Pet_WarrantyReport
       ADD CONSTRAINT FK_Pet_Species_IDSpecies_Pet_WarrantyReport_IDSpecies
              FOREIGN KEY (IDSpecies)
                             REFERENCES Pet_Species
GO

CREATE INDEX PI_InvMov_IDPreInvMov ON InventoryMov
(
       PreInventoryMovID
)
GO

CREATE TABLE Pet_PetSale (
       IDPetSale            int NOT NULL,
       IDPreInventoryMov    int NOT NULL,
       IDWarrantyReport     int NOT NULL,
       IDWarrantyCustomer   int NOT NULL,
       IDPet                int NULL
)
GO

ALTER TABLE Pet_PetSale
       ADD CONSTRAINT XPKPet_PetSale PRIMARY KEY (IDPetSale)
GO

ALTER TABLE Pet_PetSale
       ADD CONSTRAINT FK_Pet_IDPet_Pet_PetSale_IDPet
              FOREIGN KEY (IDPet)
                             REFERENCES Pet
GO

ALTER TABLE Pet_PetSale
       ADD CONSTRAINT FK_Pessoa_IDPessoa_Pet_PetSale_IDWarrantyCustomer
              FOREIGN KEY (IDWarrantyCustomer)
                             REFERENCES Pessoa
GO

ALTER TABLE Pet_PetSale
       ADD CONSTRAINT FK_Pet_WarrantReport_IDWarrantyReport_Pet_PetSale_IDWarrantyReport
              FOREIGN KEY (IDWarrantyReport)
                             REFERENCES Pet_WarrantyReport
GO

CREATE TABLE Pet_MicrochipSale (
       IDPreInventoryMov    int NOT NULL,
       IDMicrochip          int NOT NULL,
       IDPetSale            int NOT NULL,
       MicrochipNum         varchar(20) NOT NULL
)
GO

ALTER TABLE Pet_MicrochipSale
       ADD CONSTRAINT XPKPet_MicrochipSale PRIMARY KEY (
              IDPreInventoryMov, IDMicrochip)
GO

ALTER TABLE Pet_MicrochipSale
       ADD CONSTRAINT FK_Pet_PetSale_IDPetSalet_Pet_MicrochipSale_IDPetSale
              FOREIGN KEY (IDPetSale)
                             REFERENCES Pet_PetSale
GO

ALTER TABLE Pet_MicrochipSale
       ADD CONSTRAINT FK_Pet_Microchip_IDMicrochip_Pet_MicrochipSale_IDMicrochip
              FOREIGN KEY (IDMicrochip)
                             REFERENCES Pet_Microchip
GO

CREATE TABLE Pet_RegistrySale (
       IDPreInventoryMov    int NOT NULL,
       IDRegistry           int NOT NULL,
       IDPetSale            int NOT NULL,
       RegistrationNum      varchar(50) NOT NULL
)
GO

ALTER TABLE Pet_RegistrySale
       ADD CONSTRAINT XPKPet_RegistrySale PRIMARY KEY (
              IDPreInventoryMov, IDRegistry)
GO

ALTER TABLE Pet_RegistrySale
       ADD CONSTRAINT FK_Pet_PetSale_IDPetSale_Pet_RegistrySale_IDPetSale
              FOREIGN KEY (IDPetSale)
                             REFERENCES Pet_PetSale
GO

ALTER TABLE Pet_RegistrySale
       ADD CONSTRAINT FK_Pet_Registry_IDRegistry_Pet_RegistrySale_IDRegistry
              FOREIGN KEY (IDRegistry)
                             REFERENCES Pet_Registry
GO
