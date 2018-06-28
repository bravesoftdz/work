CREATE TABLE Mnt_DefaultInvoiceOBS (
	IDDefaultInvoiceOBS int NOT NULL,
	OBSType int NOT NULL,
	DefaultInvoiceOBS varchar(80) NOT NULL
)
GO

ALTER TABLE Mnt_DefaultInvoiceOBS ADD CONSTRAINT
	PK_Mnt_DefaultInvoiceOBS PRIMARY KEY (IDDefaultInvoiceOBS)
GO
