Insert into Param (IDParam, SrvParameter, SrvValue, SrvType, Description, DefaultValue)
Values (74, 'Prompt password before open MR', 'False', 'Boolean', 'Prompt user password before open MainRetail', 'False')
GO

Insert into ParamLanguage (IDParam, IDLanguage, SrvParameter, Description)
Values (74, 1, 'Prompt password before open MR', 'Prompt user password before open MainRetail')
GO

Insert into ParamLanguage (IDParam, IDLanguage, SrvParameter, Description)
Values (74, 2, 'Pedir senha antes de aberto MR', 'Pedir a senha ao operador antes de abrir o MainRetail')
GO

Insert into ParamLanguage (IDParam, IDLanguage, SrvParameter, Description)
Values (74, 3, 'Pregunte la contraseña abre antes MR', 'La contraseña pronta del usuario abre antes MainRetail')
GO

Insert into SysFunction (IDSysFunction, IDMenu, IDSubMenu, Sysfunction) Values (58, 1, 1,'Manager Cash Register only')
GO
Insert Into SysFunctionLanguage (IDSysFunction, IDLanguage, SysFunction)  Values ( 58, 1, 'Manager Cash Register only')
GO
Insert Into SysFunctionLanguage (IDSysFunction, IDLanguage, SysFunction)  Values ( 58, 2, 'Usar somente o Caixa registradora')
GO
Insert Into SysFunctionLanguage (IDSysFunction, IDLanguage, SysFunction)  Values ( 58, 3, 'Utilice Caja Registradora sólo')
GO

UPDATE UserTypeToSysFunction
SET Acesso = 0
WHERE IDUSerType = 1 AND IDSysFunction = 58
GO

UPDATE	Sis_CodigoIncremental
SET UltimoCodigo = 58
WHERE Tabela = 'SysFunction.IDSysFunction'
GO
