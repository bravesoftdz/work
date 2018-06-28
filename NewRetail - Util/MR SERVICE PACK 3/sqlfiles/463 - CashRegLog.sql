ALTER TABLE CashRegLog ADD newcol DateTime NULL
GO

UPDATE CashRegLog SET newcol = LogTime
GO

ALTER TABLE CashRegLog DROP COLUMN LogTime
GO

EXEC sp_rename 'CashRegLog.newcol', 'LogTime', 'COLUMN'
GO
