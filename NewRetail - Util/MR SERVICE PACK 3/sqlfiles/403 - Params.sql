Insert into Param (IDParam, SrvParameter, SrvValue, SrvType, Description, DefaultValue)
Values (77, 'Remove Barcode Check Digit', '0', 'Integer', 'Remove the barcode digits when scan. 1 = First Digit, 2 = Last Digit, and 3 = First and Last Digit', '0')
GO

Insert into ParamLanguage (IDParam, IDLanguage, SrvParameter, Description)
Values (77, 1, 'Remove Barcode Check Digit', 'Remove the barcode digits when scan. 1 = First Digit, 2 = Last Digit, and 3 = First and Last Digit')
GO

Insert into ParamLanguage (IDParam, IDLanguage, SrvParameter, Description)
Values (77, 2, 'Remover Dígito do Cód. Barras', 'Retirar os dígitos do Cód. Barras. 1 = primeiro, 2 = último, e 3 = primeiro e último digito')
GO

Insert into ParamLanguage (IDParam, IDLanguage, SrvParameter, Description)
Values (77, 3, 'Quite el Dígito de Cod. Barras', 'Quite los dígitos de barcode cuando escudriña. 1 = Primero Dígito, 2 = Dura el Dígito, y 3 = Primero y Dura el Dígito')
GO

Insert into Param (IDParam, SrvParameter, SrvValue, SrvType, Description, DefaultValue)
Values (78, 'Search Model after scan Barcode', 'False', 'Boolean', 'Search for model number if the barcode is not found in search', 'False')
GO

Insert into ParamLanguage (IDParam, IDLanguage, SrvParameter, Description)
Values (78, 1, 'Search Model after scan Barcode', 'Search for model number if the barcode is not found in search')
GO

Insert into ParamLanguage (IDParam, IDLanguage, SrvParameter, Description)
Values (78, 2, 'Remover Dígito do Cód. Barras', 'Procurar modelo se o Cód. Barras não for encontrado na procura')
GO

Insert into ParamLanguage (IDParam, IDLanguage, SrvParameter, Description)
Values (78, 3, 'Busque el Modelo después del Cod. Barras', 'Busque para el número modelo si el Cod. Barras no se encuentra en la búsqueda')
GO
