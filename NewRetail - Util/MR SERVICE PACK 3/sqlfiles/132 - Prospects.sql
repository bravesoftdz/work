IF EXISTS (SELECT * FROM TipoPessoa WHERE IDTipoPessoa = 10)
	UPDATE TipoPessoa SET Path = '.001.001', TipoPessoa = 'Prospects', PathName = '\ Customers\ Prospects', System = 1 WHERE IDTipoPessoa = 10
ELSE
BEGIN
	INSERT TipoPessoa (IDTipoPessoa, Path, TipoPessoa, PathName,  System)
	VALUES (10, '.001.001', 'Prospects', '\ Customers\ Prospects', 1)
END
GO
