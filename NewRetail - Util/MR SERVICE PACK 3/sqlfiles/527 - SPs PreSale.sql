if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_RemoveDiscountItem]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_RemoveDiscountItem]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_RemoveItem]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_RemoveItem]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_SpecialPriceManager]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_SpecialPriceManager]
GO

CREATE PROCEDURE sp_PreSale_RemoveDiscountItem
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
	Sal_Discount
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
	Invoice
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
	Param
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

CREATE PROCEDURE sp_PreSale_RemoveItem
			( 
			@PreSaleID 		int,
			@ModelID		int,
			@UserID 		int,
			@PreInventMovID	int,
			@Discount		money,
			@SalePrice		money,
			@Qty			float,
			@Date			DateTime,
			@ResetDiscount	bit  	= 0,
			@Manager		bit	= 0,
			@SellBelowCost		bit	= 0
			)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Testa se o discount total ainda e valido
		- Efetivamente remove o inventory moviment

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em exec @Result = sp_PreSale_SubTestDiscount
		-202  Erro em exec sp_PreSale_SubResetDiscount
		-203  Erro em Delecao do PreSerialMov
		-204  Erro em exec @result = sp_PreSale_SubRemoveItem
		-205  Erro em exec sp_PreSale_RemoveDiscountItem
		-206  Erro em exec sp_PreSale_SubCalcTotal


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
	26 June 2001		Davi Gouveia		Log de Return Values
	18 Aug  2004		Rodrigo Costa		Gravar error log
	06 Apr	2006		Leonardo Riego		Inclusão da chamada a sp_PreSale_RemoveDiscountItem
	16 Jun	2006		Rodrigo Costa		Adicionado os parametros para ErrorHistory
	18 Aug	2006		Rodrigo Costa		Novo parametro para aplicar desconto inferior ao custo
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */


DECLARE @Result  	int 
DECLARE @Value	money
DECLARE @ErrorLevel	int
DECLARE @SysError	int

SET @ErrorLevel = 0

/*------------------------------------------------------------------------------*/
/*                Testa se o discount total ainda e valido                      */
/*------------------------------------------------------------------------------*/ 

SELECT @Value = IsNull((@Qty * @SalePrice), 0) 

if @Manager = 0
   begin
 
	exec @Result = sp_PreSale_SubTestDiscount
						@PreSaleID,
						@ModelID,
						@UserID,
						@Discount,
						@Value,
						'E'
 	
	SET @SysError = @@ERROR
	IF @SysError <> 0
 	BEGIN
 		PRINT '-201'
 		RETURN -201
 	END

 	if @ResetDiscount = 1 and @Result <> 0
	   begin
		exec sp_PreSale_SubResetDiscount	@PreSaleID
		SET @SysError = @@ERROR
		IF @SysError <> 0
		BEGIN
 			PRINT '-202'
 			RETURN -202
 		END
	   end
	else
	   begin
		if @Result <> 0
		   begin
 			Return @Result
		   end
	   end
   end

/*-------------------------------------------------------------*/
/*          Efetivamente remove o inventory moviment           */
/*-------------------------------------------------------------*/ 
begin tran
 
/*--------------------------------------------------------------*/
/*		Delecao do PreSerialMov	        */
/*--------------------------------------------------------------*/
DELETE
	PSM
FROM
	PreSerialMov PSM
WHERE
	PSM.PreInventoryMovID =  @PreInventMovID

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -203
	GOTO ERRO
END

exec @result = sp_PreSale_SubRemoveItem	@PreInventMovID

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -204
	GOTO ERRO
END

exec @result = sp_PreSale_RemoveDiscountItem @PreSaleID, @PreInventMovID, @Date 	

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -205
	GOTO ERRO
END  
 
if @Result <> 0
begin
	SET @ErrorLevel = @Result
	GOTO ERRO
end
else
begin
	exec sp_PreSale_SubCalcTotal @PreSaleID, @Date
	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		SET @ErrorLevel = -206
		GOTO ERRO
	END
end

OK:
	COMMIT TRAN
	RETURN @Result
ERRO:
	ROLLBACK TRAN
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(510)
	DECLARE @Params varchar(500)	
	SET @Params = ' [ @ModelID = ' + CAST(@ModelID AS VARCHAR) + ' @UserID = '  + CAST(@UserID AS VARCHAR) + 
			' @PreInventMovID = '  + CAST(@PreInventMovID AS VARCHAR) +  ' ] '
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR) + @Params

	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PreSale_RemoveItem', @ErrorLevelStr

	RETURN @ErrorLevel
GO

CREATE  PROCEDURE sp_PreSale_SpecialPriceManager
		(
			@PreSaleID 	int,
			@PercDiscount 	Float,
			@Date 		DateTime,
			@ExemptTax	bit,
			@SellBelowCost	bit = 0
		)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Atualizo PreInventoryMov
		- Atualizo Invoice

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em UPDATE PreInventoryMov
		-202  Erro em UPDATE Invoice
		-203  Erro em exec sp_PreSale_SubCalcTotal


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
	26 June 2001		Davi Gouveia		Log de Return Values
	18 Aug 	2004		Rodrigo Costa		Gravar error log
	24 Mar	2005		Rodrigo Costa		Novo campo de @ExemptTax para isentar os impostos
	18 Aug	2006		Rodrigo Costa		Criado a opcao para vender com o valor inferior ao custo
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

DECLARE @ErrorLevel	int 
DECLARE @SysError	int

SET @ErrorLevel = 0 
BEGIN TRAN

IF (@SellBelowCost = 0)
BEGIN
UPDATE
	PreInventoryMov SET
	PreInventoryMov.Discount =
        				ROUND(
						IsNull (
							(
							SELECT  ( PreInventoryMov.SalePrice * @PercDiscount / 100) * PreInventoryMov.Qty
		                        		FROM 	Model Model
                                        		WHERE   PreInventoryMov.ModelID = Model.IDModel
								AND
                                        			Model.VendorCost <= ( PreInventoryMov.SalePrice - ( PreInventoryMov.SalePrice  * @PercDiscount / 100) )
		                        				), 0) 
					,2)
WHERE
	PreInventoryMov.DocumentID = @PreSaleID
	AND
       	PreInventoryMov.InventMovTypeID = 1
END
ELSE
BEGIN

UPDATE
	PreInventoryMov SET
	PreInventoryMov.Discount =
        				ROUND(
						IsNull (
							(
							SELECT  ( PreInventoryMov.SalePrice * @PercDiscount / 100) * PreInventoryMov.Qty
		                        		FROM 	Model Model
                                        		WHERE   PreInventoryMov.ModelID = Model.IDModel), 
							0),
				2)
WHERE
	PreInventoryMov.DocumentID = @PreSaleID
	AND
       	PreInventoryMov.InventMovTypeID = 1

END

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END

UPDATE
	Invoice
SET
	Invoice.SpecialPriceID = Null,
	Invoice.TaxIsent = @ExemptTax
WHERE
	Invoice.IDPreSale = @PreSaleID 

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -202
	GOTO ERRO
END

exec sp_PreSale_SubCalcTotal @PreSaleID, @Date

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -203
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
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PreSale_SpecialPriceManager', @ErrorLevelStr

	RETURN @ErrorLevel
GO
