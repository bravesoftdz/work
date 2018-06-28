CREATE TABLE Sal_FrequentPromo (
       IDFrequentPromo      int NOT NULL,
       IDPessoa             int NOT NULL,
       IDModel              int NOT NULL,
       Qty                  Decimal(38, 4) NULL,
       IsUsed               bit NULL
                                   CONSTRAINT DF_Zero3841
                                          DEFAULT 0
)
GO

ALTER TABLE Sal_FrequentPromo
       ADD CONSTRAINT XPKSal_FrequentPromo PRIMARY KEY (
              IDFrequentPromo)
GO

ALTER TABLE Sal_FrequentPromo
       ADD CONSTRAINT FK_Model_Sal_FrequentPromo_IDModel
              FOREIGN KEY (IDModel)
                             REFERENCES Model
GO

ALTER TABLE Sal_FrequentPromo
       ADD CONSTRAINT FK_Pessoa_Sal_FrequentPromo_IDPessoa
              FOREIGN KEY (IDPessoa)
                             REFERENCES Pessoa
GO
