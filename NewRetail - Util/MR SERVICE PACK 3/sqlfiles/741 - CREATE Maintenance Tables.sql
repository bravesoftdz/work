CREATE TABLE Mnt_Store
(
	MRKey varchar(100) NULL
)

CREATE TABLE Mnt_Controler (
       Software             varchar(50) NOT NULL,
       Info                 text NULL
)
GO

ALTER TABLE Mnt_Controler
       ADD CONSTRAINT XPKMnt_Controler PRIMARY KEY (Software)
GO
