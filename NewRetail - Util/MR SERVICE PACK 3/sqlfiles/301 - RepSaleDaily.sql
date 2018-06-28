DELETE FROM Rep_Field WHERE TableName = 'vw_Rep_CashRegisterFlow'
GO

DELETE FROM Rep_Table WHERE TableName = 'vw_Rep_CashRegisterFlow'
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vwCashRegisterTotalByDate]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vwCashRegisterTotalByDate]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_CashRegisterFlow]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_CashRegisterFlow]
GO


if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vwDailyRepayment]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vwDailyRepayment]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vwDailySales]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vwDailySales]
GO

CREATE VIEW vwDailyRepayment AS
SELECT
	CONVERT(datetime, CONVERT(varchar, CashRegLog.LogTime, 103), 103) AS RepaymentDate,
	SUM(Fin_Lancamento.ValorNominal) RepaymentsValue 
FROM 
	CashregMov 
	INNER JOIN CashRegLog ON
		(CashRegMov.IDCashRegMov = CashRegLog.IDCashRegMov AND CashRegLog.IDCashregTipoLog = 4) 
	INNER JOIN Fin_Lancamento ON
		(CashRegMov.IDCashRegMov = Fin_Lancamento.IDCashRegMovClosed)
WHERE
	Fin_Lancamento.IDLancamentoTipo = 2	
GROUP BY
	CONVERT(datetime, CONVERT(varchar, CashRegLog.LogTime, 103), 103) 
GO

CREATE VIEW vwDailySales AS
	SELECT
		CONVERT(datetime, CONVERT(varchar, I.PreSaleDate, 103), 103) AS SaleDate,
		SUM(ISNULL(I.SubTotal, 0) + ISNULL(I.AditionalExpenses, 0) + ISNULL(I.OtherExpences, 0) - ISNULL(I.ItemDiscount, 0)) AS SalesValue
	FROM
		Invoice I
	WHERE
		I.IDPreSaleParent IS NULL
		AND
		I.Canceled = 0
		AND EXISTS (SELECT IDPreSale FROM Fin_Lancamento WHERE Fin_Lancamento.IDPresale = I.IDPresale)
	GROUP BY
		CONVERT(datetime, CONVERT(varchar, I.PreSaleDate, 103), 103)
GO

CREATE VIEW vw_Rep_CashRegisterFlow AS
SELECT
	AllSales.SaleDate,
	AllSales.SalesValue,
	AllSales.SalesEvenValue,
	ISNULL(DP.RepaymentsValue, 0) AS RepaymentsValue,
	SUM(ISNULL(RepaymentsValueEven, 0)) AS RepaymentsValueEven,
	ISNULL(AllSales.SalesEvenValue, 0) - SUM(ISNULL(RepaymentsValueEven, 0)) /*- 231564.0005*/ AS Saldo

FROM
	(
		SELECT
				AllDates.SaleDate,
				IsNull(DS.SalesValue, 0) AS SalesValue,
				SUM(SalesEven.SalesEvenValue) AS SalesEvenValue
		FROM
			(
				SELECT
					CASE WHEN vwDailySales.SaleDate IS NULL THEN RepaymentDate ELSE vwDailySales.SaleDate END AS SaleDate
				FROM	
					vwDailySales FULL OUTER JOIN vwDailyRepayment on (RepaymentDate = SaleDate)								
				GROUP BY
					CASE WHEN vwDailySales.SaleDate IS NULL THEN RepaymentDate ELSE vwDailySales.SaleDate END
				
			) AS AllDates LEFT JOIN
			vwDailySales DS ON
				(AllDates.SaleDate = DS.SaleDate) LEFT JOIN
			(
				SELECT
					SaleDate,
					SUM(ISNULL(SalesValue, 0)) AS SalesEvenValue
				FROM
					vwDailySales
				GROUP BY
					SaleDate
			) SalesEven ON
				(AllDates.SaleDate >= SalesEven.SaleDate)
			
		GROUP BY
				AllDates.SaleDate,
				DS.SalesValue
	) AllSales LEFT JOIN
	
	vwDailyRepayment DP
		ON (AllSales.SaleDate = DP.RepaymentDate) LEFT JOIN
	(	
		SELECT
			RepaymentDate,
			RepaymentsValue AS RepaymentsValueEven
		FROM
			vwDailyRepayment

	) RepaymentsValueEven ON
		(AllSales.SaleDate >= RepaymentsValueEven.RepaymentDate)
	
GROUP BY
	AllSales.SaleDate,
	AllSales.SalesValue,
	AllSales.SalesEvenValue,
	DP.RepaymentsValue
GO

EXEC sp_Rep_AddTableField 'vw_Rep_CashRegisterFlow'
GO
