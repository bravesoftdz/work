SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[sp_Inventory_Tranfer_IN]
	(
	@IDModelTransf	int
	)
 AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Delecao do InventoryMov
		- Atualizo o model
		- Atualizo o custo médio no Model
		- Insiro InventoryMov
		- Atualizo o custo médio no Inventory

	TABELA DE ERROS PARA RETURN_VALUE

	 000  Ok
	-201  Erro em Delecao do InventoryMov
	-202  Erro em Inserir Model
	-203  Erro em Atualizo o custo médio no Model
	-204  Erro em Insiro InventoryMov
	-205  Erro em Atualizo o custo médio no Inventory

	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------------------------------------------------------------------------------------------------------------
	16 Jul 2005		Rodrigo Costa		Criação;
	05 Jun 2006		Carlos Lima		Adicionado Custo médio na inserção de InventoryMov
	16 Jun 2006		Carlos Lima		Atualização do custo médio
        22 Jan 2007             Maic Nogueira           Adicionado Kit na transferência de itens.
	01 Abr 2009		Rodrigo Costa		Atualizar Lote
        ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

DECLARE @ErrorLevel		int
DECLARE @SysError		int

--Declaração de variáveis para o Cursor de InventoryMov
DECLARE @DocumentID		int
DECLARE @ModelID		int
DECLARE @Qty			float
DECLARE @TransfDate		datetime
DECLARE @CostPrice		money
DECLARE @IDUser 		int 
DECLARE @PreInventoryMovID 	int 
DECLARE @IDInventoryMov    	int
DECLARE @StoreIDOrigem 	int 
DECLARE @StoreIDDestino 	int 
DECLARE @AvgCost 		money 
DECLARE @AvgCostCalc		money
DECLARE @IDInventory		int
DECLARE @IDLote			int

BEGIN TRAN


/*--------------------------------------------------------------*/
/*		Parte da Delecao do InventoryMov        	*/
/*--------------------------------------------------------------*/

DECLARE InventoryMov_Cursor CURSOR FOR

SELECT
	IDInventoryMov
FROM
	InventoryMov (NOLOCK) 
WHERE	
	InventoryMov.InventMovTypeID = 8
	AND
	InventoryMov.DocumentID = @IDModelTransf



OPEN InventoryMov_Cursor


FETCH NEXT FROM InventoryMov_Cursor INTO
	@IDInventoryMov

WHILE @@FETCH_STATUS = 0
BEGIN
	EXEC sp_Inventory_Del_Moviment @IDInventoryMov
	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		CLOSE InventoryMov_Cursor
		DEALLOCATE InventoryMov_Cursor
		SET @ErrorLevel = -201
		GOTO ERRO
	END

	FETCH NEXT FROM InventoryMov_Cursor INTO
		@IDInventoryMov
END

CLOSE InventoryMov_Cursor
DEALLOCATE InventoryMov_Cursor
--

/*--------------------------------------------------------------*/
/*		Parte da Insercao do InventoryMov        	*/
/*--------------------------------------------------------------*/

--Declaração do Cursor de InventoryMov
DECLARE TransferIN_Cursor CURSOR FOR
	SELECT
		MTD.IDModelTransf,
		MT.IDLojaOrigem,
		MT.IDLojaDestino,
		MTD.IDModel,
		MTD.Qty,
		MT.Data,
		MT.IDUser,
		MTD.IDModelTransfDet, /* guarda a linha correspondente a inserida */
		MTD.CostPrice,
		MTD.AvgCost,
		IsNull(MTD.IDLote, 0) as IDLote
	FROM
		ModelTransfDet MTD (NOLOCK) 
		INNER JOIN ModelTransf MT (NOLOCK) ON (MTD.IDModelTransf = MT.IDModelTransf)		
	WHERE
		MT.IDModelTransf = @IDModelTransf

OPEN TransferIN_Cursor

--Inicialização de TransferIN_Cursor
FETCH NEXT FROM TransferIN_Cursor INTO
	@DocumentID,
	@StoreIDOrigem,
	@StoreIDDestino,
	@ModelID,
	@Qty,
	@TransfDate,
	@IDUser,
	@PreInventoryMovID,
	@CostPrice,
	@AvgCost,
	@IDLote

--Enquanto tem registros
WHILE
@@FETCH_STATUS = 0
BEGIN

	--Atualizo o Lote
	IF @IDLote <> 0
		EXEC sp_Inventory_Lot_Adjust @ModelID, @StoreIDDestino, @IDLote, @Qty, 3


	--Inclusao da loja original
	UPDATE
		Model
	SET
		Model.AvgCostTotal = IsNull(Model.AvgCostTotal, 0) + (@AvgCost * @Qty),
		Model.AvgCost = CASE WHEN (IsNull(Model.TotQtyOnHand, 0) + @Qty) = 0 
					THEN 0 
					ELSE (IsNull(Model.AvgCostTotal, 0) + (@AvgCost * @Qty)) / (IsNull(Model.TotQtyOnHand, 0) + @Qty) 
				END
	WHERE
		Model.IDModel = @ModelID

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		CLOSE TransferIN_Cursor
		DEALLOCATE TransferIN_Cursor
		SET @ErrorLevel = -203
		GOTO ERRO
	END

	IF NOT EXISTS(SELECT ModelID FROM Inventory (NOLOCK) WHERE ModelID = @ModelID AND StoreID = @StoreIDDestino)
	BEGIN
		EXEC sp_Sis_GetNextCode'Inventory.IDInventory', @IDInventory OUTPUT
	
		INSERT Inventory
			(
			IDInventory,
			StoreID,
			ModelID
			)
		VALUES
			(
			@IDInventory,
			@StoreIDDestino,
			@ModelID
			)

		SET @SysError = @@ERROR
		IF @SysError <> 0
		BEGIN
			CLOSE TransferIN_Cursor
			DEALLOCATE TransferIN_Cursor
			SET @ErrorLevel = -204
			GOTO ERRO
		END
	END

	-- Atualiza o saldo em valor do inventory

	SELECT
		@AvgCostCalc = 
			CASE WHEN (IsNull(Inventory.QtyOnHand, 0) + @Qty) = 0 
				THEN 0 
				ELSE (IsNull(Inventory.AvgCostTotal, 0) + (@AvgCost * @Qty)) / (IsNull(Inventory.QtyOnHand, 0) + @Qty) 
			END
	FROM
		Inventory (NOLOCK) 
	WHERE
		Inventory.ModelID = @ModelID
		AND
		Inventory.StoreID = @StoreIDDestino


	UPDATE
		Inventory
	SET
		Inventory.AvgCostTotal = IsNull(Inventory.AvgCostTotal, 0) + (@AvgCost * @Qty),
		Inventory.StoreAvgPrice = @AvgCost
	WHERE
		Inventory.ModelID = @ModelID
		AND
		Inventory.StoreID = @StoreIDDestino


	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		CLOSE TransferIN_Cursor
		DEALLOCATE TransferIN_Cursor
		SET @ErrorLevel = -205
		GOTO ERRO
	END

	EXEC sp_Sis_GetNextCode'InventoryMov.IDInventoryMov', @IDInventoryMov OUTPUT

	INSERT InventoryMov
		(
		IDInventoryMov,
		InventMovTypeID,
		DocumentID,
		StoreID,
		ModelID,
		IDPessoa,
		MovDate,
		Qty,
		IDUser,
		PreInventoryMovID,
		CostPrice,
		AvgCost 
		)
	VALUES
		(
		@IDInventoryMov,
		8,   /* entrada da loja destino */
		@DocumentID,
		@StoreIDDestino,
		@ModelID,
		0,
		@TransfDate,
		@Qty,
		@IDUser,
		@PreInventoryMovID, /* guarda a linha correspondente a inserida */
		@CostPrice,
		@AvgCost 
		)

	DECLARE TransferITEMS_Cursor CURSOR FOR
	SELECT
		P.IDModel,
		P.Qty * @Qty,
		M.VendorCost,
		M.AvgCost
	FROM
		PackModel P (NOLOCK) 
		JOIN Model M (NOLOCK) ON (P.IDModel = M.IDModel) 
	WHERE
		IDPackModel = @ModelID
	
	OPEN TransferITEMS_Cursor
	
	--Inicialização de TransferITEMS_Cursor
	FETCH NEXT FROM TransferITEMS_Cursor INTO
		@ModelID,
		@Qty,
		@CostPrice,
		@AvgCost
	
	--Enquanto tem registros
	WHILE @@FETCH_STATUS = 0
	BEGIN
		IF NOT EXISTS(SELECT ModelID FROM Inventory WHERE ModelID = @ModelID AND StoreID = @StoreIDDestino)
		BEGIN
			EXEC sp_Sis_GetNextCode'Inventory.IDInventory', @IDInventory OUTPUT
		
			INSERT Inventory
				(
				IDInventory,
				StoreID,
				ModelID
				)
			VALUES
				(
				@IDInventory,
				@StoreIDDestino,
				@ModelID
				)
		END

		--Inclusao da loja original
		EXEC sp_Sis_GetNextCode 'InventoryMov.IDInventoryMov', @IDInventoryMov OUTPUT

		INSERT InventoryMov
			(
			IDInventoryMov,
			InventMovTypeID,
			DocumentID,
			StoreID,
			ModelID,
			IDPessoa,
			MovDate,
			Qty,
			IDUser,
			PreInventoryMovID,
			CostPrice,
			AvgCost
			)
		VALUES
			(
			@IDInventoryMov,
			8,   /* saida da loja original */
			@DocumentID,
			@StoreIDDestino,
			@ModelID,
			0,
			@TransfDate,
			@Qty,
			@IDUser,
			@PreInventoryMovID, /* guarda a linha correspondente a inserida */
			@CostPrice,
			@AvgCost
			)

		SET @SysError = @@ERROR
		IF @SysError <> 0
		BEGIN
			CLOSE TransferITEMS_Cursor
			DEALLOCATE TransferITEMS_Cursor
			CLOSE TransferIN_Cursor
			DEALLOCATE TransferIN_Cursor
			SET @ErrorLevel = -204
			GOTO ERRO
		END

		FETCH NEXT FROM TransferITEMS_Cursor INTO
			@ModelID,
			@Qty,
			@CostPrice,
			@AvgCost
	END

	--fechamento do cursor
	CLOSE TransferITEMS_Cursor
	--Destruição do cursor
	DEALLOCATE TransferITEMS_Cursor

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		CLOSE TransferIN_Cursor
		DEALLOCATE TransferIN_Cursor
		SET @ErrorLevel = -202
		GOTO ERRO
	END

	FETCH NEXT FROM TransferIN_Cursor INTO
		@DocumentID,
		@StoreIDOrigem,
		@StoreIDDestino,
		@ModelID,
		@Qty,
		@TransfDate,
		@IDUser,
		@PreInventoryMovID,
		@CostPrice,
		@AvgCost,
		@IDLote
END

--fechamento do cursor
CLOSE TransferIN_Cursor
--Destruição do cursor
DEALLOCATE TransferIN_Cursor

OK:
	COMMIT TRAN
	RETURN 0
ERRO:
	ROLLBACK TRAN
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_Inventory_Tranfer_IN', @ErrorLevelStr

	RETURN @ErrorLevel
GO
