CREATE TABLE Pet_PetMicrochip (
       IDMicrochip          int NOT NULL,
       IDPet                int NOT NULL,
       MicrochipNum         varchar(20) NULL
)
GO

ALTER TABLE Pet_PetMicrochip
       ADD CONSTRAINT XPKPet_PetMicrochip PRIMARY KEY (IDMicrochip, 
              IDPet)
GO

ALTER TABLE Pet_PetMicrochip
       ADD CONSTRAINT FK_Pet_IDPet_Pet_PetMicrochip_IDPet
              FOREIGN KEY (IDPet)
                             REFERENCES Pet
GO

ALTER TABLE Pet_PetMicrochip
       ADD CONSTRAINT FK_Pet_Microchip_IDMicrochip_Pet_PetMicrochip_IDMicrochip
              FOREIGN KEY (IDMicrochip)
                             REFERENCES Pet_Microchip
GO
