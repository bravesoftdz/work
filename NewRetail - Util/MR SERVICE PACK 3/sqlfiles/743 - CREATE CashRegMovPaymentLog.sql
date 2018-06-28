CREATE TABLE CashRegMovPaymentLog (
       IDPaymentLog         int NOT NULL,
       IDCashRegMov         int NOT NULL,
       IDMeioPag            int NOT NULL,
       IDBanco              int NOT NULL,
       SaleCode             varchar(20) NULL,
       PreSaleDate          datetime NULL,
       InvoiceTotal         money NULL,
       CheckNumber          varchar(20) NULL,
       CustomerDocument     varchar(20) NULL,
       CustomerName         varchar(80) NULL,
       CustomerPhone        varchar(20) NULL,
       ValorNominal         money NULL,
       DataVencimento       datetime NULL,
       NumDesdobramento     varchar(20) NULL
)
GO

ALTER TABLE CashRegMovPaymentLog
       ADD CONSTRAINT XPKCashRegMovPaymentLog PRIMARY KEY (
              IDPaymentLog)
GO

ALTER TABLE CashRegMovPaymentLog
       ADD CONSTRAINT FK_Fin_Banco_CashRegMovPaymentLog_IDBanco
              FOREIGN KEY (IDBanco)
                             REFERENCES Fin_Banco
GO

ALTER TABLE CashRegMovPaymentLog
       ADD CONSTRAINT FK_MeioPag_CashRegMovPaymentLog_IDMeioPag
              FOREIGN KEY (IDMeioPag)
                             REFERENCES MeioPag
GO

ALTER TABLE CashRegMovPaymentLog
       ADD CONSTRAINT FK_CashRegMov_CashRegMovPaymentLog_IDCashRegMov
              FOREIGN KEY (IDCashRegMov)
                             REFERENCES CashRegMov
GO
