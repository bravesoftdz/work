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

CREATE TABLE dbo.Tmp_SpecialPrice
	(
	IDSpecialPrice int NOT NULL,
	SpecialPrice varchar(30) NOT NULL,
	System bit NULL,
	Desativado bit NULL,
	Hidden bit NULL
	)  ON [PRIMARY]
GO

IF EXISTS(SELECT * FROM dbo.SpecialPrice)
	 EXEC('INSERT INTO dbo.Tmp_SpecialPrice (IDSpecialPrice, SpecialPrice, System, Desativado, Hidden)
		SELECT IDSpecialPrice, SpecialPrice, System, Desativado, Hidden FROM dbo.SpecialPrice TABLOCKX')
GO

DECLARE @temp Varchar (8000)
SET @temp = ''
SELECT @temp = @temp + 'ALTER TABLE ' + TabelaDerivada+ CHAR (13)+
+ CHAR(9)+'DROP CONSTRAINT ' + ConstraintName + CHAR (13)
FROM vw_Sis_ChaveEstrangeira
WHERE TabelaOriginal = 'SpecialPrice'
EXEC(@temp)
GO

DROP TABLE dbo.SpecialPrice
GO

ALTER TABLE dbo.Tmp_SpecialPrice ADD CONSTRAINT
	DF_Zero92 DEFAULT (0) FOR System
GO

ALTER TABLE dbo.Tmp_SpecialPrice ADD CONSTRAINT
	DF_Zero93 DEFAULT (0) FOR Desativado
GO

ALTER TABLE dbo.Tmp_SpecialPrice ADD CONSTRAINT
	DF_Zero94 DEFAULT (0) FOR Hidden
GO

EXECUTE sp_rename N'dbo.Tmp_SpecialPrice', N'SpecialPrice', 'OBJECT'
GO

ALTER TABLE dbo.SpecialPrice ADD CONSTRAINT
	PK_SpecialPrice_IDSpecialPrice PRIMARY KEY CLUSTERED 
	(
	IDSpecialPrice
	) ON [PRIMARY]

GO

CREATE NONCLUSTERED INDEX PI_SpecialP_SpecialPrice ON dbo.SpecialPrice
	(
	SpecialPrice
	) ON [PRIMARY]
GO

CREATE TRIGGER tr_SpecialPrice_delete ON dbo.SpecialPrice
FOR DELETE
NOT FOR REPLICATION
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Deleto SpecialPriceByGroup


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

if @@RowCount = 0
   Return

SET NOCOUNT ON

DELETE
	SpecialPriceByGroup
FROM
	SpecialPriceByGroup,
	Deleted
WHERE
	SpecialPriceByGroup.SpecialPriceID = Deleted.IDSpecialPrice
GO

CREATE TRIGGER tr_SpecialPrice_insert ON dbo.SpecialPrice
FOR INSERT, UPDATE
NOT FOR REPLICATION
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Testo a existencia do SpecialPrice
		- Insiro em SpecialPriceByGroup


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

if @@RowCount = 0
   return

SET NOCOUNT ON

if	EXISTS 	(
		SELECT
			INSERTED.IDSpecialPrice
		FROM
			INSERTED,
			SpecialPrice
		WHERE
			INSERTED.SpecialPrice = SpecialPrice.SpecialPrice
			AND
			SpecialPrice.IDSpecialPrice <> INSERTED.IDSpecialPrice
			AND
			INSERTED.Desativado = 0
			AND
			SpecialPrice.Desativado = 0
			)
	BEGIN
		RAISERROR ('DUP_SpecialPrice_SpecialPrice can not be duplicated',16,-1)
		ROLLBACK TRANSACTION
		RETURN
	END

/* So faz na inclusao  */

if 	NOT EXISTS
			(
			SELECT
				Deleted.IDSpecialPrice
			FROM
				Deleted
			)
	BEGIN
		INSERT
			SpecialPriceByGroup
			SELECT
			Inserted.IDSpecialPrice,
			TabGroup.IDGroup,
			0
			FROM
			TabGroup,
			Inserted
			WHERE
			TabGroup.Desativado = 0
	END
GO

ALTER TABLE dbo.Invoice WITH NOCHECK ADD CONSTRAINT
	FK_SpecialPrice_Invoice_SpecialPriceID FOREIGN KEY
	(
	SpecialPriceID
	) REFERENCES dbo.SpecialPrice
	(
	IDSpecialPrice
	) NOT FOR REPLICATION

GO

