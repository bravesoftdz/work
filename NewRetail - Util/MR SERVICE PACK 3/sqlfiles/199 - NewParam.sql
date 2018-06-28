Insert into Param (IDParam, SrvParameter, SrvValue, SrvType, Description, DefaultValue)
Values (70, 'Show resumed customer info', 'False', 'Boolean', 'Enter TRUE to display resumed information in the customer file', 'False')
GO

Insert into ParamLanguage (IDParam, IDLanguage, SrvParameter, Description)
Values (70, 1, 'Show resumed customer info', 'Enter TRUE to display resumed information in the customer file')
GO

Insert into ParamLanguage (IDParam, IDLanguage, SrvParameter, Description)
Values (70, 2, 'Resumir cadastro de clientes', 'Entre TRUE para exibir informação resumida no cadastro de cliente')
GO

Insert into ParamLanguage (IDParam, IDLanguage, SrvParameter, Description)
Values (70, 3, 'Exposición reasumió de cliente', 'Entre TRUE demostrar información reasumida en el archivo de cliente')
GO
