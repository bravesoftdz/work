if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_CashRegisterFlow]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_CashRegisterFlow]
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
			CONVERT(datetime, CONVERT(varchar, I.PreSaleDate, 103), 103) AS DataLancamento,
			SUM(ISNULL(I.SubTotal, 0) + ISNULL(I.AditionalExpenses, 0) + ISNULL(I.OtherExpences, 0) - ISNULL(I.ItemDiscount, 0)) AS VendidoHoje
		FROM
			Invoice I
		WHERE
			I.IDPreSaleParent IS NULL
			AND
			I.Canceled = 0
		GROUP BY
			CONVERT(datetime, CONVERT(varchar, I.PreSaleDate, 103), 103)) Venda LEFT JOIN
	
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
