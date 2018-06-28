SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_PreSale_AddItem]
	(
	@PreSaleID     		int,
	@IDCliente		int,
	@ModelID     		int,
	@StoreID     		int,
	@UserID      		int,
	@IDComission		int,
	@Qty         		float,
	@SalePrice      	money,
	@CostPrice		money,
	@Discount    		money,
	@MovDate     		smalldatetime,
	@ResetDiscount  	bit = 0,
	@Manager		bit = 0,
	@Date			DateTime,
	@IDPreInvMovExchange	int,
	@PreInvMovParentID	int,
	@IDDepartment		int,
	@Promo			bit = 0,
	@IDDescriptionPrice	int,
	@IDVendorPrice		int,
	@SuggPrice		int,
	@DocumentNumber		varchar(20),
	@IDDocumentType		int,
	@SequencyNum		int = 0,
	@TotParcial		varchar(10) = NULL,
	@DiscountPromo		money = 0,
	@UnitDiscount money,
	@PreInventMovID  	int = null Output,
	@ManualDiscount money = null,
	@IDSpecialPrice int = null,
    @ManualPrice money = null
	)
AS

/* ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 	SUMARIO

		- Tests if the total discount and still valid
		- Includes the movement

	ERROR TABLE FOR RETURN_VALUE

		@Result Ok
		-201  Erro in exec @Result = sp_PreSale_SubTestDiscount
		-202  Erro in exec sp_PreSale_SubResetDiscount
		-203  Erro in exec @Result = sp_PreSale_SubAddItem
		-204  Erro in exec sp_PreSale_SubCalcTotal

	LOG OF CHANGES

	Data			Programmer		Modification
	-----------------------	-----------------------	-----------------------------------------------------------------
	2000-05-15		Eduardo Costa		Creation;
	2001-06-26		Davi Gouveia		Log the Return Values;
	2004-08-18		Rodrigo Costa		Write error log;
	2005-02-01		Rodrigo Costa		New field @IDPreInvMovExchange
	2006-04-12		Leonardo Riego		New field @IDDepartment;
	2006-06-16		Rodrigo Costa		Added the parameters for ErrorHistory
	2007-07-20		Maximiliano Muniz	New parameters @IDDescriptionPrice, @IDVendorPrice and @SuggPrice;
	2007-08-08		Maximiliano Muniz	New parameters @DocumentNumber and @IDDocumentType;
	2009-08-24		Rodrigo Costa		Creation of the parameters for TotParcial and SeqNum PAF-ECF
	2010-01-18		Eliandro Souza		New parameter @DiscountPromo
    2012-12-11      Antonio M F Souza   New parameter @UnitDiscount
	2014-03-13      Nicholas Cook       New parameters @ManualDiscount, @IDSpecialPrice, and @ManualPrice along with
	                                    rework of how pricing and discounts are calculated.
	----------------------------------------------------------------------------------------------------------------- */
 
DECLARE @Result		int
DECLARE @ErrorLevel	int 
DECLARE @SysError	int

SET @ErrorLevel = 0 

/*------------------------------------------------------------------------------*/
/*	        	         Include Movement                                       */
/*------------------------------------------------------------------------------*/

BEGIN TRAN

EXEC @Result = sp_PreSale_SubAddItem
					@PreSaleID,
					@IDCliente,
					@ModelID,
					@StoreID,
					@UserID,
					@IDComission,
					@Qty,
					@SalePrice,
					@CostPrice,
					@Discount,
					@MovDate,
					@IDPreInvMovExchange,
					@PreInvMovParentID,
					@IDDepartment,
					@Promo,
					@IDDescriptionPrice,
					@IDVendorPrice,
					@SuggPrice,
					@DocumentNumber,
					@IDDocumentType,
					@SequencyNum,
					@TotParcial,
					@DiscountPromo,
					@UnitDiscount,
					@PreInventMovID Output,
					@ManualDiscount,
	                @IDSpecialPrice,
                    @ManualPrice

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -203
	GOTO ERRO
END

if @Result <> 0
	rollback tran
else
	exec sp_PreSale_SubCalcTotal @PreSaleID, @Date

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -204
	GOTO ERRO
END


OK:
	COMMIT TRAN
	RETURN 0
ERRO:
	ROLLBACK TRAN
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(510)
	DECLARE @Params varchar(500)	
	SET @Params = ' [ @IDCliente = ' + CAST(@IDCliente AS VARCHAR) + ' @ModelID = ' + CAST(@ModelID AS VARCHAR) +  
			' @StoreID = ' + CAST(@StoreID AS VARCHAR) + ' @UserID = '  + CAST(@UserID AS VARCHAR) + 
			' @IDComission = '  + CAST(@IDComission AS VARCHAR) + ' @Qty = '  + CAST(@Qty AS VARCHAR) +
			' @IDPreInvMovExchange = '  + CAST(@IDPreInvMovExchange AS VARCHAR) + 
			' @IDDepartment = '  + CAST(@IDDepartment AS VARCHAR) +  ' ] '
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR) + @Params
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PreSale_AddItem', @ErrorLevelStr

	RETURN @ErrorLevel
