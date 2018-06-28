if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_EntityType]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_EntityType]
GO


CREATE VIEW vw_Rep_EntityType (IDPersonType,Path,PersonType,PathName,PayDayDefault,CommissionOnProfit,Deleted,LastCode)
AS

SELECT
 T.IDTipoPessoa,
 T.Path,
 T.TipoPessoa,
 T.PathName,
 T.DefaultDiaPag,
 T.ComissionOnProfit,
 T.Desativado,
 T.LastCode
FROM
 TipoPessoa T

GO



DELETE FROM Rep_Field WHERE TableName = 'vw_Rep_EntityType' and FieldName IN 
('Deleted')
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
WHERE TABLE_NAME = 'vw_Rep_EntityType'
AND COLUMN_NAME IN ('Deleted')
GO
