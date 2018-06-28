Insert into SysFunction (IDSysFunction, IDMenu, IDSubMenu, Sysfunction) Values (44,1,1,'Can delete delay payments ?')
GO
Insert Into SysFunctionLanguage (IDSysFunction, IDLanguage, SysFunction)  Values ( 44, 1, 'Can delete delay payments ?')
GO
Insert Into SysFunctionLanguage (IDSysFunction, IDLanguage, SysFunction)  Values ( 44, 2, 'Pode deletar as parcelas do pre-datado ?')
GO
Insert Into SysFunctionLanguage (IDSysFunction, IDLanguage, SysFunction)  Values ( 44, 3, '¿Puede borrar los pagos de la demora?')
GO

UPDATE	Sis_CodigoIncremental
SET UltimoCodigo = 44
WHERE Tabela = 'SysFunction.IDSysFunction'
GO

Update Sis_MainMenu Set ClassName = 'MainReport.exe', LoaderType = 6
Where IDMenuItem = 147
GO