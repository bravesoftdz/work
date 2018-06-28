ALTER TABLE Pet ADD
       IDStatus             int NULL,
       IDBreeder            int NULL,
       SKU                  varchar(30) NULL,
       PenNum               varchar(10) NULL,
       VendorCost           money NULL,
       MSRP                 money NULL,
       SalePrice            money NULL,
       PromoPrice           money NULL,
       USDA                 varchar(50) NULL,
       Collar               varchar(50) NULL,
       Sire                 varchar(255) NULL,
       Dam                  varchar(255) NULL,
       WhelpDate            datetime NULL,
       PurchaseDate         datetime NULL,
       Notes                varchar(255) NULL

GO

ALTER TABLE Pet
       ADD CONSTRAINT FK_Pessoa_IDPessoa_Pet_IDBreeder
              FOREIGN KEY (IDBreeder)
                             REFERENCES Pessoa
GO


ALTER TABLE Pet
       ADD CONSTRAINT FK_Pet_Status_IDStatus_Pet_IDStatus
              FOREIGN KEY (IDStatus)
                             REFERENCES Pet_Status
GO


CREATE INDEX XIE_Pet_SKU ON Pet
(
       SKU
)
GO

CREATE INDEX XIE_Pet_Collar ON Pet
(
       Collar
)
GO

ALTER TABLE Pet ALTER COLUMN
	name varchar(50) NULL
GO
