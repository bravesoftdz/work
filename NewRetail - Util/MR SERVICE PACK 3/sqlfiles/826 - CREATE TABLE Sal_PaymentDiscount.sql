ALTER TABLE Ser_SOItemProduct
       ADD Discount money NULL CONSTRAINT DF_ZeroSOItem DEFAULT 0
GO

CREATE TABLE Sal_PaymentDiscount (
       IDPaymentDiscount    int NOT NULL,
       IDMeioPag            int NULL,
       DiscountPercent      money NULL
)
GO

ALTER TABLE Sal_PaymentDiscount
       ADD CONSTRAINT XPKSal_PaymentDiscount PRIMARY KEY (
              IDPaymentDiscount)
GO

ALTER TABLE Sal_PaymentDiscount
       ADD CONSTRAINT FK_MeioPag_Sal_PaymentDiscount_IDMeioPag
              FOREIGN KEY (IDMeioPag)
                             REFERENCES MeioPag
GO
