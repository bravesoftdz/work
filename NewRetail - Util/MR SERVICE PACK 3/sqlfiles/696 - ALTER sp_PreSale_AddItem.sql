IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[sp_PreSale_AddItem]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[sp_PreSale_AddItem]
GO

CREATE PROCEDURE sp_PreSale_AddItem
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
	@PreInventMovID  	int Output
	)
AS

/* ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 	SUMARIO

		- Testa se o discount total ainda e valido
		- Inclui a movimentaçao

	TABELA DE ERROS PARA RETURN_VALUE

		@Result Ok
		-201  Erro em exec @Result = sp_PreSale_SubTestDiscount
		-202  Erro em exec sp_PreSale_SubResetDiscount
		-203  Erro em exec @Result = sp_PreSale_SubAddItem
		-204  Erro em exec sp_PreSale_SubCalcTotal

	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	-----------------------	-----------------------	-----------------------------------------------------------------
	15 May	2000		Eduardo Costa		Criacao;
	26 Jun	2001		Davi Gouveia		Log de Return Values;
	18 Aug	2004		Rodrigo Costa		Gravar error log;
	01 Fev	2005		Rodrigo Costa		Novo campo @IDPreInvMovExchange;
	12 Apr  2006		Leonardo Riego		Novo campo @IDDepartment;
	16 Jun	2006		Rodrigo Costa		Adicionado os parametros para ErrorHistory;
	20 Jul	2007		Maximiliano Muniz	Novos parâmetros @IDDescriptionPrice, @IDVendorPrice e @SuggPrice;
	----------------------------------------------------------------------------------------------------------------- */
 
DECLARE @Result		int
DECLARE @Value		money
DECLARE @ErrorLevel	int 
DECLARE @SysError	int

SET @ErrorLevel = 0 

/*------------------------------------------------------------------------------*/
/*                Testa se o discount total ainda e valido                      */
/*------------------------------------------------------------------------------*/ 

SELECT @Value = IsNUll((@SalePrice * @Qty),0)

IF @Manager = 0 BEGIN
	EXEC @Result = sp_PreSale_SubTestDiscount 	@PreSaleID,
							@ModelID,
							@UserID,
							@Discount,
							@Value,
							'I',
							1

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		SET @ErrorLevel = -201
		GOTO ERRO
	END

	IF @ResetDiscount = 1 and @Result <> 0
	BEGIN
		EXEC sp_PreSale_SubResetDiscount	@PreSaleID
	END
	ELSE
	BEGIN
		IF @Result <> 0
		BEGIN
			RETURN @Result
		END
	END

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		SET @ErrorLevel = -202
		GOTO ERRO
	END
END

/*------------------------------------------------------------------------------*/
/*	        	         Inclui a movimentaçao                          */
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
					@PreInventMovID	Output

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
	IF @Result = 0
		COMMIT TRAN
	RETURN @Result
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
GO
