CREATE TABLE InvoiceOBS (
       IDInvoiceOBS         int NOT NULL,
       IDPreSale            int NULL,
       ObsDate              datetime NULL,
       Obs                  varchar(255) NULL
)
GO

CREATE INDEX XIF1InvoiceOBS ON InvoiceOBS
(
       IDPreSale
)
GO

ALTER TABLE InvoiceOBS
       ADD CONSTRAINT PK_InvoiceOBS_IDInvoiceOBS PRIMARY KEY (
              IDInvoiceOBS)
GO

ALTER TABLE InvoiceOBS
       ADD CONSTRAINT FK_Invoice_InvoiceOBS_IDPreSale
              FOREIGN KEY (IDPreSale)
                             REFERENCES Invoice
GO
