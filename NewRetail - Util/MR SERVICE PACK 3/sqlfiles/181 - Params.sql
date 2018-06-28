Insert into Param (IDParam, SrvParameter, SrvValue, SrvType, Description, DefaultValue)
Values (68, 'Use replacement cost', 'False', 'Boolean', 'Enter TRUE to add the replacement cost in sale', 'False')
GO

Insert into ParamLanguage (IDParam, IDLanguage, SrvParameter, Description)
Values (68, 1, 'Use replacement cost', 'Enter TRUE to add the replacement cost in sale')
GO

Insert into ParamLanguage (IDParam, IDLanguage, SrvParameter, Description)
Values (68, 2, 'Usar Custo líquido de reposição', 'Disgite TRUE para lancar o custo de líquido reposição no pedido')
GO

Insert into ParamLanguage (IDParam, IDLanguage, SrvParameter, Description)
Values (68, 3, 'Entre custo reposition', 'Entre TRUE adicionar o custo de estimeted em venda')
GO

Insert into Param (IDParam, SrvParameter, SrvValue, SrvType, Description, DefaultValue)
Values (69, 'Mark next day delivery before X hours', '-1', 'Integer', 'Users cannot mark next day delivery after X hour. Set -1 to disable', '-1')
GO

Insert into ParamLanguage (IDParam, IDLanguage, SrvParameter, Description)
Values (69, 1, 'Mark next day delivery before X hours', 'Enter TRUE to add the replacement cost in sale')
GO

Insert into ParamLanguage (IDParam, IDLanguage, SrvParameter, Description)
Values (69, 2, 'Marque próxima entrega antes da horas X', 'Não podem marcar entrega para o dia seguinte depois da hora informada. Entre -1 para desabilitar')
GO

Insert into ParamLanguage (IDParam, IDLanguage, SrvParameter, Description)
Values (69, 3, 'Entrega día siguiente antes horas X', 'No pueden marcar la entrega de día siguiente después de hora X. Entre -1 en incapacitar')
GO

Insert into SysFunction (IDSysFunction, IDMenu, IDSubMenu, Sysfunction) Values (55, 1, 1,'Can mark delivery without verify hour ?')
GO
Insert Into SysFunctionLanguage (IDSysFunction, IDLanguage, SysFunction)  Values ( 55, 1, 'Can mark delivery without verify hour ?')
GO
Insert Into SysFunctionLanguage (IDSysFunction, IDLanguage, SysFunction)  Values ( 55, 2, 'Pode marca entrega sem verificar hora ?')
GO
Insert Into SysFunctionLanguage (IDSysFunction, IDLanguage, SysFunction)  Values ( 55, 3, '¿Puede marca la entrega sin verifica hora? ')
GO

UPDATE UserTypeToSysFunction
SET Acesso = 1
WHERE IDUSerType = 1 AND IDSysFunction = 55
GO

UPDATE	Sis_CodigoIncremental
SET UltimoCodigo = 55
WHERE Tabela = 'SysFunction.IDSysFunction'
GO
