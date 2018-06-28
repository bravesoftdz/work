SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
ALTER PROCEDURE [dbo].[sp_Invoice_ChangeSalesPerson]
		(
		@IsInvoice		bit,
		@IDInventoryMov	int,
		@IDNewComission	int
		)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Troca o Vendedor

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro no primeiro update
		-202  Erro no segundo update


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	16 Nov  1999		Eduardo Costa		Criacao;
	25 June 2001		Davi Gouveia		Log de Return Values
	18 Aug 2004		Rodrigo Costa		Gravar error log
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

DECLARE @ErrorLevel 	int
DECLARE @SysError	int

SET @ErrorLevel = 0

BEGIN TRAN

IF @IsInvoice = 1
BEGIN
	UPDATE InventoryMov SET ComissionID = @IDNewComission WHERE IDInventoryMov = @IDInventoryMov

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		SET @ErrorLevel = -201
		GOTO ERRO
	END
END
ELSE
BEGIN
	UPDATE PreInventoryMov SET ComissionID = @IDNewComission WHERE IDPreInventoryMov = @IDInventoryMov

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		SET @ErrorLevel = -202
		GOTO ERRO
	END
END


OK:
	COMMIT TRAN
	RETURN 0
ERRO:
	ROLLBACK TRAN
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_Invoice_ChangeSalesPerson', @ErrorLevelStr

	RETURN @ErrorLevel
GO
