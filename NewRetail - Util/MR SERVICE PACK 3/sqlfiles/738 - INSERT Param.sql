INSERT INTO Param (IDParam, SrvParameter, SrvValue, SrvType, [Description], DefaultValue, Desativado, IDMenu)
VALUES (101, 'Calculate commission on hold paid', 'False', 'Boolean', 'If this option is TRUE, the software will calculate commission on hold paid. Otherwise, it calculates commission including all holds.', 'False', 0, 6)
GO

INSERT INTO ParamLanguage (IDParam, IDLanguage, SrvParameter, [Description])
VALUES (101, 1, 'Calculate commission on hold paid', 'If this option is TRUE, the software will calculate commission on hold paid. Otherwise, it calculates commission including all holds.')
GO

INSERT INTO ParamLanguage (IDParam, IDLanguage, SrvParameter, [Description])
VALUES (101, 2, 'Calcular comissão sobre pedido pago', 'Se esta opção for TRUE, o sistema calculará a comissão sobre pedidos com pagamento cadastrado. Se FALSE, calculará sobre todos os pedidos.')
GO

INSERT INTO ParamLanguage (IDParam, IDLanguage, SrvParameter, [Description])
VALUES (101, 3, 'Calcular la comisión en pedido pago', 'Si esta opción es TRUE, el software calculará a comisión en pedido pago. Si FALSE, calcula a comisión incluyendo todos.')
GO
