ALTER TABLE Model ADD
	AskUserOnSale Boolean NULL DEFAULT 0
GO

UPDATE Model
Set AskUserOnSale = 0
GO
