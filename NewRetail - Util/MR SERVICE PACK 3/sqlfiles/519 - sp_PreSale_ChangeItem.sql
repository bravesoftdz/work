if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_ChangeItem]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_ChangeItem]
GO

CREATE PROCEDURE sp_PreSale_ChangeItem
		(
		@PreSaleID      		int,
		@ModelID     			int,
		@UserID      			int,
		@IDComission			int,
		@Qty         			float,
		@SalePrice      		money,
		@CostPrice      		money = Null,
		@Discount    			money,
		@MovDate     			smalldatetime,
		@Manager			bit 	= 0,
		@ResetDiscount			bit	= 0,
		@Date				DateTime,
		@PreInvMovParentID		int,
		@IDDepartment			int,
		@Promo				bit,
		@PreInventMovID			int	output 
		)
AS
 /* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Testa se o discount total ainda e valido
		- Efetivamente remove e inclui o inventory moviment
		- Passa os seriais do item antigo para o novo

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em exec @Result = sp_PreSale_SubTestDiscount
		-202  Erro em exec sp_PreSale_SubResetDiscount
		-203  Erro em exec @result = sp_PreSale_SubAddItem
		-204  Erro em atualizar quantidades trocadas
		-205  Erro em Passa os seriais do item antigo para o novo
		-206  Erro em deletar a comissao do item novo
		-207  Erro em atualizar a comissao do item
		-208  Erro em exec @result = sp_PreSale_SubRemoveItem
		-209  Erro em exec sp_PreSale_SubCalcTotal


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
	26 June 2001		Davi Gouveia		Log de Return Values
	18 Aug 	2004		Rodrigo Costa		Gravar error log
	01 Fev 	2005		Rodrigo Costa		Inclusao do IDPreInvMovExchange e qtyExchanged
	12 Apr 	2006		Leonardo Riego		Novo campo @IDDepartment
	16 Jun	2006		Rodrigo Costa		Adicionado os parametros para ErrorHistory
	15 Aug 	2006		Leonardo Riego		Deleção da comissao do item novo e atualização de comissões do item novo
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

 DECLARE @Result  			int
DECLARE @Value				money
DECLARE @StoreID			int
DECLARE @IDCliente			int
DECLARE @IDOldUser			int
DECLARE @OldPreInventoryMovID 		int 
DECLARE @ErrorLevel			int
DECLARE @SysError			int
DECLARE @IDPreInvMovExchange		int
DECLARE @QtyExchanged			float

SET @ErrorLevel = 0


SET @OldPreInventoryMovID = @PreInventMovID

/*------------------------------------------------------------------------------*/
/*                Testa se o discount total ainda e valido                      */
/*------------------------------------------------------------------------------*/
 SELECT @Value = IsNull((@Qty * @SalePrice), 0)

if @Manager = 0
   begin 

	exec @Result = sp_PreSale_SubTestDiscount 	@PreSaleID,
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
 
	if @ResetDiscount = 1 and @Result <> 0
	   begin
		exec sp_PreSale_SubResetDiscount	@PreSaleID

		SET @SysError = @@ERROR
		IF @SysError <> 0 	
		BEGIN
			SET @ErrorLevel = -202
			GOTO ERRO
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

/*------------------------------------------------------------------------------*/
/*                            Descobre o Store                                  */
/*------------------------------------------------------------------------------*/

SELECT
	@StoreID = StoreID,
	@IDCliente = IDPessoa,
	@IDPreInvMovExchange = IDPreInvMovExchange,
	@QtyExchanged = QtyExchanged
FROM 
	PreInventoryMov
WHERE 
	PreInventoryMov.IDPreInventoryMov = @PreInventMovID

/*-------------------------------------------------------------*/
/*    Efetivamente remove e inclui o inventory moviment        */
/*-------------------------------------------------------------*/
begin tran

exec @result = sp_PreSale_SubAddItem	@PreSaleID,
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
					@PreInventMovID 	output

SET @SysError = @@ERROR
IF @SysError <> 0 	
BEGIN
	SET @ErrorLevel = -203
	GOTO ERRO
END

/*-------------------------------------------------------------*/
/*    Atualiza as quantidades trocadas      */
/*-------------------------------------------------------------*/

UPDATE
	PreInventoryMov
SET
	QtyExchanged = @QtyExchanged
WHERE
	IDPreInventoryMov = @PreInventMovID


SET @SysError = @@ERROR
IF @SysError <> 0 	
BEGIN
	SET @ErrorLevel = -204
	GOTO ERRO
END

/*-------------------------------------------------------------*/
/*    Passa os seriais do item antigo para o novo      */
/*-------------------------------------------------------------*/
UPDATE
	PSM
SET
	PSM.PreInventoryMovID = @PreInventMovID
FROM
	PreSerialMov PSM
WHERE
	PSM.PreInventoryMovID = @OldPreInventoryMovID

SET @SysError = @@ERROR
IF @SysError <> 0 	
BEGIN
	SET @ErrorLevel = -205
	GOTO ERRO
END

/*-------------------------------------------------------------*/
/* Deleta as comissoes do item da venda nova  */
/*-------------------------------------------------------------*/

DELETE
	SaleItemCommission
WHERE
	SaleItemCommission.IDPreInventoryMov = @PreInventMovID

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -206
	GOTO ERRO
END


/*-------------------------------------------------------------*/
/* Passa as comissoes do item antigo para o novo  */
/*-------------------------------------------------------------*/

UPDATE
	STC
SET
	STC.IDPreInventoryMov = @PreInventMovID
FROM
	SaleItemCommission STC
WHERE
	STC.IDPreInventoryMov = @OldPreInventoryMovID

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -207
	GOTO ERRO
END

/*-------------------------------------------------------------*/
/*    Deleto o presale antigo	      */
/*-------------------------------------------------------------*/

exec @result = sp_PreSale_SubRemoveItem	@OldPreInventoryMovID

SET @SysError = @@ERROR
IF @SysError <> 0 	
BEGIN
	SET @ErrorLevel = -208
	GOTO ERRO
END

if @Result <> 0 	
	rollback tran
else
begin
	exec sp_PreSale_SubCalcTotal @PreSaleID, @Date
	SET @SysError = @@ERROR
	IF @SysError <> 0 	
	BEGIN
		SET @ErrorLevel = -209
		GOTO ERRO
	END
end

OK:
	IF @Result = 0
		COMMIT TRAN
	RETURN @Result
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
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PreSale_ChangeItem', @ErrorLevelStr

	RETURN @ErrorLevel
GO
