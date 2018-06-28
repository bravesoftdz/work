CREATE TABLE Pet_PetMedicalCondition (
       IDPetMedicalCondition int NOT NULL,
       IDMedicalCondition   int NULL,
       IDPet                int NOT NULL,
       IDUser               int NOT NULL,
       RecordDate           datetime NULL,
       Notes                varchar(100) NULL
)
GO

ALTER TABLE Pet_PetMedicalCondition
       ADD CONSTRAINT XPKPet_PetMedicalCondition PRIMARY KEY (
              IDPetMedicalCondition)
GO

ALTER TABLE Pet_PetMedicalCondition
       ADD CONSTRAINT FK_SystemUser_IDUser_Pet_PetMedicalCondition_IDUser
              FOREIGN KEY (IDUser)
                             REFERENCES SystemUser
GO

ALTER TABLE Pet_PetMedicalCondition
       ADD CONSTRAINT FK_Pet_IDPet_Pet_PetMedicalCondition_IDPet
              FOREIGN KEY (IDPet)
                             REFERENCES Pet
GO

ALTER TABLE Pet_PetMedicalCondition
       ADD CONSTRAINT FK_Pet_MedicalCondition_IDMedicalCondition_Pet_PetMedicalCondition_IDMedicalCondition
              FOREIGN KEY (IDMedicalCondition)
                             REFERENCES Pet_MedicalCondition
GO
