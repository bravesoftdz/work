ALTER TABLE TabGroup ADD ServiceAutoNumber bit NULL CONSTRAINT DF_Zero1241 DEFAULT 0
GO

ALTER TABLE InventoryMov ADD SequencyNum int NULL
GO