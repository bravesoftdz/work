ALTER TABLE Inv_FrozeCount ADD newcol Decimal(38, 4) NULL
GO

UPDATE Inv_FrozeCount SET newcol = Qty
GO

ALTER TABLE Inv_FrozeCount DROP COLUMN Qty
GO

EXEC sp_rename 'Inv_FrozeCount.newcol', 'Qty', 'COLUMN'
GO
