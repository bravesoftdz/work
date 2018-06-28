if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vwModelHistoryMov]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vwModelHistoryMov]
GO

CREATE VIEW vwModelHistoryMov (Name, DocumentID, MovDate, Qty, SalePrice, IDInventoryMov, System, CostPrice, AvgCost, Freight, OtherCost, SystemUser, ModelID, StoreID, Notes, Store) AS

SELECT
	IMT.Name,
	IM.DocumentID,
	IM.MovDate,
	ISNull((Qty * (IMT.UpdateOnHand * 2 - 1)),0),
	CASE Qty
		WHEN 0 THEN SalePrice
		ELSE (SalePrice - (Discount / Qty))
	END,
	IM.IDInventoryMov,
	IMT.System,
	IM.CostPrice,
	IM.AvgCost,
	IM.Freight,
	IM.OtherCost,
	SU.SystemUser,
	IM.ModelID,
	IM.StoreID,
	IM.Notes,
	S.Name
FROM
	InventoryMov IM,
	InventoryMovType IMT,
	SystemUser SU,
	Store S
WHERE
	IM.InventMovTypeID = IMT.IDInventMovType
	AND IM.IDUser *= SU.IDUser
	AND IM.StoreID = S.IDStore

GO
