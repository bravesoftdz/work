INSERT INTO Param (IDParam, SrvParameter, SrvValue, SrvType, [Description], DefaultValue, Desativado, IDMenu)
VALUES (115, 'Insert Customer’s Sales Person on sale', 'False', 'Boolean', 'If this option is True, the system will insert the Sales Person who create the Customer on sale', 'False', 0, 1)
GO

INSERT INTO ParamLanguage (IDParam, IDLanguage, SrvParameter, [Description])
VALUES (115, 1, 'Insert Customer’s Sales Person on sale', 'If this option is True, the system will insert the Sales Person who create the Customer on sale.')
GO

INSERT INTO ParamLanguage (IDParam, IDLanguage, SrvParameter, [Description])
VALUES (115, 2, 'Fixar vendedor por carteira de clientes', 'Se essa opção for True, o sistema vai inserir o vendedor que criou o cliente nos itens da venda.')
GO

INSERT INTO ParamLanguage (IDParam, IDLanguage, SrvParameter, [Description])
VALUES (115, 3, 'Vendedor Repita na venda', 'Esta opción está True, el sistema insertará las Ventas Persona que crear el cliente a la venta.')
GO
