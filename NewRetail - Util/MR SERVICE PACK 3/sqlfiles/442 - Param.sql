INSERT INTO Param (IDParam, SrvParameter, SrvValue, SrvType, Description, DefaultValue)
VALUES (82, 'Generate Hold# when opening sale.', 'False', 'Boolean', 'Set the max number of days for payments when to validade payment method in sale', 'False')
GO

INSERT INTO ParamLanguage (IDParam, IDLanguage, SrvParameter, Description)
VALUES (82, 1, 'Generate Hold# when opening sale.', 'When the screen of venda will be opened to generate the number of the order. It enters with Falsifies to incapacitate the option')
GO

INSERT INTO ParamLanguage (IDParam, IDLanguage, SrvParameter, Description)
VALUES (82, 2, 'Gerar número do pedido ao abrir a venda. ', 'Quando for aberta a tela de venda gerar o número do pedido. Entre com False para desabilitar a opção')
GO

INSERT INTO ParamLanguage (IDParam, IDLanguage, SrvParameter, Description)
VALUES (82, 3, 'Genere Asimiento al abrir venta. ', 'Cuando la pantalla del venda será abierta para generar el número de la orden. Entre False para incapacita la opción')
GO
