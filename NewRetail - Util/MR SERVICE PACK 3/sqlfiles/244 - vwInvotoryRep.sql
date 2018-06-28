if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_InventoryHistory]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_InventoryHistory]
GO

CREATE VIEW vw_Rep_InventoryHistory AS
SELECT
	IM.ModelID,
	IM.StoreID,
	IM.MovDate,
	SUM( IsNull(IM.Qty * (2*IMT.UpdateOnHand-1), 0) ) as OnHand,
	SUM( IsNull(IM.Qty * (2*IMT.UpdateOnOrder-1), 0) ) as OnOrder,
	SUM( IsNull(IM.Qty * (2*IMT.UpdateOnRepair-1), 0) ) as OnRepair,
	SUM( IsNull(IM.Qty * (2*IMT.UpdateOnPrePurchase-1), 0) ) as OnPrePurchase,
	SUM( IsNull(IM.Qty * (2*IMT.UpdateOnPreSale-1), 0) ) as OnPreSale
FROM
	InventoryMov IM
	JOIN
	InventoryMovType IMT ON (IM.InventMovTypeID = IMT.IDInventMovType)
GROUP BY
	ModelID,
	StoreID,
	IM.MovDate
GO

EXEC sp_Rep_AddTableField 'vw_Rep_InventoryHistory'
GO
