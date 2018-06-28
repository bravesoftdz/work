SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_PO_ChangeItem]
		(
		@IDModel                	int,
		@IDPOItem 	  	int,
		@IDPO			int,
		@Qty			float,
		@CostPrice		money,
		@SalePrice		money,
		@SuggRetail		money,
		@DataPedido    		smalldatetime,
		@EstimatedDate	smalldatetime
		)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Muda os valores do POItem atual
		- Atualiza o Model
		- Atualiza o total do PO
		- Verifica Condição de fechamento do PO e atualiza

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok		
		-201  Erro em Muda os valores do POItem atual
		-202  Erro em Atualiza o Model
		-203  Erro em Atualiza o total do PO
		-204  Erro em Verifica Condição de fechamento do PO e atualiza


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
	26 June 2001		Davi Gouveia		Log de Return Values
	18 Aug  2004		Rodrigo Costa		Gravar error log
	30 Nov 2005		Carlos Lima		Atualizar totais e fechamento
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

DECLARE @SubTotal	money
DECLARE @ErrorLevel	int
DECLARE @SysError	int

SET @ErrorLevel = 0

BEGIN TRAN


/*------------------------------------------------------------------------------*/
/*     	      Muda os valores do POItem atual					*/
/*------------------------------------------------------------------------------*/

UPDATE
	dbo.vwPOItem
SET	
	Qty 			= @Qty,
	CostPrice  		= @CostPrice,
	SalePrice  		= @SalePrice,
	SuggRetail 		= @SuggRetail,
	MovDate 		= @DataPedido,
	DateEstimatedMov 	= @EstimatedDate
WHERE
	IDPOItem = @IDPOItem

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END

/*------------------------------------------------------------------------------*/
/*                             Atualiza o Model                                 */
/*------------------------------------------------------------------------------*/
UPDATE 
	MODEL
SET
	SuggRetail = @SuggRetail
FROM
	MODEL (NOLOCK) 
WHERE
	IDModel = @IDModel

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -202
	GOTO ERRO
END

/*------------------------------------------------------------------------------*/
/*		Atualiza o total do PO						*/
/*------------------------------------------------------------------------------*/

EXEC sp_PO_AtuPOTotal @IDPO

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -203
	GOTO ERRO
END

/*---------------------------------------------------------------------------------------------------------------------*/
/*               Verifica Condição de fechamento do PO e atualiza		*/
/*---------------------------------------------------------------------------------------------------------------------*/
EXEC sp_PO_CalcTotalQty @IDPO	

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -204
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
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PO_ChangeItem', @ErrorLevelStr

	RETURN @ErrorLevel
GO
