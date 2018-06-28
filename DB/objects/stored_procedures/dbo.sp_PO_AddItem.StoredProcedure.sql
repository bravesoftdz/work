SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_PO_AddItem]
		(
		@IDUser			int,
		@IDModel     		int,
		@IDFornecedor		int,
		@IDStore     		int,
		@Qty         		float,
		@CostPrice      	money,
		@SalePrice      	money,
		@SuggRetail      	money,
		@DataPedido    		smalldatetime,
		@EstimatedDate		smalldatetime,
		@BalanceRequest		bit,
		@IDPOItem 	  	int Output
		)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Descobre o IDPO do Fornecedor aberto no momento
		- Inclui o POItem
		- Atualiza o Model
                - Atualiza os totais do PO
		- Atualiza os Vendor Requests para a Mercadoria

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-001  Ok
		-201  Erro em Inclui o POItem
		-202  Erro em Atualiza o Model
		-203  Erro em Atualiza os totais do PO
		-204  Erro em Deleto de Request
		-205  Erro em Insiro em Request


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
	26 June 2001		Davi Gouveia		Log de Return Values;
 	21 Oct	2003		Rodrigo Costa		Chamada a sp_Sis_GetNextCode para @IDPOItem, @IDPO, @IDRequest; 
							Removido SELECT @IDPO = @@IDENTITY, SELECT @IDPOItem = @@IDENTITY;
							Criado @IDRequest;
	18 Aug 2004		Rodrigo Costa		Gravar error log
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

DECLARE @Result		int
DECLARE @IDPO		int
DECLARE @TotalRequest   	int
DECLARE @SubTotal		money
DECLARE @Description		varchar(50)
DECLARE @ErrorLevel		int
DECLARE @SysError		int
DECLARE @IDRequest		int

SET @ErrorLevel = 0

BEGIN TRAN

/*------------------------------------------------------------------------------*/
/*                Descobre o IDPO do Fornecedor aberto no momento                   */
/*------------------------------------------------------------------------------*/
SELECT @IDPO = 	IsNull(
		(
		SELECT 
			IDPO
		FROM 
			dbo.PO PO (NOLOCK) 
		WHERE
			IDFornecedor = @IDFornecedor   
			AND
			Aberto   = 1 	       
			AND
			IDStore  = @IDStore
		)
		, -1)
IF @IDPO = -1
BEGIN
	SELECT @Result = -1

	EXEC sp_Sis_GetNextCode 'PO.IDPO', @IDPO OUTPUT
	INSERT dbo.PO 
		(
		IDPO,
		IDFornecedor, 
		DataPedido, 
		Aberto, 
		IDStore
		) 
		VALUES 
		(
		@IDPO,
		@IDFornecedor, 
		@DataPedido, 
		1, 
		@IDStore
		)

END
ELSE
BEGIN
	SELECT @Result = 0
END

/*------------------------------------------------------------------------------*/
/*		Inclui o POItem			*/
/*------------------------------------------------------------------------------*/
EXEC sp_Sis_GetNextCode 'PreInventoryMov.IDPreInventoryMov', @IDPOItem OUTPUT
INSERT dbo.vwPOItem	(
	IDPOItem,
	IDPO , 
	ModelID , 
	MovDate , 
	Qty ,
	CostPrice , 
	SalePrice, 
	SuggRetail, 
	IDFornecedor , 
	DateEstimatedMov ,
  	IDStore, 
	InventMovTypeID
	)
	VALUES
	(
	@IDPOItem,
	@IDPO, 
	@IDModel, 
	@DataPedido, 
	@Qty,
	@CostPrice, 
	@SalePrice, 
	@SuggRetail, 
	@IDFornecedor, 
	@EstimatedDate,
	@IDStore, 
	2
	)

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
/*        		    Atualiza os totais do PO				*/
/*------------------------------------------------------------------------------*/ 
SELECT @SubTotal = @Qty * @CostPrice 
EXEC sp_PO_AtuPOTotal	@IDPO, @SubTotal

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -203
	GOTO ERRO
END

/*------------------------------------------------------------------------------*/
/*     		    Atualiza os Vendor Requests para a Mercadoria		*/
/*------------------------------------------------------------------------------*/
SELECT @TotalRequest =	IsNull(
			(
			SELECT
				SUM(QtyReq)
			FROM	
				dbo.Request (NOLOCK) 
			WHERE
				dbo.Request.StoreID = @IDStore 
				AND
				dbo.Request.ModelID = @IDModel
				), 0)

-- Deleto de Request
DELETE
FROM
	dbo.Request
WHERE
	dbo.Request.StoreID = @IDStore
	AND
	dbo.Request.ModelID = @IDModel

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -204
	GOTO ERRO
END

IF @TotalRequest > @Qty AND @BalanceRequest = 1
BEGIN
	SELECT @Description = (SELECT Description FROM Model (NOLOCK) WHERE IDModel = @IDModel)

	-- Insiro em Request
	EXEC sp_Sis_GetNextCode 'Request.IDRequest', @IDRequest OUTPUT
	INSERT
		Request (
			IDRequest,
			UserID,
			ModelID,
			Description,
			StoreID,
			Type,
			QtyReq,
			DateRequest
			)
		VALUES
			(
			@IDRequest,
			@IDUser,
			@IDModel,
			@Description,
			@IDStore,
			'P',
			(@TotalRequest-@Qty),
			GetDate()
			)

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		SET @ErrorLevel = -205
		GOTO ERRO
	END
END

OK:
	COMMIT TRAN
	RETURN @Result
ERRO:
	ROLLBACK TRAN
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PO_AddItem', @ErrorLevelStr

	RETURN @ErrorLevel
GO
