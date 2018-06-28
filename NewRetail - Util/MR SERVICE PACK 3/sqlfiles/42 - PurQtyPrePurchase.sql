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

CREATE TABLE dbo.Tmp_Pur_PurchaseQtyPrePurchase
	(
	IDPurchaseQtyPreSale int NOT NULL,
	IDStore int NULL,
	IDModel int NULL,
	IDPurchase int NULL,
	IDPOItem int NULL,
	Qty int NULL
	)  ON [PRIMARY]
GO

IF EXISTS(SELECT * FROM dbo.Pur_PurchaseQtyPrePurchase)
	 EXEC('INSERT INTO dbo.Tmp_Pur_PurchaseQtyPrePurchase (IDPurchaseQtyPreSale, IDStore, IDModel, IDPurchase, IDPOItem, Qty)
		SELECT IDPurchaseQtyPreSale, IDStore, IDModel, IDPurchase, IDPOItem, Qty FROM dbo.Pur_PurchaseQtyPrePurchase TABLOCKX')
GO

DROP TABLE dbo.Pur_PurchaseQtyPrePurchase
GO

EXECUTE sp_rename N'dbo.Tmp_Pur_PurchaseQtyPrePurchase', N'Pur_PurchaseQtyPrePurchase', 'OBJECT'
GO

ALTER TABLE dbo.Pur_PurchaseQtyPrePurchase ADD CONSTRAINT
	PK__Pur_PurchaseQtyP__4F47C5E3 PRIMARY KEY CLUSTERED 
	(
	IDPurchaseQtyPreSale
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX XIF234Pur_PurchaseQtyPrePurchase ON dbo.Pur_PurchaseQtyPrePurchase
	(
	IDStore
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX XIF235Pur_PurchaseQtyPrePurchase ON dbo.Pur_PurchaseQtyPrePurchase
	(
	IDModel
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX XIF236Pur_PurchaseQtyPrePurchase ON dbo.Pur_PurchaseQtyPrePurchase
	(
	IDPurchase
	) ON [PRIMARY]
GO

ALTER TABLE dbo.Pur_PurchaseQtyPrePurchase WITH NOCHECK ADD CONSTRAINT
	FK_Model_PurchaseQtyPrePurchase_IDModel FOREIGN KEY
	(
	IDModel
	) REFERENCES dbo.Model
	(
	IDModel
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.Pur_PurchaseQtyPrePurchase WITH NOCHECK ADD CONSTRAINT
	FK_Purchase_PurchaseQtyPrePurchase_IDPurchase FOREIGN KEY
	(
	IDPurchase
	) REFERENCES dbo.Pur_Purchase
	(
	IDPurchase
	) NOT FOR REPLICATION

GO

ALTER TABLE dbo.Pur_PurchaseQtyPrePurchase WITH NOCHECK ADD CONSTRAINT
	FK_Store_PurchaseQtyPrePurchase_IDStore FOREIGN KEY
	(
	IDStore
	) REFERENCES dbo.Store
	(
	IDStore
	) NOT FOR REPLICATION

GO

CREATE TRIGGER tr_Pur_PurchaseQtyPrePurchase_All ON dbo.Pur_PurchaseQtyPrePurchase
FOR INSERT, UPDATE, DELETE 
NOT FOR REPLICATION
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Teste da existencia de Model no Inventory
		- Delecao do Inventory Movement QtyOnPrePurchase
		- Delecao do Inventory Movement QtyOnPrePurchase no Model Master
		- Insercao do Inventory Movement QtyOnPreSalePurchase
		- Insercao do Inventory Movement QtyOnPreSalePurchase no Model Master


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
	23 Jan	2002		Rodrigo Costa		Atualizacao do QtyOnPrePurchase no Model Master
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

if @@rowcount = 0 
	return

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


/* --------------------------------------------------------- DELECAO  -------------------------------------*/
/*----------------------------------------------------------*/
/*		Delecao do Inventory Movement	QtyOnPrePurchase  */
/*----------------------------------------------------------*/

UPDATE
	Inventory 
SET 	
	Inventory.QtyOnPrePurchase = IsNull(Inventory.QtyOnPrePurchase, 0) -
			IsNull(
			(
			SELECT
				SUM(IsNull(DelPrePurchase.Qty, 0))	
			FROM	
				Deleted DelPrePurchase
			WHERE
				DelPrePurchase.IDModel = Inventory.ModelID 	
				AND
				DelPrePurchase.IDStore = Inventory.StoreID
			), 0)

		
FROM 	
	Inventory Inventory, 
	Deleted
WHERE 	
	Deleted.IDModel = Inventory.ModelID 	
	AND
	Deleted.IDStore = Inventory.StoreID


/*--------------------------------------------------------------*/
/*		Delecao do Inventory Movement	QtyOnPrePurchase no Model Master       */
/*--------------------------------------------------------------*/


UPDATE
	I
SET
	I.QtyOnPrePurchase = IsNull(I.QtyOnPrePurchase, 0) - Total.QtyPrePruchase
FROM
	(
	SELECT
		M.IDModelParent as ModelID,
		DEL.IDStore as StoreID,
		SUM( IsNull(DEL.Qty, 0) ) as QtyPrePruchase
	FROM
		Deleted DEL
		JOIN
		Model M ON (DEL.IDModel = M.IDModel)
	WHERE
		M.IDModelParent IS NOT NULL
	GROUP BY
		M.IDModelParent,
		DEL.IDStore
	) Total
	JOIN
	Inventory I ON (Total.ModelID = I.ModelID AND Total.StoreID = I.StoreID)

/* --------------------------------------------------------- INCLUSAO  -------------------------------------*/
/*----------------------------------------------------------*/
/*		Insercao do Inventory Movement QtyOnPreSalePurchase  */
/*----------------------------------------------------------*/

UPDATE 	
	Inventory 
SET 	
	Inventory.QtyOnPrePurchase = IsNull(Inventory.QtyOnPrePurchase, 0) +
			IsNull(
			(
			SELECT 	
				SUM(IsNull(InsPrePurchase.Qty, 0))	
			FROM	
				Inserted InsPrePurchase
			WHERE
				InsPrePurchase.IDModel = Inventory.ModelID 	
				AND
				InsPrePurchase.IDStore = Inventory.StoreID
			), 0)

FROM 	
	Inventory Inventory, 
	Inserted
WHERE 	
	Inserted.IDModel = Inventory.ModelID 	
	AND
	Inserted.IDStore = Inventory.StoreID


/*----------------------------------------------------------*/
/*		Insercao do Inventory Movement QtyOnPreSalePurchase  no Model Master*/
/*----------------------------------------------------------*/


UPDATE
	I
SET
	I.QtyOnPrePurchase = IsNull(I.QtyOnPrePurchase, 0) + Total.QtyPrePruchase
FROM
	(
	SELECT
		M.IDModelParent as ModelID,
		INS.IDStore as StoreID,
		SUM( IsNull(INS.Qty, 0) ) as QtyPrePruchase
	FROM
		Inserted INS
		JOIN
		Model M ON (INS.IDModel = M.IDModel)
	WHERE
		M.IDModelParent IS NOT NULL
	GROUP BY
		M.IDModelParent,
		INS.IDStore
	) Total
	JOIN
	Inventory I ON (Total.ModelID = I.ModelID AND Total.StoreID = I.StoreID)
GO

