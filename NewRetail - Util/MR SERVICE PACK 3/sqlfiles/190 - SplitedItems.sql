if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vwSplit_ListItems]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vwSplit_ListItems]
GO

CREATE VIEW dbo.vwSplit_ListItems
AS
SELECT     dbo.PreInventoryMov.IDPreInventoryMov, dbo.PreInventoryMov.DocumentID, dbo.PreInventoryMov.Marked, dbo.Model.Model, dbo.Model.Description, 
                      Comission.Comissionado AS SalesPerson, dbo.PreInventoryMov.MovDate, dbo.PreInventoryMov.Discount, 
		(dbo.PreInventoryMov.Qty - IsNull(dbo.PreInventoryMov.QtyExchanged,0)) as Qty, 
                      (dbo.PreInventoryMov.SalePrice - dbo.PreInventoryMov.Discount) * dbo.PreInventoryMov.Qty AS Total, dbo.PreInventoryMov.QtyRealMov,
		dbo.Model.IDModel, IsNull(dbo.Model.NotVerifyQty,0) as NotVerifyQty
FROM         dbo.PreInventoryMov INNER JOIN
                      dbo.Model ON dbo.PreInventoryMov.ModelID = dbo.Model.IDModel INNER JOIN
                      dbo.vwComissionado Comission ON dbo.PreInventoryMov.ComissionID = Comission.IDComissionado
WHERE     (dbo.PreInventoryMov.InventMovTypeID IN (1,25) --Sale and Canceled
		AND dbo.PreInventoryMov.IDParentPack Is Null)

GO