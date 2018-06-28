CREATE TABLE Sal_Promo (
       IDPromo              int NOT NULL,
       Barcode              varchar(20) NULL,
       Promo                varchar(35) NOT NULL,
       PromoType            int NOT NULL,
       QtyFrequent          float NULL,
       StartDate            datetime NOT NULL,
       EndDate              datetime NULL,
       DaysOfWeek           varchar(14) NULL,
       DiscountType         int NOT NULL,
       DiscountValue        float NOT NULL,
       QtyPromoItem         FLOAT NULL,
       System               Boolean
                                   CONSTRAINT DF_Zero2489
                                          DEFAULT 0,
       Hidden               Boolean
                                   CONSTRAINT DF_Zero2490
                                          DEFAULT 0,
       Desativado           Boolean
                                   CONSTRAINT DF_Zero2491
                                          DEFAULT 0,
       IDStore              int NULL
)
GO


ALTER TABLE Sal_Promo
       ADD CONSTRAINT XPKSal_Promo PRIMARY KEY (IDPromo)
GO


CREATE TABLE Sal_PromoItem (
       IDPromoItem          int NOT NULL,
       IDModel              int NOT NULL,
       IDPromo              int NOT NULL
)
GO


ALTER TABLE Sal_PromoItem
       ADD CONSTRAINT XPKSal_PromoItem PRIMARY KEY (IDPromoItem)
GO


CREATE TABLE Sal_PromoLoyaltyCustomer (
       IDPromo              int NOT NULL,
       IDTipoPessoa         int NOT NULL
)
GO


ALTER TABLE Sal_PromoLoyaltyCustomer
       ADD CONSTRAINT XPKSal_PromoLoyaltyCustomer PRIMARY KEY (
              IDPromo, IDTipoPessoa)
GO


CREATE TABLE Sal_PromoPrizeItem (
       IDPromoPrizeItem     int NOT NULL,
       IDModel              int NOT NULL,
       IDPromoItem          int NOT NULL
)
GO


ALTER TABLE Sal_PromoPrizeItem
       ADD CONSTRAINT XPKSal_PromoPrizeItem PRIMARY KEY (
              IDPromoPrizeItem)
GO


ALTER TABLE Sal_Promo
       ADD CONSTRAINT R_189
              FOREIGN KEY (IDStore)
                             REFERENCES Store
GO


ALTER TABLE Sal_PromoItem
       ADD CONSTRAINT R_193
              FOREIGN KEY (IDPromo)
                             REFERENCES Sal_Promo
GO


ALTER TABLE Sal_PromoItem
       ADD CONSTRAINT FK_Model_SalPromoItem_IDModel
              FOREIGN KEY (IDModel)
                             REFERENCES Model
GO


ALTER TABLE Sal_PromoLoyaltyCustomer
       ADD CONSTRAINT R_194
              FOREIGN KEY (IDPromo)
                             REFERENCES Sal_Promo
GO


ALTER TABLE Sal_PromoLoyaltyCustomer
       ADD CONSTRAINT FK_Model_SalPromoLoyaltyCustomer_IDTipoPessoa
              FOREIGN KEY (IDTipoPessoa)
                             REFERENCES TipoPessoa
GO


ALTER TABLE Sal_PromoPrizeItem
       ADD CONSTRAINT FK_SalPromoItem_SalPromoPrizeItem_IDPromoItem
              FOREIGN KEY (IDPromoItem)
                             REFERENCES Sal_PromoItem
GO


ALTER TABLE Sal_PromoPrizeItem
       ADD CONSTRAINT FK_Model_SalPromoPrizeItem_IDModel
              FOREIGN KEY (IDModel)
                             REFERENCES Model
GO
