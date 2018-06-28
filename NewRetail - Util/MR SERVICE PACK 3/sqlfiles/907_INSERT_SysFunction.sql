INSERT INTO SysFunction (IDSysFunction, IDMenu, IDSubMenu, SysFunction)
VALUES (91, 1, 1, 'Inform payment condition on closing sale')
GO

INSERT INTO SysFunctionLanguage (IDSysFunction, IDLanguage, SysFunction)
VALUES (91, 1, 'Inform payment condition on closing sale')
GO

INSERT INTO SysFunctionLanguage (IDSysFunction, IDLanguage, SysFunction)
VALUES (91, 2, 'Informar condição de pagamento ao fechar a venda')
GO

INSERT INTO SysFunctionLanguage (IDSysFunction, IDLanguage, SysFunction)
VALUES (91, 3, 'Informe condición de pago sobre el cierre de la venta')
GO

UPDATE UserTypeToSysFunction
SET Acesso = 0
WHERE IDSysFunction = 91
GO
