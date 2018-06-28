Insert into SysFunction (IDSysFunction, IDMenu, IDSubMenu, Sysfunction) Values (49, 4, 3,'Can update items ?')
GO
Insert Into SysFunctionLanguage (IDSysFunction, IDLanguage, SysFunction)  Values ( 49, 1, 'Can update items ?')
GO
Insert Into SysFunctionLanguage (IDSysFunction, IDLanguage, SysFunction)  Values ( 49, 2, 'Pode atualizat itens ?')
GO
Insert Into SysFunctionLanguage (IDSysFunction, IDLanguage, SysFunction)  Values ( 49, 3, '¿Puede actualizar modelos ?')
GO

UPDATE UserTypeToSysFunction
SET Acesso = 1
WHERE IDUSerType = 1 AND IDSysFunction = 49
GO

UPDATE	Sis_CodigoIncremental
SET UltimoCodigo = 49
WHERE Tabela = 'SysFunction.IDSysFunction'
GO
