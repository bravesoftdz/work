INSERT INTO SysFunction (IDSysFunction, IDMenu, IDSubMenu, SysFunction)
VALUES (87, 1, 1, 'Confirm old delivery first?')
GO

INSERT INTO SysFunctionLanguage (IDSysFunction, IDLanguage, SysFunction)
VALUES (87, 1, 'Confirm old delivery first?')
GO

INSERT INTO SysFunctionLanguage (IDSysFunction, IDLanguage, SysFunction)
VALUES (87, 2, 'Confirmar entrega de pedidos antigos primeiro?')
GO

INSERT INTO SysFunctionLanguage (IDSysFunction, IDLanguage, SysFunction)
VALUES (87, 3, '¿Confirmar la entrega de edad en primer lugar?')
GO

UPDATE UserTypeToSysFunction
SET Acesso = 0
WHERE IDSysFunction = 87
GO
