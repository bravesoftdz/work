CREATE TABLE Sal_AccountCard (
       IDAccountCard        int NOT NULL,
       CardNumber           varchar(20) NOT NULL,
       CardDate             datetime NOT NULL,
       ExpirationDate       datetime NULL,
       Amount               money NOT NULL,
       IDPreInventoryMov    int NULL,
       IDUser               int NOT NULL,
       IDCustomer           int NULL,
       Canceled             int NULL
                                   CONSTRAINT DF_Zero2507
                                          DEFAULT 0
)
GO

ALTER TABLE Sal_AccountCard
       ADD CONSTRAINT XPKSal_AccountCard PRIMARY KEY (IDAccountCard)
GO

ALTER TABLE Sal_AccountCard
       ADD CONSTRAINT FK_Pessoa_SalAccountCard_IDCustomer
              FOREIGN KEY (IDCustomer)
                             REFERENCES Pessoa
GO

ALTER TABLE Sal_AccountCard
       ADD CONSTRAINT FK_SystemUser_SalAccountCard_IDUser
              FOREIGN KEY (IDUser)
                             REFERENCES SystemUser
GO

CREATE TABLE Sal_AccountCardMov (
       IDAccountCardMov     int NOT NULL,
       DateMov              datetime NOT NULL,
       Value                money NOT NULL,
       Credit               bit NOT NULL
                                   CONSTRAINT DF_Zero2508
                                          DEFAULT 0,
       IDPreSale            int NULL,
       IDLancamento         int NULL,
       IDUser               int NOT NULL,
       IDAccountCard        int NOT NULL
)
GO

ALTER TABLE Sal_AccountCardMov
       ADD CONSTRAINT XPKSal_AccountCardMov PRIMARY KEY (
              IDAccountCardMov)
GO

ALTER TABLE Sal_AccountCardMov
       ADD CONSTRAINT FK_Invoice_SalAccountCardMov_IDPreSale
              FOREIGN KEY (IDPreSale)
                             REFERENCES Invoice
GO

ALTER TABLE Sal_AccountCardMov
       ADD CONSTRAINT FK_FinLancamento_SalAccountCardMov_IDLancamento
              FOREIGN KEY (IDLancamento)
                             REFERENCES Fin_Lancamento
GO

ALTER TABLE Sal_AccountCardMov
       ADD CONSTRAINT FK_SystemUser_SalAccountCardMov_IDUser
              FOREIGN KEY (IDUser)
                             REFERENCES SystemUser
GO

ALTER TABLE Sal_AccountCardMov
       ADD CONSTRAINT FK_SalAccountCard_SalAccountCardMov_IDAccountCard
              FOREIGN KEY (IDAccountCard)
                             REFERENCES Sal_AccountCard
GO

ALTER TABLE Sal_AccountCardMov ADD
       Obs varchar(100) NULL
GO

