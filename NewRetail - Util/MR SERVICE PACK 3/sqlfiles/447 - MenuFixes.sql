DELETE MenuItemLanguage
WHERE IDMenu = 8 AND IDSubMenu = 8
GO

DELETE MenuItemLanguage
WHERE IDMenu = 8 AND IDSubMenu = 8
GO

DELETE MenuItem
WHERE IDMenu = 8 AND IDSubMenu = 8
GO

UPDATE MenuItemLanguage
SET ParentMenu = 'Inventory'
WHERE IDMenu = 5 AND IDSubMenu = 15 AND IDLanguage = 1
GO

UPDATE MenuItemLanguage
SET ParentMenu = 'Estoque'
WHERE IDMenu = 5 AND IDSubMenu = 15 AND IDLanguage = 2
GO

UPDATE MenuItemLanguage
SET ParentMenu = 'Inventario'
WHERE IDMenu = 5 AND IDSubMenu = 15 AND IDLanguage = 3
GO

UPDATE MenuItem
SET ParentMenu = 'Inventory'
WHERE IDMenu = 5 AND IDSubMenu = 15
GO
