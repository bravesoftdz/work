Update SysFunctionLanguage
Set SysFunction = 'Pode vender por menos que preço de custo?' 
where IDSysFunction = 4 AND IDLanguage = 2 
GO

INSERT INTO SysFunction (IDSysFunction, IDMenu, IDSubMenu, SysFunction)
VALUES (80, 1, 1, 'Can add items when edit hold?')
GO

INSERT INTO SysFunctionLanguage (IDSysFunction, IDLanguage, SysFunction)
VALUES (80, 1, 'Can add items when edit hold?')
GO

INSERT INTO SysFunctionLanguage (IDSysFunction, IDLanguage, SysFunction)
VALUES (80, 2, 'Pode adicionar item quando editar pedido?')
GO

INSERT INTO SysFunctionLanguage (IDSysFunction, IDLanguage, SysFunction)
VALUES (80, 3, '¿Puede eliminar tema al editar factura?')
GO

UPDATE UserTypeToSysFunction
SET Acesso = 1
WHERE IDSysFunction = 80 AND IDUserType in (1, 2, 3, 4, 16)
GO

INSERT INTO SysFunction (IDSysFunction, IDMenu, IDSubMenu, SysFunction)
VALUES (81, 1, 1, 'Can edit items when edit hold?')
GO

INSERT INTO SysFunctionLanguage (IDSysFunction, IDLanguage, SysFunction)
VALUES (81, 1, 'Can edit items when edit hold?')
GO

INSERT INTO SysFunctionLanguage (IDSysFunction, IDLanguage, SysFunction)
VALUES (81, 2, 'Pode alterar item quando editar pedido?')
GO

INSERT INTO SysFunctionLanguage (IDSysFunction, IDLanguage, SysFunction)
VALUES (81, 3, '¿Puede editar tema al editar factura?')
GO

UPDATE UserTypeToSysFunction
SET Acesso = 1
WHERE IDSysFunction = 81 AND IDUserType in (1, 2, 3, 4, 16)
GO

INSERT INTO SysFunction (IDSysFunction, IDMenu, IDSubMenu, SysFunction)
VALUES (82, 1, 1, 'Can delete items when edit hold?')
GO

INSERT INTO SysFunctionLanguage (IDSysFunction, IDLanguage, SysFunction)
VALUES (82, 1, 'Can delete items when edit hold?')
GO

INSERT INTO SysFunctionLanguage (IDSysFunction, IDLanguage, SysFunction)
VALUES (82, 2, 'Pode deletar item quando editar pedido?')
GO

INSERT INTO SysFunctionLanguage (IDSysFunction, IDLanguage, SysFunction)
VALUES (82, 3, '¿Puede eliminar tema al editar factura?')
GO

UPDATE UserTypeToSysFunction
SET Acesso = 1
WHERE IDSysFunction = 82 AND IDUserType in (1, 2, 3, 4, 16)
GO
