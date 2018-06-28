INSERT INTO Param (IDParam, SrvParameter, SrvValue, SrvType, [Description], DefaultValue, Desativado, IDMenu)
VALUES (94, 'Limit layaway edits to month created', 'False', 'Boolean', 'Where true would mean that a layaway could not be edited after the end of the month it was created in', 'False', 0, 1)
GO
 
INSERT INTO ParamLanguage (IDParam, IDLanguage, SrvParameter, [Description])
VALUES (94, 1, 'Limit layaway edits to month created', 'If TRUE a layaway could not be edited after the end of the month it was created in.')
GO
 
INSERT INTO ParamLanguage (IDParam, IDLanguage, SrvParameter, [Description])
VALUES (94, 2, 'Não Editar crediário quando virar o mês', 'Caso TRUE não poderá editar o crediário quando virar o mês.')
GO
 
INSERT INTO ParamLanguage (IDParam, IDLanguage, SrvParameter, [Description])
VALUES (94, 3, 'Layaway del límite corrige al mes creado', 'Si TRUE un layaway no podría ser corregido después de que el final del mes que fue creado adentro')
GO
