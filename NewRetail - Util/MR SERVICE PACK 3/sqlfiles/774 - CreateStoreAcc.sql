CREATE TABLE Sal_StoreAccount (
       IDStoreAccount       int NOT NULL,
       IDStoreAccountUsed   int NULL,
       IDPessoa             int NOT NULL,
       IDUser               int NOT NULL,
       IDStore              int NOT NULL,
       IDLancamento         int NULL,
       TransactionDate      datetime NULL,
       Amount               money NULL,
       IsUsed               bit NULL,
       IsReceiving          bit NULL DEFAULT 0
)
GO

ALTER TABLE Sal_StoreAccount
       ADD CONSTRAINT XPKSal_StoreAccount PRIMARY KEY (IDStoreAccount)
GO

ALTER TABLE Sal_StoreAccount
       ADD CONSTRAINT FK_Sal_StoreAcc_Sal_StoreAcc_IDStoreAccountUsed
              FOREIGN KEY (IDStoreAccountUsed)
                             REFERENCES Sal_StoreAccount
GO

ALTER TABLE Sal_StoreAccount
       ADD CONSTRAINT FK_Fin_Lancamento_Sal_StoreAcc_IDLancamento
              FOREIGN KEY (IDLancamento)
                             REFERENCES Fin_Lancamento
GO

ALTER TABLE Sal_StoreAccount
       ADD CONSTRAINT FK_Store_Sal_StoreAcc_IDStore
              FOREIGN KEY (IDStore)
                             REFERENCES Store
GO

ALTER TABLE Sal_StoreAccount
       ADD CONSTRAINT FK_SystemUser_Sal_StoreAcc_IDStore
              FOREIGN KEY (IDUser)
                             REFERENCES SystemUser
GO

ALTER TABLE Sal_StoreAccount
       ADD CONSTRAINT FK_Pessoa_Sal_StoreAcc_IDPessoa
              FOREIGN KEY (IDPessoa)
                             REFERENCES Pessoa
GO
