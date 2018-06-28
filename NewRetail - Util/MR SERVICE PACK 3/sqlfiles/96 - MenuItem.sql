DELETE UserRights
WHERE MenuID = 8 AND SubMenuID = 13
GO

INSERT MenuItem (IDMenu, IDSubMenu, Name, ParentMenu, Tip, Visible, ImageIndex)
VALUES (8, 13, 'Invoice Expense', 'Maintenance', 'Create and maintain different expense categories for invoice such as freight, shipping, installations, etc.', 1, 15)
GO

INSERT MenuItemLanguage (IDMenu, IDSubMenu, IDLanguage, Name, ParentMenu, Tip)
VALUES (8, 13, 1, 'Invoice Expense', 'Maintenance', 'Create and maintain different expense categories for invoice such as freight, shipping, installations, etc.')
GO

INSERT MenuItemLanguage (IDMenu, IDSubMenu, IDLanguage, Name, ParentMenu, Tip)
VALUES (8, 13, 2, 'Despesas do Pedido', 'Manutenção', 'Adicionar e Manter Diferentes Tipos de Despesas para Notas como Frete, Entregas, etc.')
GO

INSERT MenuItemLanguage (IDMenu, IDSubMenu, IDLanguage, Name, ParentMenu, Tip)
VALUES (8, 13, 3, 'Gastos del Factura', 'Mantenimiento', 'Crea y mantiene diferentes categorías de gastos referentes a Factura como flete, etc.')
GO

UPDATE UserRights SET CanAccess=1, CanInsert=1, CanDelete=1, CanUpdate=1, CanPrint=1
WHERE MenuID = 8 AND SubMenuID = 13 AND UserTypeID = 1
GO

