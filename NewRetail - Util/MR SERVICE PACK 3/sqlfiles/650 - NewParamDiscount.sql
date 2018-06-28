INSERT INTO Param (IDParam, SrvParameter, SrvValue, SrvType, [Description], DefaultValue, Desativado, IDMenu)
VALUES (96, 'Apply invoice discount on items', 'True', 'Boolean', 'If true, the discount on invoice will affect the items discount', 'True', 0, 1)
GO
 
INSERT INTO ParamLanguage (IDParam, IDLanguage, SrvParameter, [Description])
VALUES (96, 1, 'Apply invoice discount on items', 'If true, the discount on invoice will affect the items discount')
GO
 
INSERT INTO ParamLanguage (IDParam, IDLanguage, SrvParameter, [Description])
VALUES (96, 2, 'Aplicar desconto da nota nos ítens', 'Caso TRUE, o disconto no invoice afetará o disconto dos ítens')
GO
 
INSERT INTO ParamLanguage (IDParam, IDLanguage, SrvParameter, [Description])
VALUES (96, 3, 'Aplicar descuento de la factura en ítens', 'Si es verdad, el descuento en factura afectará el descuento de los artículos.')
GO
