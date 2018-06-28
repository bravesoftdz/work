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

CREATE TABLE dbo.Tmp_RamoAtividade
	(
	IDRamoAtividade int NOT NULL,
	RamoAtividade varchar(50) NOT NULL,
	System bit NULL,
	Desativado bit NULL,
	Hidden bit NULL
	)  ON [PRIMARY]
GO

IF EXISTS(SELECT * FROM dbo.RamoAtividade)
	 EXEC('INSERT INTO dbo.Tmp_RamoAtividade (IDRamoAtividade, RamoAtividade, System, Desativado, Hidden)
		SELECT IDRamoAtividade, RamoAtividade, System, Desativado, Hidden FROM dbo.RamoAtividade TABLOCKX')
GO

DECLARE @temp Varchar (8000)
SET @temp = ''
SELECT @temp = @temp + 'ALTER TABLE ' + TabelaDerivada+ CHAR (13)+
+ CHAR(9)+'DROP CONSTRAINT ' + ConstraintName + CHAR (13)
FROM vw_Sis_ChaveEstrangeira
WHERE TabelaOriginal = 'RamoAtividade'
EXEC(@temp)
GO

DROP TABLE dbo.RamoAtividade
GO

ALTER TABLE dbo.Tmp_RamoAtividade ADD CONSTRAINT
	DF_Zero27 DEFAULT (0) FOR System
GO

ALTER TABLE dbo.Tmp_RamoAtividade ADD CONSTRAINT
	DF_Zero28 DEFAULT (0) FOR Desativado
GO

ALTER TABLE dbo.Tmp_RamoAtividade ADD CONSTRAINT
	DF_Zero29 DEFAULT (0) FOR Hidden
GO

EXECUTE sp_rename N'dbo.Tmp_RamoAtividade', N'RamoAtividade', 'OBJECT'
GO

ALTER TABLE dbo.RamoAtividade ADD CONSTRAINT
	PK_2__12 PRIMARY KEY CLUSTERED 
	(
	IDRamoAtividade
	) ON [PRIMARY]

GO

CREATE NONCLUSTERED INDEX PI_Ramo_RamoAtividade ON dbo.RamoAtividade
	(
	RamoAtividade
	) ON [PRIMARY]
GO

CREATE TRIGGER tr_RamoAtividade_InsUpt ON dbo.RamoAtividade
FOR INSERT,UPDATE
NOT FOR REPLICATION
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Testo a existencia do RamoAtividade


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
			INSERTED.IDRamoAtividade
		FROM
			INSERTED,
			RamoAtividade
		WHERE
			INSERTED.RamoAtividade = RamoAtividade.RamoAtividade
			AND
			RamoAtividade.IDRamoAtividade <> INSERTED.IDRamoAtividade
			AND
			INSERTED.Desativado = 0
			AND
			RamoAtividade.Desativado = 0
		)
	BEGIN
		RAISERROR ('DUP_RamoAtividade_RamoAtividade can not be duplicated',16,-1)
		ROLLBACK TRANSACTION
		RETURN
	END
GO

ALTER TABLE dbo.Pessoa WITH NOCHECK ADD CONSTRAINT
	FK_RamoAtividade_Pessoa_IDRamoAtividade FOREIGN KEY
	(
	IDRamoAtividade
	) REFERENCES dbo.RamoAtividade
	(
	IDRamoAtividade
	) NOT FOR REPLICATION

GO

