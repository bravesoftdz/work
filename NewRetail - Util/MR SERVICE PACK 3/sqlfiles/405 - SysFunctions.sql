Insert into SysFunction (IDSysFunction, IDMenu, IDSubMenu, Sysfunction) Values (64, 1, 1,'Can printing Z on fiscal printer ?')
GO
Insert Into SysFunctionLanguage (IDSysFunction, IDLanguage, SysFunction)  Values ( 64, 1, 'Can printing Z on fiscal printer ?')
GO
Insert Into SysFunctionLanguage (IDSysFunction, IDLanguage, SysFunction)  Values ( 64, 2, 'Pode emitir a Redução Z ?')
GO
Insert Into SysFunctionLanguage (IDSysFunction, IDLanguage, SysFunction)  Values ( 64, 3, '¿Puede emitir impression Z ?')
GO
 
UPDATE UserTypeToSysFunction
SET Acesso = 1
WHERE IDUserType = 1 AND IDSysFunction = 64
GO
 
UPDATE Sis_CodigoIncremental
SET UltimoCodigo = 64
WHERE Tabela = 'SysFunction.IDSysFunction'
GO
