ALTER TABLE TabGroup
ADD PackModel Boolean
GO

ALTER TABLE TabGroup ADD CONSTRAINT
DF_PackModel_Enabled DEFAULT (0) FOR PackModel
GO

UPDATE TabGroup
SET PackModel = 0
GO

CREATE TABLE dbo.PackModel
	(
	IDPackModel int NOT NULL,
	IDModel int NOT NULL,
	Qty int
	)  ON [PRIMARY]
GO

ALTER TABLE dbo.PackModel ADD CONSTRAINT
	PK_PackModel_IDPackModel_IDModel PRIMARY KEY 
	(
	IDPackModel,
	IDModel
	) ON [PRIMARY]
GO

ALTER TABLE PreInventoryMov 
ADD IDParentPack Int
GO

ALTER TABLE InventoryMov 
ADD IDParentPack Int
GO
