IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[sp_Inv_CalcModelBalance]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[sp_Inv_CalcModelBalance]
GO

CREATE PROCEDURE sp_Inv_CalcModelBalance (@ProcessDate datetime)
AS
/* -------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO
	1 - Deletar todos os saldos a partir da data a processar
	2 - Pegar a ultima linha de saldo imediatamente antes da data a processar
	3 - Fazer la�o com as movimenta��es a partir da data a processar
	4 - Atualizar quantidade e custo m�dio

	LOG DE MODIFICA��ES

	Data			Programador					Modifica��o
	----------------------- -----------------------------------------------	--------------------------------------------------------
	22 Sep	2006		Carlos Lima, Leonardo Riego e Max Muniz		Cria��o
    	-------------------------------------------------------------------------------------------------------------------------------- */

DECLARE @IDModel		int
DECLARE @MovQty			float
DECLARE @ModelQty		float
DECLARE @StoreQty		float
DECLARE @MovCost		money
DECLARE @AvgCostOut		money
DECLARE @ModelBalanceTotal	money
DECLARE @StoreBalanceTotal	money
DECLARE @LastAvgCost		money
DECLARE @NewAvgCost		money
DECLARE @HasMov			integer

DECLARE MODEL_CUR CURSOR FOR 
SELECT
	M.IDModel
FROM
	Model M
ORDER BY
	M.IDModel

OPEN MODEL_CUR

FETCH NEXT FROM MODEL_CUR INTO
	@IDModel

WHILE @@FETCH_STATUS = 0
BEGIN
	-- Deleto os saldos a partir da data de processamento
	DELETE Inv_ModelBalance WHERE IDModel = @IDModel AND BalanceDate >= @ProcessDate


	SELECT @HasMov = COUNT(*)
	FROM InventoryMov IM
	WHERE IM.ModelID = @IDModel AND CONVERT(smalldatetime, CONVERT(varchar, IM.MovDate, 103), 103) = @ProcessDate AND IM.InventMovTypeID IN (1, 2, 3, 4, 5, 11, 12, 19, 21, 22)


	IF @HasMov > 0
	BEGIN
		SET @ModelQty = 0
		SET @AvgCostOut = 0
		SET @ModelBalanceTotal = 0

		INSERT INTO Inv_ModelBalance (IDModel, BalanceDate, Qty, AvgCostOut, BalanceTotal)
		VALUES (@IDModel, @ProcessDate, @ModelQty, @AvgCostOut, @ModelBalanceTotal)


		-------------------------------------------------------------------------------------------------
		-- Pego os valores de quantidade e saldo do modelo, da �ltima data antes da data de processamento
		SELECT
			@ModelQty = MB.Qty,
			@AvgCostOut = MB.AvgCostOut,
			@ModelBalanceTotal = MB.BalanceTotal
		FROM
			Inv_ModelBalance MB
		WHERE
			MB.IDModel = @IDModel
			AND MB.BalanceDate = (	SELECT MAX(MB.BalanceDate)
						FROM Inv_ModelBalance MB
						WHERE MB.IDModel = @IDModel AND MB.BalanceDate < @ProcessDate
						GROUP BY MB.IDModel)


		----------------------------------------------------------------------
		-- Calculo o custo m�dio da �ltima data antes da data de processamento
		IF @ModelQty > 0
			SET @LastAvgCost = @ModelBalanceTotal / @ModelQty
		ELSE
			SET @LastAvgCost = 0


		-------------------------------------------------------------------------------------------------------
		-- Pego o total de quantidades de entrada, sem compras e importa��o. Esta quantidade ser� adicionada �
		-- quantidade total de estoque, sem afetar o custo m�dio.
		SET @MovQty = 0
		SELECT
			@MovQty = SUM((2*IMT.UpdateOnHand-1) * IsNull(IM.Qty, 0))
		FROM
			InventoryMov IM
			JOIN InventoryMovType IMT ON (IM.InventMovTypeID = IMT.IDInventMovType)
		WHERE
			IM.ModelID = @IDModel
			AND IMT.UpdateOnHand = 1
			AND (IMT.IDInventMovType in (4, 11, 19, 21) OR (IMT.IDInventMovType = 2 AND IM.Qty < 0))
			AND CONVERT(smalldatetime, CONVERT(varchar, IM.MovDate, 103), 103) = @ProcessDate
		GROUP BY
			IM.ModelID


		-----------------------------------------------------
		-- Calculo a nova quantidade e valor total do estoque
		SET @ModelQty = IsNull(@ModelQty, 0) + IsNull(@MovQty, 0)
		IF @ModelQty > 0
		BEGIN
			SET @ModelBalanceTotal = @ModelBalanceTotal + (IsNull(@MovQty, 0) * @LastAvgCost)
			SET @AvgCostOut = @ModelBalanceTotal / @ModelQty
		END
		ELSE
			SET @ModelBalanceTotal = 0


		---------------------------------------------------------
		-- Pego a quantidade e o custo total comprado e importado
		SET @MovQty = 0
		SET @MovCost = 0
		SELECT
			@MovQty = SUM((2*IMT.UpdateOnHand-1) * IsNull(IM.Qty, 0)),
			@MovCost = SUM(IsNull(IM.CostPrice, 0) * ((2*IMT.UpdateOnHand-1) * IsNull(IM.Qty, 0)))
		FROM
			InventoryMov IM
			JOIN InventoryMovType IMT ON (IM.InventMovTypeID = IMT.IDInventMovType)
		WHERE
			IM.ModelID = @IDModel
			AND IMT.UpdateOnHand = 1
			AND (IMT.IDInventMovType in (2, 5) AND IM.Qty > 0)
			AND CONVERT(smalldatetime, CONVERT(varchar, IM.MovDate, 103), 103) = @ProcessDate
		GROUP BY
			IM.ModelID


		---------------------------------------------------------------------------------------------------
		-- Calculo a nova quantidade e valor total do estoque. Se a quantidade em estoque antes das compras
		-- for negativa, deve ser encontrado o custo m�dio das compras para achar o valor total de estoque
		-- com a diferen�a entre a quantidade anterior e a comprada.
		IF (@ModelQty + @MovQty) > 0
		BEGIN
			IF @ModelQty < 0
				SET @ModelBalanceTotal = (@MovCost / @MovQty) * (@ModelQty + @MovQty)
			ELSE
				SET @ModelBalanceTotal = @ModelBalanceTotal + @MovCost

			SET @AvgCostOut = @ModelBalanceTotal / (@ModelQty + @MovQty)
			SET @NewAvgCost = @ModelBalanceTotal / (@ModelQty + @MovQty)
		END
		ELSE
		BEGIN
			SET @ModelBalanceTotal = 0
			SET @NewAvgCost = 0
		END

		SET @ModelQty = IsNull(@ModelQty, 0) + IsNull(@MovQty, 0)


		------------------------------------------------------------------------------------------------
		-- Atualizo o saldo da data a processar calculando com base nas movimenta��es de entrada do dia.
		UPDATE
			Inv_ModelBalance
		SET
			Qty = @ModelQty,
			AvgCostOut = @AvgCostOut,
			BalanceTotal = @ModelBalanceTotal
		WHERE
			IDModel = @IDModel
			AND BalanceDate = @ProcessDate


		-------------------------------------------------------------------------------------------------------
		-- Pego o total de quantidades de sa�da. Esta quantidade ser� removida da quantidade total de estoque,
		-- sem afetar o custo m�dio, desde que n�o zere a quantidade.
		SET @MovQty = 0
		SELECT
			@NewAvgCost = SUM((CASE WHEN IsNull(IM.Qty, 0) > 0 THEN (CASE WHEN @NewAvgCost > 0 THEN @NewAvgCost ELSE @AvgCostOut END) ELSE ISNULL(EXAVG.AvgCostOut, @AvgCostOut) END) * ((2*IMT.UpdateOnHand-1) * IsNull(IM.Qty, 0))),
			@MovQty = SUM((2*IMT.UpdateOnHand-1) * IsNull(IM.Qty, 0))
		FROM
			InventoryMov IM
			JOIN InventoryMovType IMT ON (IM.InventMovTypeID = IMT.IDInventMovType)
			LEFT OUTER JOIN (SELECT ModelID, PreInventoryMovID, CONVERT(smalldatetime, CONVERT(varchar, MovDate, 103), 103) MovDate FROM InventoryMov WHERE ModelID = @IDModel) EX ON (IM.ModelID = EX.ModelID AND IM.IDPreInvMovExchange = EX.PreInventoryMovID)
			LEFT OUTER JOIN (SELECT IDModel, BalanceDate, AvgCostOut FROM Inv_ModelBalance WHERE IDModel = @IDModel) EXAVG ON (IM.ModelID = EXAVG.IDModel AND CONVERT(smalldatetime, CONVERT(varchar, EX.MovDate, 103), 103) = EXAVG.BalanceDate)
		WHERE
			IM.ModelID = @IDModel
			AND IMT.UpdateOnHand = 0
			AND IMT.IDInventMovType in (1, 3, 12, 22)
			AND CONVERT(smalldatetime, CONVERT(varchar, IM.MovDate, 103), 103) = @ProcessDate
		GROUP BY
			IM.ModelID

		IF @MovQty <> 0
		BEGIN
			SET @ModelQty = @ModelQty + @MovQty
			IF @ModelQty > 0
					SET @ModelBalanceTotal = @ModelBalanceTotal + @NewAvgCost
			ELSE
				SET @ModelBalanceTotal = 0

			UPDATE Inv_ModelBalance
			SET Qty = @ModelQty, AvgCostOut = (CASE WHEN @ModelQty > 0 THEN @ModelBalanceTotal / @ModelQty ELSE @AvgCostOut END), BalanceTotal = @ModelBalanceTotal
			WHERE IDModel = @IDModel AND BalanceDate = @ProcessDate
		END
	END

	FETCH NEXT FROM MODEL_CUR INTO
		@IDModel
END

CLOSE MODEL_CUR
DEALLOCATE MODEL_CUR

GO