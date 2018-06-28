CREATE TABLE Sal_RebateDiscount (
	IDPreSale int NOT NULL,
	DiscountValue money NOT NULL,
	UsedDate datetime NULL
)
GO

ALTER TABLE Sal_RebateDiscount ADD CONSTRAINT
	XPKSal_RebateDiscount PRIMARY KEY (IDPreSale)
GO

ALTER TABLE Sal_RebateDiscount ADD CONSTRAINT
	FK_Invoice_SalRebateDiscount_IDPreSale FOREIGN KEY (IDPreSale) REFERENCES Invoice
GO

CREATE TABLE Sal_RebateCalendar (
	IDRebateCalendar int NOT NULL,
	IDStore int NULL,
	[Description] varchar(30) NOT NULL,
	DaysOfWeek varchar(14) NOT NULL,
	DiscountPerc float NOT NULL,
	StartDate datetime NOT NULL,
	EndDate datetime NULL,
	System TControlField,
	Hidden TControlField,
	Desativado TControlField
)
GO

ALTER TABLE Sal_RebateCalendar ADD CONSTRAINT
	XPKSal_RebateCalendar PRIMARY KEY (IDRebateCalendar)
GO

ALTER TABLE Sal_RebateCalendar ADD CONSTRAINT
	FK_Store_SalRebateCalendar_IDStore FOREIGN KEY (IDStore) REFERENCES Store
GO

CREATE TABLE Sal_RebateItem (
	IDRebateItem int NOT NULL,
	IDModel int NULL,
	IDStore int NULL,
	DiscountPerc float NOT NULL
)
GO

ALTER TABLE Sal_RebateItem ADD CONSTRAINT
	XPKSal_RebateItem PRIMARY KEY (IDRebateItem)
GO

ALTER TABLE Sal_RebateItem ADD CONSTRAINT
	FK_Store_SalRebateItem_IDStore FOREIGN KEY (IDStore) REFERENCES Store
GO

ALTER TABLE Sal_RebateItem ADD CONSTRAINT
	FK_Model_SalRebateItem_IDModel FOREIGN KEY (IDModel) REFERENCES Model
GO

CREATE TABLE Sal_RebateItemCalendar (
	IDRebateItem int NOT NULL,
	IDRebateCalendar int NOT NULL
)
GO

ALTER TABLE Sal_RebateItemCalendar ADD CONSTRAINT
	XPKSal_RebateItemCalendar PRIMARY KEY (IDRebateItem, IDRebateCalendar)
GO

ALTER TABLE Sal_RebateItemCalendar ADD CONSTRAINT
	FK_SalRebateCalendar_SalRebateItemCalendar_IDRebateCalendar FOREIGN KEY (IDRebateCalendar) REFERENCES Sal_RebateCalendar
GO

ALTER TABLE Sal_RebateItemCalendar ADD CONSTRAINT
	FK_SalRebateItem_SalRebateItemCalendar_IDRebateItem FOREIGN KEY (IDRebateItem) REFERENCES Sal_RebateItem
GO
