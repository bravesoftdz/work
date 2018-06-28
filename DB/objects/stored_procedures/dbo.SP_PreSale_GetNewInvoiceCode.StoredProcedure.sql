SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[SP_PreSale_GetNewInvoiceCode]
	(
	@IDStore 		int, 
	@InvoiceCode 		varchar(20) output
	) 
AS


DECLARE @MiddleSaleCode 	varchar(50)
DECLARE @ConcatStr 		varchar(50)

DECLARE @ErrorLevel  		int
DECLARE @SysError  		int


/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Obter novo InvoiceCode

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Obter novo InvoiceCode


	LOG DE MODIFICAÇÕES

	Data		Programador	Modificação
	-------------------------- -------------------------- ---------------------------------------------------------------------------------------------------------------------------
	03 Nov  2004	Carlos Lima	Criacao;
	29 Nov	2006	Rodrigo Costa	Removido a transacao da sp, pois a PreSalePay e que tem a transacao
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

SET @ErrorLevel = 0
 
/*----------------------------------------------------------------*/
/*	Obter um novo InvoiceCode	*/
/*----------------------------------------------------------------*/

SET @ConcatStr = 'Invoice.InvoiceCode' + CONVERT(varchar, @IDStore)
EXEC sp_Sis_GetNextCode @ConcatStr, @MiddleSaleCode OUTPUT

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO 
END


SET @InvoiceCode = CONVERT(varchar(20), @MiddleSaleCode)

 
OK:
	RETURN 0
ERRO:
	PRINT CAST(@ErrorLevel AS VARCHAR)
 
	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: SP_PreSale_GetNewInvoiceCode', @ErrorLevelStr
 
	RETURN @ErrorLevel
GO
