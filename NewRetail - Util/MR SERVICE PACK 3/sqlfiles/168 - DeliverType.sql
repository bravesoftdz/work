Insert into SysFunction (IDSysFunction, IDMenu, IDSubMenu, Sysfunction) Values (52, 1, 1,'Can exchange items for invoice items ?')
GO
Insert Into SysFunctionLanguage (IDSysFunction, IDLanguage, SysFunction)  Values ( 52, 1, 'Can exchange items for invoice items ?')
GO
Insert Into SysFunctionLanguage (IDSysFunction, IDLanguage, SysFunction)  Values ( 52, 2, 'Pode fazer devolução de itens de fatura ? ')
GO
Insert Into SysFunctionLanguage (IDSysFunction, IDLanguage, SysFunction)  Values ( 52, 3, '¿Puede cambiar por itens de fatura?')
GO

UPDATE UserTypeToSysFunction
SET Acesso = 1
WHERE IDUSerType = 1 AND IDSysFunction = 52
GO

UPDATE	Sis_CodigoIncremental
SET UltimoCodigo = 52
WHERE Tabela = 'SysFunction.IDSysFunction'
GO

Insert into SysFunction (IDSysFunction, IDMenu, IDSubMenu, Sysfunction) Values (53, 1, 1,'Verify customer name before change items ?')
GO
Insert Into SysFunctionLanguage (IDSysFunction, IDLanguage, SysFunction)  Values ( 53, 1, 'Verify customer name before change items ?')
GO
Insert Into SysFunctionLanguage (IDSysFunction, IDLanguage, SysFunction)  Values ( 53, 2, 'Verificar cliente antes de fazer a trocar itens ?')
GO
Insert Into SysFunctionLanguage (IDSysFunction, IDLanguage, SysFunction)  Values ( 53, 3, '¿Verifica el nombre del cliente antes de artículos de cambio? ')
GO

UPDATE UserTypeToSysFunction
SET Acesso = 1
WHERE IDUSerType = 1 AND IDSysFunction = 53
GO

UPDATE	Sis_CodigoIncremental
SET UltimoCodigo = 53
WHERE Tabela = 'SysFunction.IDSysFunction'
GO

Insert into SysFunction (IDSysFunction, IDMenu, IDSubMenu, Sysfunction) Values (54, 1, 1,'Check delivery status before change items?')
GO
Insert Into SysFunctionLanguage (IDSysFunction, IDLanguage, SysFunction)  Values ( 54, 1, 'Check delivery status before change items?')
GO
Insert Into SysFunctionLanguage (IDSysFunction, IDLanguage, SysFunction)  Values ( 54, 2, 'Verifique estado de entrega antes de trocar os itens? ')
GO
Insert Into SysFunctionLanguage (IDSysFunction, IDLanguage, SysFunction)  Values ( 54, 3, '¿Verifica la posición de la entrega antes de artículos de cambio?')
GO

UPDATE UserTypeToSysFunction
SET Acesso = 1
WHERE IDUSerType = 1 AND IDSysFunction = 54
GO

UPDATE	Sis_CodigoIncremental
SET UltimoCodigo = 54
WHERE Tabela = 'SysFunction.IDSysFunction'
GO

ALTER TABLE DeliverType ADD CanExchangeItem Bit NULL
GO
