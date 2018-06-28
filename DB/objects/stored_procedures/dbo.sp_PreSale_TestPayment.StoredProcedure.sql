SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_PreSale_TestPayment]

		(
		@IDMeioPag int,
		@DifDay int,
		@Value money
		)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Testa se existe o prazo escolhido

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Testa se existe o prazo escolhido
		-202  Erro em SELECT @MaxValue


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
	26 June 2001		Davi Gouveia		Log de Return Values
	18 Aug 2004		Rodrigo Costa		Gravar error log
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */


DECLARE @MaxValue	money
DECLARE @RealDifDay	int
DECLARE @ErrorLevel	int
DECLARE @SysError	int

SET @ErrorLevel = 0

/* Testa se existe o prazo escolhido */

SELECT @RealDifDay =
	(
	SELECT
		Min(MeioPagMinSale.DifDay)
	FROM
		dbo.MeioPagMinSale MeioPagMinSale (NOLOCK) 
	WHERE
		MeioPagMinSale.IDMeioPag = @IDMeioPag
		AND
   		IsNull(MeioPagMinSale.DifDay, 0) >= IsNull(@DifDay, 0)
	)

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END

if IsNull(@RealDifDay, -10000) = -10000
	return -1


 SELECT @MaxValue =
	(
	SELECT	IsNull(dbo.MeioPagMinSale.TotalSale, 0)
	FROM    dbo.MeioPagMinSale (NOLOCK) 
	WHERE   dbo.MeioPagMinSale.IDMeioPag = @IDMeioPag AND
		dbo.MeioPagMinSale.DifDay =  @RealDifDay
	)

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -202
	GOTO ERRO
END 

if @Value >= IsNull(@MaxValue, 0)
	return 0
else
            return 1

ERRO:
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PreSale_TestPayment', @ErrorLevelStr

	RETURN @ErrorLevel
GO
