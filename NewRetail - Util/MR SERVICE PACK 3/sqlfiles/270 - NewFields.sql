ALTER TABLE Estimated ADD IDPreSale int NULL
GO

CREATE INDEX XIF4Estimated ON Estimated
(
       IDPreSale
)
GO

ALTER TABLE Estimated
       ADD CONSTRAINT FK_Invoice_Estimated_IDPreSale
              FOREIGN KEY (IDPreSale)
                             REFERENCES Invoice
GO

ALTER TABLE SubGroup ADD UserCode varchar(5) NULL
GO
