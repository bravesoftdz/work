ALTER TABLE History 
       ADD IDServiceOrder int NULL
GO
ALTER TABLE History
       ADD CONSTRAINT FK_Ser_ServiceOrder_History_IDServiceOrder
              FOREIGN KEY (IDServiceOrder)
                             REFERENCES Ser_ServiceOrder
GO
