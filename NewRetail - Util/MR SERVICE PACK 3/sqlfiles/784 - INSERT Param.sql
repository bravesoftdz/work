INSERT INTO Param (IDParam, SrvParameter, SrvValue, SrvType, [Description], DefaultValue, Desativado, IDMenu)
VALUES (104, 'Invoice Tab - show complement', 'False', 'Boolean', 'Type True to displat tab complement on invoice', 'False', 0, 1)
GO

INSERT INTO ParamLanguage (IDParam, IDLanguage, SrvParameter, [Description])
VALUES (104, 1, 'Invoice Tab - show complement', 'Type True to displat tab complement on invoice.')
GO

INSERT INTO ParamLanguage (IDParam, IDLanguage, SrvParameter, [Description])
VALUES (104, 2, 'Mostrar Tabulador Nota - Complemento', 'Exibir o tabulador complemento na nota.')
GO

INSERT INTO ParamLanguage (IDParam, IDLanguage, SrvParameter, [Description])
VALUES (104, 3, 'La factura - muestra complemiento', 'Escriba True para mostrar complemiento en la factura.')
GO
