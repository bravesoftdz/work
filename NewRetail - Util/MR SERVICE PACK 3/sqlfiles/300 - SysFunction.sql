Insert into SysFunction (IDSysFunction, IDMenu, IDSubMenu, Sysfunction) Values (59, 1, 1,'Can close cash register ?')
GO
Insert Into SysFunctionLanguage (IDSysFunction, IDLanguage, SysFunction)  Values ( 59, 1, 'Can close cash register ?')
GO
Insert Into SysFunctionLanguage (IDSysFunction, IDLanguage, SysFunction)  Values ( 59, 2, 'Pode fechar o caixa ?')
GO
Insert Into SysFunctionLanguage (IDSysFunction, IDLanguage, SysFunction)  Values ( 59, 3, '¿Puede cerrar caja? ')
GO

Insert into SysFunction (IDSysFunction, IDMenu, IDSubMenu, Sysfunction) Values (60, 1, 1,'Can make deposits ?')
GO
Insert Into SysFunctionLanguage (IDSysFunction, IDLanguage, SysFunction)  Values ( 60, 1, 'Can make deposits ?')
GO
Insert Into SysFunctionLanguage (IDSysFunction, IDLanguage, SysFunction)  Values ( 60, 2, 'Pode fazer sangria ?')
GO
Insert Into SysFunctionLanguage (IDSysFunction, IDLanguage, SysFunction)  Values ( 60, 3, '¿Puede hacer depósitos? ')
GO

Insert into SysFunction (IDSysFunction, IDMenu, IDSubMenu, Sysfunction) Values (61, 1, 1,'Can make petty cash ?')
GO
Insert Into SysFunctionLanguage (IDSysFunction, IDLanguage, SysFunction)  Values ( 61, 1, 'Can make petty cash ?')
GO
Insert Into SysFunctionLanguage (IDSysFunction, IDLanguage, SysFunction)  Values ( 61, 2, 'Pode fazer suprimento ?')
GO
Insert Into SysFunctionLanguage (IDSysFunction, IDLanguage, SysFunction)  Values ( 61, 3, '¿Puede hacer caja chica? ')
GO

UPDATE UserTypeToSysFunction
SET Acesso = 1
WHERE IDUserType IN (1,2,3,4) AND IDSysFunction IN (59,60, 61)
GO

UPDATE	Sis_CodigoIncremental
SET UltimoCodigo = 61
WHERE Tabela = 'SysFunction.IDSysFunction'
GO
