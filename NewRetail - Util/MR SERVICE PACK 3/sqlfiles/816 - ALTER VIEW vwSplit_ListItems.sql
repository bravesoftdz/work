if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vwSplit_ListItems]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vwSplit_ListItems]
GO

CREATE VIEW vwSplit_ListItems AS
SELECT
	PIM.IDPreInventoryMov,
	PIM.DocumentID, 
	PIM.Marked,
	M.Model,
	M.Description,
	C.Comissionado AS SalesPerson,
	PIM.MovDate,
	PIM.Discount,
	(PIM.Qty - IsNull(PIM.QtyExchanged,0)) as Qty, 
	(PIM.SalePrice * PIM.Qty) - PIM.Discount as Total, 
	PIM.QtyRealMov,
	M.IDModel,
	IsNull(M.NotVerifyQty,0) as NotVerifyQty,
	D.Department
FROM         
	PreInventoryMov PIM (NOLOCK)
	INNER JOIN Model M (NOLOCK) ON (PIM.ModelID = M.IDModel)
	LEFT JOIN SaleItemCommission SIC (NOLOCK) ON (SIC.IDPreInventoryMov = PIM.IDPreInventoryMov )
	INNER JOIN vwComissionado C (NOLOCK) ON (SIC.IDCommission = C.IDComissionado)
	INNER JOIN Inv_Department D (NOLOCK) ON (D.IDDepartment = PIM.IDDepartment)
WHERE   
	(PIM.InventMovTypeID IN (1,25) --Sale and Canceled
	AND
	PIM.IDParentPack Is Null)


GO
