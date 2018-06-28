CREATE TABLE Ent_CustomerDiscount (
       IDTipoPessoa         int NOT NULL,
       IDGroup              int NOT NULL,
       Discount             TPercentual
)
GO

CREATE INDEX XIF1Ent_CustomerDiscount ON Ent_CustomerDiscount
(
       IDTipoPessoa
)
GO

CREATE INDEX XIF2Ent_CustomerDiscount ON Ent_CustomerDiscount
(
       IDGroup
)
GO


ALTER TABLE Ent_CustomerDiscount
       ADD CONSTRAINT XPKEnt_CustomerDiscount PRIMARY KEY (
              IDTipoPessoa, IDGroup)
GO


ALTER TABLE Ent_CustomerDiscount
       ADD CONSTRAINT FK_TabGroup_CustomerDiscount_IDGroup
              FOREIGN KEY (IDGroup)
                             REFERENCES TabGroup
GO


ALTER TABLE Ent_CustomerDiscount
       ADD CONSTRAINT FK_TipoPessoa_CustomerDiscount_IDTipoPessoa
              FOREIGN KEY (IDTipoPessoa)
                             REFERENCES TipoPessoa
GO
