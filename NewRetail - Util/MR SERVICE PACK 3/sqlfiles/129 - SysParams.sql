Insert into Param (IDParam, SrvParameter, SrvValue, SrvType, Description, DefaultValue)
Values (65, 'Display floating qty stock', 'False', 'Boolean', 'Display floating qty on stock for each store', 'False')
GO

Insert into ParamLanguage (IDParam, IDLanguage, SrvParameter, Description)
Values (65, 1, 'Display floating qty stock', 'Display floating qty on stock for each store')
GO

Insert into ParamLanguage (IDParam, IDLanguage, SrvParameter, Description)
Values (65, 2, 'Estoque flutuante', 'Trabalhar com estoque flutuante')
GO

Insert into ParamLanguage (IDParam, IDLanguage, SrvParameter, Description)
Values (65, 3, 'Demuestre flotando inventario', 'Demuestre flotando inventario para cada tienda')
GO

Insert into SysFunction (IDSysFunction, IDMenu, IDSubMenu, Sysfunction) Values (45, 1, 1,'Can display qty OnHand ?')
GO
Insert Into SysFunctionLanguage (IDSysFunction, IDLanguage, SysFunction)  Values ( 45, 1, 'Can display qty OnHand ?')
GO
Insert Into SysFunctionLanguage (IDSysFunction, IDLanguage, SysFunction)  Values ( 45, 2, 'Pode visualizar qtd em Estoque ?')
GO
Insert Into SysFunctionLanguage (IDSysFunction, IDLanguage, SysFunction)  Values ( 45, 3, '¿Puede demostrar la ctd existente?')
GO

UPDATE UserTypeToSysFunction
SET Acesso = 1
WHERE IDUSerType = 1 AND IDSysFunction = 45
GO

UPDATE	Sis_CodigoIncremental
SET UltimoCodigo = 45
WHERE Tabela = 'SysFunction.IDSysFunction'
GO

Insert into SysFunction (IDSysFunction, IDMenu, IDSubMenu, Sysfunction) Values (46, 1, 1,'Can display floating qty ?')
GO
Insert Into SysFunctionLanguage (IDSysFunction, IDLanguage, SysFunction)  Values ( 46, 1, 'Can display floating qty ?')
GO
Insert Into SysFunctionLanguage (IDSysFunction, IDLanguage, SysFunction)  Values ( 46, 2, 'Pode visualizar qtd Flutuante ?')
GO
Insert Into SysFunctionLanguage (IDSysFunction, IDLanguage, SysFunction)  Values ( 46, 3, '¿Puede demostrar la ctd flotando ?')
GO

UPDATE	Sis_CodigoIncremental
SET UltimoCodigo = 46
WHERE Tabela = 'SysFunction.IDSysFunction'
GO

Insert into SysFunction (IDSysFunction, IDMenu, IDSubMenu, Sysfunction) Values (47, 1, 1,'Can display qty OnHold ?')
GO
Insert Into SysFunctionLanguage (IDSysFunction, IDLanguage, SysFunction)  Values ( 47, 1, 'Can display qty OnHold ?')
GO
Insert Into SysFunctionLanguage (IDSysFunction, IDLanguage, SysFunction)  Values ( 47, 2, 'Pode visualizar qtd Reservada ?')
GO
Insert Into SysFunctionLanguage (IDSysFunction, IDLanguage, SysFunction)  Values ( 47, 3, '¿Puede demostrar la ctd Reservado ?')
GO

UPDATE UserTypeToSysFunction
SET Acesso = 1
WHERE IDUSerType = 1 AND IDSysFunction = 47
GO

UPDATE	Sis_CodigoIncremental
SET UltimoCodigo = 47
WHERE Tabela = 'SysFunction.IDSysFunction'
GO

