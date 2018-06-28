if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vwCashRegisterTotalByDate]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vwCashRegisterTotalByDate]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_CashRegisterFlow]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_CashRegisterFlow]
GO

CREATE VIEW vwCashRegisterTotalByDate AS
	SELECT
		CONVERT(datetime, CONVERT(varchar, F.DataLancamento, 103), 103) AS DataLancamento,
		SUM(F.ValorNominal) AS ValorTotalNominal,
		SUM(F.TotalQuitado)AS ValorTotalQuitado,
		CONVERT(datetime, CONVERT(varchar, Caixa.DataCaixaFechado, 103), 103) AS DataCaixaFechado
	FROM
		Fin_Lancamento F LEFT JOIN	
		(
			SELECT
				CashRegMov.IDCashRegMov,
				CashRegLog.LogTime AS DataCaixaFechado
			FROM
				CashRegMov LEFT JOIN
				CashRegLog ON 
					(CashRegMov.IDCashRegMov = CashRegLog.IDCashRegMov) AND
					(CashRegLog.IDCashRegTipoLog = 4)
		) AS Caixa ON
			(F.IDCashRegMovClosed = Caixa.IDCashRegMov)
	WHERE
		F.IDLancamentoTipo = 2	
	GROUP BY
		F.DataLancamento,
		Caixa.DataCaixaFechado
GO

CREATE VIEW vw_Rep_CashRegisterFlow AS
SELECT
	VendidoEAberto.DataLancamento AS RecordDate,
	VendidoEAberto.VendidoHoje AS TodaySale,
	VendidoEAberto.SaldoAReceber AmountToReceive,
	SUM(isnull(Fechado.ValorTotalNominal, 0)) AmountReceived
FROM
	(
	SELECT
		Venda.DataLancamento,
		VendidoHoje,
		SUM(isnull(Aberto.ValorTotalNominal, 0)) SaldoAReceber
		
	FROM	
		(SELECT 
			CONVERT(datetime, CONVERT(varchar, DataLancamento, 103), 103) AS DataLancamento, 
			SUM(ValorNominal) VendidoHoje
		FROM 
			Fin_Lancamento 
		WHERE 
			IDLancamentoTipo = 2 
		GROUP BY 
			CONVERT(datetime, CONVERT(varchar, DataLancamento, 103), 103)) Venda LEFT JOIN
	
		vwCashRegisterTotalByDate Aberto ON
			(
				Venda.DataLancamento >= Aberto.DataLancamento AND
				(
					Aberto.DataCaixaFechado IS NULL 
					OR 
					Venda.DataLancamento <= Aberto.DataCaixaFechado
				)
			) 
	
	GROUP BY
		Venda.DataLancamento,
		VendidoHoje
	) AS VendidoEAberto LEFT JOIN
	vwCashRegisterTotalByDate Fechado ON
			(
				VendidoEAberto.DataLancamento >= Fechado.DataLancamento AND
				(
					Fechado.DataCaixaFechado IS NOT NULL 
					AND 
					VendidoEAberto.DataLancamento = Fechado.DataCaixaFechado
				)
			)
GROUP BY
	VendidoEAberto.DataLancamento,
	VendidoEAberto.VendidoHoje,
	VendidoEAberto.SaldoAReceber
GO