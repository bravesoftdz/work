SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_Inventory_Adjust]
		(
		@IDMovType   	int,
		@IDModel   	int,
		@IDStore   	int,
		@Qty	  	float,
		@IDUser		int,
		@Date		Datetime,
		@Notes		varchar(255),
		@IDMovReason	int
		)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Ajuste estoque
		- Atualiza o Inventory
		- Atualiza o saldo em valor do Model
		- Atualiza o saldo em valor do Inventoty

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Atualiza o Inventory
		-202  Erro ao Inserir o Motivo
		-203  Atualiza o saldo em valor do Model
		-204  Atualiza o saldo em valor do Inventoty




	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	31 Mar  2006		Rodrigo Costa		Criacao;
	02 Jun	2006		Rodrigo Costa		Inserir no Inv_MovComplement
	12 Jun  2006		Carlos Lima		Atualiza o saldo em valor e o custo médio
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */


DECLARE @ErrorLevel 		int
DECLARE @SysError		int
DECLARE @IDInventoryMov		int
DECLARE @MovFactor		int
DECLARE @CostPrice		money
DECLARE @AvgCost		money
DECLARE @IDInventory 		int


SET @ErrorLevel = 0


SELECT 
	@MovFactor = (2 *UpdateOnHand-1)
FROM
	InventoryMovType (NOLOCK)
WHERE
	IDInventMovType = @IDMovType

IF @MovFactor = 1
BEGIN
	SELECT
		@CostPrice = CASE WHEN IsNull(AvgCost, 0) = 0 THEN IsNull(VendorCost, 0) ELSE IsNull(AvgCost, 0) END
	FROM
		Model (NOLOCK)
	WHERE
		IDModel = @IDModel

	-- Atualiza o saldo em valor do Model

	UPDATE
		Model
	SET
		Model.AvgCostTotal = IsNull(Model.AvgCostTotal, 0) + (@CostPrice * @Qty),
		Model.AvgCost = CASE WHEN (IsNull(Model.TotQtyOnHand, 0) + @Qty) = 0 
					THEN 0 
					ELSE (IsNull(Model.AvgCostTotal, 0) + (@CostPrice * @Qty)) / (IsNull(Model.TotQtyOnHand, 0) + @Qty) 
				END
	WHERE
		Model.IDModel = @IDModel	

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		SET @ErrorLevel = -203
		GOTO ERRO
	END


	SELECT
		@CostPrice = CASE WHEN IsNull(StoreAvgPrice, 0) = 0 THEN IsNull(StoreCostPrice, 0) ELSE IsNull(StoreAvgPrice, 0) END
	FROM
		Inventory (NOLOCK)
	WHERE
		Inventory.ModelID = @IDModel
		AND
		Inventory.StoreID = @IDStore


	IF NOT EXISTS(SELECT ModelID FROM Inventory (NOLOCK) WHERE ModelID = @IDModel AND StoreID = @IDStore)
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
			@IDStore,
			@IDModel
			)
	END



	-- Atualiza o saldo em valor do inventory

	SELECT
		@AvgCost = 
			CASE WHEN (IsNull(Inventory.QtyOnHand, 0) + @Qty) = 0 
				THEN 0 
				ELSE (IsNull(Inventory.AvgCostTotal, 0) + (@CostPrice * @Qty)) / (IsNull(Inventory.QtyOnHand, 0) + @Qty) 
			END
	FROM
		Inventory (NOLOCK)
	WHERE
		Inventory.ModelID = @IDModel
		AND
		Inventory.StoreID = @IDStore



	UPDATE
		Inventory
	SET
		Inventory.AvgCostTotal = IsNull(Inventory.AvgCostTotal, 0) + (@CostPrice * @Qty),
		Inventory.StoreAvgPrice = @AvgCost
	WHERE
		Inventory.ModelID = @IDModel
		AND
		Inventory.StoreID = @IDStore



	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		SET @ErrorLevel = -204
		GOTO ERRO
	END
END

EXEC sp_Sis_GetNextCode 'InventoryMov.IDInventoryMov', @IDInventoryMov OUTPUT

INSERT InventoryMov 	(
			IDInventoryMov,
			InventMovTypeID,
			DocumentID,
			StoreID,
			ModelID,
			MovDate,
			Qty,
			IDUser
			)
			VALUES
			(
			@IDInventoryMov,
			@IDMovType,
			0,
			@IDStore,
			@IDModel,
			@Date,
			Abs(@Qty),
			@IDUser
			)

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END

INSERT Inv_MovComplement 	(
				IDInventoryMov,
				IDMovReason,
				Notes
				)
				VALUES
				(
				@IDInventoryMov,
				@IDMovReason,
				@Notes
				)



SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -202
	GOTO ERRO
END


OK:
	RETURN 0
ERRO:
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_Inventory_Adjust', @ErrorLevelStr

	RETURN @ErrorLevel
GO
