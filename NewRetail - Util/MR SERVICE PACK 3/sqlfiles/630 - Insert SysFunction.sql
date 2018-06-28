INSERT INTO SysFunction (IDSysFunction, IDMenu, IDSubMenu, Sysfunction) Values (70, 5, 9,'Can see the cost price ?')
GO

INSERT INTO SysFunctionLanguage (IDSysFunction, IDLanguage, SysFunction)  Values (70, 1, 'Can see the cost price ?')
GO

INSERT INTO SysFunctionLanguage (IDSysFunction, IDLanguage, SysFunction)  Values (70, 2, 'Pode ver o preço de custo ?')
GO

INSERT INTO SysFunctionLanguage (IDSysFunction, IDLanguage, SysFunction)  Values (70, 3, '¿Puede ver el precio de costo ?')
GO

UPDATE UserTypeToSysFunction
SET Acesso = 1
WHERE IDUSerType = 1 AND IDSysFunction = 70
GO

UPDATE Sis_CodigoIncremental
SET UltimoCodigo = 70
WHERE Tabela = 'SysFunction.IDSysFunction'
GO

UPDATE SysFunctionLanguage SET SysFunction = 'Pode deletar ítens na transferência ?'
WHERE IDSysFunction = 67 AND IDLanguage = 2
GO

UPDATE SysFunctionLanguage SET SysFunction = 'Pode modificar ítens na transferência ?'
WHERE IDSysFunction = 68 AND IDLanguage = 2
GO

UPDATE SysFunction SET SysFunction = 'Can delete items on transfer ?'
WHERE IDSysFunction = 67
GO

UPDATE SysFunction SET SysFunction = 'Can modify items on transfer ?'
WHERE IDSysFunction = 68
GO

UPDATE SysFunctionLanguage SET SysFunction = 'Can delete items on transfer ?'
WHERE IDSysFunction = 67 AND IDLanguage = 1
GO

UPDATE SysFunctionLanguage SET SysFunction = 'Can modify items on transfer ?'
WHERE IDSysFunction = 68 AND IDLanguage = 1
GO
