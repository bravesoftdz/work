if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_ModelTransf]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_ModelTransf]
GO


CREATE VIEW vw_Rep_ModelTransf (IDModelTransf, Number, IDLojaOrigem, IDLojaDestino, IDUser, TransferType, Date) 
AS

SELECT 
 M.IDModelTransf,
 M.Number,
 M.IDLojaOrigem,
 M.IDLojaDestino,
 M.IDUser,
 M.TransferType,
 M.Data
FROM
 ModelTransf M

GO


DELETE FROM Rep_Field WHERE TableName = 'vw_Rep_ModelTransf' AND FieldName IN 
('Number', 'TransferType')
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
WHERE TABLE_NAME = 'vw_Rep_ModelTransf'
AND COLUMN_NAME IN ('Number', 'TransferType')
GO
