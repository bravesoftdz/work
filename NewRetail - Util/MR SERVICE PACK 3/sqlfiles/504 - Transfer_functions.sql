INSERT INTO SysFunction (IDSysFunction, IDMenu, IDSubMenu, Sysfunction) Values (67, 5, 9,'Can delete items on tranfer ?')
GO

INSERT INTO SysFunctionLanguage (IDSysFunction, IDLanguage, SysFunction)  Values ( 67, 1, 'Can delete items on tranfer ?')
GO

INSERT INTO SysFunctionLanguage (IDSysFunction, IDLanguage, SysFunction)  Values ( 67, 2, 'Pode deletar ítens na tranferência?')
GO

INSERT INTO SysFunctionLanguage (IDSysFunction, IDLanguage, SysFunction)  Values ( 67, 3, '¿Puede Eliminar Items en tranfer? ')
GO

UPDATE UserTypeToSysFunction
SET Acesso = 1
WHERE IDUSerType = 1 AND IDSysFunction = 67
GO

UPDATE Sis_CodigoIncremental
SET UltimoCodigo = 67
WHERE Tabela = 'SysFunction.IDSysFunction'
GO

INSERT INTO SysFunction (IDSysFunction, IDMenu, IDSubMenu, Sysfunction) Values (68, 5, 9,'Can modify items on tranfer ?')
GO

INSERT INTO SysFunctionLanguage (IDSysFunction, IDLanguage, SysFunction)  Values ( 68, 1, 'Can modify items on tranfer ?')
GO

INSERT INTO SysFunctionLanguage (IDSysFunction, IDLanguage, SysFunction)  Values ( 68, 2, 'Pode modificar ítens na tranferência?')
GO

INSERT INTO SysFunctionLanguage (IDSysFunction, IDLanguage, SysFunction)  Values ( 68, 3, '¿Puede modificarte  Items en tranfer? ')
GO

UPDATE UserTypeToSysFunction
SET Acesso = 1
WHERE IDUSerType = 1 AND IDSysFunction = 68
GO

UPDATE Sis_CodigoIncremental
SET UltimoCodigo = 68
WHERE Tabela = 'SysFunction.IDSysFunction'
GO
