SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_Purchase_AddPurchaseItemTaxRet]
		(		
		@IDPurchaseItem	int
 		)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO
		- Exclui os Pur_PurchaseItemTaxRet para o @IDPurchaseItem
		- Copia os Pur_PurchaseItemTax para Pur_PurchaseItemTaxRet

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Copia os Pur_PurchaseItemTax para Pur_PurchaseItemTaxRet
		-202  Erro em Exclui os Pur_PurchaseItemTaxRet para o @IDPurchaseItem


	LOG DE MODIFICA??ES

	Data			Programador		Modifica??o
	----------------------- ----------------------- -------------------------------------------------------------------------------------------------------------------------------------------------
	10 Mar  2005		Carlos Lima		Criacao;
	----------------------- -------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */


DECLARE @ErrorLevel	int
DECLARE @SysError	int

--Declara??o de vari?veis para o Cursor de PurchaseItemTaxRet
DECLARE @IDPurchaseItemTaxRet	int
DECLARE @IDVendorTax		int
DECLARE @TaxValue		money
DECLARE @TaxPercentage		money
DECLARE @IDPurchase		int

SET @ErrorLevel = 0

BEGIN TRAN


/*****************************************************************************************
	Exclui os Pur_PurchaseItemTaxRet para o @IDPurchaseItem
******************************************************************************************/
DELETE	Pur_PurchaseItemTaxRet
WHERE
	IDPurchaseItem = @IDPurchaseItem

SET @SysError = @@ERROR
IF @SysError <> 0 
BEGIN
	SET @ErrorLevel = -202
	GOTO ERRO
END




/*****************************************************************************************
	Copia os Pur_PurchaseItemTax para Pur_PurchaseItemTaxRet
******************************************************************************************/

--Declara??o do Cursor de PurchaseItemTax

DECLARE PurchaseItemTaxRet_Cursor CURSOR FOR

	SELECT
		IDVendorTax,
		0 as TaxValue,
		TaxPercentage,
		IDPurchase
	FROM
		Pur_PurchaseItemTax (NOLOCK) 
	WHERE
		IDPurchaseItem = @IDPurchaseItem


OPEN PurchaseItemTaxRet_Cursor

--Inicializa??o de PurchaseItemTax_Cursor
FETCH NEXT FROM PurchaseItemTaxRet_Cursor INTO
	@IDVendorTax,
	@TaxValue,
	@TaxPercentage,
	@IDPurchase

--Enquanto tem registros
WHILE
@@FETCH_STATUS = 0
BEGIN
	EXEC sp_Sis_GetNextCode 'Pur_PurchaseItemTaxRet.IDPurchaseItemTaxRet', @IDPurchaseItemTaxRet OUTPUT

	INSERT dbo.Pur_PurchaseItemTaxRet
	(
		IDPurchaseItemTaxRet,
		IDVendorTax,
		TaxValue,
		TaxPercentage,
		IDPurchase,
		IDPurchaseItem

	)
	VALUES
	(
		@IDPurchaseItemTaxRet,
		@IDVendorTax,
		@TaxValue,
		@TaxPercentage,
		@IDPurchase,
		@IDPurchaseItem
	)


	SET @SysError = @@ERROR
	IF @SysError <> 0 
	BEGIN
		CLOSE PurchaseItemTax_Cursor
		DEALLOCATE PurchaseItemTax_Cursor
		SET @ErrorLevel = -201
		GOTO ERRO
	END

	--Leitura do Proximo 
	FETCH NEXT FROM PurchaseItemTaxRet_Cursor INTO
		@IDVendorTax,
		@TaxValue,
		@TaxPercentage,
		@IDPurchase

END
--fechamento do cursor
CLOSE PurchaseItemTaxRet_Cursor

--Destrui??o do cursor
DEALLOCATE PurchaseItemTaxRet_Cursor


OK:
	COMMIT TRAN
	RETURN 0

ERRO:
	PRINT CAST(@ErrorLevel AS VARCHAR)
	ROLLBACK TRAN

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_Purchase_AddPurchaseItemTaxRet', @ErrorLevelStr

	RETURN @ErrorLevel
GO
