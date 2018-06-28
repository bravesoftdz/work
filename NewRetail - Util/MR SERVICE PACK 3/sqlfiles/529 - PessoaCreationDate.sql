ALTER TABLE Pessoa ADD
	CreationDate DateTime NULL
GO

UPDATE P
SET P.CreationDate = FirstSale
FROM
	Pessoa P
	JOIN (
		SELECT
			I.IDCustomer,
			IsNull(min(InvoiceDate) , min(PreSaleDate)) FirstSale
		FROM
			Invoice I
			JOIN Pessoa C ON (I.IDCustomer = C.IDPessoa)
		GROUP BY
			I.IDCustomer
		) FS ON (P.IDPessoa = FS.IDCustomer)
GO
