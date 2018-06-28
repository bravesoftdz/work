SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[sp_Commission_CalcVendedor]
		(
		@IDVendedor	int,
		@DataInicio	SmallDateTime,
		@DataFim	SmallDateTime,
		@IsPre		bit,
		@IsPaid		bit,
		@Commission	money output,
		@Extorno	money output,
		@Correcao	money output
		)
AS

/* ---------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Calcula a comissao do Sales Person
		- Calcula a divida do Vendedor
		- Calcula o Extorno do Vendedor
		- Calcula o Credito do Vendedor


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	-----------------------	-----------------------	----------------------------------------------------------------------------------
	19 Jun	2001		Eduardo Costa		Criação;
	14 Apr	2005		Rodrigo Costa		Calculo de comissao incluindo o PreSale;
	10 Sep	2007		Maximiliano Muniz	Cálculo por pagamento cadastrado;
	---------------------------------------------------------------------------------------------------------------------------------- */

IF NOT (@IDVendedor > 0)
	RETURN

----------------------------------------------------------------------------------
--			Calcula a comissao do Sales Person			--
----------------------------------------------------------------------------------
-- Lembrar de caso esteja setado no grupo, descontar a coordenacao da agencia da comissao do guia

IF @IsPre = 0
BEGIN
	SELECT
		@Commission = IsNull(SUM(IsNull(C.MovCommission * M.PayComission, 0)), 0)
	FROM
		Invoice I (NOLOCK)
		JOIN Media M (NOLOCK) ON (I.MediaID = M.IDMedia)
		JOIN vwCommission C (NOLOCK) ON (C.InventMovTypeID = 1 AND I.IDInvoice = C.DocumentID)
		JOIN Pessoa PSP (NOLOCK) ON (C.ComissionID = PSP.IDPessoa AND C.IDTipoPessoa = PSP.IDTipoPessoa)
		LEFT OUTER JOIN ComisPaga CP (NOLOCK) ON (C.IDPreInventoryMov = CP.IDDocumento AND CP.IDPessoa = @IDVendedor)
	WHERE
		C.ComissionID = @IDVendedor
		AND I.InvoiceDate >= @DataInicio
		AND I.InvoiceDate < @DataFim
		AND CP.IDLancPag IS NULL
		AND IsNull(I.Canceled, 0) = 0
END
ELSE
BEGIN
	IF @IsPaid = 0
	BEGIN
		SELECT
			@Commission = IsNull(SUM(IsNull(C.MovCommission * M.PayComission, 0)), 0)
		FROM
			Invoice I (NOLOCK)
			JOIN Media M (NOLOCK) ON (I.MediaID = M.IDMedia)
			JOIN vwCommission C (NOLOCK) ON (C.InventMovTypeID = 1 AND I.IDInvoice = C.DocumentID)
			JOIN Pessoa PSP (NOLOCK) ON (C.ComissionID = PSP.IDPessoa AND C.IDTipoPessoa = PSP.IDTipoPessoa)
			LEFT OUTER JOIN ComisPaga CP (NOLOCK) ON (C.IDPreInventoryMov = CP.IDDocumento AND CP.IDPessoa = @IDVendedor)
		WHERE
			C.ComissionID = @IDVendedor
			AND I.PreSaleDate >= @DataInicio
			AND I.PreSaleDate < @DataFim
			AND CP.IDLancPag IS NULL
			AND IsNull(I.Canceled, 0) = 0

		SELECT
			@Commission = @Commission + IsNull(SUM(IsNull(C.ItemCommis * M.PayComission,0)), 0)
		FROM
			Invoice I (NOLOCK)
			JOIN Media M (NOLOCK) ON (I.MediaID = M.IDMedia)
			JOIN vwSaleItem C (NOLOCK) ON (I.IDPreSale = C.DocumentID AND C.Invoice = 0)
			JOIN Pessoa PSP (NOLOCK) ON (C.ComissionID = PSP.IDPessoa AND C.IDTipoPessoa = PSP.IDTipoPessoa)
			LEFT OUTER JOIN ComisPaga CP (NOLOCK) ON (C.IDPreInventoryMov = CP.IDDocumento AND CP.IDPessoa = @IDVendedor)
		WHERE
			C.ComissionID = @IDVendedor
			AND I.PreSaleDate >= @DataInicio
			AND I.PreSaleDate < @DataFim
			AND CP.IDLancPag IS NULL
			AND IsNull(I.Canceled, 0) = 0
	END
	ELSE
	BEGIN
		SELECT
			@Commission = IsNull(SUM(IsNull(C.MovCommission * M.PayComission, 0)), 0)
		FROM
			Invoice I (NOLOCK)
			JOIN Media M (NOLOCK) ON (I.MediaID = M.IDMedia)
			JOIN vwCommission C (NOLOCK) ON (C.InventMovTypeID = 1 AND I.IDInvoice = C.DocumentID)
			JOIN Pessoa PSP (NOLOCK) ON (C.ComissionID = PSP.IDPessoa AND C.IDTipoPessoa = PSP.IDTipoPessoa)
			LEFT OUTER JOIN ComisPaga CP (NOLOCK) ON (C.IDPreInventoryMov = CP.IDDocumento AND CP.IDPessoa = @IDVendedor)
		WHERE
			C.ComissionID = @IDVendedor
			AND I.PreSaleDate >= @DataInicio
			AND I.PreSaleDate < @DataFim
			AND CP.IDLancPag IS NULL
			AND IsNull(I.Canceled, 0) = 0
			AND I.IDPreSale IN (SELECT IDPreSale FROM Fin_Lancamento)

		SELECT
			@Commission = @Commission + IsNull(SUM(IsNull(C.ItemCommis * M.PayComission,0)), 0)
		FROM
			Invoice I (NOLOCK)
			JOIN Media M (NOLOCK) ON (I.MediaID = M.IDMedia)
			JOIN vwSaleItem C (NOLOCK) ON (I.IDPreSale = C.DocumentID AND C.Invoice = 0)
			JOIN Pessoa PSP (NOLOCK) ON (C.ComissionID = PSP.IDPessoa AND C.IDTipoPessoa = PSP.IDTipoPessoa)
			LEFT OUTER JOIN ComisPaga CP (NOLOCK) ON (C.IDPreInventoryMov = CP.IDDocumento AND CP.IDPessoa = @IDVendedor)
		WHERE
			C.ComissionID = @IDVendedor
			AND I.PreSaleDate >= @DataInicio
			AND I.PreSaleDate < @DataFim
			AND CP.IDLancPag IS NULL
			AND IsNull(I.Canceled, 0) = 0
			AND I.IDPreSale IN (SELECT IDPreSale FROM Fin_Lancamento)
	END
END

--------------------------------------------------------------------------
--			Calcula a divida do Vendedor			--
--------------------------------------------------------------------------

--EXEC sp_Commission_CalcDivida @IDVendedor, @Date, @Divida

--------------------------------------------------------------------------
--			Calcula o Extorno do Vendedor			--
--------------------------------------------------------------------------
SELECT	@Extorno = IsNull((
				SELECT
					SUM (L.ValorNominal - L.TotalQuitado)
				FROM
					Fin_Lancamento L (NOLOCK)
				WHERE
					L.IDPessoa = @IDVendedor
					AND L.Situacao in (1, 5) --1=Aberto, 5=ParteQuitado
					AND L.IDLancamentoTipo = 3 --Despesas\Extorno de Comissao
			), 0)

--------------------------------------------------------------------------
--			Calcula o Credito do Vendedor			--
--------------------------------------------------------------------------
SELECT	@Correcao = IsNull((
				SELECT
					SUM (L.ValorNominal - L.TotalQuitado)
				FROM
					Fin_Lancamento L (NOLOCK)
				WHERE
					L.IDPessoa = @IDVendedor
					AND L.Situacao in (1, 5)  --1=Aberto, 5=ParteQuitado
					AND L.IDLancamentoTipo = 5 --Despesas\Correcao de comissao
			), 0)
GO
