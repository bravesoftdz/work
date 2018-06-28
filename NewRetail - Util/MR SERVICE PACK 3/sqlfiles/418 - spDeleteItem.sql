if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_Remove]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_Remove]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_RemoveItem]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_RemoveItem]
GO

CREATE PROCEDURE sp_PreSale_Remove
			(
				@PreSaleID	int,
				@IDUser	int
			)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Deleto PreSerialMov
		- Remove InventoryMov
		- Deleta os pagamentos
		- Remove o Invoice

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Delecao do PreSerialMov
		-202  Erro em Remove the Inventory Mov
		-203  Erro em Remover os lancamentos
		-207  Erro em Remove the Invoice
		-208  Erro em Remove historico
		-208  Erro em Remove outros custos
		-209  Erro em Deletar Account Number


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
	26 June 2001		Davi Gouveia		Log de Return Values
	19 July   2001		Davi Gouveia		Exclusao de testes se Hold está sendo usado, visto q o teste ja é feito no Delphi
	18 Aug 2004		Rodrigo Costa		Gravar error log
	25 Oct 2004		Rodrigo Costa		Deleta os Historicos dos pedidos
	19 Jan 2005		Rodrigo Costa		Deleta os outros custos do pedido
	22 Mar	2006		Rodrigo Costa		Deletar Account Number
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */
 
DECLARE @IsLayaway		bit
DECLARE @ErrorLevel		int 
DECLARE @SysError		int
DECLARE @IDPreInvMovOld	int
SET @ErrorLevel = 0 

BEGIN TRAN


/*--------------------------------------------------------------*/
/*	Deleta os Historicos dos pedidos        */
/*--------------------------------------------------------------*/
DELETE
	H
FROM
	History H
WHERE
	H.IDPreSale = @PreSaleID

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -208
	GOTO ERRO
END

/*--------------------------------------------------------------*/
/*		Delecao do Account Number	        */
/*--------------------------------------------------------------*/
DELETE
	AC
FROM
	PreInventoryMov PIM
	JOIN Sal_AccountCard AC ON (PIM.IDPreInventoryMov = AC.IDPreInventoryMov)
WHERE
	PIM.DocumentID = @PreSaleID
	AND
	PIM.InventMovTypeID = 1

SET @SysError = @@ERROR
IF @SysError <> 0
	BEGIN
		PRINT '-209'
		RETURN -209
	END

/*--------------------------------------------------------------*/
/*	Delecao do PreSerialMov	        */
/*--------------------------------------------------------------*/
DELETE
	PSM
FROM
	PreInventoryMov PIM
	JOIN PreSerialMov PSM ON (PSM.PreInventoryMovID = PIM.IDPreInventoryMov)
WHERE
	PIM.DocumentID = @PreSaleID
	AND
	PIM.InventMovTypeID = 1

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END

/*----------------------------------------------------------------*/
/*	Remove the PreInventoryMov		  */
/*----------------------------------------------------------------*/
--Declaração do Cursor de PreInvDel_Cursor
DECLARE PreInvDel_Cursor CURSOR STATIC FOR 
	SELECT
		IDPreInventoryMov
	FROM
		PreInventoryMov
	WHERE
		DocumentID = @PreSaleID
		AND 
		InventMovTypeID = 1

OPEN PreInvDel_Cursor

--Inicialização de PreInv_Cursor
FETCH NEXT FROM PreInvDel_Cursor INTO
            @IDPreInvMovOld

--Enquanto tem registros
WHILE @@FETCH_STATUS = 0
BEGIN
	--Deletar os items
	EXEC sp_PreSale_SubRemoveItem @IDPreInvMovOld

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
	            SET @ErrorLevel = -202
	            GOTO ERRO
	END

            FETCH NEXT FROM PreInvDel_Cursor INTO
                        @IDPreInvMovOld
END

--fechamento do cursor
CLOSE PreInvDel_Cursor
--Destruição do cursor
DEALLOCATE PreInvDel_Cursor

/*----------------------------------------------------------------*/
/*	Deleta os pagamentos  	        	  */
/*----------------------------------------------------------------*/

EXEC sp_PreSale_DeletePayments @PreSaleID, @IDUser

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
            SET @ErrorLevel = -203
            GOTO ERRO
END


-- Remove os outros custos
DELETE
	C
FROM
	InvoiceToCostType C
WHERE
	C.IDPreSale = @PreSaleID

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -209
	GOTO ERRO
END

/*----------------------------------------------------------------*/
/*	Remove the Invoice 	        	  */
/*----------------------------------------------------------------*/

DELETE
	I
FROM
	Invoice I
WHERE
	I.IDPreSale = @PreSaleID
	AND
	I.IDInvoice IS  NULL 

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -207
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
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PreSale_Remove', @ErrorLevelStr
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
			@Manager		bit	= 0
			)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Testa se o discount total ainda e valido
		- Delecao do Account Number
		- Efetivamente remove o inventory moviment

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em exec @Result = sp_PreSale_SubTestDiscount
		-202  Erro em exec sp_PreSale_SubResetDiscount
		-203  Erro em Delecao do PreSerialMov
		-204  Erro em exec @result = sp_PreSale_SubRemoveItem
		-205  Erro em exec sp_PreSale_SubCalcTotal
		-206  Erro em deletar Account Number


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
	26 June 2001		Davi Gouveia		Log de Return Values
	18 Aug 2004		Rodrigo Costa		Gravar error log
	22 Mar	2006		Rodrigo Costa		Deletar Account Number
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
/*		Delecao do Account Number	        */
/*--------------------------------------------------------------*/
DELETE
	AC
FROM
	Sal_AccountCard AC
WHERE
	AC.IDPreInventoryMov =  @PreInventMovID

SET @SysError = @@ERROR
IF @SysError <> 0
	BEGIN
		PRINT '-206'
		RETURN -206
	END
 
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
		SET @ErrorLevel = -205
		GOTO ERRO
	END
end

OK:
	COMMIT TRAN
	RETURN @Result
ERRO:
	ROLLBACK TRAN
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PreSale_RemoveItem', @ErrorLevelStr

	RETURN @ErrorLevel
GO
