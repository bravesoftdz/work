SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_Comission_CalcPayDate]
		(
		@IDComissionado	int,
		@InvoiceDate 		smalldatetime,
		@DataPagamento 	smalldatetime output
		)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Teste de Mes seguinte
		- Troca o dia


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Rodrigo Costa		Criacao;
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */


DECLARE @DiaPagamento 	int
DECLARE @DiaInvoice   	int

SELECT @DiaPagamento = ( SELECT DiaPagamento FROM dbo.vwComissionado (NOLOCK) WHERE IDComissionado = @IDComissionado )

SELECT @DiaInvoice = DATEPART(day, @InvoiceDate)

SELECT @DataPagamento = @InvoiceDate

/*	Teste de Mes seguinte  */

IF @DiaPagamento < @DiaInvoice
	SELECT @DataPagamento = ( DATEADD(month, 1, @InvoiceDate) )

/*	Troca o dia      */

SELECT @DataPagamento = ( DATEADD(day, (@DiaPagamento-@DiaInvoice), @DataPagamento) )

RETURN
GO
