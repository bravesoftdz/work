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

CREATE TABLE dbo.Tmp_Pur_PurchaseQtyOrder
	(
	IDPurchaseQtyOrder int NOT NULL,
	IDPurchase int NULL,
	IDModel int NULL,
	IDStore int NULL,
	IDPOItem int NULL,
	Qty int NULL
	)  ON [PRIMARY]
GO

IF EXISTS(SELECT * FROM dbo.Pur_PurchaseQtyOrder)
	 EXEC('INSERT INTO dbo.Tmp_Pur_PurchaseQtyOrder (IDPurchaseQtyOrder, IDPurchase, IDModel, IDStore, IDPOItem, Qty)
		SELECT IDPurchaseQtyOrder, IDPurchase, IDModel, IDStore, IDPOItem, Qty FROM dbo.Pur_PurchaseQtyOrder TABLOCKX')
GO

DROP TABLE dbo.Pur_PurchaseQtyOrder
GO

EXECUTE sp_rename N'dbo.Tmp_Pur_PurchaseQtyOrder', N'Pur_PurchaseQtyOrder', 'OBJECT'
GO

ALTER TABLE dbo.Pur_PurchaseQtyOrder ADD CONSTRAINT
	PK__Pur_PurchaseQtyO__0697FACD PRIMARY KEY CLUSTERED 
	(
	IDPurchaseQtyOrder
	) ON [PRIMARY]

GO

CREATE NONCLUSTERED INDEX XIF218Pur_PurchaseQtyOrder ON dbo.Pur_PurchaseQtyOrder
	(
	IDStore
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX XIF219Pur_PurchaseQtyOrder ON dbo.Pur_PurchaseQtyOrder
	(
	IDModel
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX XIF220Pur_PurchaseQtyOrder ON dbo.Pur_PurchaseQtyOrder
	(
	IDPurchase
	) ON [PRIMARY]
GO

ALTER TABLE dbo.Pur_PurchaseQtyOrder WITH NOCHECK ADD CONSTRAINT
	FK_Purchase_PurchaseQtyOrder_IDPurchase FOREIGN KEY
	(
	IDPurchase
	) REFERENCES dbo.Pur_Purchase
	(
	IDPurchase
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.Pur_PurchaseQtyOrder WITH NOCHECK ADD CONSTRAINT
	FK_Store_PurchaseQtyOrder_IDStore FOREIGN KEY
	(
	IDStore
	) REFERENCES dbo.Store
	(
	IDStore
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.Pur_PurchaseQtyOrder WITH NOCHECK ADD CONSTRAINT
	FK_Model_PurchaseQtyOrder_IDModel FOREIGN KEY
	(
	IDModel
	) REFERENCES dbo.Model
	(
	IDModel
	) NOT FOR REPLICATION
GO

CREATE TRIGGER tr_Pur_PurchaseQtyOrder_All ON dbo.Pur_PurchaseQtyOrder
FOR INSERT, UPDATE, DELETE
NOT FOR REPLICATION
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Teste da existencia de Model no Inventory
		- Atualizo PreInentoryMov  QtyRealMov


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

IF @@rowcount = 0
	RETURN

SET NOCOUNT ON

/*--------------------------------------------------------------*/
/*		Teste da existencia de Model no Inventory       */
/*--------------------------------------------------------------*/
INSERT 	Inventory
	(
	StoreID,
	ModelID
	)

	SELECT
		Inserted.IDStore,
		Inserted.IDModel
	FROM
		Inserted
	WHERE
	 	NOT EXISTS
		(
		SELECT
			Inventory.StoreID
		FROM
			Inventory Inventory
		WHERE
			Inventory.StoreID = Inserted.IDStore
			AND
			Inventory.ModelID = Inserted.IDModel
		)

	GROUP BY
		Inserted.IDStore,
		Inserted.IDModel


/*----------------------------------------------------------*/
/*		DELETE                     */
/*----------------------------------------------------------*/

-- PreInentoryMov  QtyRealMov

UPDATE
	PIM
SET
	PIM.QtyRealMov = IsNull(PIM.QtyRealMov, 0) -
			IsNull(
			(
			SELECT
				SUM(IsNull(DelPrePurchase.Qty, 0))
			FROM
				Deleted DelPrePurchase
			WHERE
				DelPrePurchase.IDPOItem = PIM.IDPreInventoryMov
			), 0)


FROM
	PreInventoryMov PIM,
	Deleted
WHERE
	Deleted.IDPOItem = PIM.IDPreInventoryMov
	AND
	Deleted.IDPOItem IS NOT NULL

/*----------------------------------------------------------*/
/*		INSERT	        */
/*----------------------------------------------------------*/

-- PreInentoryMov  QtyRealMov

UPDATE
	PIM
SET
	PIM.QtyRealMov = IsNull(PIM.QtyRealMov, 0) +
			IsNull(
			(
			SELECT
				SUM(IsNull(InsPrePurchase.Qty, 0))
			FROM
				Inserted InsPrePurchase
			WHERE
				InsPrePurchase.IDPOItem = PIM.IDPreInventoryMov
			), 0)


FROM
	PreInventoryMov PIM,
	Inserted
WHERE
	Inserted.IDPOItem = PIM.IDPreInventoryMov
	AND
	Inserted.IDPOItem IS NOT NULL

GO

