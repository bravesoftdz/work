DROP TABLE Pet_MedicalCondition
GO

DROP TABLE Pet_Treatment
GO

CREATE TABLE Pet_MedicalCondition (
       IDMedicalCondition   int NOT NULL,
       MedicalCondition     varchar(50) NULL,
       SubMedicalCondition  varchar(255) NULL,
       System               bit NULL
                                   CONSTRAINT DF_Zero3391
                                          DEFAULT 0,
       Hidden               bit NULL
                                   CONSTRAINT DF_Zero3392
                                          DEFAULT 0,
       Desativado           bit NULL
                                   CONSTRAINT DF_Zero3393
                                          DEFAULT 0
)
GO


ALTER TABLE Pet_MedicalCondition
       ADD CONSTRAINT XPKPet_MedicalCondition PRIMARY KEY (
              IDMedicalCondition)
GO

CREATE TABLE Pet_Treatment (
       IDTreatment          int NOT NULL,
       Treatment            varchar(50) NULL,
       TreatmentType        int NULL,
       Mfg                  varchar(50) NULL,
       System               bit NULL
                                   CONSTRAINT DF_Zero3394
                                          DEFAULT 0,
       TreatmentLotSize     int NULL,
       Hidden               bit NULL
                                   CONSTRAINT DF_Zero3395
                                          DEFAULT 0,
       Desativado           bit NULL
                                   CONSTRAINT DF_Zero3396
                                          DEFAULT 0
)
GO

ALTER TABLE Pet_Treatment
       ADD CONSTRAINT XPKPet_Treatment PRIMARY KEY (IDTreatment)
GO

CREATE TABLE Pet_MedicalConditionSpecies (
       IDMedicalCondition   int NOT NULL,
       IDSpecies            int NOT NULL
)
GO

ALTER TABLE Pet_MedicalConditionSpecies
       ADD CONSTRAINT XPKPet_MedicalConditionSpecies PRIMARY KEY (
              IDMedicalCondition, IDSpecies)
GO

ALTER TABLE Pet_MedicalConditionSpecies
       ADD CONSTRAINT FK_Pet_Species_IDSpecies_Pet_MedicalContidionSpecies_IDSpecies
              FOREIGN KEY (IDSpecies)
                             REFERENCES Pet_Species
GO

ALTER TABLE Pet_MedicalConditionSpecies
       ADD CONSTRAINT FK_Pet_MedicalCondition_IDMedicalCondition_Pet_MedicalContidionSpecies_IDMedicalCondition
              FOREIGN KEY (IDMedicalCondition)
                             REFERENCES Pet_MedicalCondition
GO

CREATE TABLE Pet_TreatmentSpecies (
       IDSpecies            int NOT NULL,
       IDTreatment          int NOT NULL
)
GO

ALTER TABLE Pet_TreatmentSpecies
       ADD CONSTRAINT XPKPet_TreatmentSpecies PRIMARY KEY (IDSpecies, 
              IDTreatment)
GO

ALTER TABLE Pet_TreatmentSpecies
       ADD CONSTRAINT FK_Pet_Treatment_IDTreatment_Pet_TreatmentSpecies_IDTreatment
              FOREIGN KEY (IDTreatment)
                             REFERENCES Pet_Treatment
GO

ALTER TABLE Pet_TreatmentSpecies
       ADD CONSTRAINT FK_Pet_Species_IDSpecies_Pet_TreatmentSpecies_IDSpecies
              FOREIGN KEY (IDSpecies)
                             REFERENCES Pet_Species
GO

UPDATE Pet
SET IDSpecies = NULL
GO

DELETE Pet_Species
GO

INSERT Pet_Species (IDSpecies, Species, System, Hidden, Desativado) 
VALUES (1, 'Dog', 1, 0, 0)
GO

INSERT Pet_Species (IDSpecies, Species, System, Hidden, Desativado) 
VALUES (2, 'Cat', 1, 0, 0)
GO

DELETE Sis_CodigoIncremental
WHERE Tabela = 'Pet_Species.IDSpecies'

INSERT Sis_CodigoIncremental VALUES ('Pet_Species.IDSpecies', 2)
GO

CREATE TABLE Pet_RegistrySpecies (
       IDRegistry           int NOT NULL,
       IDSpecies            int NOT NULL
)
GO

ALTER TABLE Pet_RegistrySpecies
       ADD CONSTRAINT XPKPet_RegistrySpecies PRIMARY KEY (IDRegistry, 
              IDSpecies)
GO

ALTER TABLE Pet_RegistrySpecies
       ADD CONSTRAINT FK_Pet_Species_IDSpecies_Pet_RegistrySpecies_IDSpecies
              FOREIGN KEY (IDSpecies)
                             REFERENCES Pet_Species
GO

ALTER TABLE Pet_RegistrySpecies
       ADD CONSTRAINT FK_Pet_Registry_IDRegistry_Pet_RegistrySpecies_IDRegistry
              FOREIGN KEY (IDRegistry)
                             REFERENCES Pet_Registry
GO

CREATE TABLE Pet_TreatmentLot (
       IDTreatmentLot       int NOT NULL,
       IDTreatment          int NOT NULL,
       LotNumber            varchar(30) NULL,
       ExpirationDate       datetime NULL,
       System               bit NULL
                                   CONSTRAINT DF_Zero3397
                                          DEFAULT 0,
       Hidden               bit NULL
                                   CONSTRAINT DF_Zero3398
                                          DEFAULT 0,
       Desativado           bit NULL
                                   CONSTRAINT DF_Zero3399
                                          DEFAULT 0
)
GO

ALTER TABLE Pet_TreatmentLot
       ADD CONSTRAINT XPKPet_TreatmentLot PRIMARY KEY (IDTreatmentLot)
GO

ALTER TABLE Pet_TreatmentLot
       ADD CONSTRAINT FK_Pet_Treatment_IDTreatment_Pet_TreatmentLot_IDTreatment
              FOREIGN KEY (IDTreatment)
                             REFERENCES Pet_Treatment
GO

CREATE TABLE Pet_PetTreatment (
       IDPetTreatment       int NOT NULL,
       IDTreatment          int NOT NULL,
       IDTreatmentLot       int NULL,
       IDPet                int NOT NULL,
       IDUser               int NOT NULL,
       ExpirationDate       datetime NULL,
       DosesUsed            int NULL,
       TreatmentDate        datetime NULL,
       Notes                varchar(255) NULL
)
GO

ALTER TABLE Pet_PetTreatment
       ADD CONSTRAINT XPKPet_PetTreatment PRIMARY KEY (IDPetTreatment)
GO

ALTER TABLE Pet_PetTreatment
       ADD CONSTRAINT FK_SystemUser_IDUser_Pet_PetTreatment_IDUser
              FOREIGN KEY (IDUser)
                             REFERENCES SystemUser
GO

ALTER TABLE Pet_PetTreatment
       ADD CONSTRAINT FK_Pet_IDPet_Pet_PetTreatment_IDPet
              FOREIGN KEY (IDPet)
                             REFERENCES Pet
GO

ALTER TABLE Pet_PetTreatment
       ADD CONSTRAINT FK_Pet_TreatmentLot_IDTreatmentLot_Pet_Treatment_IDTreatmentLot
              FOREIGN KEY (IDTreatmentLot)
                             REFERENCES Pet_TreatmentLot
GO

ALTER TABLE Pet_PetTreatment
       ADD CONSTRAINT FK_Pet_Treatment_IDTreatment_Pet_PetTreatment_IDTreatment
              FOREIGN KEY (IDTreatment)
                             REFERENCES Pet_Treatment
GO
