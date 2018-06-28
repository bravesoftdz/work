ALTER TABLE MenuItem
ADD Shortcut int
GO

ALTER TABLE MenuItem
ADD ImageIndex int
GO

ALTER TABLE Sys_Module 
ADD VersionType VARCHAR(15) NULL
GO

ALTER TABLE Sys_Module
ADD RestricForms Text 
GO

ALTER TABLE Rep_Field
ADD DataModule varchar(100)
GO

ALTER TABLE Rep_Field
ADD DataSet varchar(100)
GO

ALTER TABLE Rep_Field
ADD ListField varchar(100)
GO
