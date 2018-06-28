ALTER TABLE Model ADD PromotionPrice money NULL
GO

ALTER TABLE Model ADD DiscountPerc float NULL
GO

ALTER TABLE Pessoa ADD UserCode varchar(5) NULL
GO

ALTER TABLE TabGroup ADD UserCode varchar(5) NULL
GO

CREATE TABLE VendorModelCode (
       IDVendorModelCode    int NOT NULL,
       IDPessoa             int NULL,
       IDModel              int NULL,
       VendorCode           varchar(10) NULL
)
GO

CREATE INDEX XIF1VendorModelCode ON VendorModelCode
(
       IDPessoa
)
GO

CREATE INDEX XIF2VendorModelCode ON VendorModelCode
(
       IDModel
)
GO


ALTER TABLE VendorModelCode
       ADD CONSTRAINT XPKVendorModelCode PRIMARY KEY (
              IDVendorModelCode)
GO


ALTER TABLE VendorModelCode
       ADD CONSTRAINT FK_Model_VendorCode_IDModel
              FOREIGN KEY (IDModel)
                             REFERENCES Model
GO


ALTER TABLE VendorModelCode
       ADD CONSTRAINT FK_Pessoa_VendorCode_IDPessoa
              FOREIGN KEY (IDPessoa)
                             REFERENCES Pessoa
GO
