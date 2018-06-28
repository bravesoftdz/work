CREATE TABLE Pet_Transfer (
       IDPetTransfer        int NOT NULL,
       IDPet                int NOT NULL,
       IDStoreSource        int NOT NULL,
       IDStoreDest          int NOT NULL,
       IDUser               int NOT NULL,
       TransferDate         datetime NULL
)
GO

ALTER TABLE Pet_Transfer
       ADD CONSTRAINT XPKPet_Transfer PRIMARY KEY (IDPetTransfer)
GO

ALTER TABLE Pet_Transfer
       ADD CONSTRAINT FK_Store_Pet_Transfer_IDStoreDest
              FOREIGN KEY (IDStoreDest)
                             REFERENCES Store
GO

ALTER TABLE Pet_Transfer
       ADD CONSTRAINT FK_Store_Pet_Transfer_IDStoreSource
              FOREIGN KEY (IDStoreSource)
                             REFERENCES Store
GO

ALTER TABLE Pet_Transfer
       ADD CONSTRAINT FK_SystemUser_IDUser_Pet_Transfer_IDSystemUser
              FOREIGN KEY (IDUser)
                             REFERENCES SystemUser
GO

ALTER TABLE Pet_Transfer
       ADD CONSTRAINT FK_Pet_IDPet_Pet_Transfer_IDPet
              FOREIGN KEY (IDPet)
                             REFERENCES Pet
GO

INSERT  Sis_CodigoIncremental (Tabela, UltimoCodigo)
SELECT 'Pet_Transfer.IDPetTransfer', UltimoCodigo
FROM Sis_CodigoIncremental
WHERE Tabela = 'Media.IDMedia'
GO
