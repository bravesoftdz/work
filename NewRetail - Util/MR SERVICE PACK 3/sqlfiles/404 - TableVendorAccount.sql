CREATE TABLE Mnt_StoreVendorAccount (
       IDStoreVendorAccount int NOT NULL,
       IDStore              int NOT NULL,
       IDPessoa             int NOT NULL,
       Account              varchar(35) NOT NULL
)
GO

ALTER TABLE Mnt_StoreVendorAccount
       ADD CONSTRAINT XPKMnt_StoreVendorAccount PRIMARY KEY (
              IDStoreVendorAccount)
GO

ALTER TABLE Mnt_StoreVendorAccount
       ADD CONSTRAINT FK_Pessoa_StoreVendorAccount_IDPessoa
              FOREIGN KEY (IDPessoa)
                             REFERENCES Pessoa
GO

ALTER TABLE Mnt_StoreVendorAccount
       ADD CONSTRAINT FK_Store_StoreVendorAccount_IDStore
              FOREIGN KEY (IDStore)
                             REFERENCES Store
GO
