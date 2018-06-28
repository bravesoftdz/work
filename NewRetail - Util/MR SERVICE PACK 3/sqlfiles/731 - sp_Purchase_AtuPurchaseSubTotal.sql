if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Purchase_AtuPurchaseSubTotal]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Purchase_AtuPurchaseSubTotal]
GO

CREATE  PROCEDURE sp_Purchase_AtuPurchaseSubTotal
	(
	@IDPurchase	int,
	@TaxInCost	bit
	)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Teste se ja existe a tabela de SubTotal
		- Atualizo o SubTotal do Purchase

	OBS
		Devido a um BUG do BDE, tenho que guardar o total do purchase em uma tabela separada,
		espero um dia, quando o bug for resolvido, voltar ao código original e remover a tabela desnecessaria.

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Teste se o purchase ja esta na tabela
		-202  Erro em Atualizo o SubTotal


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	04 Dec	2000		Eduardo Costa		Criação;
	26 Jun	2001		Davi Gouveia		Log de Return Values
	18 Aug	2004		Rodrigo Costa		Gravar error log
	05 Jan	2005		Rodrigo Costa		Somar os impostos totais que tem a opcao adcionar
	22 Mar	2006		Maximiliano Muniz	Somar os fretes totais
	03 Aug  2006		Leonardo Riego		Soma do valor total do Purchase não é feita direto na tabela de itens. 
							(Quando o Purchase não tinha mais itens o retorno do select era nulo)
							(o que gerava erro no Purchase com valor no SubTotal sem itens )	
	24 Aug	2007		Rodrigo Costa		Estava somando o campo de custo errado no total da compra.
							Somando NewCostPrice * Qty ... tinha que somar o CostPrice
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

DECLARE @ErrorLevel		int
DECLARE @SysError		int
DECLARE @TaxTotal		float
DECLARE @TaxTotalRet		float

SET @ErrorLevel = 0

BEGIN TRAN


------------------------------------------------------------------------------
-- Teste se o purchase ja esta na tabela

IF NOT EXISTS (SELECT SubTotal FROM Pur_PurchaseTotal WHERE IDPurchase = @IDPurchase)
	INSERT Pur_PurchaseTotal (IDPurchase, SubTotal, SubTotalRet) VALUES (@IDPurchase, 0, 0)

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END


------------------------------------------------------------------------------
-- Atualizo o SubTotal
IF (@TaxInCost=1)
BEGIN

	--Somar os impostos totais que tem a opcao adcionar
	
	SELECT 
		@TaxTotal = SUM(IsNull(PIT.TaxValue,0))
	FROM 
		Pur_PurchaseItemTax PIT
		LEFT OUTER JOIN VendorTax VT ON (VT.IDVendorTax = PIT.IDVendorTax)
		LEFT OUTER JOIN TaxCategory CT ON (CT.IDTaxCategory = VT.IDTaxCategory)
	WHERE
		PIT.IDPurchase = @IDPurchase
		AND
		CT.Debit = 0

	--Somar os impostos totais que tem a opcao adcionar de Retorno
	SELECT 
		@TaxTotalRet = SUM(IsNull(PIT.TaxValue,0))
	FROM 
		Pur_PurchaseItemTaxRet PIT
		LEFT OUTER JOIN VendorTax VT ON (VT.IDVendorTax = PIT.IDVendorTax)
		LEFT OUTER JOIN TaxCategory CT ON (CT.IDTaxCategory = VT.IDTaxCategory)
	WHERE
		PIT.IDPurchase = @IDPurchase
		AND
		CT.Debit = 0

	
	UPDATE
		P
	SET
		P.SubTotal = (PT.SubTotal + IsNull(@TaxTotal,0)),
		P.SubTotalRet = (PT.SubTotalRet + IsNull(@TaxTotalRet,0))
	FROM
		Pur_PurchaseTotal P -- Quando o bug for resolvido trocar a tabela e remover o codigo acima
		JOIN (
			SELECT
				PU.IDPurchase,
				SUM(IsNull(PPI.CostPrice,0)) as SubTotal,
				SUM(IsNull(PPI.CostPriceRet,0)) as SubTotalRet
			FROM
				Pur_Purchase PU
				LEFT JOIN Pur_PurchaseItem PPI ON (PU.IDPurchase = PPI.IDPurchase)
			WHERE
				PU.IDPurchase = @IDPurchase
			GROUP BY
				PU.IDPurchase
		) as PT ON (P.IDPurchase = PT.IDPurchase)


	UPDATE
		P
	SET
		P.Freight = PT.Freight,
		P.OtherCharges = PT.Other,
		P.FreightRet = PT.FreightRet,
		P.OtherChargesRet = PT.OtherRet	FROM
		Pur_Purchase P -- Quando o bug for resolvido trocar a tabela e remover o codigo acima
		JOIN (
			SELECT
				PPI.IDPurchase,
				SUM(IsNull(PPI.FreightCost, 0)) as Freight,
				SUM(IsNull(PPI.OtherCost, 0)) as Other,
				SUM(IsNull(PPI.FreightCostRet, 0)) as FreightRet,
				SUM(IsNull(PPI.OtherCostret, 0)) as OtherRet
			FROM
				Pur_PurchaseItem PPI
			WHERE
				PPI.IDPurchase = @IDPurchase
			GROUP BY
				PPI.IDPurchase
		) as PT ON (P.IDPurchase = PT.IDPurchase)

END
ELSE

BEGIN
	UPDATE
		P
	SET
		P.SubTotal = PT.SubTotal,
		P.SubTotalRet = PT.SubTotalRet 
	FROM
		Pur_PurchaseTotal P -- Quando o bug for resolvido trocar a tabela e remover o codigo acima
		JOIN (
	
			SELECT
				PU.IDPurchase,
				SUM(IsNull(PPI.NewCostPrice * PPI.Qty, 0)) as SubTotal,
				SUM(IsNull(PPI.NewCostPriceRet * PPI.Qty, 0)) as SubTotalRet
			FROM
				Pur_Purchase PU
				LEFT JOIN Pur_PurchaseItem PPI ON (PU.IDPurchase = PPI.IDPurchase)
			WHERE
				PU.IDPurchase = @IDPurchase
			GROUP BY
				PU.IDPurchase
	
		) as PT ON (P.IDPurchase = PT.IDPurchase)
END

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -202
	GOTO ERRO
END



OK:
	COMMIT TRAN
	RETURN 0

ERRO:
	ROLLBACK TRAN
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_Purchase_AtuPurchaseSubTotal', @ErrorLevelStr

	RETURN @ErrorLevel
GO
