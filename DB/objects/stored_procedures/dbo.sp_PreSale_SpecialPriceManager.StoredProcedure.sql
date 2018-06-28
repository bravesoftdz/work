SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_PreSale_SpecialPriceManager]
		(
			@PreSaleID 	int,
			@PercDiscount 	Float,
			@Date 		DateTime,
			@ExemptTax	bit,
			@SellBelowCost	bit = 0,
			@IsPromo	bit = 0
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
		-204  Erro no update que faz a correção do valor de desconto


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
	26 June 2001		Davi Gouveia		Log de Return Values
	18 Aug 	2004		Rodrigo Costa		Gravar error log
	24 Mar	2005		Rodrigo Costa		Novo campo de @ExemptTax para isentar os impostos
	18 Aug	2006		Rodrigo Costa		Criado a opcao para vender com o valor inferior ao custo
	19 Jan  2010		Eliandro Souza		Inclusão o campo DiscountPromo no calculo desconto
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

DECLARE @ErrorLevel	int 
DECLARE @SysError	int

SET @ErrorLevel = 0 
BEGIN TRAN

IF (@SellBelowCost = 0)
BEGIN
UPDATE
	PreInventoryMov SET
	PreInventoryMov.Discount = PreInventoryMov.DiscountPromo + ROUND(
					  IsNull ( ( SELECT  ( PreInventoryMov.SalePrice * @PercDiscount / 100) * PreInventoryMov.Qty
		                        		FROM 	Model Model (NOLOCK) 
                                        		WHERE   PreInventoryMov.ModelID = Model.IDModel
								AND
                                        			Model.VendorCost <= ( PreInventoryMov.SalePrice - ( PreInventoryMov.SalePrice  * @PercDiscount / 100) )
		                        	    ), 0)
					,2),
	PreInventoryMov.DiscountPromo = PreInventoryMov.DiscountPromo + 
						CASE WHEN @IsPromo = 1 THEN
							ROUND(  IsNull ( ( SELECT  ( PreInventoryMov.SalePrice * @PercDiscount / 100) * PreInventoryMov.Qty
					                        		FROM 	Model Model (NOLOCK) 
                        			                		WHERE   PreInventoryMov.ModelID = Model.IDModel
											AND Model.VendorCost <= ( PreInventoryMov.SalePrice - ( PreInventoryMov.SalePrice  * @PercDiscount / 100) )
			                        	        ), 0)
							 ,2)
						ELSE 0 END
WHERE
	PreInventoryMov.DocumentID = @PreSaleID
	AND PreInventoryMov.InventMovTypeID = 1
END
ELSE
BEGIN

UPDATE
	PreInventoryMov SET
	PreInventoryMov.Discount = PreInventoryMov.DiscountPromo +
        				ROUND(
						IsNull (
							(
							SELECT  ( PreInventoryMov.SalePrice * @PercDiscount / 100) * PreInventoryMov.Qty
		                        		FROM 	Model Model (NOLOCK) 
                                        		WHERE   PreInventoryMov.ModelID = Model.IDModel), 
							0),
				2),
	PreInventoryMov.DiscountPromo = PreInventoryMov.DiscountPromo + 
						CASE WHEN @IsPromo = 1 THEN
							ROUND(	IsNull (
								( SELECT  ( PreInventoryMov.SalePrice * @PercDiscount / 100) * PreInventoryMov.Qty
				                        		FROM 	Model Model (NOLOCK) 
                		                        		WHERE   PreInventoryMov.ModelID = Model.IDModel), 
								0),
							2)
						ELSE 0 END

WHERE
	PreInventoryMov.DocumentID = @PreSaleID
	AND PreInventoryMov.InventMovTypeID = 1
END


SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END


UPDATE PreInventoryMov SET Discount = SalePrice * Qty
  WHERE PreInventoryMov.DocumentID = @PreSaleID
	AND PreInventoryMov.InventMovTypeID = 1
	AND ( (SalePrice * Qty) - Discount) < 0

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -204
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
