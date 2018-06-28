IF NOT EXISTS (SELECT Name FROM InventoryMovType WHERE IDInventMovType = 26)
BEGIN
INSERT InventoryMovType (IDInventMovType, Name, Entrando, System, Desativado, Hidden, UpdateOnHand)
VALUES (26, 'Store Use', 0, 0, 0, 0, 0)
END
ELSE
BEGIN
UPDATE InventoryMovType SET Name = 'Store Use', Entrando = 0, System = 0, Desativado = 0, Hidden = 0, UpdateOnHand = 0
WHERE IDInventMovType = 26
END
GO

UPDATE	Sis_CodigoIncremental
SET UltimoCodigo = 26
WHERE Tabela = 'InventoryMovType.IDInventMovType'
GO
