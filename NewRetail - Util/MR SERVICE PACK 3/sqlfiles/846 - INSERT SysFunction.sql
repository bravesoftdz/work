INSERT INTO SysFunction (IDSysFunction, IDMenu, IDSubMenu, SysFunction)
VALUES (88, 2, 1, 'Can delete hold?')
GO

INSERT INTO SysFunctionLanguage (IDSysFunction, IDLanguage, SysFunction)
VALUES (88, 1, 'Can delete hold?')
GO

INSERT INTO SysFunctionLanguage (IDSysFunction, IDLanguage, SysFunction)
VALUES (88, 2, 'Pode cancelar pedido?')
GO

INSERT INTO SysFunctionLanguage (IDSysFunction, IDLanguage, SysFunction)
VALUES (88, 3, '¿Puede eliminar venta?')
GO

UPDATE UserTypeToSysFunction
SET Acesso = 0
WHERE IDSysFunction = 88
GO

UPDATE UserTypeToSysFunction
SET Acesso = 1
WHERE IDSysFunction = 88 AND IDUserType = 1
GO
