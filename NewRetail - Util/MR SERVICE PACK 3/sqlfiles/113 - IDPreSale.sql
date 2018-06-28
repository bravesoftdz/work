ALTER TABLE Invoice ADD IDPreSaleParent int NULL
GO

ALTER TABLE Invoice
       ADD CONSTRAINT FK_Invoice_Invoice_IDPresaleParent
              FOREIGN KEY (IDPreSaleParent)
                             REFERENCES Invoice
GO
