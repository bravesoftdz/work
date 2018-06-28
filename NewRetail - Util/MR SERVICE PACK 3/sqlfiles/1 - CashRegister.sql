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


CREATE TABLE dbo.Tmp_CashRegister
	(
	IDCashRegister int NOT NULL,
	Name varchar(15) NOT NULL,
	IsAssociated bit NULL,
	Desativado bit NULL,
	Hidden bit NULL,
	System bit NULL
	)  ON [PRIMARY]
GO

IF EXISTS(SELECT * FROM dbo.CashRegister)
	 EXEC('INSERT INTO dbo.Tmp_CashRegister (IDCashRegister, Name, IsAssociated, Desativado, Hidden, System)
		SELECT IDCashRegister, Name, IsAssociated, Desativado, Hidden, System FROM dbo.CashRegister TABLOCKX')
GO

DECLARE @temp Varchar (8000)
SET @temp = ''
SELECT @temp = @temp + 'ALTER TABLE ' + TabelaDerivada+ CHAR (13)+
+ CHAR(9)+'DROP CONSTRAINT ' + ConstraintName + CHAR (13)
FROM vw_Sis_ChaveEstrangeira
WHERE TabelaOriginal = 'CashRegister'
EXEC(@temp)
GO

DROP TABLE dbo.CashRegister
GO

ALTER TABLE dbo.Tmp_CashRegister ADD CONSTRAINT
	DF_Zero69 DEFAULT (0) FOR IsAssociated
GO

ALTER TABLE dbo.Tmp_CashRegister ADD CONSTRAINT
	DF_Zero70 DEFAULT (0) FOR Desativado
GO

ALTER TABLE dbo.Tmp_CashRegister ADD CONSTRAINT
	DF_Zero71 DEFAULT (0) FOR Hidden
GO

ALTER TABLE dbo.Tmp_CashRegister ADD CONSTRAINT
	DF_Zero72 DEFAULT (0) FOR System
GO

EXECUTE sp_rename N'dbo.Tmp_CashRegister', N'CashRegister', 'OBJECT'
GO

ALTER TABLE dbo.CashRegister ADD CONSTRAINT
	PK_CashRegister_IDCashRegister PRIMARY KEY CLUSTERED 
	(
	IDCashRegister
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX PI_CashRegister_Name ON dbo.CashRegister
	(
	Name
	) ON [PRIMARY]
GO

CREATE TRIGGER tr_CashRegister_InsUpt ON dbo.CashRegister
FOR INSERT,UPDATE
NOT FOR REPLICATION
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Testo a existencia do CashRegister

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
			INSERTED.IDCashRegister
		FROM
			INSERTED,
			CashRegister
		WHERE
			INSERTED.NAME = CashRegister.NAME
			AND
			CashRegister.IDCashRegister <> INSERTED.IDCashRegister
			AND
			INSERTED.Desativado = 0
			AND
			CashRegister.Desativado = 0
		)

	BEGIN
		RAISERROR ('DUP_CashRegister_CashRegister can not be duplicated',16,-1)
		ROLLBACK TRANSACTION
		RETURN
	END

GO

ALTER TABLE dbo.CashRegMov WITH NOCHECK ADD CONSTRAINT
	FK_CashReg_CashRegMov_IDCashRegister FOREIGN KEY
	(
	IDCashRegister
	) REFERENCES dbo.CashRegister
	(
	IDCashRegister
	) NOT FOR REPLICATION
GO