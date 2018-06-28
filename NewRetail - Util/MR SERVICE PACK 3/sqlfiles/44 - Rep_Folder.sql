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

CREATE TABLE dbo.Tmp_Rep_Folder
	(
	FolderId int NOT NULL,
	Name varchar(60) NULL,
	ParentId int NULL
	)  ON [PRIMARY]
GO

IF EXISTS(SELECT * FROM dbo.Rep_Folder)
	 EXEC('INSERT INTO dbo.Tmp_Rep_Folder (FolderId, Name, ParentId)
		SELECT FolderId, Name, ParentId FROM dbo.Rep_Folder TABLOCKX')
GO

DECLARE @temp Varchar (8000)
SET @temp = ''
SELECT @temp = @temp + 'ALTER TABLE ' + TabelaDerivada+ CHAR (13)+
+ CHAR(9)+'DROP CONSTRAINT ' + ConstraintName + CHAR (13)
FROM vw_Sis_ChaveEstrangeira
WHERE TabelaOriginal = 'Rep_Folder'
EXEC(@temp)
GO

DROP TABLE dbo.Rep_Folder
GO

EXECUTE sp_rename N'dbo.Tmp_Rep_Folder', N'Rep_Folder', 'OBJECT'
GO

ALTER TABLE dbo.Rep_Folder ADD CONSTRAINT
	XPKRep_Folder PRIMARY KEY CLUSTERED 
	(
	FolderId
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX XIF395Rep_Folder ON dbo.Rep_Folder
	(
	ParentId
	) ON [PRIMARY]
GO

ALTER TABLE dbo.Rep_Folder WITH NOCHECK ADD CONSTRAINT
	FK_RepFolder_RepFolder_ParentId FOREIGN KEY
	(
	ParentId
	) REFERENCES dbo.Rep_Folder
	(
	FolderId
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.Rep_FolderToTable WITH NOCHECK ADD CONSTRAINT
	FK_RepFolder_RepFolderToTable_FolderId FOREIGN KEY
	(
	FolderId
	) REFERENCES dbo.Rep_Folder
	(
	FolderId
	) NOT FOR REPLICATION
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

