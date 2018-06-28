CREATE TABLE Pet_PetRegistry (
       IDRegistry           int NOT NULL,
       IDPet                int NOT NULL,
       RegistrationNum      varchar(50) NULL
)
GO

ALTER TABLE Pet_PetRegistry
       ADD CONSTRAINT XPKPet_PetRegistry PRIMARY KEY (IDRegistry, 
              IDPet)
GO

ALTER TABLE Pet_PetRegistry
       ADD CONSTRAINT FK_Pet_IDPet_Pet_PetRegistry_IDPet
              FOREIGN KEY (IDPet)
                             REFERENCES Pet
GO

ALTER TABLE Pet_PetRegistry
       ADD CONSTRAINT FK_Pet_Registry_IDRegistry_Pet_PetRegistry_IDRegistry
              FOREIGN KEY (IDRegistry)
                             REFERENCES Pet_Registry
GO
