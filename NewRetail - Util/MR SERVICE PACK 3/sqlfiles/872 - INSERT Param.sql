INSERT INTO Param (IDParam, SrvParameter, SrvValue, SrvType, [Description], DefaultValue, Desativado, IDMenu)
VALUES (113, 'Return without receipt = Store Credit', 'True', 'Boolean', 'If this option is TRUE, Return without receipt requires Store credit payment only', 'True', 0, 1)
GO

INSERT INTO ParamLanguage (IDParam, IDLanguage, SrvParameter, [Description])
VALUES (113, 1, 'Return without receipt = Store Credit', 'If this option is set to True then returns without a receipt can only be issued by store credit.')
GO

INSERT INTO ParamLanguage (IDParam, IDLanguage, SrvParameter, [Description])
VALUES (113, 2, 'Devolução sem recibo = Crédito loja', 'Sef or TRUE, Devolução sem recibo deve ser concluído com pagamento do crédito da loja!')
GO

INSERT INTO ParamLanguage (IDParam, IDLanguage, SrvParameter, [Description])
VALUES (113, 3, 'Volver sin recibir = crédito tienda', 'Si esta opción se establece en True devuelve sin un recibo sólo puede ser expedido por crédito en la tienda.')
GO
