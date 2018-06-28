SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_Pessoa_CalcSaldos]

			(
			@IDPessoa 	int,
			@CalcDate	DateTime
			)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Calcula Saldo Vencido e a Vencer baseado em uma determinada data


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

SELECT 	IsNull(	(
		SELECT
 			Sum(ValorPrevisto - ValorQuitado)
 		FROM
			dbo.Lancamento (NOLOCK) 
		WHERE
			(Situacao = 'N')
			AND
			(IDPessoa = @IDPessoa)
			AND
			(DataVencimento <= @CalcDate)
		), 0) as SaldoVencido,
 
	IsNull(	(
		SELECT
			Sum(ValorPrevisto - ValorQuitado)
		FROM
			dbo.Lancamento (NOLOCK) 
		WHERE
			(Situacao = 'N')
			AND
			(IDPessoa = @IDPessoa)
			AND
			(DataVencimento > @CalcDate)
		),0)  as SaldoAVencer
GO
