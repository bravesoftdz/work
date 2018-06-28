SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE  PROCEDURE [dbo].[sp_PreSale_ChangeItem]
	(
	@PreSaleID      	int,
	@ModelID     		int,
	@UserID      		int,
	@IDComission		int,
	@Qty         		float,
	@SalePrice      	money,
	@CostPrice      	money = Null,
	@Discount    		money,
	@MovDate     		smalldatetime,
	@Manager		bit = 0,
	@ResetDiscount		bit = 0,
	@Date			DateTime,
	@PreInvMovParentID	int,
	@IDDepartment		int,
	@Promo			bit,
	@IDDescriptionPrice	int,
	@IDVendorPrice		int,
	@SuggPrice		int,
	@DocumentNumber		varchar(20),
	@IDDocumentType		int,
	@DiscountPromo 		money=0,
	@UnitDiscount     money,    
	@PreInventMovID		int output 
	)
AS
	/* -------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Testa se o discount total ainda e valido
		- Efetivamente remove e inclui o inventory moviment
		- Passa os seriais do item antigo para o novo

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em exec @Result = sp_PreSale_SubTestDiscount
		-202  Erro em exec sp_PreSale_SubResetDiscount
		-209  Erro em exec sp_PreSale_SubCalcTotal

	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	-----------------------	-----------------------	----------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
	26 June 2001		Davi Gouveia		Log de Return Values;
	18 Aug 	2004		Rodrigo Costa		Gravar error log;
	01 Fev 	2005		Rodrigo Costa		Inclusao do IDPreInvMovExchange e qtyExchanged;
	12 Apr 	2006		Leonardo Riego		Novo campo @IDDepartment;
	16 Jun	2006		Rodrigo Costa		Adicionado os parametros para ErrorHistory;
	15 Aug 	2006		Leonardo Riego		Deleção da comissao do item novo e atualização de comissões do item novo;
	10 Aug	2007		Maximiliano Muniz	Novos parâmetros @IDDescriptionPrice, @IDVendorPrice e @SuggPrice;
							Novos parâmetros @DocumentNumber e @IDDocumentType;
	20 Aug	2007		Rodrigo Costa		Editar a tabela de PreInvMov sem deletar e incluir novamente
	19 Set	2008		Rodrigo Costa		Atualizar quantidades do Kit na venda
	18 Jan  2010		Eliandro Souza		inclusão do novo parâmetro @DiscountPromo
	16 Jul	2010		Rodrigo Costa		Loop para alterar a quantidade do KIT na venda
December 11 2012    Antonio M F Souza   added new parameter UnitDiscount 		
	---------------------------------------------------------------------------------------------------------------------------------- */

DECLARE @Result  		int
DECLARE @Value			money
DECLARE @StoreID		int
DECLARE @IDCliente		int
DECLARE @IDOldUser		int
DECLARE @OldPreInventoryMovID 	int 
DECLARE @ErrorLevel		int
DECLARE @SysError		int
DECLARE @IDPreInvMovExchange	int
DECLARE @QtyExchanged		float
DECLARE @IDChild		int
DECLARE @QtyChild		Decimal(38, 4)


SET @ErrorLevel = 0

/*------------------------------------------------------------------------------*/
/*                Testa se o discount total ainda e valido                      */
/*------------------------------------------------------------------------------*/
SELECT @Value = IsNull((@Qty * @SalePrice), 0)

IF @Manager = 0
BEGIN
	EXEC @Result = sp_PreSale_SubTestDiscount 	@PreSaleID,
							@ModelID,
							@UserID,
 							@Discount,
							@Value,
							'A', 
							@PreInventMovID

	SET @SysError = @@ERROR
	IF @SysError <> 0 	
	BEGIN
		SET @ErrorLevel = -201
		GOTO ERRO
	END

	IF @ResetDiscount = 1 and @Result <> 0
	BEGIN
		EXEC sp_PreSale_SubResetDiscount	@PreSaleID

		SET @SysError = @@ERROR
		IF @SysError <> 0 	
		BEGIN
			SET @ErrorLevel = -202
			GOTO ERRO
		END
	END
	ELSE
	BEGIN
		IF @Result <> 0
		BEGIN
			RETURN @Result
		END
	END
END

/*-------------------------------------------------------------*/
/*    Efetivamente remove e inclui o inventory moviment        */
/*-------------------------------------------------------------*/
BEGIN TRAN


UPDATE
	PreInventoryMov
SET
	QtyExchanged = @QtyExchanged,
	UserID = @UserID,
	Qty = @Qty,
	SalePrice = @SalePrice,
	CostPrice = @CostPrice,
	Discount = @Discount+@DiscountPromo,
	MovDate = @MovDate,
	IDDepartment = @IDDepartment,
	Promo = @Promo,
	SuggRetail = @SuggPrice,
	DiscountPromo = @DiscountPromo,
	UnitDiscount = @UnitDiscount
WHERE
	IDPreInventoryMov = @PreInventMovID

SET @SysError = @@ERROR
IF @SysError <> 0 	
BEGIN
	SET @ErrorLevel = -203
	GOTO ERRO
END

/*-------------------------------------------------------------*/
/*    Atualizar os itens do kit          */
/*-------------------------------------------------------------*/

DECLARE ModelChild_Cursor CURSOR FOR

	SELECT
		PIM.IDPreInventoryMov,
		MP.Qty
	FROM 
 		PreInventoryMov PIM (NOLOCK)
		JOIN (SELECT
				P.IDModel,
				P.Qty		
			FROM 
		 		PackModel P (NOLOCK)
		 	WHERE
				P.IDPackModel = @ModelID) MP ON (MP.IDModel = PIM.ModelID)
 	WHERE
		PIM.IDParentPack = @PreInventMovID


OPEN ModelChild_Cursor

--Inicialização de ModelChild_Cursor
FETCH NEXT FROM ModelChild_Cursor INTO
	@IDChild,
	@QtyChild

--Enquanto tem registros
WHILE
@@FETCH_STATUS = 0
BEGIN

	UPDATE
		PreInventoryMov
	SET
		Qty = @QtyChild * @Qty
	WHERE
		IDPreInventoryMov = @IDChild

	--Leitura do Proximo 
	FETCH NEXT FROM ModelChild_Cursor INTO
		@IDChild,
		@QtyChild

END
--fechamento do cursor
CLOSE ModelChild_Cursor

--Destruição do cursor
DEALLOCATE ModelChild_Cursor

SET @SysError = @@ERROR
IF @SysError <> 0 	
BEGIN
	SET @ErrorLevel = -204
	GOTO ERRO
END


/*-------------------------------------------------------------*/
/*    Calcula o SupTotal        */
/*-------------------------------------------------------------*/


exec sp_PreSale_SubCalcTotal @PreSaleID, @Date
SET @SysError = @@ERROR
IF @SysError <> 0 	
BEGIN
	SET @ErrorLevel = -209
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
	SET @Params = ' [ @ModelID = ' + CAST(@ModelID AS VARCHAR) + ' @UserID = '  + CAST(@UserID AS VARCHAR) + 
			' @IDComission = ' + CAST(@IDComission AS VARCHAR) + ' @Qty = '  + CAST(@Qty AS VARCHAR) +
			' @PreInvMovParentID = '  + CAST(@PreInvMovParentID AS VARCHAR) + 
			' @IDDepartment = ' + CAST(@IDDepartment AS VARCHAR) + ' ] '

	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR) + @Params
	EXEC sp_PreSale_ChangeItem 0, 0, @SysError, 'MainRetail', 'Error: sp_PreSale_ChangeItem', @ErrorLevelStr

	RETURN @ErrorLevel
GO
