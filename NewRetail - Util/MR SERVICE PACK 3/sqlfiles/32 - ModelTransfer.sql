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

CREATE TABLE dbo.Tmp_ModelTransf
	(
	IDModelTransf int NOT NULL,
	IDLojaOrigem int NOT NULL,
	IDLojaDestino int NOT NULL,
	IDUser int NOT NULL,
	Data smalldatetime NOT NULL,
	System bit NULL,
	Hidden bit NULL,
	Desativado bit NULL
	)  ON [PRIMARY]
GO

IF EXISTS(SELECT * FROM dbo.ModelTransf)
	 EXEC('INSERT INTO dbo.Tmp_ModelTransf (IDModelTransf, IDLojaOrigem, IDLojaDestino, IDUser, Data, System, Hidden, Desativado)
		SELECT IDModelTransf, IDLojaOrigem, IDLojaDestino, IDUser, Data, System, Hidden, Desativado FROM dbo.ModelTransf TABLOCKX')
GO

DECLARE @temp Varchar (8000)
SET @temp = ''
SELECT @temp = @temp + 'ALTER TABLE ' + TabelaDerivada+ CHAR (13)+
+ CHAR(9)+'DROP CONSTRAINT ' + ConstraintName + CHAR (13)
FROM vw_Sis_ChaveEstrangeira
WHERE TabelaOriginal = 'ModelTransf'
EXEC(@temp)
GO

DROP TABLE dbo.ModelTransf
GO

ALTER TABLE dbo.Tmp_ModelTransf ADD CONSTRAINT
	DF_Zero178 DEFAULT (0) FOR System
GO

ALTER TABLE dbo.Tmp_ModelTransf ADD CONSTRAINT
	DF_Zero179 DEFAULT (0) FOR Hidden
GO

ALTER TABLE dbo.Tmp_ModelTransf ADD CONSTRAINT
	DF_Zero180 DEFAULT (0) FOR Desativado
GO

EXECUTE sp_rename N'dbo.Tmp_ModelTransf', N'ModelTransf', 'OBJECT'
GO

ALTER TABLE dbo.ModelTransf ADD CONSTRAINT
	PK__ModelTransf__0A338187 PRIMARY KEY CLUSTERED 
	(
	IDModelTransf
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX XIF129ModelTransf ON dbo.ModelTransf
	(
	IDLojaOrigem
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX XIF130ModelTransf ON dbo.ModelTransf
	(
	IDLojaDestino
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX XIF131ModelTransf ON dbo.ModelTransf
	(
	IDUser
	) ON [PRIMARY]
GO

ALTER TABLE dbo.ModelTransf WITH NOCHECK ADD CONSTRAINT
	FK_SystemUser_ModelTransf_IDUser FOREIGN KEY
	(
	IDUser
	) REFERENCES dbo.SystemUser
	(
	IDUser
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.ModelTransf WITH NOCHECK ADD CONSTRAINT
	FK_Store_ModelTransf_IDLojaDestino FOREIGN KEY
	(
	IDLojaDestino
	) REFERENCES dbo.Store
	(
	IDStore
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.ModelTransf WITH NOCHECK ADD CONSTRAINT
	FK_Store_ModelTransf_IDLojaOrigem FOREIGN KEY
	(
	IDLojaOrigem
	) REFERENCES dbo.Store
	(
	IDStore
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.ModelTransfDet WITH NOCHECK ADD CONSTRAINT
	FK_ModelTransf_ModelTransfDet_IDModelTransf FOREIGN KEY
	(
	IDModelTransf
	) REFERENCES dbo.ModelTransf
	(
	IDModelTransf
	) NOT FOR REPLICATION
GO

