Insert into Param (IDParam, SrvParameter, SrvValue, SrvType, Description, DefaultValue)
Values (63, 'Type of Sales screen', '1', 'Integer', 'Chooses the type of Sales Screen. 1 = POS, 2 = Office', '1')
GO

Insert into ParamLanguage (IDParam, IDLanguage, SrvParameter, Description)
Values (63, 1, 'Type of Sales screen', 'Chooses the type of Sales Screen. 1 = POS, 2 = Office')
GO

Insert into ParamLanguage (IDParam, IDLanguage, SrvParameter, Description)
Values (63, 2, 'Tipo da tela de Vendas', 'Escolhe o tipo da tela de Vendas. 1 = PDV, 2 = Escritório')
GO

Insert into ParamLanguage (IDParam, IDLanguage, SrvParameter, Description)
Values (63, 3, 'Tipo de la tela de Ventas', 'Elegir lo tipo de la tela de Ventas. 1 = POS, 2 = Oficina')
GO

Insert into Param (IDParam, SrvParameter, SrvValue, SrvType, Description, DefaultValue)
Values (64, 'Exempt sale tax', 'False', 'Boolean', 'Always exempt sale tax', 'False')
GO

Insert into ParamLanguage (IDParam, IDLanguage, SrvParameter, Description)
Values (64, 1, 'Exempt sale tax', 'Always exempt sale tax')
GO

Insert into ParamLanguage (IDParam, IDLanguage, SrvParameter, Description)
Values (64, 2, 'Isentar impostos do pedido', 'Sempre isentar impostos no pedido')
GO

Insert into ParamLanguage (IDParam, IDLanguage, SrvParameter, Description)
Values (64, 3, 'Exima impuesto sobre las ventas', 'Siempre exima impuesto sobre las ventas')
GO