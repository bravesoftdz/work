ALTER TABLE Ser_SOItemProduct
	ADD IDCustomer int NULL
GO

ALTER TABLE Ser_SOItemProduct
       ADD CONSTRAINT FK_Pessoa_Ser_SOItemProduct_IDCustomer
              FOREIGN KEY (IDCustomer)
                             REFERENCES Pessoa
GO
