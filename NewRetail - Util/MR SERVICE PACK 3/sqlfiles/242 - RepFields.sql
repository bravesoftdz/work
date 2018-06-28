INSERT INTO Rep_table (TableName, TableAlias) VALUES ('vw_Rep_CashRegisterFlow','vw_Rep_CashRegisterFlow')
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
WHERE TABLE_NAME = 'vw_Rep_CashRegisterFlow'
GO