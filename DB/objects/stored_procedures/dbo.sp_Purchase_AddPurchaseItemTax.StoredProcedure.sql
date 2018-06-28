SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_Purchase_AddPurchaseItemTax]
		(
		@IDVendor      		int,
		@IDPurchaseItem	int,
		@IDPurchase		int
 		)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Insert on Pur_PurchaseItemTax

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Insert on Pur_PurchaseItemTax


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	10 Dec  2000		Rodrigo Costa		Criacao;
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */


DECLARE @ErrorLevel	int
DECLARE @SysError	int

--Declaração de variáveis para o Cursor de PurchaseItem
DECLARE @IDPurchaseItemTax		int 
DECLARE @IDVendorTax  		int
DECLARE @IDTaxCategory  		int

SET @ErrorLevel = 0

BEGIN TRAN


/*****************************************************************************************
	Inclusão dos impostos no item
******************************************************************************************/

--Declaração do Cursor de PurchaseItem

DECLARE PurchaseItem_Cursor CURSOR FOR

	SELECT
		VT.IDVendorTax,
		VT.IDTaxCategory
	FROM
		VendorTax VT (NOLOCK) 
	WHERE
		VT.IDPessoa = @IDVendor


OPEN PurchaseItem_Cursor 

--Inicialização de PurchaseItem_Cursor
FETCH NEXT FROM PurchaseItem_Cursor INTO
	@IDVendorTax,
	@IDTaxCategory

--Enquanto tem registros
WHILE
@@FETCH_STATUS = 0
BEGIN
	EXEC sp_Sis_GetNextCode'Pur_PurchaseItemTax.IDPurchaseItemTax', @IDPurchaseItemTax OUTPUT

	INSERT dbo.Pur_PurchaseItemTax
	(
	IDPurchaseItemTax,
	IDPurchaseItem,
	IDVendorTax,
	TaxValue,
	TaxPercentage,
	IDPurchase
	)
	SELECT
		@IDPurchaseItemTax,
		@IDPurchaseItem,
		@IDVendorTax,
		0,
	 	TG.Tax,
		@IDPurchase
	FROM
		TaxCategory TG (NOLOCK) 
	WHERE
		TG.IDTaxCategory = @IDTaxCategory

	SET @SysError = @@ERROR
	IF @SysError <> 0 
	BEGIN
		CLOSE PurchaseItem_Cursor
		DEALLOCATE PurchaseItem_Cursor
		SET @ErrorLevel = -201
		GOTO ERRO
	END

	--Leitura do Proximo 
	FETCH NEXT FROM PurchaseItem_Cursor INTO
		@IDVendorTax,
		@IDTaxCategory

END
--fechamento do cursor
CLOSE PurchaseItem_Cursor

--Destruição do cursor
DEALLOCATE PurchaseItem_Cursor


OK:
	COMMIT TRAN
	RETURN 0

ERRO:
	PRINT CAST(@ErrorLevel AS VARCHAR)
	ROLLBACK TRAN

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_Purchase_AddPurchaseItemTax', @ErrorLevelStr

	RETURN @ErrorLevel
GO
