INSERT INTO SysFunction (IDSysFunction, IDMenu, IDSubMenu, SysFunction)
VALUES (84, 1, 1, 'Can convert budget in hold?')
GO

INSERT INTO SysFunctionLanguage (IDSysFunction, IDLanguage, SysFunction)
VALUES (84, 1, 'Can convert budget in hold?')
GO

INSERT INTO SysFunctionLanguage (IDSysFunction, IDLanguage, SysFunction)
VALUES (84, 2, 'Pode converter orçamento em pedido?')
GO

INSERT INTO SysFunctionLanguage (IDSysFunction, IDLanguage, SysFunction)
VALUES (84, 3, '¿Puede convertir el presupuesto en celebrar?')
GO

UPDATE UserTypeToSysFunction
SET Acesso = 1
WHERE IDSysFunction = 84 AND IDUserType = 1
GO

INSERT INTO SysFunction (IDSysFunction, IDMenu, IDSubMenu, SysFunction)
VALUES (85, 1, 1, 'Validate budget before export?')
GO

INSERT INTO SysFunctionLanguage (IDSysFunction, IDLanguage, SysFunction)
VALUES (85, 1, 'Validate budget before export?')
GO

INSERT INTO SysFunctionLanguage (IDSysFunction, IDLanguage, SysFunction)
VALUES (85, 2, 'Validar orçamento antes da exportação?')
GO

INSERT INTO SysFunctionLanguage (IDSysFunction, IDLanguage, SysFunction)
VALUES (85, 3, '¿Validar el presupuesto antes de la exportación?')
GO

UPDATE UserTypeToSysFunction
SET Acesso = 1
WHERE IDSysFunction = 85 AND IDUserType = 1
GO
