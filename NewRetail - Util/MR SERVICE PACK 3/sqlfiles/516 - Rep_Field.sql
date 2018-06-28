INSERT INTO Rep_Field (TableName, FieldName, FieldAlias, DataType, SelecTable, Searchable, Sortable, Autosearch, Mandatory)
(SELECT
	TABLE_NAME,
	COLUMN_NAME AS fieldname,
	COLUMN_NAME AS fieldalias,
	CASE data_type
		WHEN 'INT' THEN 'dtInteger'
		WHEN 'DateTime' THEN 'dtDateTime'
		WHEN 'smalldatetime' THEN 'dtDateTime'
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
FROM
	INFORMATION_SCHEMA.COLUMNS C
WHERE
	C.TABLE_NAME = 'vw_Rep_Records_Resum'
	AND C.COLUMN_NAME not IN (SELECT fieldname FROM Rep_Field WHERE tablename = C.TABLE_NAME))
GO

INSERT INTO Rep_Table (TableName, TableAlias)
VALUES ('vw_Rep_Records_Resum','vw_Rep_Records_Resum')
GO
