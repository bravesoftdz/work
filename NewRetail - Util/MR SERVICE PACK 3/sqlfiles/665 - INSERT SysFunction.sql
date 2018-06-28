INSERT INTO SysFunction (IDSysFunction, IDMenu, IDSubMenu, SysFunction)
VALUES (74, 2, 1, 'Can give item discount after invoice discout, or invoice discount after item discount?')
GO

INSERT INTO SysFunctionLanguage (IDSysFunction, IDLanguage, SysFunction)
VALUES (74, 1, 'Can give item discount after invoice discout, or invoice discount after item discount?')
GO

INSERT INTO SysFunctionLanguage (IDSysFunction, IDLanguage, SysFunction)
VALUES (74, 2, 'Pode dar desconto no item depois de dar na nota, ou na nota depois de dar no item?')
GO

INSERT INTO SysFunctionLanguage (IDSysFunction, IDLanguage, SysFunction)
VALUES (74, 3, '¿Puede descontar el artículo después de discout de la factura,ou en la factura después del artículo?')
GO

UPDATE UserTypeToSysFunction
SET Acesso = 1
WHERE IDSysFunction = 74 AND IDUserType = 1
GO
