SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_PreSale_SetTaxIsention]
		(
			@IDPreSale 	int,
			@IDMedia   	int,
			@Date  	DateTime
		)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Testa se isencao de taxa e automatica e tira a taxa do invoice

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em UPDATE Invoice SET TaxIsent = 1
		-202  Erro em UPDATE Invoice SET TaxIsent = 0
		-203  Erro em exec sp_PreSale_SubCalcTax


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

/*		Testa se isencao de taxa e automatica e tira a taxa do invoice   */
if (SELECT TaxMode FROM Media (NOLOCK)  WHERE IDMedia = @IDMedia) = 3
  begin
	UPDATE
		Invoice
	SET
		Tax = 0,
		TaxIsent = 1
	WHERE
		IDPreSale = @IDPreSale

	SET @SysError = @@ERROR 
	IF @SysError <> 0
	BEGIN
		SET @ErrorLevel = -201
		GOTO ERRO
        	END
  end
else
  begin
	UPDATE
		Invoice
	SET
		TaxIsent = 0
	WHERE
		IDPreSale = @IDPreSale

	SET @SysError = @@ERROR 
	IF @SysError <> 0
	BEGIN
		SET @ErrorLevel = -202
		GOTO ERRO
        	END

	exec sp_PreSale_SubCalcTax @IDPreSale, @Date

	SET @SysError = @@ERROR 
	IF @SysError <> 0
	BEGIN
		SET @ErrorLevel = -203
		GOTO ERRO
        	END
  end


OK:
	RETURN 0
ERRO:
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PreSale_SetTaxIsention', @ErrorLevelStr

	RETURN @ErrorLevel
GO
