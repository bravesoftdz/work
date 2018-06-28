Insert into SysFunction (IDSysFunction, IDMenu, IDSubMenu, Sysfunction) Values (56, 1, 1,'Can display qty Info "Yes/No" ?')
GO
Insert Into SysFunctionLanguage (IDSysFunction, IDLanguage, SysFunction)  Values ( 56, 1, 'Can display qty Info "Yes/No" ?')
GO
Insert Into SysFunctionLanguage (IDSysFunction, IDLanguage, SysFunction)  Values ( 56, 2, 'Pode mostrar qtd na loja "Sim/Não"?')
GO
Insert Into SysFunctionLanguage (IDSysFunction, IDLanguage, SysFunction)  Values ( 56, 3, '¿Puede mostrar ctd na tienda "Si/No"? ')
GO

UPDATE UserTypeToSysFunction
SET Acesso = 1
WHERE IDUSerType = 1 AND IDSysFunction = 56
GO

UPDATE	Sis_CodigoIncremental
SET UltimoCodigo = 56
WHERE Tabela = 'SysFunction.IDSysFunction'
GO
