ALTER TABLE InvoiceOBS 
       ADD IDUserDeliver int NULL
GO

ALTER TABLE InvoiceOBS
       ADD CONSTRAINT FK_SystemUser_InvoiceOBS_IDUser
              FOREIGN KEY (IDUserDeliver)
                             REFERENCES SystemUser
GO
