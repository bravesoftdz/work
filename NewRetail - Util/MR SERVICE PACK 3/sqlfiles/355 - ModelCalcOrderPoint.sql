ALTER TABLE Model ADD newcol FLOAT NULL
GO

UPDATE Model SET newcol = VD
GO

ALTER TABLE Model DROP COLUMN VD
GO

EXEC sp_rename 'Model.newcol', 'VD', 'COLUMN'
GO

ALTER TABLE Model ADD newcol FLOAT NULL
GO

UPDATE Model SET newcol = VP
GO

ALTER TABLE Model DROP COLUMN VP
GO

EXEC sp_rename 'Model.newcol', 'VP', 'COLUMN'
GO

ALTER TABLE Model ADD newcol FLOAT NULL
GO

UPDATE Model SET newcol = SX
GO

ALTER TABLE Model DROP COLUMN SX
GO

EXEC sp_rename 'Model.newcol', 'SX', 'COLUMN'
GO

ALTER TABLE Model ADD newcol FLOAT NULL
GO

UPDATE Model SET newcol = SX2
GO

ALTER TABLE Model DROP COLUMN SX2
GO

EXEC sp_rename 'Model.newcol', 'SX2', 'COLUMN'
GO
