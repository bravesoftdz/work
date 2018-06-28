ALTER TABLE Fin_Lancamento ADD PaymentPlace int NULL
GO

CREATE TABLE InvoiceToCostType (
       IDInvoiceCost        int NOT NULL,
       IDPreSale            int NOT NULL,
       IDCostType           int NOT NULL,
       Amount               money NULL
       CONSTRAINT DF_ZeroCostType DEFAULT 0
)
GO

ALTER TABLE InvoiceToCostType
       ADD CONSTRAINT XPKInvoiceToCostType PRIMARY KEY (IDInvoiceCost)
GO

ALTER TABLE InvoiceToCostType
       ADD CONSTRAINT FK_CostType_InvoiceToCostType_IDCostType
              FOREIGN KEY (IDCostType)
                             REFERENCES CostType
GO

ALTER TABLE InvoiceToCostType
       ADD CONSTRAINT FK_Invoice_InvoiceToCostType_IDPreSale
              FOREIGN KEY (IDPreSale)
                             REFERENCES Invoice
GO
 
ALTER TABLE Invoice ADD IDFormOfPayment int NULL
GO

ALTER TABLE Invoice ADD AditionalExpenses money NULL 
CONSTRAINT DF_ZeroAdExp DEFAULT 0
GO

ALTER TABLE MeioPag ADD ImageIndex int NULL
GO

Update MeioPag Set ImageIndex = 1
Where IDMeioPag = 1
GO

Update MeioPag Set ImageIndex = 2
Where IDMeioPag = 2
GO

Update MeioPag Set ImageIndex = 3
Where IDMeioPag = 3
GO

Update MeioPag Set ImageIndex = 4
Where IDMeioPag = 4
GO

Update MeioPag Set ImageIndex = 6
Where IDMeioPag = 5
GO

Update MeioPag Set ImageIndex = 7
Where IDMeioPag = 6
GO

ALTER TABLE Param ADD Desativado Boolean Default 0
GO

UPDATE Param SET Desativado = 0
GO

CREATE TABLE InvAccessory (
       IDInvAccessory       int NOT NULL,
       IDModel              int NOT NULL,
       Description          varchar(255) NULL
)
GO

CREATE INDEX XIF6InvAccessory ON InvAccessory
(
       IDModel
)
GO

CREATE INDEX XIF7InvAccessory ON InvAccessory
(
       IDInvAccessory
)
GO

ALTER TABLE InvAccessory
       ADD CONSTRAINT XPKInvAccessory PRIMARY KEY (IDInvAccessory, 
              IDModel)
GO

ALTER TABLE InvAccessory
       ADD CONSTRAINT FK_Model_InvAccessory_IDInvAccessory
              FOREIGN KEY (IDInvAccessory)
                             REFERENCES Model
GO

ALTER TABLE InvAccessory
       ADD CONSTRAINT FK_Model_InvAccessory_IDModel
              FOREIGN KEY (IDModel)
                             REFERENCES Model
GO

ALTER TABLE DeliverType add CanConfirmDeliver TBit default 0
GO