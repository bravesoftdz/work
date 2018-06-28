UPDATE ParamLanguage
SET SrvParameter = 'Usar cálculo de markup',
Description = 'Se escolher "Yes", MainRetail irá calcular o preço de venda com o Mark-up.'
WHERE IDParam = 72 AND IDLanguage = 2
GO
