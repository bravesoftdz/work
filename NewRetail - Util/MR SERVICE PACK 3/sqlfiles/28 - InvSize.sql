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

CREATE TABLE dbo.Tmp_InvSize
	(
	IDSize int NOT NULL,
	SizeName varchar(20) NOT NULL,
	Hidden bit NULL,
	Desativado bit NULL,
	System bit NULL,
	CodSize varchar(10) NULL
	)  ON [PRIMARY]
GO

IF EXISTS(SELECT * FROM dbo.InvSize)
	 EXEC('INSERT INTO dbo.Tmp_InvSize (IDSize, SizeName, Hidden, Desativado, System, CodSize)
		SELECT IDSize, SizeName, Hidden, Desativado, System, CodSize FROM dbo.InvSize TABLOCKX')
GO

DECLARE @temp Varchar (8000)
SET @temp = ''
SELECT @temp = @temp + 'ALTER TABLE ' + TabelaDerivada+ CHAR (13)+
+ CHAR(9)+'DROP CONSTRAINT ' + ConstraintName + CHAR (13)
FROM vw_Sis_ChaveEstrangeira
WHERE TabelaOriginal = 'InvSize'
EXEC(@temp)
GO

DROP TABLE dbo.InvSize
GO

ALTER TABLE dbo.Tmp_InvSize ADD CONSTRAINT
	DF_Zero DEFAULT (0) FOR Hidden
GO

ALTER TABLE dbo.Tmp_InvSize ADD CONSTRAINT
	DF_Zero2 DEFAULT (0) FOR Desativado
GO

ALTER TABLE dbo.Tmp_InvSize ADD CONSTRAINT
	DF_Zero3 DEFAULT (0) FOR System
GO

EXECUTE sp_rename N'dbo.Tmp_InvSize', N'InvSize', 'OBJECT'
GO

ALTER TABLE dbo.InvSize ADD CONSTRAINT
	PK__InvSize__1367E606 PRIMARY KEY CLUSTERED 
	(
	IDSize
	) ON [PRIMARY]

GO

ALTER TABLE dbo.Model WITH NOCHECK ADD CONSTRAINT
	FK_InvSize_Model_IDSize FOREIGN KEY
	(
	IDSize
	) REFERENCES dbo.InvSize
	(
	IDSize
	) NOT FOR REPLICATION

GO

