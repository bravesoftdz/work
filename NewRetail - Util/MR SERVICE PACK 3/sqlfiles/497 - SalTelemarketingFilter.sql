CREATE TABLE Sal_TelemarketingFilter (
	IDTelemarketingFilter int NOT NULL,
	FilterName varchar(30) NOT NULL,
	FilterValues text NOT NULL,
	SQL text NOT NULL
)
GO

ALTER TABLE Sal_TelemarketingFilter ADD
	CONSTRAINT XPKSal_TelemarketingFilter PRIMARY KEY (IDTelemarketingFilter)
GO
