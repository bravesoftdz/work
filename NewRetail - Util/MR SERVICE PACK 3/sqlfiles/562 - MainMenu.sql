INSERT MenuItem (IDMenu, IDSubMenu, Name, ParentMenu, Tip, Visible, Enabled, Shortcut, ImageIndex)
VALUES (2, 11, 'Reports', 'Sales Support', 'Display and analyze sales results by reports', 1, 1, NULL, 3)
GO

INSERT MenuItemLanguage (IDMenu, IDSubMenu, IDLanguage, Name, ParentMenu, Tip)
VALUES (2, 11, 1, 'Reports', 'Sales Support', 'Display and analyze sales results by reports')
GO

INSERT MenuItemLanguage (IDMenu, IDSubMenu, IDLanguage, Name, ParentMenu, Tip)
VALUES (2, 11, 2, 'Relatórios', 'Apoio a Vendas', 'Exibe Resultados de Venda.')
GO

INSERT MenuItemLanguage (IDMenu, IDSubMenu, IDLanguage, Name, ParentMenu, Tip)
VALUES (2, 11, 3, 'Informes', 'Data Ventas', 'Muestra y analiza los resultados de las ventas a través de informes.')
GO

UPDATE UserRights
SET CanAccess = 1, CanInsert = 1, CanDelete = 1, CanUpdate = 1, CanPrint = 1
WHERE UserTypeID = 1 AND MenuID = 2 AND SubMenuID = 11
GO

UPDATE MenuItem 
SET Name = 'Promotions', Tip = 'Create promotions for sales', ImageIndex = 64, Shortcut = NULL
WHERE IDMenu = 2 AND IDSubMenu = 10
GO

UPDATE MenuItemLanguage 
SET Name = 'Promotions', Tip = 'Create promotions for sales'
WHERE IDMenu = 2 AND IDSubMenu = 10 AND IDLanguage = 1
GO

UPDATE MenuItemLanguage 
SET Name = 'Promoções', Tip = 'Criar promocões para vendas'
WHERE IDMenu = 2 AND IDSubMenu = 10 AND IDLanguage = 2
GO

UPDATE MenuItemLanguage 
SET Name = 'Promociones', Tip = 'Crear promociones para las ventas'
WHERE IDMenu = 2 AND IDSubMenu = 10 AND IDLanguage = 3
GO

UPDATE UserRights
SET CanAccess = 1, CanInsert = 1, CanDelete = 1, CanUpdate = 1, CanPrint = 1
WHERE UserTypeID = 1 AND MenuID = 2 AND SubMenuID = 10
GO
