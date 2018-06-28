INSERT INTO Param (IDParam, SrvParameter, SrvValue, SrvType, [Description], DefaultValue, Desativado)
VALUES (89, 'Ask price when sale price is 0 on sale.', 'False', 'Boolean', 'Enter TRUE to ask price when sale price is 0 on sale.', 'False', 0)
GO

INSERT INTO ParamLanguage (IDParam, IDLanguage, SrvParameter, [Description])
VALUES (89, 1, 'Ask price when sale price is 0 on sale. ', 'Enter TRUE to ask price when sale price is 0 on sale.')
GO

INSERT INTO ParamLanguage (IDParam, IDLanguage, SrvParameter, [Description])
VALUES (89, 2, 'Pedir preço quando preço de venda é 0.', 'Entrar TRUE para pedir preço quando preço de venda é 0 na venda.')
GO

INSERT INTO ParamLanguage (IDParam, IDLanguage, SrvParameter, [Description])
VALUES (89, 3, 'Pedir precio cuando precio de venta 0. ', 'Entrar TRUE para pedir el precio cuando el precio de venta es 0 en venta.')
GO
