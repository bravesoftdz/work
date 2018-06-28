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

CREATE TABLE dbo.Tmp_PreInventoryMov
	(
	IDPreInventoryMov int NOT NULL,
	InventMovTypeID int NULL,
	StoreID int NULL,
	ModelID int NULL,
	IDPessoa int NULL,
	ComissionID int NULL,
	UserID int NULL,
	IDCotacao int NULL,
	IDPreInventoryMovParent int NULL,
	BarCodeID TBarCode NULL,
	DocumentID int NOT NULL,
	MovDate smalldatetime NULL,
	Qty int NULL,
	CostPrice money NULL,
	SalePrice money NULL,
	Discount money NULL,
	DateEstimatedMov smalldatetime NULL,
	DateRealMov smalldatetime NULL,
	QtyRealMov int NULL,
	Marked bit NULL,
	ExchangeInvoice int NULL,
	SuggRetail money NULL
	)  ON [PRIMARY]
GO

IF EXISTS(SELECT * FROM dbo.PreInventoryMov)
	 EXEC('INSERT INTO dbo.Tmp_PreInventoryMov (IDPreInventoryMov, InventMovTypeID, StoreID, ModelID, IDPessoa, ComissionID, UserID, IDCotacao, IDPreInventoryMovParent, BarCodeID, DocumentID, MovDate, Qty, CostPrice, SalePrice, Discount, DateEstimatedMov, DateRealMov, QtyRealMov, Marked, ExchangeInvoice, SuggRetail)
		SELECT IDPreInventoryMov, InventMovTypeID, StoreID, ModelID, IDPessoa, ComissionID, UserID, IDCotacao, IDPreInventoryMovParent, BarCodeID, DocumentID, MovDate, Qty, CostPrice, SalePrice, Discount, DateEstimatedMov, DateRealMov, QtyRealMov, Marked, ExchangeInvoice, SuggRetail FROM dbo.PreInventoryMov TABLOCKX')
GO

DECLARE @temp Varchar (8000)
SET @temp = ''
SELECT @temp = @temp + 'ALTER TABLE ' + TabelaDerivada+ CHAR (13)+
+ CHAR(9)+'DROP CONSTRAINT ' + ConstraintName + CHAR (13)
FROM vw_Sis_ChaveEstrangeira
WHERE TabelaOriginal = 'PreInventoryMov'
EXEC(@temp)
GO

DROP TABLE dbo.PreInventoryMov
GO

ALTER TABLE dbo.Tmp_PreInventoryMov ADD CONSTRAINT
	DF_Zero127 DEFAULT (0) FOR Qty
GO

ALTER TABLE dbo.Tmp_PreInventoryMov ADD CONSTRAINT
	DF_Zero128 DEFAULT (0) FOR CostPrice
GO

ALTER TABLE dbo.Tmp_PreInventoryMov ADD CONSTRAINT
	DF_Zero129 DEFAULT (0) FOR SalePrice
GO

ALTER TABLE dbo.Tmp_PreInventoryMov ADD CONSTRAINT
	DF_Zero130 DEFAULT (0) FOR Discount
GO

ALTER TABLE dbo.Tmp_PreInventoryMov ADD CONSTRAINT
	DF_Zero131 DEFAULT (0) FOR QtyRealMov
GO

ALTER TABLE dbo.Tmp_PreInventoryMov ADD CONSTRAINT
	DF_Zero132 DEFAULT (0) FOR Marked
GO

ALTER TABLE dbo.Tmp_PreInventoryMov ADD CONSTRAINT
	DF_Zero133 DEFAULT (0) FOR SuggRetail
GO

EXECUTE sp_rename N'dbo.Tmp_PreInventoryMov', N'PreInventoryMov', 'OBJECT'
GO

CREATE CLUSTERED INDEX PI_PreInventMov_InventMovType ON dbo.PreInventoryMov
	(
	InventMovTypeID,
	DocumentID
	) ON [PRIMARY]
GO

ALTER TABLE dbo.PreInventoryMov ADD CONSTRAINT
	PK__PreInventoryMov__04AFB25B PRIMARY KEY NONCLUSTERED 
	(
	IDPreInventoryMov
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX XIF221PreInventoryMov ON dbo.PreInventoryMov
	(
	StoreID
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX XIF222PreInventoryMov ON dbo.PreInventoryMov
	(
	ModelID
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX XIF224PreInventoryMov ON dbo.PreInventoryMov
	(
	UserID
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX XIF225PreInventoryMov ON dbo.PreInventoryMov
	(
	IDPessoa
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX XIF226PreInventoryMov ON dbo.PreInventoryMov
	(
	ComissionID
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX XIF227PreInventoryMov ON dbo.PreInventoryMov
	(
	InventMovTypeID
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX XIF423PreInventoryMov ON dbo.PreInventoryMov
	(
	IDCotacao
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX XIF424PreInventoryMov ON dbo.PreInventoryMov
	(
	IDPreInventoryMovParent
	) ON [PRIMARY]
GO

ALTER TABLE dbo.PreInventoryMov WITH NOCHECK ADD CONSTRAINT
	FK_InventoryMovType_PreInventoryMov_InventMovTypeID FOREIGN KEY
	(
	InventMovTypeID
	) REFERENCES dbo.InventoryMovType
	(
	IDInventMovType
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.PreInventoryMov WITH NOCHECK ADD CONSTRAINT
	FK_Pessoa_PreInventoryMov_ComissionID FOREIGN KEY
	(
	ComissionID
	) REFERENCES dbo.Pessoa
	(
	IDPessoa
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.PreInventoryMov WITH NOCHECK ADD CONSTRAINT
	FK_Pessoa_PreInventoryMov_IDPessoa FOREIGN KEY
	(
	IDPessoa
	) REFERENCES dbo.Pessoa
	(
	IDPessoa
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.PreInventoryMov WITH NOCHECK ADD CONSTRAINT
	FK_PreInventoryMov_PreInventoryMov_IDPreInventoryMovParent FOREIGN KEY
	(
	IDPreInventoryMovParent
	) REFERENCES dbo.PreInventoryMov
	(
	IDPreInventoryMov
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.PreInventoryMov WITH NOCHECK ADD CONSTRAINT
	FK_SystemUser_PreInvnetoryMov_UserID FOREIGN KEY
	(
	UserID
	) REFERENCES dbo.SystemUser
	(
	IDUser
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.PreInventoryMov WITH NOCHECK ADD CONSTRAINT
	FK_Store_PreInventoryMov_StoreID FOREIGN KEY
	(
	StoreID
	) REFERENCES dbo.Store
	(
	IDStore
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.PreInventoryMov WITH NOCHECK ADD CONSTRAINT
	FK_Model_PreInventMov_ModelID FOREIGN KEY
	(
	ModelID
	) REFERENCES dbo.Model
	(
	IDModel
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.PreInventoryMov WITH NOCHECK ADD CONSTRAINT
	FK_Cotacao_PreInventoryMov_IDCotacao FOREIGN KEY
	(
	IDCotacao
	) REFERENCES dbo.Cotacao
	(
	IDCotacao
	) NOT FOR REPLICATION

GO

CREATE TRIGGER tr_PreInventMov_All ON dbo.PreInventoryMov
FOR INSERT,UPDATE,DELETE
NOT FOR REPLICATION
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Teste da existencia de Model e do MASTER no Inventory
		- INVENTORY e INVENTORY MASTER:  QtyOnPreSale & QtyOnOrder
		- MODEL e MODEL MASTER: Atualiza o Total no model


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

IF @@rowcount = 0
	RETURN

SET NOCOUNT ON

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--	B O T H      I N S E R T      A N D      D E L E T E
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------


----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--   	Teste da existencia de Model no Inventory
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
INSERT
	Inventory
	(
	StoreID,
	ModelID
	)
	SELECT
		PIM.StoreID,
		PIM.ModelID
	FROM
		Inserted PIM
		LEFT OUTER JOIN
		Inventory I ON (PIM.StoreID =I.StoreID AND PIM.ModelID = I.ModelID)
	WHERE
		I.ModelID IS NULL
		AND
		PIM.ModelID IS NOT NULL
		AND
		PIM.StoreID IS NOT NULL
	GROUP BY
		PIM.StoreID,
		PIM.ModelID


----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--   	Teste da existencia do MASTER no Inventory
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
INSERT
	Inventory
	(
	StoreID,
	ModelID
	)
	SELECT
		PIM.StoreID,
		M.IDModelParent
	FROM
		Inserted PIM
		JOIN
		Model M ON (PIM.ModelID = M.IDModel)
		LEFT OUTER JOIN
		Inventory I ON (PIM.StoreID =I.StoreID AND M.IDModelParent = I.ModelID)
	WHERE
		I.ModelID IS NULL
		AND
		M.IDModelParent IS NOT NULL
	GROUP BY
		PIM.StoreID,
		M.IDModelParent



----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--	D E L E T E
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--	   INVENTORY:  QtyOnPreSale & QtyOnOrder
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

UPDATE
	I
SET
	I.QtyOnHand 		= IsNull(I.QtyOnHand, 0) - Total.OnHand,
	I.QtyOnOrder 		= IsNull(I.QtyOnOrder, 0) - Total.OnOrder,
	I.QtyOnRepair 		= IsNull(I.QtyOnRepair, 0) - Total.OnRepair,
	I.QtyOnPrePurchase	= IsNull(I.QtyOnPrePurchase, 0) - Total.OnPrePurchase,
	I.QtyOnPreSale 		= IsNull(I.QtyOnPreSale, 0) - Total.OnPreSale
FROM
	(
	SELECT
		ModelID,
		StoreID,
		SUM( IsNull(PIM.Qty * (2*IMT.UpdatePreOnHand-1), 0) ) as OnHand,
		SUM( IsNull((PIM.Qty - IsNull(PIM.QtyRealMov,0)) * (2*IMT.UpdatePreOnOrder-1), 0) ) as OnOrder,
		SUM( IsNull(PIM.Qty * (2*IMT.UpdatePreOnRepair-1), 0) ) as OnRepair,
		SUM( IsNull(PIM.Qty * (2*IMT.UpdatePreOnPrePurchase-1), 0) ) as OnPrePurchase,
		SUM( IsNull(PIM.Qty * (2*IMT.UpdatePreOnPreSale-1), 0) ) as OnPreSale
	FROM
		Deleted PIM
		JOIN
		InventoryMovType IMT ON (PIM.InventMovTypeID = IMT.IDInventMovType)
	WHERE
		PIM.ModelID IS NOT NULL
		AND
		PIM.StoreID IS NOT NULL
	GROUP BY
		ModelID,
		StoreID
	) Total
	JOIN
	Inventory I ON (Total.ModelID = I.ModelID AND Total.StoreID = I.StoreID)


----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--	   INVENTORY MASTER:  QtyOnPreSale & QtyOnOrder
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

UPDATE
	I
SET
	I.QtyOnHand 		= IsNull(I.QtyOnHand, 0) - Total.OnHand,
	I.QtyOnOrder 		= IsNull(I.QtyOnOrder, 0) - Total.OnOrder,
	I.QtyOnRepair 		= IsNull(I.QtyOnRepair, 0) - Total.OnRepair,
	I.QtyOnPrePurchase	= IsNull(I.QtyOnPrePurchase, 0) - Total.OnPrePurchase,
	I.QtyOnPreSale 		= IsNull(I.QtyOnPreSale, 0) - Total.OnPreSale
FROM
	(
	SELECT
		M.IDModelParent as ModelID,
		PIM.StoreID,
		SUM( IsNull(PIM.Qty * (2*IMT.UpdatePreOnHand-1), 0) ) as OnHand,
		SUM( IsNull((PIM.Qty - IsNull(PIM.QtyRealMov,0)) * (2*IMT.UpdatePreOnOrder-1), 0) ) as OnOrder,
		SUM( IsNull(PIM.Qty * (2*IMT.UpdatePreOnRepair-1), 0) ) as OnRepair,
		SUM( IsNull(PIM.Qty * (2*IMT.UpdatePreOnPrePurchase-1), 0) ) as OnPrePurchase,
		SUM( IsNull(PIM.Qty * (2*IMT.UpdatePreOnPreSale-1), 0) ) as OnPreSale
	FROM
		Deleted PIM
		JOIN Model M ON (PIM.ModelID = M.IDModel)
		JOIN InventoryMovType IMT ON (PIM.InventMovTypeID = IMT.IDInventMovType)
	WHERE
		M.IDModelParent IS NOT NULL
	GROUP BY
		M.IDModelParent,
		PIM.StoreID
	) Total
	JOIN
	Inventory I ON (Total.ModelID = I.ModelID AND Total.StoreID = I.StoreID)



----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--	MODEL: Atualiza o Total no model
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------


UPDATE
	M
SET
	M.TotQtyOnHand 		= IsNull(M.TotQtyOnHand, 0) - Total.OnHand,
	M.TotQtyOnOrder		= IsNull(M.TotQtyOnOrder, 0) - Total.OnOrder,
	M.TotQtyOnRepair 		= IsNull(M.TotQtyOnRepair, 0) - Total.OnRepair,
	M.TotQtyOnPrePurchase		= IsNull(M.TotQtyOnPrePurchase, 0) - Total.OnPrePurchase,
	M.TotQtyOnPreSale		= IsNull(M.TotQtyOnPreSale, 0) - Total.OnPreSale
FROM
	(
	SELECT
		ModelID,
		SUM( IsNull(PIM.Qty * (2*IMT.UpdatePreOnHand-1), 0) ) as OnHand,
		SUM( IsNull((PIM.Qty - IsNull(PIM.QtyRealMov,0)) * (2*IMT.UpdatePreOnOrder-1), 0) ) as OnOrder,
		SUM( IsNull(PIM.Qty * (2*IMT.UpdatePreOnRepair-1), 0) ) as OnRepair,
		SUM( IsNull(PIM.Qty * (2*IMT.UpdatePreOnPrePurchase-1), 0) ) as OnPrePurchase,
		SUM( IsNull(PIM.Qty * (2*IMT.UpdatePreOnPreSale-1), 0) ) as OnPreSale
	FROM
		Deleted PIM
		JOIN
		InventoryMovType IMT ON (PIM.InventMovTypeID = IMT.IDInventMovType)
	GROUP BY
		ModelID
	) Total
	JOIN
	Model M ON (Total.ModelID = M.IDModel)


----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--	MODEL MASTER: Atualiza o Total no model
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

UPDATE
	M
SET
	M.TotQtyOnHand 		= IsNull(M.TotQtyOnHand, 0) - Total.OnHand,
	M.TotQtyOnOrder		= IsNull(M.TotQtyOnOrder, 0) - Total.OnOrder,
	M.TotQtyOnRepair 		= IsNull(M.TotQtyOnRepair, 0) - Total.OnRepair,
	M.TotQtyOnPrePurchase		= IsNull(M.TotQtyOnPrePurchase, 0) - Total.OnPrePurchase,
	M.TotQtyOnPreSale		= IsNull(M.TotQtyOnPreSale, 0) - Total.OnPreSale
FROM
	(
	SELECT
		IDModelParent,
		SUM( IsNull(PIM.Qty * (2*IMT.UpdatePreOnHand-1), 0) ) as OnHand,
		SUM( IsNull((PIM.Qty - IsNull(PIM.QtyRealMov,0)) * (2*IMT.UpdatePreOnOrder-1), 0) ) as OnOrder,
		SUM( IsNull(PIM.Qty * (2*IMT.UpdatePreOnRepair-1), 0) ) as OnRepair,
		SUM( IsNull(PIM.Qty * (2*IMT.UpdatePreOnPrePurchase-1), 0) ) as OnPrePurchase,
		SUM( IsNull(PIM.Qty * (2*IMT.UpdatePreOnPreSale-1), 0) ) as OnPreSale
	FROM
		Deleted PIM
		JOIN
		Model M ON (PIM.ModelID = M.IDModel)
		JOIN
		InventoryMovType IMT ON (PIM.InventMovTypeID = IMT.IDInventMovType)
	WHERE
		M.IDModelParent IS NOT NULL
	GROUP BY
		IDModelParent
	) Total
	JOIN
	Model M ON (Total.IDModelParent = M.IDModel)



----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--	I N S E R T
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------


----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--	   Atualiza QtyOnPreSale & QtyOnOrder
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

UPDATE
	I
SET
	I.QtyOnHand 		= IsNull(I.QtyOnHand, 0) + Total.OnHand,
	I.QtyOnOrder 		= IsNull(I.QtyOnOrder, 0) + Total.OnOrder,
	I.QtyOnRepair 		= IsNull(I.QtyOnRepair, 0) + Total.OnRepair,
	I.QtyOnPrePurchase	= IsNull(I.QtyOnPrePurchase, 0) + Total.OnPrePurchase,
	I.QtyOnPreSale 		= IsNull(I.QtyOnPreSale, 0) + Total.OnPreSale
FROM
	(
	SELECT
		ModelID,
		StoreID,
		SUM( IsNull(PIM.Qty * (2*IMT.UpdatePreOnHand-1), 0) ) as OnHand,
		SUM( IsNull((PIM.Qty - IsNull(PIM.QtyRealMov,0)) * (2*IMT.UpdatePreOnOrder-1), 0) ) as OnOrder,
		SUM( IsNull(PIM.Qty * (2*IMT.UpdatePreOnRepair-1), 0) ) as OnRepair,
		SUM( IsNull(PIM.Qty * (2*IMT.UpdatePreOnPrePurchase-1), 0) ) as OnPrePurchase,
		SUM( IsNull(PIM.Qty * (2*IMT.UpdatePreOnPreSale-1), 0) ) as OnPreSale
	FROM
		Inserted PIM
		JOIN
		InventoryMovType IMT ON (PIM.InventMovTypeID = IMT.IDInventMovType)
	WHERE
		PIM.ModelID IS NOT NULL
		AND
		PIM.StoreID IS NOT NULL
	GROUP BY
		ModelID,
		StoreID
	) Total
	JOIN
	Inventory I ON (Total.ModelID = I.ModelID AND Total.StoreID = I.StoreID)


----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--	   INVENTORY MASTER:  QtyOnPreSale & QtyOnOrder
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

UPDATE
	I
SET
	I.QtyOnHand 		= IsNull(I.QtyOnHand, 0) + Total.OnHand,
	I.QtyOnOrder 		= IsNull(I.QtyOnOrder, 0) + Total.OnOrder,
	I.QtyOnRepair 		= IsNull(I.QtyOnRepair, 0) + Total.OnRepair,
	I.QtyOnPrePurchase	= IsNull(I.QtyOnPrePurchase, 0) + Total.OnPrePurchase,
	I.QtyOnPreSale 		= IsNull(I.QtyOnPreSale, 0) + Total.OnPreSale
FROM
	(
	SELECT
		M.IDModelParent as ModelID,
		PIM.StoreID,
		SUM( IsNull(PIM.Qty * (2*IMT.UpdatePreOnHand-1), 0) ) as OnHand,
		SUM( IsNull((PIM.Qty - IsNull(PIM.QtyRealMov,0)) * (2*IMT.UpdatePreOnOrder-1), 0) ) as OnOrder,
		SUM( IsNull(PIM.Qty * (2*IMT.UpdatePreOnRepair-1), 0) ) as OnRepair,
		SUM( IsNull(PIM.Qty * (2*IMT.UpdatePreOnPrePurchase-1), 0) ) as OnPrePurchase,
		SUM( IsNull(PIM.Qty * (2*IMT.UpdatePreOnPreSale-1), 0) ) as OnPreSale
	FROM
		Inserted PIM
		JOIN
		Model M ON (PIM.ModelID = M.IDModel)
		JOIN
		InventoryMovType IMT ON (PIM.InventMovTypeID = IMT.IDInventMovType)
	WHERE
		M.IDModelParent IS NOT NULL
	GROUP BY
		M.IDModelParent,
		PIM.StoreID
	) Total
	JOIN
        Inventory I ON (Total.ModelID = I.ModelID AND Total.StoreID = I.StoreID)


----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--	MODEL: Atualiza o Total no model
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------


UPDATE
	M
SET
	M.TotQtyOnHand 		= IsNull(M.TotQtyOnHand, 0) + Total.OnHand,
	M.TotQtyOnOrder		= IsNull(M.TotQtyOnOrder, 0) + Total.OnOrder,
	M.TotQtyOnRepair 		= IsNull(M.TotQtyOnRepair, 0) + Total.OnRepair,
	M.TotQtyOnPrePurchase		= IsNull(M.TotQtyOnPrePurchase, 0) + Total.OnPrePurchase,
	M.TotQtyOnPreSale		= IsNull(M.TotQtyOnPreSale, 0) + Total.OnPreSale
FROM
	(
	SELECT
		ModelID,
		SUM( IsNull(PIM.Qty * (2*IMT.UpdatePreOnHand-1), 0) ) as OnHand,
		SUM( IsNull((PIM.Qty - IsNull(PIM.QtyRealMov,0)) * (2*IMT.UpdatePreOnOrder-1), 0) ) as OnOrder,
		SUM( IsNull(PIM.Qty * (2*IMT.UpdatePreOnRepair-1), 0) ) as OnRepair,
		SUM( IsNull(PIM.Qty * (2*IMT.UpdatePreOnPrePurchase-1), 0) ) as OnPrePurchase,
		SUM( IsNull(PIM.Qty * (2*IMT.UpdatePreOnPreSale-1), 0) ) as OnPreSale
	FROM
		Inserted PIM
		JOIN
		InventoryMovType IMT ON (PIM.InventMovTypeID = IMT.IDInventMovType)
	GROUP BY
		ModelID
	) Total
	JOIN
	Model M ON (Total.ModelID = M.IDModel)


----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--	MODEL MASTER: Atualiza o Total no model
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

UPDATE
	M
SET
	M.TotQtyOnHand 		= IsNull(M.TotQtyOnHand, 0) + Total.OnHand,
	M.TotQtyOnOrder		= IsNull(M.TotQtyOnOrder, 0) + Total.OnOrder,
	M.TotQtyOnRepair 		= IsNull(M.TotQtyOnRepair, 0) + Total.OnRepair,
	M.TotQtyOnPrePurchase		= IsNull(M.TotQtyOnPrePurchase, 0) + Total.OnPrePurchase,
	M.TotQtyOnPreSale		= IsNull(M.TotQtyOnPreSale, 0) + Total.OnPreSale
FROM
	(
	SELECT
		IDModelParent,
		SUM( IsNull(PIM.Qty * (2*IMT.UpdatePreOnHand-1), 0) ) as OnHand,
		SUM( IsNull((PIM.Qty - IsNull(PIM.QtyRealMov,0)) * (2*IMT.UpdatePreOnOrder-1), 0) ) as OnOrder,
		SUM( IsNull(PIM.Qty * (2*IMT.UpdatePreOnRepair-1), 0) ) as OnRepair,
		SUM( IsNull(PIM.Qty * (2*IMT.UpdatePreOnPrePurchase-1), 0) ) as OnPrePurchase,
		SUM( IsNull(PIM.Qty * (2*IMT.UpdatePreOnPreSale-1), 0) ) as OnPreSale
	FROM
		Inserted PIM
		JOIN
		Model M ON (PIM.ModelID = M.IDModel)
		JOIN
		InventoryMovType IMT ON (PIM.InventMovTypeID = IMT.IDInventMovType)
	WHERE
		M.IDModelParent IS NOT NULL
	GROUP BY
		IDModelParent
	) Total
	JOIN
	Model M ON (Total.IDModelParent = M.IDModel)

GO

ALTER TABLE dbo.POItemRequest WITH NOCHECK ADD CONSTRAINT
	FK_PreInventoryMov_POItemRequest_IDPreInventoryMov FOREIGN KEY
	(
	IDPreInventoryMov
	) REFERENCES dbo.PreInventoryMov
	(
	IDPreInventoryMov
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.Request WITH NOCHECK ADD CONSTRAINT
	FK_PreInventoryMov_Request_IDPreInventoryMov FOREIGN KEY
	(
	IDPreInventoryMov
	) REFERENCES dbo.PreInventoryMov
	(
	IDPreInventoryMov
	) NOT FOR REPLICATION
GO

