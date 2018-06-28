CREATE TABLE Sal_DrawerKickLog (
	IDDrawerKickLog int NOT NULL,
	IDUser int NOT NULL,
	IDCashRegister int NOT NULL,
	MovDate datetime NOT NULL,
	Type int NOT NULL
)
GO

ALTER TABLE Sal_DrawerKickLog ADD CONSTRAINT
	XPKSal_DrawerKickLog PRIMARY KEY (IDDrawerKickLog)
GO

ALTER TABLE Sal_DrawerKickLog ADD CONSTRAINT
	FK_CashRegister_SalDrawerKickLog_IDCashRegister FOREIGN KEY (IDCashRegister) REFERENCES CashRegister
GO

ALTER TABLE Sal_DrawerKickLog ADD CONSTRAINT
	FK_SystemUser_SalDrawerKickLog_IDUser FOREIGN KEY (IDUser) REFERENCES SystemUser
GO
