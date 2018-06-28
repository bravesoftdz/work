SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_PreSale_RemoveDiscountItem]
			( 
			@IDPreSale 		int,
			@IDPreInventMov	int,
			@Date 			DateTime,
			@SellBelowCost		bit = 0
			)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Testa se possui Item de Desconto 
		- Delecao do item de Desconto
		- Guarda o valor do desconto no Invoice
		- Atualização do Desconto na Nota

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro ao guardar o valor do desconto do item
		-202  Erro em Delecao do item de Desconto
		-203  Erro ao guardar o valor do desconto do invoice
		-205  Erro ao guardar o valor do parametro TAX_EXEMPT_ON_SALE  
		-205  Erro em Atualizar o Desconto na Nota 
		


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	5  Apr  2006		Leonardo Riego		Criacao;
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */


DECLARE @ItemDiscount	  money
DECLARE @InvoiceDiscount  money
DECLARE @NewDiscountValue money
DECLARE @TaxinSale      bit
DECLARE @ErrorLevel	int
DECLARE @SysError	int

SET @ErrorLevel = 0

BEGIN TRAN

/*------------------------------------------------------------------------------*/
/*                Testa se possui Item de Desconto                              */
/*------------------------------------------------------------------------------*/ 

SELECT
	@ItemDiscount = Discount
FROM
	Sal_Discount (NOLOCK) 
WHERE
	IDPreSale = @IDPreSale
	AND
	IDPreInventoryMov = @IDPreInventMov

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	PRINT 'ERRO -201'
	SET @ErrorLevel = -201
	GOTO ERRO
END

/*------------------------------------------------------------------------------*/
/*                Delecao do item de Desconto                              */
/*------------------------------------------------------------------------------*/ 

DELETE FROM
	Sal_Discount
WHERE
	IDPreSale = @IDPreSale
	AND
	IDPreInventoryMov = @IDPreInventMov

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	PRINT 'ERRO -202'
	SET @ErrorLevel = -202
	GOTO ERRO
END

/*------------------------------------------------------------------------------*/
/*                Guarda o valor do desconto no Invoice                         */
/*------------------------------------------------------------------------------*/ 

SELECT
	@InvoiceDiscount = ItemDiscount
FROM
	Invoice (NOLOCK) 
WHERE
	IDPreSale = @IDPreSale
	
SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	PRINT 'ERRO -203'
	SET @ErrorLevel = -203
	GOTO ERRO
END

/*------------------------------------------------------------------------------*/
/*                Guarda o valor do parametro TAX_EXEMPT_ON_SALE                */
/*------------------------------------------------------------------------------*/ 

SELECT
	@TaxinSale = CASE WHEN SrvValue = 'TRUE' THEN 1
			  	ELSE  0
			END
FROM
	Param (NOLOCK) 
WHERE
	IDParam = 64
	

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	PRINT 'ERRO -204'
	SET @ErrorLevel = -204
	GOTO ERRO
END

/*------------------------------------------------------------------------------*/
/*                Atualização do Desconto na Nota                              */
/*------------------------------------------------------------------------------*/ 
IF (@ItemDiscount <> 0)
BEGIN

exec sp_PreSale_SpecialPriceManager @IDPreSale, 0, @Date, @TaxinSale, @SellBelowCost

SET @NewDiscountValue = @InvoiceDiscount - @ItemDiscount

exec sp_PreSale_SpecialPriceManager @IDPreSale, @NewDiscountValue, @Date, @TaxinSale, @SellBelowCost

END

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	PRINT 'ERRO -205'
	SET @ErrorLevel = -205
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
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PreSale_RemoveDiscountItem', @ErrorLevelStr

	RETURN @ErrorLevel
GO
