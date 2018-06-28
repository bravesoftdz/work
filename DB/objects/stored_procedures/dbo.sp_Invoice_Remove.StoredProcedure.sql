SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
ALTER PROCEDURE [dbo].[sp_Invoice_Remove]
			(
			@InvoiceID   int
			)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Update Cash RegisterMovent
		- Remove the Inventory Mov
		- Remove the Serial Mov
		- Remove as prestacaoes do finacneiro
		- Remove the Invoice

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Update Cash RegisterMovent
		-202  Erro em Remove the Inventory Mov
		-203  Erro em Remove the Serial Mov
		-204  Erro em Remove as prestacaoes do finacneiro
		-205  Erro em Remove the Invoice


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
	26 May  2000		Eduardo Costa		suporte ao novo financeiro
	25 June 2001		Davi Gouveia		Log de Return Values
	18 Aug 2004		Rodrigo Costa		Gravar error log
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */


DECLARE @ErrorLevel 	int
DECLARE @SysError	int

SET @ErrorLevel = 0

BEGIN TRAN

/*----------------------------------------------------------------*/
/*		Update Cash RegisterMovent    		     	  */
/*----------------------------------------------------------------*/

UPDATE 
	dbo.CashRegMov
SET 	
	dbo.CashRegMov.TotalSales = IsNull(dbo.CashRegMov.TotalSales, 0) -
	   	  		    IsNull(IsNull(Inv.SubTotal, 0) - IsNull(Inv.ItemDiscount, 0) +
				    IsNull(Inv.Tax, 0), 0) FROM	
	Invoice	Inv WHERE	
	Inv.IDInvoice = @InvoiceID   
	AND
	CashRegMov.IDCashRegMov = Inv.CashRegMovID

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END

/*----------------------------------------------------------------*/
/*			Remove the Inventory Mov		  */
/*----------------------------------------------------------------*/

DELETE
	dbo.InventoryMov
WHERE 	dbo.InventoryMov.DocumentID = @InvoiceID 	AND 	dbo.InventoryMov.InventMovTypeID = 1


SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -202
	GOTO ERRO
END

/*----------------------------------------------------------------*/
/*			Remove the Serial Mov			  */
/*----------------------------------------------------------------*/
 
DELETE
	dbo.SerialMov
FROM
	dbo.InventoryMov InvMov
WHERE
 	InvMov.IDInventoryMov  = dbo.SerialMov.InventoryMovID
 	AND
 	InvMov.DocumentID = @InvoiceID
	AND
	InvMov.InventMovTypeID = 1

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -203
	GOTO ERRO
END

/*-------------------------------------------------------------------------------------------------------------------------------*/
/*			Remove as prestacaoes do finacneiro 	        	          */ 
/*-------------------------------------------------------------------------------------------------------------------------------*/

DELETE
	L
FROM
	Fin_Lancamento L
	JOIN
	Invoice I ON (L.IDPreSale = I.IDPreSale)
WHERE
	I.IDInvoice = @InvoiceID

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -204
	GOTO ERRO
END



/*----------------------------------------------------------------*/
/*			Remove the Invoice 	        	  */ 
/*----------------------------------------------------------------*/

DELETE
 	dbo.Invoice 
WHERE
	dbo.Invoice.IDInvoice = @InvoiceID

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
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
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_Invoice_Remove', @ErrorLevelStr

	RETURN @ErrorLevel
GO
