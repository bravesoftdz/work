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

CREATE TABLE dbo.Tmp_TaxCategory
	(
	IDTaxCategory int NOT NULL,
	TaxCategory varchar(50) NOT NULL,
	Tax money NOT NULL,
	SpecialDateStart smalldatetime NULL,
	SpecialDateEnd smalldatetime NULL,
	SpecialTax money NULL,
	TaxExempt bit NULL,
	MaxItemValue money NULL,
	System bit NULL,
	Hidden bit NULL,
	Desativado bit NULL
	)  ON [PRIMARY]
GO

IF EXISTS(SELECT * FROM dbo.TaxCategory)
	 EXEC('INSERT INTO dbo.Tmp_TaxCategory (IDTaxCategory, TaxCategory, Tax, SpecialDateStart, SpecialDateEnd, SpecialTax, TaxExempt, MaxItemValue, System, Hidden, Desativado)
		SELECT IDTaxCategory, TaxCategory, Tax, SpecialDateStart, SpecialDateEnd, SpecialTax, TaxExempt, MaxItemValue, System, Hidden, Desativado FROM dbo.TaxCategory TABLOCKX')
GO

DECLARE @temp Varchar (8000)
SET @temp = ''
SELECT @temp = @temp + 'ALTER TABLE ' + TabelaDerivada+ CHAR (13)+
+ CHAR(9)+'DROP CONSTRAINT ' + ConstraintName + CHAR (13)
FROM vw_Sis_ChaveEstrangeira
WHERE TabelaOriginal = 'TaxCategory'
EXEC(@temp)
GO

DROP TABLE dbo.TaxCategory
GO

ALTER TABLE dbo.Tmp_TaxCategory ADD CONSTRAINT
	DF_Zero143 DEFAULT (0) FOR TaxExempt
GO

ALTER TABLE dbo.Tmp_TaxCategory ADD CONSTRAINT
	DF_Zero144 DEFAULT (0) FOR System
GO

ALTER TABLE dbo.Tmp_TaxCategory ADD CONSTRAINT
	DF_Zero145 DEFAULT (0) FOR Hidden
GO

ALTER TABLE dbo.Tmp_TaxCategory ADD CONSTRAINT
	DF_Zero146 DEFAULT (0) FOR Desativado
GO

EXECUTE sp_rename N'dbo.Tmp_TaxCategory', N'TaxCategory', 'OBJECT'
GO

ALTER TABLE dbo.TaxCategory ADD CONSTRAINT
	PK__TaxCategory__477199F1 PRIMARY KEY CLUSTERED 
	(
	IDTaxCategory
	) ON [PRIMARY]
GO

ALTER TABLE dbo.StoreToTabGroup WITH NOCHECK ADD CONSTRAINT
	FK_TaxCategory_StoreToTabGroup_IDTaxCategory FOREIGN KEY
	(
	IDTaxCategory
	) REFERENCES dbo.TaxCategory
	(
	IDTaxCategory
	) NOT FOR REPLICATION

GO

