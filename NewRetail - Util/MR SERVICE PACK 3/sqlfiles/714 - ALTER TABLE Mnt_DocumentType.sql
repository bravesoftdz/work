ALTER TABLE Mnt_DocumentType ADD
	DefaultType bit NOT NULL CONSTRAINT DF_MntDocumentType_DefaultType_False DEFAULT 0
GO
