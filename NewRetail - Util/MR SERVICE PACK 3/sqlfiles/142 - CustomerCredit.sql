Insert into SysFunction (IDSysFunction, IDMenu, IDSubMenu, Sysfunction) Values (48, 2, 6,'Can update Customer Credit ?')
GO
Insert Into SysFunctionLanguage (IDSysFunction, IDLanguage, SysFunction)  Values ( 48, 1, 'Can update Customer Credit ?')
GO
Insert Into SysFunctionLanguage (IDSysFunction, IDLanguage, SysFunction)  Values ( 48, 2, 'Pode atualizar Crédito do Cliente? ')
GO
Insert Into SysFunctionLanguage (IDSysFunction, IDLanguage, SysFunction)  Values ( 48, 3, '¿Puede actualizar el Crédito de Cliente? ')
GO

UPDATE UserTypeToSysFunction
SET Acesso = 1
WHERE IDUSerType = 1 AND IDSysFunction = 48
GO

UPDATE	Sis_CodigoIncremental
SET UltimoCodigo = 48
WHERE Tabela = 'SysFunction.IDSysFunction'
GO
