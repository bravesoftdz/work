DROP INDEX Pet.XIF2Pet
GO

ALTER TABLE Pet DROP CONSTRAINT FK_Race_IDRace_Pet_IDRace
GO

ALTER TABLE Pet DROP COLUMN IDRace
GO

DROP TABLE Pet_Race
GO

CREATE TABLE Pet_Breed (
       IDBreed              int NOT NULL,
       Breed                varchar(50) NOT NULL,
       System               bit NULL
                                   CONSTRAINT DF_Zero3364
                                          DEFAULT 0,
       Hidden               bit NULL
                                   CONSTRAINT DF_Zero3365
                                          DEFAULT 0,
       Desativado           bit NULL
                                   CONSTRAINT DF_Zero3366
                                          DEFAULT 0
)
GO

ALTER TABLE Pet_Breed
       ADD CONSTRAINT XPKPet_Breed PRIMARY KEY (IDBreed)
GO

ALTER TABLE Pet
	ADD IDBreed int NULL
GO

ALTER TABLE Pet
       ADD CONSTRAINT FK_Breed_IDBreed_Pet_IDBreed
              FOREIGN KEY (IDBreed)
                             REFERENCES Pet_Breed
GO
