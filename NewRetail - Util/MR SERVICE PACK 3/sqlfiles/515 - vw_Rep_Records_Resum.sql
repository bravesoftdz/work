if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_Records_Resum]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_Records_Resum]
GO

CREATE VIEW vw_Rep_Records_Resum
AS
SELECT
	F.DataLancamento,
	F.IDPreSale,
	F.IDQuitacaoMeioPrevisto,
	SUM(F.ValorNominal) as ValorNominal,
	F.IDCashRegMov
FROM
	Fin_Lancamento F
GROUP BY
	F.IDQuitacaoMeioPrevisto,
	F.DataLancamento,
	F.IDCashRegMov,
	F.IDPreSale
GO
