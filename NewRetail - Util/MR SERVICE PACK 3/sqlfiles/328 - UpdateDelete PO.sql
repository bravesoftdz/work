if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PO_ChangeItem]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PO_ChangeItem]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PO_DeleteItem]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PO_DeleteItem]
GO

CREATE PROCEDURE sp_PO_ChangeItem
		(
		@IDModel                	int,
		@IDPOItem 	  	int,
		@IDPO			int,
		@Qty			int,
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
	MODEL
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

CREATE PROCEDURE sp_PO_DeleteItem
		( 		
			@IDPOItem	int,
	 		@IDPO		int,
			@SubTotal	money
		)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO
		
		- Remove Item do PO
		- Atualiza o total do PO
		- Testa se o numero de itens chegou a zero e deleta o PO
		- Verifica Condição de fechamento do PO e atualiza


	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Remove Item do PO
		-202  Erro em Testa se o numero de itens chegou a zero e deleta o PO
		-203  Erro em Atualiza o total do PO
		-204  Verifica Condição de fechamento do PO e atualiza

	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
	26 June 2001		Davi Gouveia		Log de Return Values
	18 Aug  2004		Rodrigo Costa		Gravar error log
	29 Nov  2005		Carlos Lima		Atualizar totais e fechamento ao excluir item do PO
	
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */


DECLARE @CountItem 	int
DECLARE @ErrorLevel	int
DECLARE @SysError	int

SET @ErrorLevel = 0

BEGIN TRAN

/*------------------------------------------------------------------------------*/
/*		Remove Item do PO		*/
/*-----------------------------------------------------------------------------*/

SELECT @SubTotal = -@SubTotal

--EXEC sp_PO_AtuPOTotal @IDPO, @SubTotal

DELETE FROM dbo.vwPOItem WHERE dbo.vwPOItem.IDPOItem = @IDPOItem

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END

/*------------------------------------------------------------------------------*/
/*		Atualiza o total do PO		*/
/*-----------------------------------------------------------------------------*/

EXEC sp_PO_AtuPOTotal @IDPO

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -203
	GOTO ERRO
END


/*---------------------------------------------------------------------------------------------------------------------*/
/*                Testa se o numero de itens chegou a zero e deleta o PO	*/
/*---------------------------------------------------------------------------------------------------------------------*/

SELECT @CountItem = 	(
			SELECT 
				Count(*)
			FROM 
				dbo.vwPOItem 			WHERE 
				dbo.vwPOItem.IDPO = @IDPO
			)

IF @CountItem = 0
	DELETE FROM dbo.PO WHERE IDPO = @IDPO

	

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -202
	GOTO ERRO
END

/*---------------------------------------------------------------------------------------------------------------------*/
/*               Verifica Condição de fechamento do PO e atualiza		*/
/*---------------------------------------------------------------------------------------------------------------------*/
IF @CountItem <> 0
BEGIN
	EXEC sp_PO_CalcTotalQty @IDPO	

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		SET @ErrorLevel = -204
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
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PO_DeleteItem', @ErrorLevelStr

	RETURN @ErrorLevel
GO
