INSERT INTO Param (IDParam, SrvParameter, SrvValue, SrvType, [Description], DefaultValue, Desativado)
VALUES (86, 'Default expiration length for gift cards', '-1', 'Integer', 'The default number of months until gift cards expire (-1 for no expiration)', '-1', 0)
GO

INSERT INTO ParamLanguage (IDParam, IDLanguage, SrvParameter, [Description])
VALUES (86, 1, 'Default expiration length for gift cards', 'The default number of months until gift cards expire (-1 for no expiration)')
GO

INSERT INTO ParamLanguage (IDParam, IDLanguage, SrvParameter, [Description])
VALUES (86, 2, 'Data de expiração para vale presente', 'O número de meses que o vale presente irá expirar (-1 para nenhuma expiração)')
GO

INSERT INTO ParamLanguage (IDParam, IDLanguage, SrvParameter, [Description])
VALUES (86, 3, 'Expiración del tarjetas del regalo', 'El número del defecto de meses hasta tarjetas del regalo expira (- 1 para ninguna expiración)')
GO
