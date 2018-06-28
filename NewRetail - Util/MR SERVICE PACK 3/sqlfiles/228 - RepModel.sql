if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_Model]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_Model]
GO

CREATE VIEW vw_Rep_Model AS
SELECT 
	M.IDModel, 
	M.GroupID, 
	M.IDUnidade, 
	M.IDFabricante, 
	M.IDSize, 
	M.IDColor, 
	M.Model, 
	M.Description, 
	M.FreightCost, 
	M.OtherCost, 
	M.VendorCost, 
	M.DateLastCost, 
	M.MarkUp, 
	M.SellingPrice, 
	M.DateLastSellingPrice, 
	M.Peso as Weight, 
	M.Avaiable, 
	M.LastCost, 
	M.SuggRetail, 
	M.VD, 
	M.SX, 
	M.TotQtyOnHand, 
	M.SX2, 
	M.LastMovDate, 
	M.PVD, 
	M.DP, 
	M.ES, 
	M.PP, 
	M.VP, 
	M.InicioPontoPedido, 
	M.ClasseABC, 
	M.AutomaticRequest, 
	M.TR, 
	M.ModelType, 
	M.CustomSalePrice, 
	M.CustomCostPrice, 
	M.CustomSpecialPrice, 
	M.CustomPromotion, 
	M.AvgCost, 
	M.FinalCost, 
	M.Desativado as Deleted, 
	M.ReplacementCost,
	M.LargeImage, 
	M.FloatPercent, 
	M.LargeImage2, 
	M.NotVerifyQty
FROM 
	Model M
GO

INSERT INTO Rep_Field (
        tablename,
        fieldname,
        fieldalias,
        datatype,
        selectable,
        searchable,
        sortable,
        autosearch,
        mandatory)
SELECT
        TABLE_NAME,
        COLUMN_NAME AS fieldname,
        COLUMN_NAME AS fieldalias,
        CASE data_type
                WHEN 'INT' THEN 'dtInteger'
                WHEN 'DateTime' THEN 'dtDateTime'
                WHEN 'TBit' THEN 'dtBoolean'
                WHEN 'TControlField' THEN 'dtBoolean'
                WHEN 'Bit' THEN 'dtBoolean'
                WHEN 'Money' THEN 'dtCurrency'
                WHEN 'TValor' THEN 'dtCurrency'
                WHEN 'TValorNull' THEN 'dtCurrency'
                ELSE  'dtString' END AS data_type,
        'T' AS selectable,
        'T' AS searchable,
        'T' AS sortable,
        'T' AS autosearch,
        'T' AS mandatory
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'vw_Rep_Model'
AND COLUMN_NAME IN ('ReplacementCost','LargeImage','FloatPercent','LargeImage2','NotVerifyQty')
GO
