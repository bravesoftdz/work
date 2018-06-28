INSERT INTO Param (IDParam, SrvParameter, SrvValue, SrvType, [Description], DefaultValue, Desativado)
VALUES (87, 'Allow progressive quantity discounts', 'False', 'Boolean', 'Enter TRUE to Apply discounts to all items that excede quantity level for price break', 'False', 0)
GO

INSERT INTO ParamLanguage (IDParam, IDLanguage, SrvParameter, [Description])
VALUES (87, 1, 'Allow progressive quantity discounts', 'Enter TRUE to Apply discounts to all items that excede quantity level for price break')
GO

INSERT INTO ParamLanguage (IDParam, IDLanguage, SrvParameter, [Description])
VALUES (87, 2, 'Permitir discontos qtd progressivas', 'Entrar TRUE para aplicar discontos as qtds que exceder o valor informado no Estoque/Promocao de quantidades')
GO

INSERT INTO ParamLanguage (IDParam, IDLanguage, SrvParameter, [Description])
VALUES (87, 3, 'Permitir descuentos de ctd progresivos', 'Entrar TRUE para aplicar descuentos a todos los artículos que nivel de la cantidad del excede para la rotura del precio')
GO
