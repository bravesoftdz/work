INSERT INTO Param (IDParam, SrvParameter, SrvValue, SrvType, [Description], DefaultValue, Desativado, IDMenu)
VALUES (95, 'Validate case qty on hold', 'False', 'Boolean', 'Where true would mean that it will not be able to sell Cases with differents qty of their multiple', 'False', 0, 1)
GO
 
INSERT INTO ParamLanguage (IDParam, IDLanguage, SrvParameter, [Description])
VALUES (95, 1, 'Validate case qty on hold', 'If TRUE it will not be able to sell Cases with differents qty of their multiple.')
GO
 
INSERT INTO ParamLanguage (IDParam, IDLanguage, SrvParameter, [Description])
VALUES (95, 2, 'Validar embalagem na venda', 'Caso TRUE não poderá vender embalgens com qtd diferentes de múltiplos da qtd da emblagem.')
GO
 
INSERT INTO ParamLanguage (IDParam, IDLanguage, SrvParameter, [Description])
VALUES (95, 3, 'Validar el qty del caso en asimiento', 'Si es TRUE no puede vender casos con diverso qty de su múltiplo.')
GO
