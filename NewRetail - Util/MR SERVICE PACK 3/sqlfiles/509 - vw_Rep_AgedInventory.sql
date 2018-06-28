if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_AgedInventory]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_AgedInventory]
GO

CREATE VIEW vw_Rep_AgedInventory
AS
/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO
		- View criada para ser utilizada no relatório Aged Inventory by Date

	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
 	08 Jan 2004		Marcello Felipelli	Criação;
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */
SELECT
	I.IDModel,
	M.Model,
	M.Description,
	(CASE WHEN I.QtyOnHand > 0 THEN (I.QtyOnHand * M.SellingPrice) ELSE 0 END) AS ExtOurPrice,
	M.SellingPrice,
	M.FreightCost,
	M.OtherCost,
	(CASE WHEN I.QtyOnHand > 0 THEN (I.QtyOnHand * M.VendorCost) ELSE 0 END) AS ExtVendorCost,
	M.VendorCost,
	M.DateLastCost,
	M.MarkUp,
	M.DateLastSellingPrice as LastSoldDate,
	M.LastCost,
	(CASE WHEN I.QtyOnHand > 0 THEN (I.QtyOnHand * M.SuggRetail) ELSE 0 END) AS ExtSuggRetail,
	M.SuggRetail,
	M.LastMovDate,
	M.AvgCost,
	(CASE WHEN I.QtyOnHand > 0 THEN (I.QtyOnHand * M.FinalCost) ELSE 0 END) AS ExtFinalCost,
	M.FinalCost,
	CASE WHEN M.SellingPrice > 0 THEN M.SellingPrice - M.FinalCost END as RealMarkUpValue,
	CASE WHEN M.SellingPrice > 0 AND M.FinalCost <> 0 THEN ROUND(( (M.SellingPrice-M.FinalCost)/M.FinalCost * 100),2) END as RealMarkUpPercent,
	TG.Category,
	TG.IDCategory,
	(CASE WHEN I.QtyOnHand > 0 THEN IsNull(I.QtyOnHand,0) ELSE 0 END) as PostiveQtyOnHand,
	IsNull(F.FullName,'Not Defined') as Manufacture,
	DATEDIFF(day, M.DateLastCost, getdate()) as Days,
	I.QtyOnHand,
	I.QtyOnPreSale,
	I.QtyOnOrder,
	I.QtyOnRepair,
	I.QtyInReceiving
FROM
	vw_Rep_Model M
	JOIN vw_Rep_Category TG ON (M.GroupID = TG.IDCategory)
	LEFT OUTER JOIN 
		(
		SELECT
			I.IDModel,
			SUM(IsNull(I.QtyOnHand,0)) as QtyOnHand,
			SUM(IsNull(I.QtyOnPreSale,0)) as QtyOnPreSale,
			SUM(IsNull(I.QtyOnOrder,0)) as QtyOnOrder,
			SUM(IsNull(I.QtyOnRepair,0)) as QtyOnRepair,
			SUM(IsNull(I.QtyOnPrePurchase,0)) as QtyInReceiving
		FROM			
			vw_Rep_Inventory I
		GROUP BY
			I.IDModel
		) I ON (M.IDModel = I.IDModel)
	LEFT OUTER JOIN vw_Rep_Entity F ON ( M.IDFabricante = F.IDPerson AND F.IDPersonType = 7 )
WHERE 
	M.Deleted = 0

GO
