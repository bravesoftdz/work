Insert into SysFunction (IDSysFunction, IDMenu, IDSubMenu, Sysfunction) Values (62, 1, 2,'Can view other cash register ?')
GO
Insert Into SysFunctionLanguage (IDSysFunction, IDLanguage, SysFunction)  Values ( 62, 1, 'Can view other cash register ?')
GO
Insert Into SysFunctionLanguage (IDSysFunction, IDLanguage, SysFunction)  Values ( 62, 2, 'Pode visualizar outros caixas? ')
GO
Insert Into SysFunctionLanguage (IDSysFunction, IDLanguage, SysFunction)  Values ( 62, 3, '¿Puede Ve otro caja? ')
GO

UPDATE UserTypeToSysFunction
SET Acesso = 1
WHERE IDUserType = 1 AND IDSysFunction = 62
GO

UPDATE	Sis_CodigoIncremental
SET UltimoCodigo = 62
WHERE Tabela = 'SysFunction.IDSysFunction'
GO
