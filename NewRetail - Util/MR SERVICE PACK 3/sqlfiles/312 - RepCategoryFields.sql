if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_Category]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_Category]
GO

CREATE VIEW vw_Rep_Category  AS

SELECT 
	T.IDGroup as IDCategory, 
	T.Name as Category, 
	T.Taxable, 
	T.PrcPartDiscount, 
	T.Path, 
	T.PathName, 
	T.SerialNumber, 
	T.SizeAndColor,
	T.PackModel,
	T.Service,
	T.Credit,
	T.DesiredMarkup,
	T.UserCode,
	T.PuppyTracker,
	T.RequestCustomer
FROM 
	TabGroup T
GO

DELETE FROM Rep_Field WHERE TableName = 'vw_Rep_Category' AND FieldName IN 
('PackModel', 'Service', 'Credit', 'DesiredMarkup',
'UserCode','PuppyTracker','RequestCustomer')
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
WHERE TABLE_NAME = 'vw_Rep_Category'
AND COLUMN_NAME IN ('PackModel', 'Service', 'Credit', 'DesiredMarkup',
'UserCode','PuppyTracker','RequestCustomer')
GO
