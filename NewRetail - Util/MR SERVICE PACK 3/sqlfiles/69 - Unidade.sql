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

CREATE TABLE dbo.Tmp_Unidade
	(
	IDUnidade int NOT NULL,
	Unidade varchar(100) NOT NULL,
	Sigla char(4) NOT NULL
	)  ON [PRIMARY]
GO

IF EXISTS(SELECT * FROM dbo.Unidade)
	 EXEC('INSERT INTO dbo.Tmp_Unidade (IDUnidade, Unidade, Sigla)
		SELECT IDUnidade, Unidade, Sigla FROM dbo.Unidade TABLOCKX')
GO

DECLARE @temp Varchar (8000)
SET @temp = ''
SELECT @temp = @temp + 'ALTER TABLE ' + TabelaDerivada+ CHAR (13)+
+ CHAR(9)+'DROP CONSTRAINT ' + ConstraintName + CHAR (13)
FROM vw_Sis_ChaveEstrangeira
WHERE TabelaOriginal = 'Unidade'
EXEC(@temp)
GO

DROP TABLE dbo.Unidade
GO

EXECUTE sp_rename N'dbo.Tmp_Unidade', N'Unidade', 'OBJECT'
GO

ALTER TABLE dbo.Unidade ADD CONSTRAINT
	PK_Unidade_1__19 PRIMARY KEY CLUSTERED 
	(
	IDUnidade
	) ON [PRIMARY]

GO

ALTER TABLE dbo.Model WITH NOCHECK ADD CONSTRAINT
	FK_Unidade_Model_IDUnidade FOREIGN KEY
	(
	IDUnidade
	) REFERENCES dbo.Unidade
	(
	IDUnidade
	) NOT FOR REPLICATION
GO

