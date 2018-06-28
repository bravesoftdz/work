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

CREATE TABLE dbo.Tmp_InvColor
	(
	IDColor int NOT NULL,
	Color varchar(20) NOT NULL,
	Desativado bit NULL,
	Hidden bit NULL,
	System bit NULL,
	CodColor varchar(10) NULL
	)  ON [PRIMARY]
GO

IF EXISTS(SELECT * FROM dbo.InvColor)
	 EXEC('INSERT INTO dbo.Tmp_InvColor (IDColor, Color, Desativado, Hidden, System, CodColor)
		SELECT IDColor, Color, Desativado, Hidden, System, CodColor FROM dbo.InvColor TABLOCKX')
GO

DECLARE @temp Varchar (8000)
SET @temp = ''
SELECT @temp = @temp + 'ALTER TABLE ' + TabelaDerivada+ CHAR (13)+
+ CHAR(9)+'DROP CONSTRAINT ' + ConstraintName + CHAR (13)
FROM vw_Sis_ChaveEstrangeira
WHERE TabelaOriginal = 'InvColor'
EXEC(@temp)
GO

DROP TABLE dbo.InvColor
GO

ALTER TABLE dbo.Tmp_InvColor ADD CONSTRAINT
	DF_Zero004 DEFAULT (0) FOR Desativado
GO

ALTER TABLE dbo.Tmp_InvColor ADD CONSTRAINT
	DF_Zero005 DEFAULT (0) FOR Hidden
GO

ALTER TABLE dbo.Tmp_InvColor ADD CONSTRAINT
	DF_Zero006 DEFAULT (0) FOR System
GO

EXECUTE sp_rename N'dbo.Tmp_InvColor', N'InvColor', 'OBJECT'
GO

ALTER TABLE dbo.InvColor ADD CONSTRAINT
	PK__InvColor__182C9B23 PRIMARY KEY CLUSTERED 
	(
	IDColor
	) ON [PRIMARY]
GO

ALTER TABLE dbo.Model WITH NOCHECK ADD CONSTRAINT
	FK_InvColor_Model_IDColor FOREIGN KEY
	(
	IDColor
	) REFERENCES dbo.InvColor
	(
	IDColor
	) NOT FOR REPLICATION
GO

