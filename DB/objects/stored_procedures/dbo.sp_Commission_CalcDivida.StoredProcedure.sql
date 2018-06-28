SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_Commission_CalcDivida]
			(
			@IDPessoa	int,
			@Date		datetime,
			@Divida	money 	output
			)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Calcula Divida


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	26 May  2000		Eduardo Costa		suporte ao novo financeiro.
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */


SELECT
	@Divida = IsNull(
	(
	SELECT
		SUM( L.ValorNominal - L.TotalQuitado )
	FROM
		Fin_Lancamento L (NOLOCK)
	WHERE
		L.IDPessoa = @IDPessoa
		AND
		L.Situacao in (1,5)  -- 1=Aberto, 5=ParteQuitado
		AND
		L.Pagando = 0
		AND
		L.DataVencimento >= @Date
	), 0)
GO
