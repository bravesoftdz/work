CREATE TABLE Pet_Color (
       IDColor              int NOT NULL,
       Color                varchar(50) NOT NULL,
       System               int NULL
                                   CONSTRAINT DF_Zero3441
                                          DEFAULT 0,
       Hidden               bit NULL
                                   CONSTRAINT DF_Zero3442
                                          DEFAULT 0,
       Desativado           bit NULL
                                   CONSTRAINT DF_Zero3443
                                          DEFAULT 0
)
GO

ALTER TABLE Pet_Color
       ADD CONSTRAINT XPKPet_Color PRIMARY KEY (IDColor)
GO

CREATE TABLE Pet_ColorSpecies (
       IDSpecies            int NOT NULL,
       IDColor              int NOT NULL
)
GO

ALTER TABLE Pet_ColorSpecies
       ADD CONSTRAINT XPKPet_ColorSpecies PRIMARY KEY (IDSpecies, 
              IDColor)
GO

ALTER TABLE Pet_ColorSpecies
       ADD CONSTRAINT FK_Pet_Color_IDColor_Pet_ColorSpecies_IDColor
              FOREIGN KEY (IDColor)
                             REFERENCES Pet_Color
GO

ALTER TABLE Pet_ColorSpecies
       ADD CONSTRAINT FK_Pet_Species_IDSpecies_Pet_ColorSpecies_IDSpecies
              FOREIGN KEY (IDSpecies)
                             REFERENCES Pet_Species
GO

ALTER TABLE Pet ADD IDColor int NULL
GO

ALTER TABLE Pet
       ADD CONSTRAINT FK_Pet_Color_IDColor_Pet__IDColor
              FOREIGN KEY (IDColor)
                             REFERENCES Pet_Color
GO

ALTER TABLE Pet DROP COLUMN Color
GO
