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

CREATE TABLE dbo.Tmp_Sis_AppHistory
	(
	IDHistory int NOT NULL,
	IDUsuario int NULL,
	ErrorLevel int NULL,
	FormSource varchar(255) NULL,
	ErrorMessage text NULL,
	HistoryDate datetime NULL,
	Software varchar(20) NULL
	)  ON [PRIMARY]
	 TEXTIMAGE_ON [PRIMARY]
GO

IF EXISTS(SELECT * FROM dbo.Sis_AppHistory)
	 EXEC('INSERT INTO dbo.Tmp_Sis_AppHistory (IDHistory, IDUsuario, ErrorLevel, FormSource, ErrorMessage, HistoryDate, Software)
		SELECT IDHistory, IDUsuario, ErrorLevel, FormSource, ErrorMessage, HistoryDate, Software FROM dbo.Sis_AppHistory TABLOCKX')
GO

DROP TABLE dbo.Sis_AppHistory
GO

EXECUTE sp_rename N'dbo.Tmp_Sis_AppHistory', N'Sis_AppHistory', 'OBJECT'
GO

ALTER TABLE dbo.Sis_AppHistory ADD CONSTRAINT
	PK__Sis_AppHistory__32616E72 PRIMARY KEY CLUSTERED 
	(
	IDHistory
	) ON [PRIMARY]

GO

CREATE NONCLUSTERED INDEX XIF813Sis_AppHistory ON dbo.Sis_AppHistory
	(
	IDUsuario
	) ON [PRIMARY]
GO

ALTER TABLE dbo.Sis_AppHistory WITH NOCHECK ADD CONSTRAINT
	FK_SystemUser_Sis_AppHistory_IDUsuario FOREIGN KEY
	(
	IDUsuario
	) REFERENCES dbo.SystemUser
	(
	IDUser
	)
GO

