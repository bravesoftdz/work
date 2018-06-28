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

CREATE TABLE dbo.Tmp_InventoryMov
	(
	IDInventoryMov int NOT NULL,
	IDRepair int NULL,
	StoreID int NOT NULL,
	ModelID int NOT NULL,
	InventMovTypeID int NOT NULL,
	IDPessoa int NULL,
	ComissionID int NULL,
	IDAgrupaPag int NULL,
	IDTemp int NULL,
	IDLancPagCom int NULL,
	DocumentID int NOT NULL,
	IDUser int NULL,
	BarCodeID TBarCode NULL,
	PreInventoryMovID int NULL,
	MovDate smalldatetime NOT NULL,
	Qty int NOT NULL,
	CostPrice money NULL,
	SalePrice money NULL,
	Discount money NULL,
	Freight money NULL,
	OtherCost money NULL,
	ExchangeInvoice int NULL,
	QtyExchanged int NULL,
	SalesTax money NULL,
	Notes varchar(255) NULL
	)  ON [PRIMARY]
GO

IF EXISTS(SELECT * FROM dbo.InventoryMov)
	 EXEC('INSERT INTO dbo.Tmp_InventoryMov (IDInventoryMov, IDRepair, StoreID, ModelID, InventMovTypeID, IDPessoa, ComissionID, IDAgrupaPag, IDTemp, IDLancPagCom, DocumentID, IDUser, BarCodeID, PreInventoryMovID, MovDate, Qty, CostPrice, SalePrice, Discount, Freight, OtherCost, ExchangeInvoice, QtyExchanged, SalesTax, Notes)
		SELECT IDInventoryMov, IDRepair, StoreID, ModelID, InventMovTypeID, IDPessoa, ComissionID, IDAgrupaPag, IDTemp, IDLancPagCom, DocumentID, IDUser, BarCodeID, PreInventoryMovID, MovDate, Qty, CostPrice, SalePrice, Discount, Freight, OtherCost, ExchangeInvoice, QtyExchanged, SalesTax, Notes FROM dbo.InventoryMov TABLOCKX')
GO

DECLARE @temp Varchar (8000)
SET @temp = ''
SELECT @temp = @temp + 'ALTER TABLE ' + TabelaDerivada+ CHAR (13)+
+ CHAR(9)+'DROP CONSTRAINT ' + ConstraintName + CHAR (13)
FROM vw_Sis_ChaveEstrangeira
WHERE TabelaOriginal = 'InventoryMov'
EXEC(@temp)
GO

DROP TABLE dbo.InventoryMov
GO

ALTER TABLE dbo.Tmp_InventoryMov ADD CONSTRAINT
	DF_Zero115 DEFAULT (0) FOR CostPrice
GO

ALTER TABLE dbo.Tmp_InventoryMov ADD CONSTRAINT
	DF_Zero116 DEFAULT (0) FOR SalePrice
GO

ALTER TABLE dbo.Tmp_InventoryMov ADD CONSTRAINT
	DF_Zero117 DEFAULT (0) FOR Discount
GO

ALTER TABLE dbo.Tmp_InventoryMov ADD CONSTRAINT
	DF_Zero118 DEFAULT (0) FOR Freight
GO

ALTER TABLE dbo.Tmp_InventoryMov ADD CONSTRAINT
	DF_Zero119 DEFAULT (0) FOR OtherCost
GO

EXECUTE sp_rename N'dbo.Tmp_InventoryMov', N'InventoryMov', 'OBJECT'
GO

CREATE CLUSTERED INDEX PI_InventoryMov_InventMovType ON dbo.InventoryMov
	(
	InventMovTypeID,
	DocumentID
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX PI_MovInvent_Date ON dbo.InventoryMov
	(
	MovDate
	) ON [PRIMARY]
GO

ALTER TABLE dbo.InventoryMov ADD CONSTRAINT
	PK_InventoryMov_IDInventoryMov PRIMARY KEY NONCLUSTERED 
	(
	IDInventoryMov
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX XIF107InventoryMov ON dbo.InventoryMov
	(
	IDPessoa
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX XIF108InventoryMov ON dbo.InventoryMov
	(
	ComissionID
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX XIF109InventoryMov ON dbo.InventoryMov
	(
	InventMovTypeID
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX PI_InventMov_ModelID ON dbo.InventoryMov
	(
	ModelID
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX XIF385InventoryMov ON dbo.InventoryMov
	(
	StoreID
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX XIF412InventoryMov ON dbo.InventoryMov
	(
	IDUser
	) ON [PRIMARY]
GO

CREATE NONCLUSTERED INDEX XIF445InventoryMov ON dbo.InventoryMov
	(
	IDRepair
	) ON [PRIMARY]
GO

ALTER TABLE dbo.InventoryMov WITH NOCHECK ADD CONSTRAINT
	FK_SystemUser_InventoryMov_IDUser FOREIGN KEY
	(
	IDUser
	) REFERENCES dbo.SystemUser
	(
	IDUser
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.InventoryMov WITH NOCHECK ADD CONSTRAINT
	FK_Store_InventoryMov_StoreID FOREIGN KEY
	(
	StoreID
	) REFERENCES dbo.Store
	(
	IDStore
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.InventoryMov WITH NOCHECK ADD CONSTRAINT
	FK_Model_InventoryMov_ModelID FOREIGN KEY
	(
	ModelID
	) REFERENCES dbo.Model
	(
	IDModel
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.InventoryMov WITH NOCHECK ADD CONSTRAINT
	FK_InventoryMovType_IventoryMov_InventMovTypeID FOREIGN KEY
	(
	InventMovTypeID
	) REFERENCES dbo.InventoryMovType
	(
	IDInventMovType
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.InventoryMov WITH NOCHECK ADD CONSTRAINT
	FK_Pessoa_InventoryMov_ComissionID FOREIGN KEY
	(
	ComissionID
	) REFERENCES dbo.Pessoa
	(
	IDPessoa
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.InventoryMov WITH NOCHECK ADD CONSTRAINT
	FK_Pessoa_IventoryMov_IDPessoa FOREIGN KEY
	(
	IDPessoa
	) REFERENCES dbo.Pessoa
	(
	IDPessoa
	) NOT FOR REPLICATION
GO

CREATE TRIGGER tr_InventoryMov_All ON dbo.InventoryMov
FOR INSERT,UPDATE,DELETE
NOT FOR REPLICATION
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Teste da existencia de MODEL no Inventory
		- Teste existencia do MODEL  no Inventory MovTotals
		- Teste da existencia do MASTER no Inventory
		- Teste existencia do MASTER no Inventory MovTotals
		- Atualiza o LastMovDate no Model, se for Insert and Update
		- Atualiza o DateLastSellingPrice no Model, se for Insert and Update
		- INVENTORY e INVMASTER:  Atualiza QtyOnHand
		- MODEL e MODEL MASTER: Atualiza o Total no model
		- MODEL e MODEL MASTER: Atualiza o InventoryMovTotals


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
	01 Aug  2001		Rodrigo Costa		Gravar o LastMovDate no Model;
	22 Aug  2001		Davi Gouveia		Gravar o DateLastSellingPrice no Model
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

IF @@rowcount = 0
	RETURN

SET NOCOUNT ON

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--	B O T H      I N S E R T      A N D      D E L E T E
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------


----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--   	Teste da existencia de MODEL no Inventory
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
INSERT
	Inventory
	(
	StoreID,
	ModelID
	)
	SELECT
		IM.StoreID,
		IM.ModelID
	FROM
		Inserted IM
		LEFT OUTER JOIN
		Inventory I ON (IM.StoreID =I.StoreID AND IM.ModelID = I.ModelID)
	WHERE
		I.ModelID IS NULL
	GROUP BY
		IM.StoreID,
		IM.ModelID



----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--	Teste existencia do MODEL  no Inventory MovTotals
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

INSERT
	InventoryMovTotal

	SELECT
		IT.StoreID,
		IT.ModelID,
		IT.InventMovTypeID,
		IT.Year,
		IT.Month,
		0,
		0,
		0
	FROM 	(
		SELECT
			Inserted.StoreID,
			Inserted.ModelID,
			Inserted.InventMovTypeID,
			DatePart(yy, Inserted.MovDate) Year,
			DatePart(mm, Inserted.MovDate) Month
 		FROM
			Inserted
		GROUP BY
			Inserted.StoreID,
			Inserted.ModelID,
			Inserted.InventMovTypeID,
                 		DatePart(yy, Inserted.MovDate),
			DatePart(mm, Inserted.MovDate)
		) IT
		LEFT OUTER JOIN InventoryMovTotal IMT
			ON (
				IMT.StoreID = IT.StoreID
				AND
				IMT.ModelID = IT.ModelID
				AND
				IMT.InventMovTypeID = IT.InventMovTypeID
				AND
				IMT.Year  = IT.Year
				AND
				IMT.Month = IT.Month )
	WHERE
		IMT.StoreID IS NULL



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
		IM.StoreID,
		M.IDModelParent
	FROM
		Inserted IM
		JOIN
		Model M ON (IM.ModelID = M.IDModel)
		LEFT OUTER JOIN
		Inventory I ON (IM.StoreID =I.StoreID AND M.IDModelParent = I.ModelID)
	WHERE
		I.ModelID IS NULL
		AND --Rodrigo
		M.IDModelParent IS NOT NULL
	GROUP BY
		IM.StoreID,
		M.IDModelParent



----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--	Teste existencia do MASTER no Inventory MovTotals
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

INSERT
	InventoryMovTotal

	SELECT
		IT.StoreID,
		IT.ModelID,
		IT.InventMovTypeID,
		IT.Year,
		IT.Month,
		0,
		0,
		0
	FROM 	(
		SELECT
			Inserted.StoreID,
			M.IDModelParent as ModelID,
			Inserted.InventMovTypeID,
			DatePart(yy, Inserted.MovDate) Year,
			DatePart(mm, Inserted.MovDate) Month
 		FROM
			Inserted
			JOIN
			Model M ON (Inserted.ModelID = M.IDModel)
		WHERE
			M.IDModelParent IS NOT NULL
		GROUP BY
			Inserted.StoreID,
			M.IDModelParent,
			Inserted.InventMovTypeID,
                 		DatePart(yy, Inserted.MovDate),
			DatePart(mm, Inserted.MovDate)
		) IT
		LEFT OUTER JOIN InventoryMovTotal IMT
			ON (
				IMT.StoreID = IT.StoreID
				AND
				IMT.ModelID = IT.ModelID
				AND
				IMT.InventMovTypeID = IT.InventMovTypeID
				AND
				IMT.Year  = IT.Year
				AND
				IMT.Month = IT.Month )
	WHERE
		IMT.StoreID IS NULL



----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--	Atualiza o LastMovDate no Model, se for Insert and Update
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

UPDATE
	M
SET
	M.LastMovDate 	= IM.MovDate
FROM
	Inserted IM
	JOIN Model M ON (IM.ModelID = M.IDModel)
WHERE
	IsNull(M.LastMovDate,0)	< IM.MovDate


----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--	Atualiza o DateLastSellingPrice no Model, se for Insert and Update
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

UPDATE
	M
SET
	M.DateLastSellingPrice = IM.MovDate
FROM
	Inserted IM
	JOIN Model M ON (IM.ModelID = M.IDModel)
WHERE
	IM.InventMovTypeID = 1
	AND
	IM.MovDate > IsNull(M.DateLastSellingPrice,0)


----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--	D E L E T E
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------



----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--	Parte da Delecao do SerialMov
--   	Só executa se for delete mesmo, nao se for update
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

DELETE
	SM
FROM
	SerialMov SM
	JOIN
	Deleted IMD ON (IMD.IDInventoryMov = SM.InventoryMovID)
	LEFT OUTER JOIN
	Inserted IMI ON (IMI.IDInventoryMov = SM.InventoryMovID)
WHERE
	IMI.IDInventoryMov IS NULL


----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--	   INVENTORY:  Atualiza QtyOnHand
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
		SUM( IsNull(IM.Qty * (2*IMT.UpdateOnHand-1), 0) ) as OnHand,
		SUM( IsNull(IM.Qty * (2*IMT.UpdateOnOrder-1), 0) ) as OnOrder,
		SUM( IsNull(IM.Qty * (2*IMT.UpdateOnRepair-1), 0) ) as OnRepair,
		SUM( IsNull(IM.Qty * (2*IMT.UpdateOnPrePurchase-1), 0) ) as OnPrePurchase,
		SUM( IsNull(IM.Qty * (2*IMT.UpdateOnPreSale-1), 0) ) as OnPreSale
	FROM
		Deleted IM
		JOIN
		InventoryMovType IMT ON (IM.InventMovTypeID = IMT.IDInventMovType)
	GROUP BY
		ModelID,
		StoreID
	) Total
	JOIN
        Inventory I ON (Total.ModelID = I.ModelID AND Total.StoreID = I.StoreID)

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--	   INVENTORY MASTER:  Atualiza QtyOnHand
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
		IM.StoreID,
		SUM( IsNull(IM.Qty * (2*IMT.UpdateOnHand-1), 0) ) as OnHand,
		SUM( IsNull(IM.Qty * (2*IMT.UpdateOnOrder-1), 0) ) as OnOrder,
		SUM( IsNull(IM.Qty * (2*IMT.UpdateOnRepair-1), 0) ) as OnRepair,
		SUM( IsNull(IM.Qty * (2*IMT.UpdateOnPrePurchase-1), 0) ) as OnPrePurchase,
		SUM( IsNull(IM.Qty * (2*IMT.UpdateOnPreSale-1), 0) ) as OnPreSale
	FROM
		Deleted IM
		JOIN
		Model M ON (IM.ModelID = M.IDModel)
		JOIN
		InventoryMovType IMT ON (IM.InventMovTypeID = IMT.IDInventMovType)
	WHERE
		M.IDModelParent IS NOT NULL

	GROUP BY
		M.IDModelParent,
		IM.StoreID
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
		SUM( IsNull(IM.Qty * (2*IMT.UpdateOnHand-1), 0) ) as OnHand,
		SUM( IsNull(IM.Qty * (2*IMT.UpdateOnOrder-1), 0) ) as OnOrder,
		SUM( IsNull(IM.Qty * (2*IMT.UpdateOnRepair-1), 0) ) as OnRepair,
		SUM( IsNull(IM.Qty * (2*IMT.UpdateOnPrePurchase-1), 0) ) as OnPrePurchase,
		SUM( IsNull(IM.Qty * (2*IMT.UpdateOnPreSale-1), 0) ) as OnPreSale
	FROM
		Deleted IM
		JOIN
		InventoryMovType IMT ON (IM.InventMovTypeID = IMT.IDInventMovType)
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
		SUM( IsNull(IM.Qty * (2*IMT.UpdateOnHand-1), 0) ) as OnHand,
		SUM( IsNull(IM.Qty * (2*IMT.UpdateOnOrder-1), 0) ) as OnOrder,
		SUM( IsNull(IM.Qty * (2*IMT.UpdateOnRepair-1), 0) ) as OnRepair,
		SUM( IsNull(IM.Qty * (2*IMT.UpdateOnPrePurchase-1), 0) ) as OnPrePurchase,
		SUM( IsNull(IM.Qty * (2*IMT.UpdateOnPreSale-1), 0) ) as OnPreSale
	FROM
		Deleted IM
		JOIN
		Model M ON (IM.ModelID = M.IDModel)
		JOIN
		InventoryMovType IMT ON (IM.InventMovTypeID = IMT.IDInventMovType)
	WHERE
		M.IDModelParent IS NOT NULL
	GROUP BY
		IDModelParent
	) Total
	JOIN
        Model M ON (Total.IDModelParent = M.IDModel)



----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--	MODEL: Atualiza o InventoryMovTotals
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

UPDATE
	IMT
SET
	IMT.TotQty = IsNull(IMT.TotQty, 0) - Total.Qty,
	IMT.TotSale = IsNull(IMT.TotSale, 0) - Total.Sale,
	IMT.TotCost = IsNull(IMT.TotCost, 0) - Total.Cost
FROM
	(
	SELECT
		IM.StoreID,
		IM.ModelID,
		IM.InventMovTypeID,
		DatePart(yy, IM.MovDate) as [Year],
		DatePart(mm, IM.MovDate) as [Month],
		SUM( IsNull( IM.Qty, 0 ) ) as Qty,
		SUM( IsNull( IM.Qty * IM.SalePrice, 0 )  - IsNull(IM.Discount , 0) ) as Sale,
		SUM( IsNull( IM.Qty * IM.CostPrice, 0) ) as Cost
	FROM
		Deleted IM
	GROUP BY
		IM.StoreID,
		IM.ModelID,
		IM.InventMovTypeID,
		DatePart(yy, IM.MovDate),
		DatePart(mm, IM.MovDate)
	) as Total
	JOIN InventoryMovTotal IMT
		ON (	Total.StoreID = IMT.StoreID
			AND
			Total.ModelID = IMT.ModelID
			AND
			Total.InventMovTypeID = IMT.InventMovTypeID
			AND
			Total.[Year] = IMT.[Year]
			AND
			Total.[Month] = IMT.[Month] )



----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--	MASTER: Atualiza o InventoryMovTotals
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

UPDATE
	IMT
SET
	IMT.TotQty = IsNull(IMT.TotQty, 0) - Total.Qty,
	IMT.TotSale = IsNull(IMT.TotSale, 0) - Total.Sale,
	IMT.TotCost = IsNull(IMT.TotCost, 0) - Total.Cost
FROM
	(
	SELECT
		IM.StoreID,
		M.IDModelParent as ModelID,
		IM.InventMovTypeID,
		DatePart(yy, IM.MovDate) as [Year],
		DatePart(mm, IM.MovDate) as [Month],
		SUM( IsNull( IM.Qty, 0 ) ) as Qty,
		SUM( IsNull( IM.Qty * IM.SalePrice, 0 )  - IsNull(IM.Discount , 0) ) as Sale,
		SUM( IsNull( IM.Qty * IM.CostPrice, 0) ) as Cost
	FROM
		Deleted IM
		JOIN
		Model M ON (IM.ModelID = M.IDModel)
	WHERE
		M.IDModelParent IS NOT NULL
	GROUP BY
		IM.StoreID,
		M.IDModelParent,
		IM.InventMovTypeID,
		DatePart(yy, IM.MovDate),
		DatePart(mm, IM.MovDate)
	) as Total
	JOIN InventoryMovTotal IMT
		ON (	Total.StoreID = IMT.StoreID
			AND
			Total.ModelID = IMT.ModelID
			AND
			Total.InventMovTypeID = IMT.InventMovTypeID
			AND
			Total.[Year] = IMT.[Year]
			AND
			Total.[Month] = IMT.[Month] )



----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--	I N S E R T
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------


----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--	   INVENTORY: Atualiza QtyOnHand
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
		SUM( IsNull(IM.Qty * (2*IMT.UpdateOnHand-1), 0) ) as OnHand,
		SUM( IsNull(IM.Qty * (2*IMT.UpdateOnOrder-1), 0) ) as OnOrder,
		SUM( IsNull(IM.Qty * (2*IMT.UpdateOnRepair-1), 0) ) as OnRepair,
		SUM( IsNull(IM.Qty * (2*IMT.UpdateOnPrePurchase-1), 0) ) as OnPrePurchase,
		SUM( IsNull(IM.Qty * (2*IMT.UpdateOnPreSale-1), 0) ) as OnPreSale
	FROM
		Inserted IM
		JOIN InventoryMovType IMT ON (IM.InventMovTypeID = IMT.IDInventMovType)
	GROUP BY
		ModelID,
		StoreID
	) Total
	JOIN
	Inventory I ON (Total.ModelID = I.ModelID AND Total.StoreID = I.StoreID)



----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--	   INVENTORY MASTER: Atualiza QtyOnHand
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
		StoreID,
		SUM( IsNull(IM.Qty * (2*IMT.UpdateOnHand-1), 0) ) as OnHand,
		SUM( IsNull(IM.Qty * (2*IMT.UpdateOnOrder-1), 0) ) as OnOrder,
		SUM( IsNull(IM.Qty * (2*IMT.UpdateOnRepair-1), 0) ) as OnRepair,
		SUM( IsNull(IM.Qty * (2*IMT.UpdateOnPrePurchase-1), 0) ) as OnPrePurchase,
		SUM( IsNull(IM.Qty * (2*IMT.UpdateOnPreSale-1), 0) ) as OnPreSale
	FROM
		Inserted IM
		JOIN Model M ON (IM.ModelID = M.IDModel)
		JOIN InventoryMovType IMT ON (IM.InventMovTypeID = IMT.IDInventMovType)
	WHERE
		M.IDModelParent IS NOT NULL

	GROUP BY
		M.IDModelParent,
		StoreID
	) Total
	JOIN
	Inventory I ON (Total.ModelID = I.ModelID AND Total.StoreID = I.StoreID)



----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--	MODEL: Atualiza o Total no Model
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
		SUM( IsNull(IM.Qty * (2*IMT.UpdateOnHand-1), 0) ) as OnHand,
		SUM( IsNull(IM.Qty * (2*IMT.UpdateOnOrder-1), 0) ) as OnOrder,
		SUM( IsNull(IM.Qty * (2*IMT.UpdateOnRepair-1), 0) ) as OnRepair,
		SUM( IsNull(IM.Qty * (2*IMT.UpdateOnPrePurchase-1), 0) ) as OnPrePurchase,
		SUM( IsNull(IM.Qty * (2*IMT.UpdateOnPreSale-1), 0) ) as OnPreSale
	FROM
		Inserted IM
		JOIN
		InventoryMovType IMT ON (IM.InventMovTypeID = IMT.IDInventMovType)
	GROUP BY
		ModelID
	) Total
	JOIN
	Model M ON (Total.ModelID = M.IDModel)



----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--	MASTER: Atualiza o Total no Master
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
		SUM( IsNull(IM.Qty * (2*IMT.UpdateOnHand-1), 0) ) as OnHand,
		SUM( IsNull(IM.Qty * (2*IMT.UpdateOnOrder-1), 0) ) as OnOrder,
		SUM( IsNull(IM.Qty * (2*IMT.UpdateOnRepair-1), 0) ) as OnRepair,
		SUM( IsNull(IM.Qty * (2*IMT.UpdateOnPrePurchase-1), 0) ) as OnPrePurchase,
		SUM( IsNull(IM.Qty * (2*IMT.UpdateOnPreSale-1), 0) ) as OnPreSale
	FROM
		Inserted IM
		JOIN Model M ON (IM.ModelID = M.IDModel)
		JOIN InventoryMovType IMT ON (IM.InventMovTypeID = IMT.IDInventMovType)
	WHERE
		M.IDModelParent IS NOT NULL
	GROUP BY
		IDModelParent
	) Total
	JOIN
	Model M ON (Total.IDModelParent = M.IDModel)



----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--	MODEL: Atualiza o InventoryMovTotals
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

UPDATE
	IMT
SET
	IMT.TotQty = IsNull(IMT.TotQty, 0) + Total.Qty,
	IMT.TotSale = IsNull(IMT.TotSale, 0) + Total.Sale,
	IMT.TotCost = IsNull(IMT.TotCost, 0) + Total.Cost
FROM
	(
	SELECT
		IM.StoreID,
		IM.ModelID,
		IM.InventMovTypeID,
		DatePart(yy, IM.MovDate) as [Year],
		DatePart(mm, IM.MovDate) as [Month],
		SUM( IsNull( IM.Qty, 0 ) ) as Qty,
		SUM( IsNull( IM.Qty * IM.SalePrice, 0 )  - IsNull(IM.Discount , 0) ) as Sale,
		SUM( IsNull( IM.Qty * IM.CostPrice, 0) ) as Cost
	FROM
		Inserted IM
	GROUP BY
		IM.StoreID,
		IM.ModelID,
		IM.InventMovTypeID,
		DatePart(yy, IM.MovDate),
		DatePart(mm, IM.MovDate)
	) as Total
	JOIN InventoryMovTotal IMT
		ON (	Total.StoreID = IMT.StoreID
			AND
			Total.ModelID = IMT.ModelID
			AND
			Total.InventMovTypeID = IMT.InventMovTypeID
			AND
			Total.[Year] = IMT.[Year]
			AND
			Total.[Month] = IMT.[Month] )



----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--	MASTER: Atualiza o InventoryMovTotals
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

UPDATE
	IMT
SET
	IMT.TotQty = IsNull(IMT.TotQty, 0) + Total.Qty,
	IMT.TotSale = IsNull(IMT.TotSale, 0) + Total.Sale,
	IMT.TotCost = IsNull(IMT.TotCost, 0) + Total.Cost
FROM
	(
	SELECT
		IM.StoreID,
		M.IDModelParent as ModelID,
		IM.InventMovTypeID,
		DatePart(yy, IM.MovDate) as [Year],
		DatePart(mm, IM.MovDate) as [Month],
		SUM( IsNull( IM.Qty, 0 ) ) as Qty,
		SUM( IsNull( IM.Qty * IM.SalePrice, 0 )  - IsNull(IM.Discount , 0) ) as Sale,
		SUM( IsNull( IM.Qty * IM.CostPrice, 0) ) as Cost
	FROM
		Inserted IM
		JOIN
		Model M ON (IM.ModelID = M.IDModel)
	WHERE
		M.IDModelParent IS NOT NULL
	GROUP BY
		IM.StoreID,
		M.IDModelParent,
		IM.InventMovTypeID,
		DatePart(yy, IM.MovDate),
		DatePart(mm, IM.MovDate)
	) as Total
	JOIN InventoryMovTotal IMT
		ON (	Total.StoreID = IMT.StoreID
			AND
			Total.ModelID = IMT.ModelID
			AND
			Total.InventMovTypeID = IMT.InventMovTypeID
			AND
			Total.[Year] = IMT.[Year]
			AND
			Total.[Month] = IMT.[Month] )
GO

ALTER TABLE dbo.GroupCost WITH NOCHECK ADD CONSTRAINT
	FK_InventoryMov_GroupCost_IDInventoryMov FOREIGN KEY
	(
	IDInventoryMov
	) REFERENCES dbo.InventoryMov
	(
	IDInventoryMov
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.Repair WITH NOCHECK ADD CONSTRAINT
	FK_InventoryMov_Repair_IDInvMovReturn FOREIGN KEY
	(
	IDInvMovReturn
	) REFERENCES dbo.InventoryMov
	(
	IDInventoryMov
	) NOT FOR REPLICATION

GO

ALTER TABLE dbo.Repair WITH NOCHECK ADD CONSTRAINT
	FK_InventoryMov_Repair_IDInvMovSend FOREIGN KEY
	(
	IDInvMovSend
	) REFERENCES dbo.InventoryMov
	(
	IDInventoryMov
	) NOT FOR REPLICATION
GO

ALTER TABLE dbo.InventoryMov WITH NOCHECK ADD CONSTRAINT
	FK_Repair_InventoryMov_IDRepair FOREIGN KEY
	(
	IDRepair
	) REFERENCES dbo.Repair
	(
	IDRepair
	) NOT FOR REPLICATION
GO

