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

CREATE TABLE dbo.Tmp_Trajeto
	(
	IDTrajeto int NOT NULL,
	Trajeto varchar(50) NOT NULL,
	CustoMotorista money NOT NULL,
	CustoGasolina money NOT NULL,
	System bit NULL,
	Desativado int NULL,
	Hidden bit NULL,
	MinPax int NULL
	)  ON [PRIMARY]
GO

IF EXISTS(SELECT * FROM dbo.Trajeto)
	 EXEC('INSERT INTO dbo.Tmp_Trajeto (IDTrajeto, Trajeto, CustoMotorista, CustoGasolina, System, Desativado, Hidden, MinPax)
		SELECT IDTrajeto, Trajeto, CustoMotorista, CustoGasolina, System, Desativado, Hidden, MinPax FROM dbo.Trajeto TABLOCKX')
GO

DROP TABLE dbo.Trajeto
GO

ALTER TABLE dbo.Tmp_Trajeto ADD CONSTRAINT
	DF_Zero136 DEFAULT (0) FOR CustoMotorista
GO

ALTER TABLE dbo.Tmp_Trajeto ADD CONSTRAINT
	DF_Zero137 DEFAULT (0) FOR CustoGasolina
GO

ALTER TABLE dbo.Tmp_Trajeto ADD CONSTRAINT
	DF_Zero138 DEFAULT (0) FOR System
GO

ALTER TABLE dbo.Tmp_Trajeto ADD CONSTRAINT
	DF_Zero139 DEFAULT (0) FOR Desativado
GO

ALTER TABLE dbo.Tmp_Trajeto ADD CONSTRAINT
	DF_Zero140 DEFAULT (0) FOR Hidden
GO

ALTER TABLE dbo.Tmp_Trajeto ADD CONSTRAINT
	DF_Trajeto_Enabled4 DEFAULT (1) FOR MinPax
GO

EXECUTE sp_rename N'dbo.Tmp_Trajeto', N'Trajeto', 'OBJECT'
GO

ALTER TABLE dbo.Trajeto ADD CONSTRAINT
	PK__Trajeto__24285DB4 PRIMARY KEY CLUSTERED 
	(
	IDTrajeto
	) ON [PRIMARY]

GO

CREATE NONCLUSTERED INDEX PI_Trajeto_Trajeto ON dbo.Trajeto
	(
	Trajeto
	) ON [PRIMARY]
GO

CREATE TRIGGER tr_Trajeto_InsUpt ON dbo.Trajeto
FOR INSERT,UPDATE
NOT FOR REPLICATION
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Testo a existencia do Trajeto


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

SET NOCOUNT ON

if	EXISTS 	(
		SELECT
			INSERTED.IDTrajeto
		FROM
			INSERTED,
			Trajeto
		WHERE
			INSERTED.Trajeto = Trajeto.Trajeto
			AND
			Trajeto.IDTrajeto <> INSERTED.IDTrajeto
			AND
			INSERTED.Desativado = 0
			AND
			Trajeto.Desativado = 0
		)

	BEGIN
		RAISERROR ('DUP_Trajeto_Trajeto can not be duplicated',16,-1)
		ROLLBACK TRANSACTION
		RETURN
	END
GO
