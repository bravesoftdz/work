INSERT INTO Param (IDParam, SrvParameter, SrvValue, SrvType, Description, DefaultValue)
VALUES (83, 'Treat Hold as Invoice on Sale', 'False', 'Boolean', 'If this option is TRUE, the system will treat the hold as invoice in commission, graphs, etc.', 'False')
GO

INSERT INTO ParamLanguage (IDParam, IDLanguage, SrvParameter, Description)
VALUES (83, 1, 'Treat Hold as Invoice on Sale', 'If this option is TRUE, the system will treat the hold as invoice in commision, graphs, etc.')
GO

INSERT INTO ParamLanguage (IDParam, IDLanguage, SrvParameter, Description)
VALUES (83, 2, 'Tratar Pedido como Fatura na venda ', 'Se for TRUE, o sistema tratará o pedido como fatura na comissão, gráficos, etc.')
GO

INSERT INTO ParamLanguage (IDParam, IDLanguage, SrvParameter, Description)
VALUES (83, 3, 'Asimiento pedido como factura en venta', 'Si esta opción es TRUE, el sistema tratará el asimiento como factura en el commision, gráficos, el etc. ')
GO

INSERT INTO Param (IDParam, SrvParameter, SrvValue, SrvType, [Description], DefaultValue, Desativado)
VALUES (84, 'Send item for the trash', 'False', 'Boolean', 'Items are automatic sended to trash, when to zero the amount.', 'False', 0)
GO

INSERT INTO ParamLanguage (IDParam, IDLanguage, SrvParameter, [Description])
VALUES (84, 1, 'Send item for the trash', 'Items are automatic sended to trash, when to zero the amount.')
GO

INSERT INTO ParamLanguage (IDParam, IDLanguage, SrvParameter, [Description])
VALUES (84, 2, 'Enviar item para lixeira', 'Enviar item para a lixeira, quando zerar o estoque.')
GO

INSERT INTO ParamLanguage (IDParam, IDLanguage, SrvParameter, [Description])
VALUES (84, 3, 'Para enviar el item para la basura', 'Para enviar el item para la basura, cuándo poner a cero la cantidad. ')
GO
