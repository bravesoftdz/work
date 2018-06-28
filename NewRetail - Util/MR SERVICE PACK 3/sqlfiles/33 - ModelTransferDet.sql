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

CREATE TABLE dbo.Tmp_ModelTransfDet
	(
	IDModelTransfDet int NOT NULL,
	IDModelTransf int NOT NULL,
	IDModel int NOT NULL,
	Qty int NOT NULL,
	System bit NULL,
	Hidden bit NULL,
	Desativado bit NULL
	)  ON [PRIMARY]
GO

IF EXISTS(SELECT * FROM dbo.ModelTransfDet)
	 EXEC('INSERT INTO dbo.Tmp_ModelTransfDet (IDModelTransfDet, IDModelTransf, IDModel, Qty, System, Hidden, Desativado)
		SELECT IDModelTransfDet, IDModelTransf, IDModel, Qty, System, Hidden, Desativado FROM dbo.ModelTransfDet TABLOCKX')
GO

DROP TABLE dbo.ModelTransfDet
GO

ALTER TABLE dbo.Tmp_ModelTransfDet ADD CONSTRAINT
	DF_Zero181 DEFAULT (0) FOR Qty
GO

ALTER TABLE dbo.Tmp_ModelTransfDet ADD CONSTRAINT
	DF_Zero182 DEFAULT (0) FOR System
GO

ALTER TABLE dbo.Tmp_ModelTransfDet ADD CONSTRAINT
	DF_Zero183 DEFAULT (0) FOR Hidden
GO

ALTER TABLE dbo.Tmp_ModelTransfDet ADD CONSTRAINT
	DF_Zero184 DEFAULT (0) FOR Desativado
GO

EXECUTE sp_rename N'dbo.Tmp_ModelTransfDet', N'ModelTransfDet', 'OBJECT'
GO

ALTER TABLE dbo.ModelTransfDet ADD CONSTRAINT
	PK__ModelTransfDet__15A53433 PRIMARY KEY CLUSTERED 
	(
	IDModelTransfDet
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX XIF104ModelTransfDet ON dbo.ModelTransfDet
	(
	IDModel
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX XIF105ModelTransfDet ON dbo.ModelTransfDet
	(
	IDModelTransf
	) ON [PRIMARY]
GO

ALTER TABLE dbo.ModelTransfDet WITH NOCHECK ADD CONSTRAINT
	FK_Model_ModelTransfDet_IDModel FOREIGN KEY
	(
	IDModel
	) REFERENCES dbo.Model
	(
	IDModel
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

CREATE TRIGGER tr_ModelTransfDet_All ON dbo.ModelTransfDet
FOR INSERT,UPDATE,DELETE
NOT FOR REPLICATION
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Parte da Delecao do InventoryMov
                - Parte da Insercao do InventoryMov


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

IF @@rowcount = 0
	RETURN

SET NOCOUNT ON

/*--------------------------------------------------------------*/
/*		Parte da Delecao do InventoryMov        	*/
/*--------------------------------------------------------------*/
DELETE
	InventoryMov
FROM
	DELETED
WHERE	( InventoryMov.InventMovTypeID >= 7 AND InventoryMov.InventMovTypeID <= 8 )
	AND
	InventoryMov.DocumentID = DELETED.IDModelTransf
	AND
	DELETED.IDModelTransfDet = InventoryMov.PreInventoryMovID

/*--------------------------------------------------------------*/
/*		Parte da Insercao do InventoryMov        	*/
/*--------------------------------------------------------------*/
INSERT	InventoryMov
	(
	InventMovTypeID,
	DocumentID,
	StoreID,
	ModelID,
	IDPessoa,
	MovDate,
	Qty,
	IDUser,
	PreInventoryMovID  /* guarda a linha correspondente a inserida */
	)
	SELECT
	7,   /* saida da loja original */
	INSERTED.IDModelTransf,
	ModelTransf.IDLojaOrigem,
	INSERTED.IDModel,
	0,
	GetDate(),
	INSERTED.Qty,
	ModelTransf.IDUser,
	INSERTED.IDModelTransfDet

	FROM
		INSERTED,
		ModelTransf
	WHERE
		INSERTED.IDModelTransf = ModelTransf.IDModelTransf

INSERT	InventoryMov
	(
	InventMovTypeID,
	DocumentID,
	StoreID,
	ModelID,
	IDPessoa,
	MovDate,
	Qty,
	IDUser,
	PreInventoryMovID  /* guarda a linha correspondente a inserida */
	)
	SELECT
	8,   /* entrada da loja destino */
	INSERTED.IDModelTransf,
	ModelTransf.IDLojaDestino,
	INSERTED.IDModel,
	0,
	GetDate(),
	INSERTED.Qty,
	ModelTransf.IDUser,
	INSERTED.IDModelTransfDet

	FROM
		INSERTED,
		ModelTransf
	WHERE
		INSERTED.IDModelTransf = ModelTransf.IDModelTransf
GO

