CREATE TABLE Sal_InvoiceShipping (
	IDInvoiceShipping int NOT NULL,
	IDPreSale int NOT NULL,
	ShipDate datetime NOT NULL,
	Tracking varchar(255) NULL,
	IDDeliverType int NULL,
	AddressName varchar(30) NULL,
	Address varchar(50) NULL,
	City varchar(20) NULL,
	ZIP varchar(10) NULL,
	IDEstado char(3) NULL,
	IDPais int NULL
)
GO

ALTER TABLE Sal_InvoiceShipping ADD CONSTRAINT
	XPKSal_InvoiceShipping PRIMARY KEY (IDInvoiceShipping)
GO

ALTER TABLE Sal_InvoiceShipping ADD CONSTRAINT
	FK_DeliverType_SalInvoiceShipping_IDDeliverType FOREIGN KEY (IDDeliverType) REFERENCES DeliverType
GO

ALTER TABLE Sal_InvoiceShipping ADD CONSTRAINT
	FK_Invoice_SalInvoiceShipping_IDPreSale FOREIGN KEY (IDPreSale) REFERENCES Invoice
GO

ALTER TABLE Sal_InvoiceShipping ADD CONSTRAINT
	FK_Pais_SalInvoiceShipping_IDPais FOREIGN KEY (IDPais) REFERENCES Pais
GO

ALTER TABLE Sal_InvoiceShipping ADD CONSTRAINT
	FK_Estado_SalInvoiceShipping_IDEstado FOREIGN KEY (IDEstado) REFERENCES Estado
GO
