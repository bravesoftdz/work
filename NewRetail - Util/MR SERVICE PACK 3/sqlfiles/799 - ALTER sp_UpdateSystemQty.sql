if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_UpdateSystemQty]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_UpdateSystemQty]
GO

CREATE  PROCEDURE sp_UpdateSystemQty
AS

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--	Recalculo dos saldos do sistema.
-- 	Não faz parte da operação normal do sistema.        	
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--	   CLEAR DOS SALDOS 
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

UPDATE
	I 
SET
	I.QtyOnHand = 0,
	I.QtyOnOrder = 0,
	I.QtyOnPreSale = 0,
	I.QtyOnPrePurchase =0 ,
	I.QtyOnRepair = 0
FROM
	Inventory I (NOLOCK) 

UPDATE 
	IMT
SET
	IMT.TotQty = 0,
	IMT.TotCost = 0,
	IMT.TotSale = 0
FROM
	InventoryMovTotal IMT (NOLOCK) 


UPDATE
	M
SET
	M.TotQtyOnHand = 0,
	M.TotQtyOnOrder = 0,
	M.TotQtyOnPreSale = 0,
	M.TotQtyOnPrePurchase =0,
	M.TotQtyOnRepair = 0
FROM
	Model M



---###################################################################################################
-- ###### PreInventoryMov atualiza as Qty
---###################################################################################################
			
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--	   INVENTORY
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
		PreInventoryMov PIM (NOLOCK) 
		JOIN InventoryMovType IMT (NOLOCK) ON (PIM.InventMovTypeID = IMT.IDInventMovType)
	WHERE
		--PIM.InventMovTypeID = 1		AND
		PIM.ModelID IS NOT NULL		AND
		PIM.StoreID IS NOT NULL
	GROUP BY
		ModelID,
		StoreID
	) Total
	JOIN Inventory I ON (Total.ModelID = I.ModelID AND Total.StoreID = I.StoreID)


----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--	   INVENTORY MASTER
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
		PreInventoryMov PIM (NOLOCK) 
		JOIN Model M (NOLOCK) ON (PIM.ModelID = M.IDModel)
		JOIN InventoryMovType IMT (NOLOCK) ON (PIM.InventMovTypeID = IMT.IDInventMovType)
	WHERE
		M.IDModelParent IS NOT NULL

	GROUP BY
		M.IDModelParent,
		PIM.StoreID
	) Total
	JOIN Inventory I ON (Total.ModelID = I.ModelID AND Total.StoreID = I.StoreID)



----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--	MODEL TOTAL
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------


UPDATE
	M	
SET
	M.TotQtyOnHand 		= IsNull(M.TotQtyOnHand, 0) + Total.OnHand,
	M.TotQtyOnOrder		= IsNull(M.TotQtyOnOrder, 0) + Total.OnOrder,
	M.TotQtyOnRepair 	= IsNull(M.TotQtyOnRepair, 0) + Total.OnRepair,
	M.TotQtyOnPrePurchase	= IsNull(M.TotQtyOnPrePurchase, 0) + Total.OnPrePurchase,
	M.TotQtyOnPreSale	= IsNull(M.TotQtyOnPreSale, 0) + Total.OnPreSale
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
		PreInventoryMov PIM (NOLOCK) 
		JOIN InventoryMovType IMT (NOLOCK) ON (PIM.InventMovTypeID = IMT.IDInventMovType)
	GROUP BY
		ModelID
	) Total
	JOIN Model M ON (Total.ModelID = M.IDModel)

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--	MODEL MASTER TOTAL
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

UPDATE	M
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
		PreInventoryMov PIM (NOLOCK) 
		JOIN Model M (NOLOCK) ON (PIM.ModelID = M.IDModel)
		JOIN InventoryMovType IMT (NOLOCK) ON (PIM.InventMovTypeID = IMT.IDInventMovType)
	WHERE
		M.IDModelParent IS NOT NULL
	GROUP BY
		IDModelParent
	) Total
	JOIN Model M ON (Total.IDModelParent = M.IDModel)


---###################################################################################################
-- ###### Inventory atualiza as Qty
---###################################################################################################


----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--	   INVENTORY
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
		SUM( IsNull(IM.Qty * (2*IMT.UpdateOnPrePurchase-1), 0) ) + IsNull(PPI.Qty,0) as OnPrePurchase,
		SUM( IsNull(IM.Qty * (2*IMT.UpdateOnPreSale-1), 0) ) as OnPreSale
	FROM
		InventoryMov IM (NOLOCK) 
		JOIN InventoryMovType IMT (NOLOCK) ON (IM.InventMovTypeID = IMT.IDInventMovType)
		LEFT JOIN (
				SELECT 
					PPI.IDModel,
					PU.IDStore,
					SUM(Qty - IsNull(QtyRet,0)) as Qty
				FROM
					Pur_PurchaseItem PPI (NOLOCK)
					JOIN Pur_Purchase PU (NOLOCK) ON (PU.IDPurchase = PPI.IDPurchase)
				WHERE
					DateFinalReceiving IS NULL
				GROUP BY
					PPI.IDModel,
					PU.IDStore
			) PPI ON (PPI.IDModel = IM.ModelID AND PPI.IDStore = IM.StoreID)
	GROUP BY
		ModelID,
		StoreID,
		PPI.Qty
	) Total
	JOIN Inventory I ON (Total.ModelID = I.ModelID AND Total.StoreID = I.StoreID)


----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--	   INVENTORY MASTER
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
		(SUM( IsNull(IM.Qty * (2*IMT.UpdateOnPrePurchase-1), 0) ) + IsNull(PPI.Qty,0)) as OnPrePurchase,
		SUM( IsNull(IM.Qty * (2*IMT.UpdateOnPreSale-1), 0) ) as OnPreSale
	FROM
		InventoryMov IM (NOLOCK) 
		JOIN Model M (NOLOCK) ON (IM.ModelID = M.IDModel)
		JOIN InventoryMovType IMT (NOLOCK) ON (IM.InventMovTypeID = IMT.IDInventMovType)
		LEFT JOIN (
				SELECT 
					PPI.IDModel,
					PU.IDStore,
					SUM(Qty - IsNull(QtyRet,0)) as Qty
				FROM
					Pur_PurchaseItem PPI (NOLOCK)
					JOIN Pur_Purchase PU (NOLOCK) ON (PU.IDPurchase = PPI.IDPurchase)
				WHERE
					DateFinalReceiving IS NULL
				GROUP BY
					PPI.IDModel,
					PU.IDStore
			) PPI ON (PPI.IDModel = IM.ModelID AND PPI.IDStore = IM.StoreID)
	WHERE
		M.IDModelParent IS NOT NULL
	GROUP BY
		M.IDModelParent,
		StoreID,
		PPI.Qty
	) Total
	JOIN Inventory I ON (Total.ModelID = I.ModelID AND Total.StoreID = I.StoreID)



----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--	MODEL TOTAL
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------


UPDATE
	M
SET
	M.TotQtyOnHand 		= IsNull(M.TotQtyOnHand, 0) + Total.OnHand,
	M.TotQtyOnOrder		= IsNull(M.TotQtyOnOrder, 0) + Total.OnOrder,
	M.TotQtyOnRepair 	= IsNull(M.TotQtyOnRepair, 0) + Total.OnRepair,
	M.TotQtyOnPrePurchase	= IsNull(M.TotQtyOnPrePurchase, 0) + Total.OnPrePurchase,
	M.TotQtyOnPreSale	= IsNull(M.TotQtyOnPreSale, 0) + Total.OnPreSale
FROM
	(
	SELECT
		ModelID,
		SUM( IsNull(IM.Qty * (2*IMT.UpdateOnHand-1), 0) ) as OnHand,
		SUM( IsNull(IM.Qty * (2*IMT.UpdateOnOrder-1), 0) ) as OnOrder,
		SUM( IsNull(IM.Qty * (2*IMT.UpdateOnRepair-1), 0) ) as OnRepair,
		SUM( IsNull(IM.Qty * (2*IMT.UpdateOnPrePurchase-1), 0) ) + IsNull(PPI.Qty, 0) as OnPrePurchase,
		SUM( IsNull(IM.Qty * (2*IMT.UpdateOnPreSale-1), 0) ) as OnPreSale
	FROM
		InventoryMov IM (NOLOCK) 
		JOIN InventoryMovType IMT (NOLOCK)  ON (IM.InventMovTypeID = IMT.IDInventMovType)
		LEFT JOIN (
				SELECT 
					PPI.IDModel,
					SUM(Qty - IsNull(QtyRet,0)) as Qty
				FROM
					Pur_PurchaseItem PPI (NOLOCK)
					JOIN Pur_Purchase PU (NOLOCK) ON (PU.IDPurchase = PPI.IDPurchase)
				WHERE
					DateFinalReceiving IS NULL
				GROUP BY
					PPI.IDModel,
					PU.IDStore
			) PPI ON (PPI.IDModel = IM.ModelID)
	GROUP BY
		ModelID,
		PPI.Qty
	) Total
	JOIN Model M ON (Total.ModelID = M.IDModel)



----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--	MODEL MASTER TOTAL
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
UPDATE
	M
SET
	M.TotQtyOnHand 		= IsNull(M.TotQtyOnHand, 0) + Total.OnHand,
	M.TotQtyOnOrder		= IsNull(M.TotQtyOnOrder, 0) + Total.OnOrder,
	M.TotQtyOnRepair 	= IsNull(M.TotQtyOnRepair, 0) + Total.OnRepair,
	M.TotQtyOnPrePurchase	= IsNull(M.TotQtyOnPrePurchase, 0) + Total.OnPrePurchase,
	M.TotQtyOnPreSale	= IsNull(M.TotQtyOnPreSale, 0) + Total.OnPreSale
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
		InventoryMov IM (NOLOCK) 
		JOIN Model M (NOLOCK) ON (IM.ModelID = M.IDModel)
		JOIN InventoryMovType IMT (NOLOCK) ON (IM.InventMovTypeID = IMT.IDInventMovType)

	WHERE
		M.IDModelParent IS NOT NULL

	GROUP BY
		IDModelParent
	) Total
	JOIN Model M ON (Total.IDModelParent = M.IDModel)

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
		InventoryMov IM (NOLOCK) 
	GROUP BY
		IM.StoreID,
		IM.ModelID,
		IM.InventMovTypeID,
		DatePart(yy, IM.MovDate),
		DatePart(mm, IM.MovDate)
	) as Total
	JOIN InventoryMovTotal IMT  (NOLOCK) 
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
		InventoryMov IM (NOLOCK) 
		JOIN Model M (NOLOCK) ON (IM.ModelID = M.IDModel)
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
