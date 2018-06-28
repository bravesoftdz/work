SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_Inv_AdjustAvgCostInventory] 
	(
	@IDModel int, 
	@IDStore int
	)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Zera Valores de AvgCost e AvgCostTotal no Inventory
		- Atualiza o AvgCostTotal ( e AvgCost se necessário ) no Inventory

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Zera Valores de AvgCost e AvgCostTotal no Inventory
		-202  Erro em Atualiza o AvgCostTotal ( e AvgCost se necessário ) no Inventory
		-203  Erro em Atualiza AvgCost no InventoryMov


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	----------------------- ----------------------- -------------------------------- -----------------------------------------------------------------------------------------------------
	23 Jun  2006		Carlos Lima		Criação
    	-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */


DECLARE @IDInventoryMov			int
DECLARE @IDPreInventoryMov		int

DECLARE @InventMovTypeID		int
DECLARE @Qty				float
DECLARE @CostPrice			float
DECLARE @MovFactor			float
DECLARE @DocumentID			int


DECLARE @QtyInventory			float

DECLARE @AvgCostTotalInventory		float

DECLARE @CostPriceInventory		float

DECLARE @AvgCostInventory		float
DECLARE @AvgCostInvMov		float

DECLARE @NomeMov			varchar(60)

DECLARE @ErrorLevel 			int
DECLARE @SysError			int
DECLARE @PrintDebug			bit

DECLARE @TransactionName		varchar(60)

SET @ErrorLevel = 0

SET @PrintDebug = 0

SET @TransactionName = 'Tran_sp_Inv_AdjustAvgCostInventory'

BEGIN TRANSACTION @TransactionName

SET @AvgCostTotalInventory = 0


/* Tratar */

UPDATE	
	Inventory
SET
	AvgCostTotal	= 0,
	StoreAvgPrice 	= 0
WHERE
	ModelID = @IDModel
	AND
	StoreID = @IDStore

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END



SET @QtyInventory = 0

DECLARE AVG_CUR CURSOR FOR 
SELECT
	IMV.PreInventoryMovID,
	IMV.IDInventoryMov,
	IMV.InventMovTypeID,
	(2*IMT.UpdateOnHand-1) * IsNull(IMV.Qty, 0),
	IsNull(IMV.CostPrice, 0),
	(2*IMT.UpdateOnHand-1),
	IMV.DocumentID,
	IMT.name

FROM
	InventoryMov IMV (NOLOCK) 
	INNER JOIN InventoryMovType IMT (NOLOCK) ON (IMV.InventMovTypeID = IMT.IDInventMovType)
WHERE
	ModelID = @IDModel
	AND
	StoreID = @IDStore
ORDER BY
	IMV.IDInventoryMov

OPEN AVG_CUR

FETCH NEXT FROM AVG_CUR INTO
	@IDPreInventoryMov,
	@IDInventoryMov,
	@InventMovTypeID,
	@Qty,
	@CostPrice,
	@MovFactor,
	@DocumentID,
	@NomeMov

WHILE @@FETCH_STATUS = 0
BEGIN

	SELECT
		@AvgCostTotalInventory	= IsNull(AvgCostTotal, 0)
	FROM
		Inventory
	WHERE
		ModelID = @IDModel
		AND
		StoreID = @IDStore

	/* Zera os valores, caso a movimentação zere o estoque */
	IF (@QtyInventory + @Qty) = 0
		BEGIN
			SET @AvgCostInventory = 0
			SET @AvgCostTotalInventory = 0

		END


	IF @MovFactor = 1
		BEGIN
			IF (@QtyInventory + @Qty) = 0
			BEGIN
				SET @AvgCostInvMov = @CostPrice
			END
			
			ELSE
				BEGIN
					/* 
						Se for Entrada por transferencia, pega o custo médio salvo 
						na saida como preco de custo 
					*/

					IF @InventMovTypeID = 8
						BEGIN
							SELECT
								@CostPriceInventory = IsNull(AvgCost, 0)
							FROM
								ModelTransf MT (NOLOCK)  INNER JOIN
								ModelTransfDet MTD (NOLOCK)  ON (MT.IDModelTransf = MTD.IDModelTransf)
							WHERE	
								
								MT.IDModelTransf = @DocumentID
								AND
								MTD.IDModelTransfDet = @IDPreInventoryMov						

						END
					ELSE
						BEGIN
							SET @CostPriceInventory = IsNull(@CostPrice, 0)
						END
	
	
					SET @AvgCostInventory = (@AvgCostTotalInventory + (@Qty * IsNull(@CostPriceInventory, 0))) / (@QtyInventory + @Qty)
					SET @AvgCostTotalInventory = @AvgCostTotalInventory + (@Qty * IsNull(@CostPriceInventory, 0))

					SET @AvgCostInvMov = @AvgCostInventory
				END
	
			
			SET @QtyInventory = @QtyInventory + @Qty
	
			UPDATE 
				Inventory 
			SET 
				StoreAvgPrice	= @AvgCostInventory,
				AvgCostTotal	= @AvgCostTotalInventory
			WHERE
				ModelID = @IDModel
				AND
				StoreID = @IDStore

			SET @SysError = @@ERROR
			IF @SysError <> 0
			BEGIN
				CLOSE AVG_CUR
				DEALLOCATE AVG_CUR

				SET @ErrorLevel = -202
				GOTO ERRO
			END

	
		END
	ELSE
		BEGIN

			SELECT 
				@AvgCostInvMov = CASE WHEN IsNull(StoreAvgPrice, 0) = 0 THEN IsNull(@CostPrice, 0) ELSE StoreAvgPrice END
			FROM
				Inventory
			WHERE
				ModelID = @IDModel
				AND
				StoreID = @IDStore

			IF (@QtyInventory + @Qty) <> 0
				BEGIN
					/* 
						Se for Entrada por transferencia, pega o custo médio salvo na 
						saída como preco de custo 
					*/
					IF @InventMovTypeID = 7
						BEGIN

							SELECT
								@CostPriceInventory = IsNull(MTDOut.AvgCost, 0)
							FROM
								ModelTransf MTOut (NOLOCK) 
								INNER JOIN ModelTransf MTIn (NOLOCK) 
									ON (MTOut.Number = MTIn.Number)
								INNER JOIN ModelTransfDet MTDOut (NOLOCK) 
									ON (MTOut.IDModelTransf = MTDOut.IDModelTransf)
							WHERE
								MTDOut.IDModel = @IDModel
								AND
								MTIn.IDModelTransf = @IDInventoryMov
							GROUP BY
								MTDOut.AvgCost											
						END
					ELSE
						BEGIN							
							SELECT 
								@CostPriceInventory = CASE WHEN IsNull(StoreAvgPrice, 0) = 0 THEN IsNull(@CostPrice, 0) ELSE StoreAvgPrice END
							FROM
								Inventory
							WHERE
								ModelID = @IDModel
								AND
								StoreID = @IDStore
							
						END
	
	
					SET @AvgCostTotalInventory = @AvgCostTotalInventory + (@Qty * IsNull(@CostPriceInventory, 0))
				END
	
			
			SET @QtyInventory = @QtyInventory + @Qty
	

			UPDATE 
				Inventory 
			SET 
				AvgCostTotal = @AvgCostTotalInventory
			WHERE
				ModelID = @IDModel
				AND
				StoreID = @IDStore

			SET @SysError = @@ERROR
			IF @SysError <> 0
			BEGIN
				CLOSE AVG_CUR
				DEALLOCATE AVG_CUR

				SET @ErrorLevel = -202
				GOTO ERRO
			END


	
		END

		UPDATE 
			InventoryMov
		SET
			AvgCost = @AvgCostInvMov
		WHERE
			IDInventoryMov = @IDInventoryMov

		SET @SysError = @@ERROR
		IF @SysError <> 0
		BEGIN
			CLOSE AVG_CUR
			DEALLOCATE AVG_CUR

			SET @ErrorLevel = -203
			GOTO ERRO
		END


		if @PrintDebug = 1
		BEGIN
			print @NomeMov
			print 'AvgCostTotal ' + convert(varchar, @AvgCostTotalInventory)
			print 'Qtd Mov ' + convert(varchar, @Qty)
			print 'Qtd Atual ' + convert(varchar, @QtyInventory)		
			print 'CostPrice ' + convert(varchar, @CostPriceInventory)
		END

	FETCH NEXT FROM AVG_CUR INTO
		@IDPreInventoryMov,
		@IDInventoryMov,
		@InventMovTypeID,
		@Qty,
		@CostPrice,
		@MovFactor,
		@DocumentID,
		@NomeMov
END

CLOSE AVG_CUR
DEALLOCATE AVG_CUR

OK:
	COMMIT TRANSACTION @TransactionName
	RETURN 0
ERRO:
	ROLLBACK TRANSACTION @TransactionName
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_Inv_AdjustAvgCostInventory', @ErrorLevelStr

	RETURN @ErrorLevel
GO
