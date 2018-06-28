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

CREATE TABLE dbo.Tmp_Sis_Language
	(
	IDLanguage int NOT NULL,
	[Language] varchar(20) NULL
	)  ON [PRIMARY]
GO

IF EXISTS(SELECT * FROM dbo.Sis_Language)
	 EXEC('INSERT INTO dbo.Tmp_Sis_Language (IDLanguage, [Language])
		SELECT IDLanguage, [Language] FROM dbo.Sis_Language TABLOCKX')
GO

DECLARE @temp Varchar (8000)
SET @temp = ''
SELECT @temp = @temp + 'ALTER TABLE ' + TabelaDerivada+ CHAR (13)+
+ CHAR(9)+'DROP CONSTRAINT ' + ConstraintName + CHAR (13)
FROM vw_Sis_ChaveEstrangeira
WHERE TabelaOriginal = 'Sis_Language'
EXEC(@temp)
GO

DROP TABLE dbo.Sis_Language
GO

EXECUTE sp_rename N'dbo.Tmp_Sis_Language', N'Sis_Language', 'OBJECT'
GO

ALTER TABLE dbo.Sis_Language ADD CONSTRAINT
	XPKSis_Language PRIMARY KEY CLUSTERED 
	(
	IDLanguage
	) ON [PRIMARY]
GO

ALTER TABLE dbo.ParamLanguage WITH NOCHECK ADD CONSTRAINT
	FK_Sis_Language_Param_IDLanguage FOREIGN KEY
	(
	IDLanguage
	) REFERENCES dbo.Sis_Language
	(
	IDLanguage
	)
GO

ALTER TABLE dbo.SysFunctionLanguage WITH NOCHECK ADD CONSTRAINT
	FK_Sis_Language_SysFunctionLanguage_IDLanguage FOREIGN KEY
	(
	IDLanguage
	) REFERENCES dbo.Sis_Language
	(
	IDLanguage
	)
GO

ALTER TABLE dbo.MenuItemLanguage WITH NOCHECK ADD CONSTRAINT
	FK_Sis_Language_MenuItem_IDLanguage FOREIGN KEY
	(
	IDLanguage
	) REFERENCES dbo.Sis_Language
	(
	IDLanguage
	)
GO

ALTER TABLE dbo.MenuMainLanguage WITH NOCHECK ADD CONSTRAINT
	FK_Sis_Language_MenuMainLanguage_IDLanguage FOREIGN KEY
	(
	IDLanguage
	) REFERENCES dbo.Sis_Language
	(
	IDLanguage
	)
GO

ALTER TABLE dbo.Sis_MainMenuLanguage WITH NOCHECK ADD CONSTRAINT
	FK_Sis_Language_Sis_MainMenuLanguage_IDLanguage FOREIGN KEY
	(
	IDLanguage
	) REFERENCES dbo.Sis_Language
	(
	IDLanguage
	)
GO

IF NOT EXISTS(select * from dbo.sysobjects 
	where id = object_id(N'[dbo].[FK_Param_ParamLanguage_IDParam]'))
	 EXEC('ALTER TABLE dbo.ParamLanguage WITH NOCHECK ADD CONSTRAINT
		FK_Param_ParamLanguage_IDParam FOREIGN KEY
		(
		IDParam
		) REFERENCES dbo.Param
		(
		IDParam)')
GO

