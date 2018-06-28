ALTER TABLE Estimated ADD
       IDDeliverType        int NULL,
       DeliverDate          datetime NULL,
       DeliverAddress       varchar(100) NULL,
       DeliverOBS           varchar(255) NULL,
       TotalDiscount        money NULL,
       Confirmed            bit NULL
GO

ALTER TABLE Estimated
       ADD CONSTRAINT FK_DeliverType_Estimated_IDDeliverType
              FOREIGN KEY (IDDeliverType)
                             REFERENCES DeliverType
GO

CREATE TABLE Sal_PaymentCondition (
       IDPaymentCondition   int NOT NULL,
       IDEstimated          int NULL,
       IDPreSale            int NULL,
       IDMeioPag            int NULL,
       Amount               money NULL,
       OBS                  varchar(100) NULL
)
GO

ALTER TABLE Sal_PaymentCondition
       ADD CONSTRAINT XPKSal_PaymentCondition PRIMARY KEY (
              IDPaymentCondition)
GO

ALTER TABLE Sal_PaymentCondition
       ADD CONSTRAINT FK_MeioPag_Sal_PaymentCondition_IDMeioPag
              FOREIGN KEY (IDMeioPag)
                             REFERENCES MeioPag
GO

ALTER TABLE Sal_PaymentCondition
       ADD CONSTRAINT FK_Invoice_Sal_PaymentCondition_IDPreSale
              FOREIGN KEY (IDPreSale)
                             REFERENCES Invoice
GO

ALTER TABLE Sal_PaymentCondition
       ADD CONSTRAINT FK_Estimated_Sal_PaymentCondition_IDEstimated
              FOREIGN KEY (IDEstimated)
                             REFERENCES Estimated
GO
