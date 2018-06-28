ALTER TABLE Rep_Item
	ADD Version Int
GO

UPDATE Rep_Item Set Version = 1
GO

UPDATE Rep_Item Set ItemID = ItemID + 1000
WHERE System = 0
GO

UPDATE Sis_CodigoIncremental SET UltimoCodigo = (SELECT MAX(ItemID) FROM Rep_Item)
WHERE Tabela = 'Rep_Item.ItemId'
GO

DELETE Rep_Item
Where System = 1
GO
