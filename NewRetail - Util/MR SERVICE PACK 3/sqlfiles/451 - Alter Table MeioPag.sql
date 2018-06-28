ALTER TABLE MeioPag ADD
	PayOnCashRegClose Boolean NULL,
	DrawerKickOnPay Boolean NULL
GO

EXEC sp_bindefault DEF_Bit_True, 'MeioPag.PayOnCashRegClose'
EXEC sp_bindefault DEF_Bit_True, 'MeioPag.DrawerKickOnPay'
GO

UPDATE MeioPag
SET PayOnCashRegClose = 1, DrawerKickOnPay = 1
GO

ALTER TABLE MeioPag ALTER COLUMN
	PayOnCashRegClose Boolean NOT NULL
GO

ALTER TABLE MeioPag ALTER COLUMN
	DrawerKickOnPay Boolean NOT NULL
GO
