SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_Commission_CalcOther]

		(
		@IDOtherComission	int,
		@DataInicio		SmallDateTime,
		@DataFim		SmallDateTime,
		@Commission		money	output,
		@Extorno 		money	output,
		@Correcao 		money	output
		)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Calcula a comissao do Vendedor
		- Calcula o Extorno do Vendedor
		- Calcula o Credito do Vendedor


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	26 May  2000		Eduardo Costa		suporte ao novo financeiro
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */



if not (@IDOtherComission > 0)
   return

/*------------------------------------------------------------------------------*/
/*	   Calcula a comissao do Vendedor	*/ /*------------------------------------------------------------------------------*/
SELECT
	@Commission =  IsNull(SUM(IsNull(C.MovCommission,0)),0)
FROM
	Invoice I (NOLOCK)
	JOIN Media M (NOLOCK) 
		ON (I.MediaID = M.IDMedia)
	JOIN vwCommission C (NOLOCK) 
		ON (I.IDInvoice = C.DocumentID AND C.InventMovTypeID=1)
	JOIN Pessoa P (NOLOCK) 
		ON (M.IDOtherCommission = P.IDPessoa AND C.IDTipoPessoa = P.IDTipoPessoa)

WHERE
	I.OtherComissionID = @IDOtherComission
	AND
	I.InvoiceDate >= @DataInicio
	AND
	I.InvoiceDate < @DataFim
	AND
	I.IDLancPagOtherCom IS NULL

/*------------------------------------------------------------------------------*/
/*  Calcula o Extorno do Vendedor		*/
/*------------------------------------------------------------------------------*/
SELECT	@Extorno = IsNull(
			(
			SELECT 	SUM ( L.ValorNominal - L.TotalQuitado)

			FROM 		Fin_Lancamento L (NOLOCK)

			WHERE	L.IDPessoa = @IDOtherComission
					AND
					L.Situacao in (1,5)  --  1=Aberto, 5=ParteQuitado
					AND
					L.IDLancamentoTipo = 3    -- \\Despesas\Extorno de Comissao
			), 0)


/*------------------------------------------------------------------------------*/
/*  Calcula o Credito do Vendedor	 		*/
/*------------------------------------------------------------------------------*/
SELECT	@Correcao = IsNull(
			(
			SELECT 	SUM ( L.ValorNominal - L.TotalQuitado)

			FROM 		Fin_Lancamento L (NOLOCK)

			WHERE	L.IDPessoa = @IDOtherComission
					AND
					L.Situacao in (1,5)  --  1=Aberto, 5=ParteQuitado
					AND
					L.IDLancamentoTipo = 5    -- \\Despesas\Correcao de comissao
			), 0)
GO
