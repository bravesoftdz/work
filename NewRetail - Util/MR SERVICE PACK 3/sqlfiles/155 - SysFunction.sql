Insert into SysFunction (IDSysFunction, IDMenu, IDSubMenu, Sysfunction) Values (50, 6, 1,'Can view others sales person commission ?')
GO
Insert Into SysFunctionLanguage (IDSysFunction, IDLanguage, SysFunction)  Values ( 50, 1, 'Can view others sales person commission ?')
GO
Insert Into SysFunctionLanguage (IDSysFunction, IDLanguage, SysFunction)  Values ( 50, 2, 'Pode ver comissão de outros vendedores ?')
GO
Insert Into SysFunctionLanguage (IDSysFunction, IDLanguage, SysFunction)  Values ( 50, 3, '¿Puede ver la comisión de de otros vendedores ?')
GO

UPDATE UserTypeToSysFunction
SET Acesso = 1
WHERE IDUSerType = 1 AND IDSysFunction = 50
GO

UPDATE	Sis_CodigoIncremental
SET UltimoCodigo = 50
WHERE Tabela = 'SysFunction.IDSysFunction'
GO

Insert into SysFunction (IDSysFunction, IDMenu, IDSubMenu, Sysfunction) Values (51, 6, 1,'Can view commission from other stores ?')
GO
Insert Into SysFunctionLanguage (IDSysFunction, IDLanguage, SysFunction)  Values ( 51, 1, 'Can view commission from other stores ?')
GO
Insert Into SysFunctionLanguage (IDSysFunction, IDLanguage, SysFunction)  Values ( 51, 2, 'Pode ver a comissão de outras lojas?')
GO
Insert Into SysFunctionLanguage (IDSysFunction, IDLanguage, SysFunction)  Values ( 51, 3, '¿Puede ver la comisión de otras tiendas?')
GO

UPDATE UserTypeToSysFunction
SET Acesso = 1
WHERE IDUSerType = 1 AND IDSysFunction = 51
GO

UPDATE	Sis_CodigoIncremental
SET UltimoCodigo = 51
WHERE Tabela = 'SysFunction.IDSysFunction'
GO
