SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_PreSale_quQtyOnStore]
	(
	@ModelID int
	)
AS

/* ---------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Retorna Qtde do Model por Loja

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro no Select


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	-----------------------	-----------------------	----------------------------------------------------------------------------------
	15 May	2000		Eduardo Costa		Criacao;
	26 Jun	2001		Davi Gouveia		Log de Return Values;
	18 Aug	2004		Rodrigo Costa		Gravar error log;
	19 Nov	2004		Rodrigo Costa		Novo Campo Model.FloatPercent;
	28 Aug			Maximiliano Muniz	Melhorando performance do SELECT;
	---------------------------------------------------------------------------------------------------------------------------------- */

DECLARE @ErrorLevel	int
DECLARE @SysError	int

SET @ErrorLevel = 0

SELECT
	S.[Name],
	I.QtyOnPreSale,
	I.QtyOnHand,
	I.QtyOnOrder,
	I.QtyOnRepair,
	I.MinQty,
	I.MaxQty,
	I.StoreID,
	(M.VendorCost + M.OtherCost + M.FreightCost) CurrentCost,
	I.QtyOnPrePurchase,
	M.FloatPercent
FROM
	Inventory I (NOLOCK)
	JOIN Model M (NOLOCK) ON (I.ModelID = M.IDModel)
	JOIN Store S (NOLOCK) ON (I.StoreID = S.IDStore)
WHERE
	I.ModelID = @ModelID

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END

OK:
	RETURN 0
ERRO:
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PreSale_quQtyOnStore', @ErrorLevelStr

	RETURN @ErrorLevel
GO
