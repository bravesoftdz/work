if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Commission_CalcGuide]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Commission_CalcGuide]
GO

CREATE  PROCEDURE sp_Commission_CalcGuide

		(
		@IDGuide 	int,
		@DataInicio	SmallDateTime,
		@DataFim	SmallDateTime,
		@Date		DateTime,
		@IsPre		bit,
		@IDTouristGroup	int,
		@Commission	money	output,
		@Divida 	money	output
		)
AS

/* --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

	SUMARIO

		- Calcula a comissao do Guia
		- Calcula a divida do Guia


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	19 June 2001   		Eduardo Costa		Criação;
	20 Feb 2008   		Rodrigo Costa		Incluido calculo de comissao do pedido;
    --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */


if not (@IDGuide > 0)
   return


-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 	Calcula a comissao do Guia
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


-- Lembrar de caso esteja setado no grupo, descontar a coordenacao da agencia da comissao do guia
IF @IsPre = 0
BEGIN

	SELECT
		@Commission = IsNull(SUM(IsNull(C.MovCommission * (1-(TG.ComissaoSobreGuia*TG.DescontaCoordenacao/100)),0)),0)
	FROM
		TouristGroup TG (NOLOCK)
		JOIN Invoice I (NOLOCK)
			ON (TG.IDTouristGroup = I.IDTouristGroup)
		JOIN Pessoa PG (NOLOCK)
			ON (TG.IDGuide = PG.IDPessoa)
		JOIN vwCommission C (NOLOCK)
			ON (I.IDInvoice = C.DocumentID AND C.InventMovTypeID=1 AND C.IDTipoPessoa = PG.IDTipoPessoa)
	WHERE
		TG.IDLancPagGuia IS NULL
		AND
		TG.IDGuide = @IDGuide
		AND
		I.InvoiceDate >= @DataInicio
		AND
		I.InvoiceDate < @DataFim

END
ELSE
BEGIN

	SELECT
		@Commission = IsNull(SUM(IsNull(C.MovCommission * (1-(TG.ComissaoSobreGuia*TG.DescontaCoordenacao/100)),0)),0)
	FROM
		TouristGroup TG (NOLOCK)
		JOIN Invoice I (NOLOCK)
			ON (TG.IDTouristGroup = I.IDTouristGroup)
		JOIN Pessoa PG (NOLOCK)
			ON (TG.IDGuide = PG.IDPessoa)
		JOIN vwCommission C (NOLOCK)
			ON (I.IDInvoice = C.DocumentID AND C.InventMovTypeID=1 AND C.IDTipoPessoa = PG.IDTipoPessoa)
	WHERE
		TG.IDLancPagGuia IS NULL
		AND
		TG.IDGuide = @IDGuide
		AND
		I.PreSaleDate >= @DataInicio
		AND
		I.PreSaleDate < @DataFim


	SELECT
		@Commission = @Commission + IsNull(SUM(IsNull(C.ItemCommis * (1-(TG.ComissaoSobreGuia*TG.DescontaCoordenacao/100)),0)),0)
	FROM
		TouristGroup TG (NOLOCK)
		JOIN Invoice I (NOLOCK)
			ON (TG.IDTouristGroup = I.IDTouristGroup)
		JOIN Pessoa PG (NOLOCK)
			ON (TG.IDGuide = PG.IDPessoa)
		JOIN vwSaleItem C (NOLOCK)
			ON (I.IDPreSale = C.DocumentID AND C.Invoice = 0 AND C.IDTipoPessoa = PG.IDTipoPessoa)
	WHERE
		TG.IDLancPagGuia IS NULL
		AND
		TG.IDGuide = @IDGuide
		AND
		I.PreSaleDate >= @DataInicio
		AND
		I.PreSaleDate < @DataFim

END

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 	Calcula a divida do Guia
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

EXEC sp_Commission_CalcDivida @IDGuide, @Date, @Divida

GO
