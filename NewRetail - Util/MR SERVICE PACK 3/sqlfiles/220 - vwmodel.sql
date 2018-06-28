if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_Model]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_Model]
GO

CREATE VIEW vw_Rep_Model (IDModel, GroupID, IDUnidade, IDFabricante, IDSize, IDColor, Model, Description, FreightCost, OtherCost, VendorCost, DateLastCost, MarkUp, SellingPrice, DateLastSellingPrice, Weight, Avaiable, LastCost, SuggRetail, VD, SX, TotQtyOnHand, SX2, LastMovDate, PVD, DP, ES, PP, VP, InicioPontoPedido, ABCClass, AutomaticRequest, TR, ModelType, CustomSalePrice, CustomCostPrice, CustomSpecialPrice, CustomPromotion, AvgCost, FinalCost, Deleted, ReplacementCost)  AS
       SELECT M.IDModel, M.GroupID, M.IDUnidade, M.IDFabricante, M.IDSize, M.IDColor, M.Model, M.Description, M.FreightCost, M.OtherCost, M.VendorCost, M.DateLastCost, M.MarkUp, M.SellingPrice, M.DateLastSellingPrice, M.Peso, M.Avaiable, M.LastCost, M.SuggRetail, M.VD, M.SX, M.TotQtyOnHand, M.SX2, M.LastMovDate, M.PVD, M.DP, M.ES, M.PP, M.VP, M.InicioPontoPedido, M.ClasseABC, M.AutomaticRequest, M.TR, M.ModelType, M.CustomSalePrice, M.CustomCostPrice, M.CustomSpecialPrice, M.CustomPromotion, M.AvgCost, M.FinalCost, M.Desativado, M.ReplacementCost
       FROM Model M
GO
