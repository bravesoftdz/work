CREATE TABLE Pet_Weight (
       IDWeight             int NOT NULL,
       IDPet                int NOT NULL,
       EntryDate            datetime NULL,
       Weight               decimal(38,4) NULL
)
GO


ALTER TABLE Pet_Weight
       ADD CONSTRAINT XPKPet_Weight PRIMARY KEY (IDWeight)
GO


ALTER TABLE Pet_Weight
       ADD CONSTRAINT FK_Pet_IDPet_Pet_Weight_IDPet
              FOREIGN KEY (IDPet)
                             REFERENCES Pet
GO
