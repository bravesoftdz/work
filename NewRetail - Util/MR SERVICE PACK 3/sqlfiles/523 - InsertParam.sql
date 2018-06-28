INSERT INTO Param (IDParam, SrvParameter, SrvValue, SrvType, [Description], DefaultValue, Desativado)
VALUES (88, 'Use Catalog', 'False', 'Boolean', 'Enter TRUE to Search in Catalog when the product is not found', 'False', 0)
GO

INSERT INTO ParamLanguage (IDParam, IDLanguage, SrvParameter, [Description])
VALUES (88, 1, 'Use Catalog', 'Enter TRUE to Search in Catalog when the product is not found')
GO

INSERT INTO ParamLanguage (IDParam, IDLanguage, SrvParameter, [Description])
VALUES (88, 2, 'Utilizar Catálogo', 'Entrar TRUE para procurar no Catálogo quando o produto não for encontrado')
GO

INSERT INTO ParamLanguage (IDParam, IDLanguage, SrvParameter, [Description])
VALUES (88, 3, 'Utilizar el Catálogo', 'Entrar TRUE para buscar en el catálogo cuando el modelo no fue encontrado')
GO
