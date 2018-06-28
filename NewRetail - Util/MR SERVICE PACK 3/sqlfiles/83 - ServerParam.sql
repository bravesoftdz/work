Insert into Param (IDParam, SrvParameter, SrvValue, SrvType, Description, DefaultValue)
Values (48, 'Show Post-Date on Sale', 'False', 'Boolean', 'Display option for post-payment on sale', 'False')
GO

Insert into ParamLanguage (IDParam, IDLanguage, SrvParameter, Description)
Values (48, 1, 'Show Post-Date on Sale', 'Display option for post-payment on sale')
GO

Insert into ParamLanguage (IDParam, IDLanguage, SrvParameter, Description)
Values (48, 2, 'Vender pre-datado', 'Mostrar opcao de vender pre-datado')
GO

Insert into ParamLanguage (IDParam, IDLanguage, SrvParameter, Description)
Values (48, 3, 'Ventas pre-datada', 'Digite TRUE si usted no desea que el usuario tenga acceso venta pre-datada')
GO
