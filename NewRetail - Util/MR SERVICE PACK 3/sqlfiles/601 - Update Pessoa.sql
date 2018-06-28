ALTER TABLE Pessoa
	ADD SalesTaxExempt bit NULL
		CONSTRAINT DF_Pessoa_SalesTaxExempt DEFAULT 0
GO

UPDATE P SET P.SalesTaxExempt = 0
FROM Pessoa P
JOIN TipoPessoa TP ON (TP.IDTipoPessoa = P.IDTipoPessoa)
WHERE Path like '.001%'
GO
