if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_InventoryHistory]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_InventoryHistory]
GO

CREATE VIEW vw_Rep_InventoryHistory AS
SELECT
	IM.ModelID,
	IM.StoreID,
	IM.MovDate,
	IM.CostPrice,
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
	IM.MovDate,
	IM.CostPrice

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
WHERE TABLE_NAME = 'vw_Rep_InventoryHistory'
AND COLUMN_NAME IN ('CostPrice')
GO

UPDATE Rep_Field SET DataModule = 'DM', DataSet = 'quLookUpStore', ListField = 'Name' 
Where FieldName = 'StoreID'
GO

