SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_PreSale_DelOldHold] AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Deleto PreInventoryMov
		- Deleto Invoice

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Deleto PreInventoryMov
		-202  Erro em Deleto Invoice


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
	26 June 2001		Davi Gouveia		Log de Return Values
	18 Aug 2004		Rodrigo Costa		Gravar error log
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

DECLARE @ErrorLevel	int
DECLARE @SysError	int

SET @ErrorLevel = 0

BEGIN TRAN

-- Deleto PreInventoryMov
DELETE	
	PreInventoryMov
FROM	
	Invoice (NOLOCK) 
WHERE	
	PreInventoryMov.DocumentID = Invoice.IDPreSale		
	AND
	PreInventoryMov.InventMovTypeID = 1			
	AND
	Invoice.IDInvoice IS NULL				
	AND
	Invoice.PreSaleDate < dateadd(dd, -7, GetDate())	
	AND
	(
	Invoice.EstimatedPay IS NULL 				
	OR
	Invoice.EstimatedPay < dateadd(dd, 1, GetDate())
	)

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END

-- Deleto Invoice
DELETE	
	Invoice
WHERE	
	Invoice.IDInvoice IS NULL				
	AND
	Invoice.PreSaleDate < dateadd(dd, -7, GetDate())	
	AND
	(
	Invoice.EstimatedPay IS NULL 				
	OR
	Invoice.EstimatedPay < dateadd(dd, 1, GetDate())
	)

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -202
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
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PreSale_DelOldHold', @ErrorLevelStr

	RETURN @ErrorLevel
GO
