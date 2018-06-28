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

CREATE TABLE dbo.Tmp_Pais
	(
	IDPais int NOT NULL,
	CodPais varchar(3) NOT NULL,
	Pais varchar(50) NOT NULL,
	Desativado bit NULL,
	hidden bit NULL,
	system bit NULL
	)  ON [PRIMARY]
GO

IF EXISTS(SELECT * FROM dbo.Pais)
	 EXEC('INSERT INTO dbo.Tmp_Pais (IDPais, CodPais, Pais, Desativado, hidden, system)
		SELECT IDPais, CodPais, Pais, Desativado, hidden, system FROM dbo.Pais TABLOCKX')
GO

DECLARE @temp Varchar (8000)
SET @temp = ''
SELECT @temp = @temp + 'ALTER TABLE ' + TabelaDerivada+ CHAR (13)+
+ CHAR(9)+'DROP CONSTRAINT ' + ConstraintName + CHAR (13)
FROM vw_Sis_ChaveEstrangeira
WHERE TabelaOriginal = 'Pais'
EXEC(@temp)
GO

DROP TABLE dbo.Pais
GO

ALTER TABLE dbo.Tmp_Pais ADD CONSTRAINT
	DF_Zero24 DEFAULT (0) FOR Desativado
GO

ALTER TABLE dbo.Tmp_Pais ADD CONSTRAINT
	DF_Zero25 DEFAULT (0) FOR hidden
GO

ALTER TABLE dbo.Tmp_Pais ADD CONSTRAINT
	DF_Zero26 DEFAULT (0) FOR system
GO

EXECUTE sp_rename N'dbo.Tmp_Pais', N'Pais', 'OBJECT'
GO

ALTER TABLE dbo.Pais ADD CONSTRAINT
	PK__Pais__3C69FB99 PRIMARY KEY CLUSTERED 
	(
	IDPais
	) ON [PRIMARY]

GO

ALTER TABLE dbo.Pessoa WITH NOCHECK ADD CONSTRAINT
	FK_Pais_Pessoa_IDPais FOREIGN KEY
	(
	IDPais
	) REFERENCES dbo.Pais
	(
	IDPais
	) NOT FOR REPLICATION
GO

