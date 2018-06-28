INSERT INTO Param (IDParam, SrvParameter, SrvValue, SrvType, Description, DefaultValue)
VALUES (81, 'Prompt commissioner for each sale', 'False', 'Boolean', 'When initiating new sale, the user will have to inform the commissioner.', 'False')
GO

INSERT INTO ParamLanguage (IDParam, IDLanguage, SrvParameter, Description)
VALUES (81, 1, 'Prompt commissioner for each sale', 'When initiating new sale, the user will have to inform the commissioner.')
GO

INSERT INTO ParamLanguage (IDParam, IDLanguage, SrvParameter, Description)
VALUES (81, 2, 'Pedir comissionado para cada venda', 'Ao iniciar uma nova venda, o usuário deverá informar o comissionado.')
GO

INSERT INTO ParamLanguage (IDParam, IDLanguage, SrvParameter, Description)
VALUES (81, 3, 'Pedir en cada venta', 'Al iniciar nueva venta, el usuario tendrá que informar a la comisión .')
GO
