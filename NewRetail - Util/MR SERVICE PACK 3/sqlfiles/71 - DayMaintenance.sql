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

CREATE TABLE dbo.Tmp_DailyMaintenanceReport
	(
	IDDailyMaintenanceReport int NOT NULL,
	[Date] datetime NOT NULL,
	Maintenance varchar(35) NOT NULL,
	LastMessage varchar(255) NULL
	)  ON [PRIMARY]
GO

IF EXISTS(SELECT * FROM dbo.DailyMaintenanceReport)
	 EXEC('INSERT INTO dbo.Tmp_DailyMaintenanceReport (IDDailyMaintenanceReport, [Date], Maintenance, LastMessage)
		SELECT IDDailyMaintenanceReport, [Date], Maintenance, LastMessage FROM dbo.DailyMaintenanceReport TABLOCKX')
GO

DROP TABLE dbo.DailyMaintenanceReport
GO

EXECUTE sp_rename N'dbo.Tmp_DailyMaintenanceReport', N'DailyMaintenanceReport', 'OBJECT'
GO

ALTER TABLE dbo.DailyMaintenanceReport ADD CONSTRAINT
	PK__DailyMaintenance__57DD0BE4 PRIMARY KEY CLUSTERED 
	(
	IDDailyMaintenanceReport
	) ON [PRIMARY]

GO

