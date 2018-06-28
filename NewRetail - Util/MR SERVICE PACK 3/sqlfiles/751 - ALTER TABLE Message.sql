ALTER TABLE Sis_Message ADD
	Desativado bit NOT NULL DEFAULT 0
GO

ALTER TABLE Sis_MessageUser ADD
	Desativado bit NOT NULL DEFAULT 0
GO
