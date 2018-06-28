ALTER TABLE InvoiceOBS ADD
       IDCarrier            int NULL,
       FreightType          int NULL
GO

ALTER TABLE InvoiceOBS
       ADD CONSTRAINT FK_Pessoa_InvoiceOBS_IDCarrier
              FOREIGN KEY (IDCarrier)
                             REFERENCES Pessoa
GO
