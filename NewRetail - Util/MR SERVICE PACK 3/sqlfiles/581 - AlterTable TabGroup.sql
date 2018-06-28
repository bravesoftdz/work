ALTER TABLE TabGroup ADD
	PackModelAddItems bit NULL CONSTRAINT DF_TabGroup_PackModelAddItems_Zero DEFAULT 0
GO
