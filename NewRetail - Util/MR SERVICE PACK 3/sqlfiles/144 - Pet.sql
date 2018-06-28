CREATE TABLE Pet (
       IDPet                int NOT NULL,
       Name                 varchar(50) NOT NULL,
       Sex                  varchar(1) NULL,
       Color                varchar(50) NULL,
       IDSpecies            int NULL,
       IDRace               int NULL,
       IDPorte              int NULL
)
GO

CREATE INDEX XIF1Pet ON Pet
(
       IDSpecies
)
GO

CREATE INDEX XIF2Pet ON Pet
(
       IDRace
)
GO

CREATE INDEX XIF3Pet ON Pet
(
       IDPorte
)
GO


ALTER TABLE Pet
       ADD CONSTRAINT XPKPet PRIMARY KEY (IDPet)
GO


CREATE TABLE Pet_PessoaToPet (
       IDPessoa             int NOT NULL,
       IDPet                int NOT NULL
)
GO

CREATE INDEX XIF1Pet_PessoaToPet ON Pet_PessoaToPet
(
       IDPessoa
)
GO

CREATE INDEX XIF2Pet_PessoaToPet ON Pet_PessoaToPet
(
       IDPet
)
GO

ALTER TABLE Pet_PessoaToPet
       ADD CONSTRAINT XPKPet_PessoaToPet PRIMARY KEY (IDPessoa, IDPet)
GO

CREATE TABLE Pet_Porte (
       IDPorte              int NOT NULL,
       Porte                varchar(50) NOT NULL,
       System               bit NULL DEFAULT 0,
       Hidden               bit NULL DEFAULT 0,
       Desativado           bit NULL DEFAULT 0
)
GO


ALTER TABLE Pet_Porte
       ADD CONSTRAINT XPKPet_Porte PRIMARY KEY (IDPorte)
GO


CREATE TABLE Pet_Race (
       IDRace               int NOT NULL,
       Race                 varchar(50) NOT NULL,
       System               bit NULL DEFAULT 0,
       Hidden               bit NULL DEFAULT 0,
       Desativado           bit NULL DEFAULT 0
)
GO


ALTER TABLE Pet_Race
       ADD CONSTRAINT XPKPet_Race PRIMARY KEY (IDRace)
GO

CREATE TABLE Pet_Species (
       IDSpecies            int NOT NULL,
       Species              varchar(50) NOT NULL,
       System               bit NULL DEFAULT 0,
       Hidden               bit NULL DEFAULT 0,
       Desativado           bit NULL DEFAULT 0
)
GO

ALTER TABLE Pet_Species
       ADD CONSTRAINT XPKPet_Species PRIMARY KEY (IDSpecies)
GO

ALTER TABLE Pet
       ADD CONSTRAINT FK_Porte_IDPorte_Pet_IDPorte
              FOREIGN KEY (IDPorte)
                             REFERENCES Pet_Porte
GO

ALTER TABLE Pet
       ADD CONSTRAINT FK_Race_IDRace_Pet_IDRace
              FOREIGN KEY (IDRace)
                             REFERENCES Pet_Race
GO

ALTER TABLE Pet
       ADD CONSTRAINT FK_Pet_Species_IDSpecies_Pet_Species_IDSpecies
              FOREIGN KEY (IDSpecies)
                             REFERENCES Pet_Species
GO

ALTER TABLE Pet_PessoaToPet
       ADD CONSTRAINT FK_Pet_IDPet_Pet_PessoaToPet_IDPet
              FOREIGN KEY (IDPet)
                             REFERENCES Pet
GO

ALTER TABLE Pet_PessoaToPet
       ADD CONSTRAINT FK_Pessoa_IDPessoa_Pet_PessoaToPet_IDPessoa
              FOREIGN KEY (IDPessoa)
                             REFERENCES Pessoa
GO
