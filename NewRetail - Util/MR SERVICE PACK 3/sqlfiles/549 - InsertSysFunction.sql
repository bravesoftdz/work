INSERT INTO SysFunction (IDSysFunction, IDMenu, IDSubMenu, Sysfunction) Values (69, 1, 1,'Can create new items on Sale ?')
GO

INSERT INTO SysFunctionLanguage (IDSysFunction, IDLanguage, SysFunction)  Values ( 69, 1, 'Can create new items on Sale')
GO

INSERT INTO SysFunctionLanguage (IDSysFunction, IDLanguage, SysFunction)  Values ( 69, 2, 'Pode criar produtos novos na venda?')
GO

INSERT INTO SysFunctionLanguage (IDSysFunction, IDLanguage, SysFunction)  Values ( 69, 3, '¿Puede crear nuevos artículos en venta?')
GO

UPDATE UserTypeToSysFunction
SET Acesso = 1
WHERE IDUSerType = 1 AND IDSysFunction = 69
GO

UPDATE Sis_CodigoIncremental
SET UltimoCodigo = 69
WHERE Tabela = 'SysFunction.IDSysFunction'
GO
