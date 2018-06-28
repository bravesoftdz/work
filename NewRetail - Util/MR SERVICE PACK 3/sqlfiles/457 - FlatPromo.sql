ALTER TABLE Sal_Promo ADD
	FlatPromo Boolean NULL CONSTRAINT DF_SalPromo_FlatPromo_Zero DEFAULT 0
GO

UPDATE Sal_Promo SET FlatPromo = 0
GO

ALTER TABLE Sal_Promo ALTER COLUMN
	FlatPromo Boolean NOT NULL
GO
