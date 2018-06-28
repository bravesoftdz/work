SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_Cotation_CreatePO]
	(
	@IDCotacao	int,
	@IDFornecedor	int,
	@IDStore	int,
	@IDUser	int,
	@Date		DateTime
	)

AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		Crio os PO para os itens marcados de uma cotacao
		Caso seja passado um iDFornecedor, somente crio para ele, senão para todos

		- Teste se existe algum PO aberto
		- Incluo os Itens
		- Atualiza o total do PO

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Teste se existe algum PO aberto
		-202  Erro em Incluo os Itens
		-203  Erro em Atualiza o total do PO


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
	01 June 2001		Rodrigo Costa   	Coloquei o SubTotal na PO
	25 June 2001		Davi Gouveia		Log de Return Values
	21 Oct	2003		André Bogado		Chamada a sp_Sis_GetNextCode
							Delcaração de PreInventoryMov_Cursor
	18 Aug 2004		Rodrigo Costa		Gravar error log
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */



DECLARE @PO			int
DECLARE @ErrorLevel 		int
DECLARE @SysError		int

--Declaração de variáveis para o Cursor de PreInventoryMov
DECLARE @IDPreInventoryMov 	int
DECLARE @InventMovTypeID 	int 
DECLARE @DocumentID 	int 
DECLARE @StoreID 		int 
DECLARE @ModelID 		int 
DECLARE @MovDate 		smalldatetime 
DECLARE @Qty 		float
DECLARE @CostPrice 		money 
DECLARE @IDPessoa 		int 
DECLARE @UserID 		int 

SET @ErrorLevel = 0

-- Teste se existe algum PO aberto
IF EXISTS
	(
	SELECT
		IDPO
	FROM
		PO (NOLOCK)
	WHERE
		PO.IDFornecedor = @IDFornecedor
		AND
		PO.IDStore = @IDStore
		AND
		PO.Aberto = 1
	)
	BEGIN
		SELECT 
			@PO = PO.IDPO
		FROM
			PO
		WHERE
			PO.IDFornecedor = @IDFornecedor
			AND
			PO.IDStore = @IDStore
			AND
			PO.Aberto = 1
	END
ELSE
	BEGIN
		-- Obtenho IDPO e guardo em @PO
		EXEC sp_Sis_GetNextCode 'PO.IDPO', @PO OUTPUT
		INSERT 	PO (IDPO,IDFornecedor, DataPedido, IDStore, Aberto)
		VALUES	(@PO,@IDFornecedor, @Date, @IDStore, 1)
	END

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END


-- Incluo os Itens
--Declaração do Cursor de PreInventoryMov

DECLARE PreInventoryMov_Cursor CURSOR FOR

SELECT
	2,
	@PO,
	@IDStore,
	CR.IDModel,
	@Date,
	CTM.QtyCotada,
	CR.Cost,
	@IDFornecedor,
	@IDUser
FROM
	CotacaoResult CR (NOLOCK)
	JOIN CotacaoToModel CTM (NOLOCK) ON (CR.IDModel = CTM.IDModel AND CR.IDCotacao =CTM.IDCotacao)
WHERE
	CR.PO = 1
	AND
	CR.IDFornecedor = @IDFornecedor
	AND
	CR.IDCotacao = @IDCotacao

OPEN PreInventoryMov_Cursor

--Inicialização de PreInventoryMov_Cursor
FETCH NEXT FROM PreInventoryMov_Cursor INTO
	@InventMovTypeID,
	@DocumentID,
	@StoreID,
	@ModelID,
	@MovDate,
	@Qty,
	@CostPrice,
	@IDPessoa,
	@UserID
--Enquanto tem registros
WHILE @@FETCH_STATUS = 0
BEGIN
	EXEC sp_Sis_GetNextCode 'PreInventoryMov.IDPreInventoryMov', @IDPreInventoryMov OUTPUT

	INSERT PreInventoryMov
		(
		IDPreInventoryMov,
		InventMovTypeID,
		DocumentID,
		StoreID,
		ModelID,
		MovDate,
		DateEstimatedMov,
		Qty,
		CostPrice,
		IDPessoa,
		UserID
		)
	VALUES 
		(
		@IDPreInventoryMov,
		@InventMovTypeID,
		@DocumentID,
		@StoreID,
		@ModelID,
		@MovDate,
		@MovDate,
		@Qty,
		@CostPrice,
		@IDPessoa,
		@UserID	
		)

	FETCH NEXT FROM PreInventoryMov_Cursor INTO
		@InventMovTypeID,
		@DocumentID,
		@StoreID,
		@ModelID,
		@MovDate,
		@Qty,
		@CostPrice,
		@IDPessoa,
		@UserID
END
--fechamento do cursor
CLOSE PreInventoryMov_Cursor
--Destruição do cursor
DEALLOCATE PreInventoryMov_Cursor


SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -202
	GOTO ERRO
END

------------------------------------------------------------------------------
-- Atualiza o total do PO

EXEC sp_PO_AtuPOTotal @PO

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -203
	GOTO ERRO
END

OK:
	RETURN 0

ERRO:
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_Cotation_CreatePO', @ErrorLevelStr

	RETURN @ErrorLevel
GO
