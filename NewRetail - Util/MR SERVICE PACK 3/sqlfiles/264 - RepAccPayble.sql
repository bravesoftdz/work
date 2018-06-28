if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_LancamentoPC]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_LancamentoPC]
GO

CREATE VIEW vw_Rep_LancamentoPC AS
	SELECT
		Fin_LancamentoTipo.CodigoContabil,
		REPLICATE('  ', LEN(Fin_LancamentoTipo.CodigoContabil) - 1) + Fin_LancamentoTipo.CodigoContabil AS CodigoArvore,
		Fin_LancamentoTipo.Path,
		REPLICATE('  ', LEN(Fin_LancamentoTipo.CodigoContabil) - 1) + Fin_LancamentoTipo.Path AS PathArvore,
		LancPC.DataVencimento,
		LancPC.DataLancamento,
		SUM(ISNULL(LancPC.ValorNominal, 0)) AS Valor
	FROM
		Fin_LancamentoTipo INNER JOIN
		(
		SELECT				
			F.DataVencimento,
			F.DataLancamento,
			FT.CodigoContabil,
			F.ValorNominal
		FROM
			Fin_Lancamento F INNER JOIN 
			Fin_LancamentoTipo FT ON
				(F.IDLancamentoTipo = FT.IDLancamentoTipo)
	
		) AS LancPC on (LancPC.CodigoContabil LIKE Fin_LancamentoTipo.CodigoContabil + '%')
	GROUP BY
		Fin_LancamentoTipo.CodigoContabil,
		Fin_LancamentoTipo.Path,
		LancPC.DataVencimento,
		LancPC.DataLancamento
GO

EXEC sp_Rep_AddTableField 'vw_Rep_LancamentoPC'
GO
