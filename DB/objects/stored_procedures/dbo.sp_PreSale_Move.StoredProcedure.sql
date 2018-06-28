SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
ALTER PROCEDURE [dbo].[sp_PreSale_Move]
			(
			@IDPreSaleOrigem 	int,
			@IDPreSaleDestino	int 
			)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Atualizo PreInventoryMov

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Atualizo PreInventoryMov
		-202  Erro em exec sp_PreSale_SubCalcTotal @IDPreSaleOrigem
		-203  Erro em exec sp_PreSale_SubCalcTotal @IDPreSaleDestino


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

-- Atualizo PreInventoryMov
UPDATE 	PreInventoryMov
	SET	DocumentID = @IDPreSaleDestino,
		Marked = 0
	WHERE	DocumentID = @IDPreSaleOrigem   AND
		InventMovTypeID = 1		AND
		Marked = 1

SET @SysError = @@ERROR
IF @SysError <> 0 
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END 
exec sp_PreSale_SubCalcTotal @IDPreSaleOrigem

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -202
	GOTO ERRO
END

exec sp_PreSale_SubCalcTotal @IDPreSaleDestino

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
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PreSale_Move', @ErrorLevelStr

	RETURN @ErrorLevel
GO
