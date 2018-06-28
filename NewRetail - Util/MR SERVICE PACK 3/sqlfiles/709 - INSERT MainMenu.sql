INSERT MenuItem (IDMenu, IDSubMenu, Name, ParentMenu, Tip, Visible, Enabled, Shortcut, ImageIndex)
VALUES (2, 12, 'Reports', 'Sales Support', 'Display and analyze sales results by reports', 1, 1, NULL, 3)
GO

INSERT MenuItemLanguage (IDMenu, IDSubMenu, IDLanguage, Name, ParentMenu, Tip)
VALUES (2, 12, 1, 'Reports', 'Sales Support', 'Display and analyze sales results by reports')
GO

INSERT MenuItemLanguage (IDMenu, IDSubMenu, IDLanguage, Name, ParentMenu, Tip)
VALUES (2, 12, 2, 'Relatórios', 'Apoio a Vendas', 'Exibe Resultados de Venda.')
GO

INSERT MenuItemLanguage (IDMenu, IDSubMenu, IDLanguage, Name, ParentMenu, Tip)
VALUES (2, 12, 3, 'Informes', 'Data Ventas', 'Muestra y analiza los resultados de las ventas a través de informes.')
GO

UPDATE UserRights
SET CanAccess = 1, CanInsert = 1, CanDelete = 1, CanUpdate = 1, CanPrint = 1
WHERE UserTypeID = 1 AND MenuID = 2 AND SubMenuID = 12
GO

UPDATE MenuItem 
SET Name = 'Documents Control', Tip = 'Keep control of sales document', ImageIndex = 2, Shortcut = NULL
WHERE IDMenu = 2 AND IDSubMenu = 11
GO

UPDATE MenuItemLanguage 
SET Name = 'Documents Control', Tip = 'Keep control of sales document'
WHERE IDMenu = 2 AND IDSubMenu = 11 AND IDLanguage = 1
GO

UPDATE MenuItemLanguage 
SET Name = 'Controle de Documentos', Tip = 'Controlar documentos de vendas'
WHERE IDMenu = 2 AND IDSubMenu = 11 AND IDLanguage = 2
GO

UPDATE MenuItemLanguage 
SET Name = 'Control de los documentos', Tip = 'Control del documento de las ventas'
WHERE IDMenu = 2 AND IDSubMenu = 11 AND IDLanguage = 3
GO

UPDATE UserRights
SET CanAccess = 1, CanInsert = 1, CanDelete = 1, CanUpdate = 1, CanPrint = 1
WHERE UserTypeID = 1 AND MenuID = 2 AND SubMenuID = 11
GO
