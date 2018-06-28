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

CREATE TABLE dbo.Tmp_Hotel
	(
	IDHotel int NOT NULL,
	Hotel varchar(50) NOT NULL,
	Endereco TAddress NULL,
	Cidade TCity NULL,
	CEP TZipCode NULL,
	Telefone TTelephone NULL,
	Fax TTelephone NULL,
	OBS varchar(255) NULL,
	System bit NULL,
	Desativado bit NULL,
	Hidden bit NULL
	)  ON [PRIMARY]
GO

IF EXISTS(SELECT * FROM dbo.Hotel)
	 EXEC('INSERT INTO dbo.Tmp_Hotel (IDHotel, Hotel, Endereco, Cidade, CEP, Telefone, Fax, OBS, System, Desativado, Hidden)
		SELECT IDHotel, Hotel, Endereco, Cidade, CEP, Telefone, Fax, OBS, System, Desativado, Hidden FROM dbo.Hotel TABLOCKX')
GO

DECLARE @temp Varchar (8000)
SET @temp = ''
SELECT @temp = @temp + 'ALTER TABLE ' + TabelaDerivada+ CHAR (13)+
+ CHAR(9)+'DROP CONSTRAINT ' + ConstraintName + CHAR (13)
FROM vw_Sis_ChaveEstrangeira
WHERE TabelaOriginal = 'Hotel'
EXEC(@temp)
GO

DROP TABLE dbo.Hotel
GO

ALTER TABLE dbo.Tmp_Hotel ADD CONSTRAINT
	DF_Zero88 DEFAULT (0) FOR System
GO

ALTER TABLE dbo.Tmp_Hotel ADD CONSTRAINT
	DF_Zero89 DEFAULT (0) FOR Desativado
GO

ALTER TABLE dbo.Tmp_Hotel ADD CONSTRAINT
	DF_Zero90 DEFAULT (0) FOR Hidden
GO

EXECUTE sp_rename N'dbo.Tmp_Hotel', N'Hotel', 'OBJECT'
GO

ALTER TABLE dbo.Hotel ADD CONSTRAINT
	PK_Hotel_1__21 PRIMARY KEY CLUSTERED 
	(
	IDHotel
	) ON [PRIMARY]
GO

ALTER TABLE dbo.TouristGroup WITH NOCHECK ADD CONSTRAINT
	FK_Hotel_TouristGroup_IDHotel FOREIGN KEY
	(
	IDHotel
	) REFERENCES dbo.Hotel
	(
	IDHotel
	) NOT FOR REPLICATION
GO
