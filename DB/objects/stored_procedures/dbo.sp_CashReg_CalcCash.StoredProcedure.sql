SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_CashReg_CalcCash]
		(
		@IDCashRegMov	int,
		@TotalCash		money output
		)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO
		
		- Setando @SaleCash
		- Setando @CashierCash
		- Calculando @TotalCash


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	26 May 2000		Eduardo Costa		suporte ao novo financeiro.
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */


DECLARE @SaleCash		money
DECLARE @CashierCash	money

-- Setando @SaleCash

SELECT @SaleCash = 		(
				SELECT
					SUM( L.ValorNominal)
				FROM
					Fin_Lancamento L (NOLOCK)
					JOIN 
					Invoice I (NOLOCK) ON (L.IDPreSale = I.IDPreSale AND I.IDInvoice IS NOT NULL)
				WHERE
					I.CashRegMovID = @IDCashRegMov
					AND 		
					L.IDQuitacaoMeioPrevisto = 1
				)


-- Setando @CashierCash

SELECT @CashierCash = 	(
				SELECT 	
					SUM( ( 2 * CRTL.Entrando - 1 )  * CRL.TotalCash )
				FROM
					CashRegLog CRL (NOLOCK)
					JOIN 
					CashRegTipoLog CRTL (NOLOCK) ON ( CRL.IDCashRegTipoLog = CRTL.IDCashRegTipoLog )
				WHERE
					CRL.IDCashRegMov = @IDCashRegMov
					AND
					CRTL.Movimenta = 1 
				)

-- Calculando @TotalCash

SELECT @TotalCash = IsNull(@SaleCash, 0) + IsNull(@CashierCash, 0)
GO
