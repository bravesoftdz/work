INSERT INTO SysFunction (IDSysFunction, IDMenu, IDSubMenu, Sysfunction) Values (66, 1, 1,'Can delete items on Invoice ?')
GO

INSERT INTO SysFunctionLanguage (IDSysFunction, IDLanguage, SysFunction)  Values ( 66, 1, 'Can delete items on Invoice ?')
GO

INSERT INTO SysFunctionLanguage (IDSysFunction, IDLanguage, SysFunction)  Values ( 66, 2, 'Pode deletar ítens na Nota?')
GO

INSERT INTO SysFunctionLanguage (IDSysFunction, IDLanguage, SysFunction)  Values ( 66, 3, '¿Puede Eliminar Items en Boletas? ')
GO

UPDATE UserTypeToSysFunction
SET Acesso = 1
WHERE IDUSerType = 1 AND IDSysFunction = 66
GO

UPDATE Sis_CodigoIncremental
SET UltimoCodigo = 66
WHERE Tabela = 'SysFunction.IDSysFunction'
GO
