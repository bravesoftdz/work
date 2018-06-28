if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vwBarcode]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vwBarcode]
GO

CREATE VIEW vwBarcode AS
SELECT
	B.IDBarcode, 
	B.Data as BarcodeDate,
	M.Model, 
	M.Description, 
	M.SellingPrice, 
	F.Pessoa as Manufacture,
	U.Unidade,
	U.Sigla,
	INVS.CodSize,
	INVS.SizeName,
	INVC.CodColor,
	INVC.Color
FROM
	Barcode B
	JOIN Model M ON (M.IDModel = B.IDModel)
	LEFT JOIN Pessoa F ON (F.IDPessoa = M.IDFabricante)
	LEFT JOIN Unidade U ON (M.IDUnidade = U.IDUnidade)
	LEFT JOIN InvSize INVS ON (INVS.IDSize = M.IDSize)
	LEFT JOIN InvColor INVC ON (INVC.IDColor = M.IDColor)
WHERE
	M.Desativado = 0
	AND
	M.Hidden = 0


GO
