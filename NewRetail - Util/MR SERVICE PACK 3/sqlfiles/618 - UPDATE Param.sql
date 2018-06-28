UPDATE Param
SET [Description] = 'If you choose TRUE, MainRetail will not include the taxes to calculate the markup.'
WHERE IDParam = 72
GO

UPDATE ParamLanguage
SET [Description] = 'If you choose TRUE, mark-up will override margin in inventory file.'
WHERE IDParam = 72 AND IDLanguage = 1
GO

UPDATE ParamLanguage
SET [Description] = 'Se escolher TRUE, MainRetail irá calcular o preço de venda com o Mark-up.'
WHERE IDParam = 72 AND IDLanguage = 2
GO

UPDATE ParamLanguage
SET [Description] = 'Si eliges TRUE, la marca para arriba eliminará el margen en arch de invt.'
WHERE IDParam = 72 AND IDLanguage = 3
GO
