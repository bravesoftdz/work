DELETE Rep_Table
where TableName = 'SubGroup'
GO

DELETE Rep_Field
where TableName = 'SubGroup'
GO

DELETE Rep_Field
where FieldName = 'IDSubGroup'
GO

DELETE FROM Rep_Field WHERE TableName = 'vw_Rep_Model' AND FieldName IN 
('IDModelGroup', 'IDModelSubGroup')
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
AND COLUMN_NAME IN ('IDModelGroup', 'IDModelSubGroup')
GO

EXEC sp_Rep_AddTableField 'ModelGroup'
GO

EXEC sp_Rep_AddTableField 'ModelSubGroup'
GO

UPDATE Rep_Field SET DataModule = 'DM', DataSet = 'quLookUpModelGroup', ListField = 'ModelGroup'
where FieldName = 'IDModelGroup' OR FieldName = 'ModelGroup'
GO

UPDATE Rep_Field SET DataModule = 'DM', DataSet = 'quLookUpModelSubGroup', ListField = 'ModelSubGroup'
where FieldName = 'IDModelSubGroup' OR FieldName = 'ModelSubGroup'
GO
