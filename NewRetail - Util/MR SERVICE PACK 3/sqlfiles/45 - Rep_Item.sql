SET QUOTED_IDENTIFIER ON
GO

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO

SET ARITHABORT ON
GO

SET NUMERIC_ROUNDABORT OFF
GO

SET CONCAT_NULL_YIELDS_NULL ON
GO

SET ANSI_NULLS ON
GO

SET ANSI_PADDING ON
GO

SET ANSI_WARNINGS ON
GO

CREATE TABLE dbo.Tmp_Rep_Item
	(
	ItemId int NOT NULL,
	FolderId int NULL,
	Name varchar(60) NULL,
	[Size] int NULL,
	ItemType int NULL,
	Modified datetime NULL,
	Deleted datetime NULL,
	Template image NULL,
	Filters text NULL
	)  ON [PRIMARY]
	 TEXTIMAGE_ON [PRIMARY]
GO

IF EXISTS(SELECT * FROM dbo.Rep_Item)
	 EXEC('INSERT INTO dbo.Tmp_Rep_Item (ItemId, FolderId, Name, [Size], ItemType, Modified, Deleted, Template, Filters)
		SELECT ItemId, FolderId, Name, [Size], ItemType, Modified, Deleted, Template, Filters FROM dbo.Rep_Item TABLOCKX')
GO

DROP TABLE dbo.Rep_Item
GO

ALTER TABLE dbo.Tmp_Rep_Item ADD CONSTRAINT
	DF_Zero142 DEFAULT (0) FOR ItemType
GO

EXECUTE sp_rename N'dbo.Tmp_Rep_Item', N'Rep_Item', 'OBJECT'
GO

ALTER TABLE dbo.Rep_Item ADD CONSTRAINT
	XPKRep_Item PRIMARY KEY CLUSTERED 
	(
	ItemId
	) ON [PRIMARY]

GO

CREATE NONCLUSTERED INDEX XIF178Rep_Item ON dbo.Rep_Item
	(
	FolderId
	) ON [PRIMARY]
GO

ALTER TABLE dbo.Rep_Item WITH NOCHECK ADD CONSTRAINT
	FK_RepFolder_RepItem_FolderId FOREIGN KEY
	(
	FolderId
	) REFERENCES dbo.Rep_Folder
	(
	FolderId
	) NOT FOR REPLICATION
GO

