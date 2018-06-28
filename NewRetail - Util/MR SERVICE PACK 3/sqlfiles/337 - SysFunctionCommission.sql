Insert into SysFunction (IDSysFunction, IDMenu, IDSubMenu, Sysfunction) Values (63, 1, 1,'Can change commission ?')
GO
Insert Into SysFunctionLanguage (IDSysFunction, IDLanguage, SysFunction)  Values ( 63, 1, 'Can change commission ?')
GO
Insert Into SysFunctionLanguage (IDSysFunction, IDLanguage, SysFunction)  Values ( 63, 2, 'Pode alterar a comissão ?')
GO
Insert Into SysFunctionLanguage (IDSysFunction, IDLanguage, SysFunction)  Values ( 63, 3, '¿Puede el cambio comisionar ?')
GO
 
UPDATE UserTypeToSysFunction
SET Acesso = 1
WHERE IDUserType = 1 AND IDSysFunction = 63
GO
 
UPDATE Sis_CodigoIncremental
SET UltimoCodigo = 63
WHERE Tabela = 'SysFunction.IDSysFunction'
GO
