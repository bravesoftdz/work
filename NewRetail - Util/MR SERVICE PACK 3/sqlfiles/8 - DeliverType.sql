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

CREATE TABLE dbo.Tmp_DeliverType
	(
	IDDeliverType int NOT NULL,
	Name varchar(30) NOT NULL,
	System bit NULL,
	Desativado bit NULL,
	Hidden bit NULL
	)  ON [PRIMARY]
GO


IF EXISTS(SELECT * FROM dbo.DeliverType)
	 EXEC('INSERT INTO dbo.Tmp_DeliverType (IDDeliverType, Name, System, Desativado, Hidden)
		SELECT IDDeliverType, Name, System, Desativado, Hidden FROM dbo.DeliverType TABLOCKX')
GO

DECLARE @temp Varchar (8000)
SET @temp = ''
SELECT @temp = @temp + 'ALTER TABLE ' + TabelaDerivada+ CHAR (13)+
+ CHAR(9)+'DROP CONSTRAINT ' + ConstraintName + CHAR (13)
FROM vw_Sis_ChaveEstrangeira
WHERE TabelaOriginal = 'DeliverType'
EXEC(@temp)
GO

DROP TABLE dbo.DeliverType
GO

ALTER TABLE dbo.Tmp_DeliverType ADD CONSTRAINT
	DF_Zero85 DEFAULT (0) FOR System
GO

ALTER TABLE dbo.Tmp_DeliverType ADD CONSTRAINT
	DF_Zero86 DEFAULT (0) FOR Desativado
GO

ALTER TABLE dbo.Tmp_DeliverType ADD CONSTRAINT
	DF_Zero87 DEFAULT (0) FOR Hidden
GO

EXECUTE sp_rename N'dbo.Tmp_DeliverType', N'DeliverType', 'OBJECT'
GO

ALTER TABLE dbo.DeliverType ADD CONSTRAINT
	PK_DeliverType_IDDeliverType PRIMARY KEY CLUSTERED 
	(
	IDDeliverType
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX PI_DeliverType_Name ON dbo.DeliverType
	(
	Name
	) ON [PRIMARY]
GO

CREATE TRIGGER tr_DeliverType_Delete ON dbo.DeliverType
FOR DELETE
NOT FOR REPLICATION
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Testo se registro excluido é System


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

if @@rowCount = 0
   return

SET NOCOUNT ON

IF EXISTS (SELECT IDDeliverType	FROM Deleted WHERE Deleted.System = 1)
BEGIN
	RAISERROR ('Can not delete system value',16,-1)
	ROLLBACK TRANSACTION
END

GO

CREATE TRIGGER tr_DeliverType_InsUpt ON dbo.DeliverType
FOR INSERT,UPDATE
NOT FOR REPLICATION
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Testo a existencia do DeliverType


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
			INSERTED.IDDeliverType
		FROM
			INSERTED,
			DeliverType
		WHERE
			INSERTED.Name = DeliverType.Name
			AND
			DeliverType.IDDeliverType <> INSERTED.IDDeliverType
			AND
			INSERTED.Desativado = 0
			AND
			DeliverType.Desativado = 0
		)

	BEGIN
		RAISERROR ('DUP_DeliverType_DeliverType can not be duplicated',16,-1)
		ROLLBACK TRANSACTION
		RETURN
	END
GO

ALTER TABLE dbo.Invoice WITH NOCHECK ADD CONSTRAINT
	FK_DeliverType_Invoice_DeliverTypeID FOREIGN KEY
	(
	DeliverTypeID
	) REFERENCES dbo.DeliverType
	(
	IDDeliverType
	) NOT FOR REPLICATION

GO
