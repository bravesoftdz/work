CREATE TABLE Inv_ColorToGroup (
       IDSizeColorGroup     int NOT NULL,
       IDColor              int NOT NULL
)
GO

CREATE INDEX XIF1Inv_ColorToGroup ON Inv_ColorToGroup
(
       IDSizeColorGroup
)
GO

ALTER TABLE Inv_ColorToGroup
       ADD CONSTRAINT XPKInv_ColorToGroup PRIMARY KEY (
              IDSizeColorGroup, IDColor)
GO

CREATE TABLE Inv_SizeColorGroup (
       IDSizeColorGroup     int NOT NULL,
       Description          varchar(50) NOT NULL,
       IsColor              bit NOT NULL DEFAULT 0,
       System               bit NULL DEFAULT 0,
       Hidden               bit NULL DEFAULT 0,
       Desativado           bit NULL DEFAULT 0
)
GO

ALTER TABLE Inv_SizeColorGroup
       ADD CONSTRAINT XPKInv_SizeColorGroup PRIMARY KEY (
              IDSizeColorGroup)
GO

CREATE TABLE Inv_SizeToGroup (
       IDSizeColorGroup     int NOT NULL,
       IDSize               int NOT NULL
)
GO

CREATE INDEX XIF1Inv_SizeToGroup ON Inv_SizeToGroup
(
       IDSizeColorGroup
)
GO

ALTER TABLE Inv_SizeToGroup
       ADD CONSTRAINT XPKInv_SizeToGroup PRIMARY KEY (
              IDSizeColorGroup, IDSize)
GO

ALTER TABLE Inv_ColorToGroup
       ADD CONSTRAINT FK_SizeToColorGroup_IDSizeColorGroup_ColorToGroup_IDSizeColorGroup
              FOREIGN KEY (IDSizeColorGroup)
                             REFERENCES Inv_SizeColorGroup
GO

ALTER TABLE Inv_SizeToGroup
       ADD CONSTRAINT FK_SizeToColorGroup_IDSizeColorGroup_SizeToGroup_IDSizeColorGroup
              FOREIGN KEY (IDSizeColorGroup)
                             REFERENCES Inv_SizeColorGroup
GO
