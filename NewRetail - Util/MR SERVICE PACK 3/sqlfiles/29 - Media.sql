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

CREATE TABLE dbo.Tmp_Media
	(
	IDMedia int NOT NULL,
	IDOtherCommission int NULL,
	Media varchar(255) NOT NULL,
	System bit NULL,
	Desativado bit NULL,
	Hidden bit NULL,
	TaxMode int NULL,
	PayComission int NULL
	)  ON [PRIMARY]
GO

IF EXISTS(SELECT * FROM dbo.Media)
	 EXEC('INSERT INTO dbo.Tmp_Media (IDMedia, IDOtherCommission, Media, System, Desativado, Hidden, TaxMode, PayComission)
		SELECT IDMedia, IDOtherCommission, Media, System, Desativado, Hidden, TaxMode, PayComission FROM dbo.Media TABLOCKX')
GO

DECLARE @temp Varchar (8000)
SET @temp = ''
SELECT @temp = @temp + 'ALTER TABLE ' + TabelaDerivada+ CHAR (13)+
+ CHAR(9)+'DROP CONSTRAINT ' + ConstraintName + CHAR (13)
FROM vw_Sis_ChaveEstrangeira
WHERE TabelaOriginal = 'Media'
EXEC(@temp)
GO

DROP TABLE dbo.Media
GO

ALTER TABLE dbo.Tmp_Media ADD CONSTRAINT
	DF_Zero82 DEFAULT (0) FOR System
GO

ALTER TABLE dbo.Tmp_Media ADD CONSTRAINT
	DF_Zero83 DEFAULT (0) FOR Desativado
GO

ALTER TABLE dbo.Tmp_Media ADD CONSTRAINT
	DF_Zero84 DEFAULT (0) FOR Hidden
GO

ALTER TABLE dbo.Tmp_Media ADD CONSTRAINT
	DF_Media_Pay001 DEFAULT (1) FOR PayComission
GO


EXECUTE sp_rename N'dbo.Tmp_Media', N'Media', 'OBJECT'
GO

ALTER TABLE dbo.Media ADD CONSTRAINT
	PK_Media_1__21 PRIMARY KEY CLUSTERED 
	(
	IDMedia
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX PI_Media_Media ON dbo.Media
	(
	Media
	) ON [PRIMARY]
GO

CREATE TRIGGER tr_Media_InsUpt ON dbo.Media
FOR INSERT,UPDATE
NOT FOR REPLICATION
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Testo a existencia da Media


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

if  	@@rowcount = 0
	return

SET NOCOUNT ON

if	EXISTS 	(
		SELECT
			INSERTED.IDMedia
		FROM
			INSERTED,
			Media
		WHERE
			INSERTED.Media = Media.Media
			AND
			Media.IDMedia <> INSERTED.IDMedia
			AND
			INSERTED.Desativado = 0
			AND
			Media.Desativado = 0
		)
	BEGIN
		RAISERROR ('DUP_Media_Media can not be duplicated',16,-1)
		ROLLBACK TRANSACTION
		RETURN
	END
GO

ALTER TABLE dbo.Invoice WITH NOCHECK ADD CONSTRAINT
	FK_Media_Invoice_MediaID FOREIGN KEY
	(
	MediaID
	) REFERENCES dbo.Media
	(
	IDMedia
	) NOT FOR REPLICATION
GO

