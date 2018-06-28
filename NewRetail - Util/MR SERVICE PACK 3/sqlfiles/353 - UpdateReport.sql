UPDATE
    Rep_Field
SET 
    DataType = 'dtDouble'
WHERE
    Fieldname LIKE '%qty%'
    AND
    DataType = 'dtInteger'
GO
