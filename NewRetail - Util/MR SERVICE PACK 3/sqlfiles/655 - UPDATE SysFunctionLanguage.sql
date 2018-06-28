UPDATE SysFunctionLanguage
SET SysFunction = 'Pode dar desconto acima do limite?'
WHERE IDSysFunction = 9 AND IDLanguage = 2
GO

UPDATE SysFunctionLanguage
SET SysFunction = 'Pode fazer desconto especial?'
WHERE IDSysFunction = 41 AND IDLanguage = 2
GO
