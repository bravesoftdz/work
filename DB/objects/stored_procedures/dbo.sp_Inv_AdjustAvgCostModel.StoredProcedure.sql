SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_Inv_AdjustAvgCostModel] (@IDModel	int)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Zera Valores de AvgCost e AvgCostTotal no Model
		- Atualiza o AvgCostTotal ( e AvgCost se necessário ) no Model

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Zera Valores de AvgCost e AvgCostTotal no Model
		-202  Atualiza o AvgCostTotal ( e AvgCost se necessário ) no Model


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	----------------------- ----------------------- -------------------------------- -----------------------------------------------------------------------------------------------------
	23 Jun  2006		Carlos Lima		Criação
    	-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

DECLARE @IDInventoryMov			int
DECLARE @IDPreInventoryMov		int
DECLARE @IDStore			int
DECLARE @InventMovTypeID		int
DECLARE @Qty				float
DECLARE @CostPrice			float
DECLARE @MovFactor			float
DECLARE @DocumentID			int

DECLARE @QtyModel			float

DECLARE @AvgCostTotalModel		float

DECLARE @AvgCostInventoryMov		float




DECLARE @CostPriceModel			float



DECLARE @AvgCostModel			float

DECLARE @NomeMov			varchar(60)

DECLARE @ErrorLevel 			int
DECLARE @SysError			int
DECLARE @PrintDebug			bit


DECLARE @TransactionName		varchar(60)

SET @ErrorLevel = 0
SET @PrintDebug = 0

SET @TransactionName = 'Tran_sp_Inv_AdjustAvgCostModel'

SET @AvgCostTotalModel = 0



BEGIN TRANSACTION @TransactionName



UPDATE	
	Model	
SET
	AvgCostTotal	= 0,
	AvgCost 	= 0
WHERE
	IDModel = @IDModel

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END


SET @QtyModel = 0

DECLARE AVG_CUR CURSOR FOR 
SELECT
	IMV.PreInventoryMovID,
	IMV.IDInventoryMov,
	IMV.StoreID,
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
ORDER BY
	IMV.IDInventoryMov

OPEN AVG_CUR

FETCH NEXT FROM AVG_CUR INTO
	@IDPreInventoryMov,
	@IDInventoryMov,
	@IDStore,
	@InventMovTypeID,
	@Qty,
	@CostPrice,
	@MovFactor,
	@DocumentID,
	@NomeMov

WHILE @@FETCH_STATUS = 0
BEGIN

	SELECT
		@AvgCostTotalModel	= IsNull(AvgCostTotal, 0)
	FROM
		Model
	WHERE
		IDModel = @IDModel

	/* Zera os valores, caso a movimentação zere o estoque */
	IF (@QtyModel + @Qty) = 0
		BEGIN
			SET @AvgCostModel = 0
			SET @AvgCostTotalModel = 0
		END


	IF @MovFactor = 1
		BEGIN			
			IF (@QtyModel + @Qty) <> 0
				BEGIN
					/* 
						Se for Entrada por transferencia, pega o custo médio salvo 
						na saida como preco de custo 
					*/
					IF @InventMovTypeID = 8
						BEGIN
							SELECT
								@CostPriceModel = IsNull(AvgCost, 0)
							FROM
								ModelTransf MT (NOLOCK) INNER JOIN
								ModelTransfDet MTD (NOLOCK) ON (MT.IDModelTransf = MTD.IDModelTransf)
							WHERE	
								
								MT.IDModelTransf = @DocumentID
								AND
								MTD.IDModelTransfDet = @IDPreInventoryMov						

						END
					ELSE
						BEGIN
							SET @CostPriceModel = IsNull(@CostPrice, 0)
						END
	
	
					SET @AvgCostModel = (@AvgCostTotalModel + (@Qty * IsNull(@CostPriceModel, 0))) / (@QtyModel + @Qty)
					SET @AvgCostTotalModel = @AvgCostTotalModel + (@Qty * IsNull(@CostPriceModel, 0))
				END
	
			
			SET @QtyModel = @QtyModel + @Qty
	
			UPDATE 
				Model 
			SET 
				AvgCost	= @AvgCostModel,
				AvgCostTotal = @AvgCostTotalModel
			WHERE
				IDModel = @IDModel

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
			IF (@QtyModel + @Qty) <> 0
				BEGIN
					/* 
						Se for Entrada por transferencia, pega o custo médio salvo na 
						saída como preco de custo 
					*/
					IF @InventMovTypeID = 7
						BEGIN

							SELECT
								@CostPriceModel = MTDOut.AvgCost
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
								@CostPriceModel = CASE WHEN AvgCost = 0 THEN @CostPrice ELSE AvgCost END
							FROM
								Model
							WHERE
								IDModel = @IDModel							
							
						END
	
	
					SET @AvgCostTotalModel = @AvgCostTotalModel + (@Qty * IsNull(@CostPriceModel, 0))
				END
	
			
			SET @QtyModel = @QtyModel + @Qty
	
			UPDATE 
				Model 
			SET 
				AvgCostTotal = IsNull(@AvgCostTotalModel, 0)
			WHERE
				IDModel = @IDModel

			SET @SysError = @@ERROR
			IF @SysError <> 0
			BEGIN
				CLOSE AVG_CUR
				DEALLOCATE AVG_CUR

				SET @ErrorLevel = -202
				GOTO ERRO
			END
	
		END

		if @PrintDebug = 1
		BEGIN	
			print @NomeMov
			print 'AvgCostTotal ' + convert(varchar, @AvgCostTotalModel)
			print 'Qtd Mov ' + convert(varchar, @Qty)
			print 'Qtd Atual ' + convert(varchar, @QtyModel)		
			print 'CostPrice ' + convert(varchar, @CostPriceModel)
		END

	FETCH NEXT FROM AVG_CUR INTO
		@IDPreInventoryMov,
		@IDInventoryMov,
		@IDStore,
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
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_Inv_AdjustAvgCostModel', @ErrorLevelStr

	RETURN @ErrorLevel
GO
