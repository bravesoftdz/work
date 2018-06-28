UPDATE MenuItem
SET Name = 'Inventory setup',
Tip = 'Calculate margin, ClassABC, Auto-Request, and rounding prices per category, sub-category, and group'
Where IDMenu = 8 AND IDSubMenu = 8
GO

UPDATE MenuItemLanguage
SET Name = 'Inventory setup',
Tip = 'Calculate margin, ClassABC, Auto-Request, and rounding prices per category, sub-category, and group'
Where IDMenu = 8 AND IDSubMenu = 8 AND IDLanguage = 1
GO

UPDATE MenuItemLanguage
SET Name = 'Configuração do estoque',
Tip = 'Configurar margem, Curva ABC, auto-requisição e arredondamento de preços para categoria, subcategoria, e grupos'
Where IDMenu = 8 AND IDSubMenu = 8 AND IDLanguage = 2
GO

UPDATE MenuItemLanguage
SET Name = 'Arreglo Inventorio',
Tip = 'Calcule margen, CurvaABC, y precios redondos por la categoría, por la subcategoría, y por el grupo'
Where IDMenu = 8 AND IDSubMenu = 8 AND IDLanguage = 3
GO
