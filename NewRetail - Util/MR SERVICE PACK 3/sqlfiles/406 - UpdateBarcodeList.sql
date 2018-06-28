INSERT MenuItem (IDMenu, IDSubMenu, Name, ParentMenu, Tip, Visible, Enabled, Shortcut, ImageIndex)
SELECT 5, 16, Name, ParentMenu, Tip, 1, Enabled, ShortCut, ImageIndex
FROM MenuItem 
WHERE IDMenu = 5 AND IDSubMenu = 14
GO

INSERT MenuItemLanguage (IDMenu, IDSubMenu, IDLanguage, Name, ParentMenu, Tip)
SELECT 5, 16, IDLanguage, Name, ParentMenu, Tip
FROM MenuItemLanguage
WHERE IDMenu = 5 AND IDSubMenu = 14 AND IDLanguage = 1
GO

INSERT MenuItemLanguage (IDMenu, IDSubMenu, IDLanguage, Name, ParentMenu, Tip)
SELECT 5, 16, IDLanguage, Name, ParentMenu, Tip
FROM MenuItemLanguage
WHERE IDMenu = 5 AND IDSubMenu = 14 AND IDLanguage = 2
GO

INSERT MenuItemLanguage (IDMenu, IDSubMenu, IDLanguage, Name, ParentMenu, Tip)
SELECT 5, 16, IDLanguage, Name, ParentMenu, Tip
FROM MenuItemLanguage
WHERE IDMenu = 5 AND IDSubMenu = 14 AND IDLanguage = 3
GO

INSERT MenuItem (IDMenu, IDSubMenu, Name, ParentMenu, Tip, Visible, Enabled, Shortcut, ImageIndex)
SELECT 5, 15, Name, ParentMenu, Tip, 1, Enabled, Shortcut, ImageIndex 
FROM MenuItem 
WHERE IDMenu = 8 AND IDSubMenu = 8
GO

INSERT MenuItemLanguage (IDMenu, IDSubMenu, IDLanguage, Name, ParentMenu, Tip)
SELECT 5, 15, IDLanguage, Name, ParentMenu, Tip
FROM MenuItemLanguage
WHERE IDMenu = 8 AND IDSubMenu = 8 AND IDLanguage = 1
GO

INSERT MenuItemLanguage (IDMenu, IDSubMenu, IDLanguage, Name, ParentMenu, Tip)
SELECT 5, 15, IDLanguage, Name, ParentMenu, Tip
FROM MenuItemLanguage
WHERE IDMenu = 8 AND IDSubMenu = 8 AND IDLanguage = 2
GO

INSERT MenuItemLanguage (IDMenu, IDSubMenu, IDLanguage, Name, ParentMenu, Tip)
SELECT 5, 15, IDLanguage, Name, ParentMenu, Tip
FROM MenuItemLanguage
WHERE IDMenu = 8 AND IDSubMenu = 8 AND IDLanguage = 3
GO

UPDATE MenuItem
SET Enabled = 0, Visible = 0
WHERE IDMenu = 8 AND IDSubMenu = 8
GO

UPDATE MenuItem SET Name = 'Barcode Print', ParentMenu = 'Inventory', Tip = 'Printing barcode list', 
Visible = 1, Enabled = 1, ImageIndex = 61
WHERE IDMenu = 5 AND IDSubMenu = 14
GO

UPDATE MenuItemLanguage SET Name = 'Barcode Print', ParentMenu = 'Inventory', Tip = 'Printing barcode list'
WHERE IDMenu = 5 AND IDSubMenu = 14 AND IDLanguage = 1
GO

UPDATE MenuItemLanguage SET Name = 'Imprimir Código de Barras', ParentMenu = 'Estoque', Tip = 'Imprimir listagem de Código de Barras'
WHERE IDMenu = 5 AND IDSubMenu = 14 AND IDLanguage = 2
GO

UPDATE MenuItemLanguage SET Name = 'Imprimir Código de Barras', ParentMenu = 'Inventario', Tip = 'Imprimir listagem de Código de Barras'
WHERE IDMenu = 5 AND IDSubMenu = 14 AND IDLanguage = 3
GO

ALTER TABLE Inv_BarcodePrint
	DROP CONSTRAINT FK_Barcode_BarcodePrint_IDBarcode
GO
