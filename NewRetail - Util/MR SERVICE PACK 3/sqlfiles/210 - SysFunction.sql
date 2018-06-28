Insert into SysFunction (IDSysFunction, IDMenu, IDSubMenu, Sysfunction) Values (57, 1, 1,'Can join hold ?')
GO
Insert Into SysFunctionLanguage (IDSysFunction, IDLanguage, SysFunction)  Values ( 57, 1, 'Can display qty Info "Yes/No" ?')
GO
Insert Into SysFunctionLanguage (IDSysFunction, IDLanguage, SysFunction)  Values ( 57, 2, 'Pode juntar pedidos ?')
GO
Insert Into SysFunctionLanguage (IDSysFunction, IDLanguage, SysFunction)  Values ( 57, 3, '¿Puede unir el boleta? ')
GO

UPDATE UserTypeToSysFunction
SET Acesso = 1
WHERE IDUSerType = 1 AND IDSysFunction = 57
GO

UPDATE	Sis_CodigoIncremental
SET UltimoCodigo = 57
WHERE Tabela = 'SysFunction.IDSysFunction'
GO
