SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_Inv_CalcModelStoreBalanceT] (@IDModel int, @ProcessDate datetime)
AS
/* -------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO
	1 - Deletar todos os saldos a partir da data a processar
	2 - Pegar a ultima linha de saldo imediatamente antes da data a processar
	3 - Fazer laço com as movimentações a partir da data a processar
	4 - Atualizar quantidade e custo médio

	LOG DE MODIFICAÇÕES

	Data			Programador					Modificação
	----------------------- -----------------------------------------------	--------------------------------------------------------
	14 May	2007		Maximiliano Muniz				Criação
    	-------------------------------------------------------------------------------------------------------------------------------- */

DECLARE @IDStore		int
DECLARE @MovQty			float
DECLARE @ModelQty		float
DECLARE @StoreQty		float
DECLARE @MovCost		money
DECLARE @AvgCostOut		money
DECLARE @ModelBalanceTotal	money
DECLARE @StoreBalanceTotal	money
DECLARE @LastAvgCost		money
DECLARE @NewAvgCost		money
DECLARE @HasMov			int

DECLARE MODEL_CUR CURSOR FOR 
SELECT
	M.IDModel
FROM
	Model M
WHERE
	M.IDModel = @IDModel
ORDER BY
	M.IDModel

OPEN MODEL_CUR

FETCH NEXT FROM MODEL_CUR INTO
	@IDModel

WHILE @@FETCH_STATUS = 0
BEGIN
	DECLARE STORE_CUR CURSOR FOR 
	SELECT
		S.IDStore
	FROM
		Store S
	WHERE
		S.System = 0
		AND S.Hidden = 0
		AND S.Desativado = 0
	ORDER BY
		S.IDStore
	
	OPEN STORE_CUR
	
	FETCH NEXT FROM STORE_CUR INTO
		@IDStore

	WHILE @@FETCH_STATUS = 0
	BEGIN
		-- Deleto os saldos a partir da data de processamento
		DELETE Inv_ModelStoreBalance WHERE IDStore = @IDStore AND IDModel = @IDModel AND BalanceDate >= @ProcessDate

		SELECT @HasMov = COUNT(*)
		FROM InventoryMov IM (NOLOCK)
		WHERE IM.StoreID = @IDStore AND IM.ModelID = @IDModel AND CONVERT(smalldatetime, CONVERT(varchar, IM.MovDate, 103), 103) = @ProcessDate AND IM.InventMovTypeID IN (1, 2, 3, 4, 5, 7, 8, 11, 12, 19, 21, 22)

		IF @HasMov > 0
		BEGIN
			SET @ModelQty = 0
			SET @AvgCostOut = 0
			SET @ModelBalanceTotal = 0

			INSERT INTO Inv_ModelStoreBalance (IDStore, IDModel, BalanceDate, Qty, AvgCostOut, BalanceTotal)
			VALUES (@IDStore, @IDModel, @ProcessDate, @ModelQty, @AvgCostOut, @ModelBalanceTotal)

			-------------------------------------------------------------------------------------------------
			-- Pego os valores de quantidade e saldo do modelo, da última data antes da data de processamento
			SELECT
				@ModelQty = MB.Qty,
				@AvgCostOut = MB.AvgCostOut,
				@ModelBalanceTotal = MB.BalanceTotal
			FROM
				Inv_ModelStoreBalance MB (NOLOCK)
			WHERE
				MB.IDStore = @IDStore
				AND MB.IDModel = @IDModel
				AND MB.BalanceDate = (	SELECT MAX(MB.BalanceDate)
							FROM Inv_ModelStoreBalance MB (NOLOCK) 
							WHERE MB.IDStore = @IDStore AND MB.IDModel = @IDModel AND MB.BalanceDate < @ProcessDate
							GROUP BY MB.IDModel)
			--PRINT 'Loja = ' + cast(@IDStore as varchar) + 'Data processo = ' + cast(@ProcessDate as varchar) + ' Qtd anterior = ' + cast(@ModelQty as varchar)
			----------------------------------------------------------------------
			-- Calculo o custo médio da última data antes da data de processamento
			IF @ModelQty > 0
				SET @LastAvgCost = @ModelBalanceTotal / @ModelQty
			ELSE
				SET @LastAvgCost = 0

			---------------------------------------------------------------------------------------------------
			-- Pego o total de quantidades de entrada, sem compras, transferência e importação. Esta quantidade
			-- será adicionada à quantidade total de estoque, sem afetar o custo médio.
			SET @MovQty = 0
			SELECT
				@MovQty = SUM((2*IMT.UpdateOnHand-1) * IsNull(IM.Qty, 0))
			FROM
				InventoryMov IM (NOLOCK) 
				JOIN InventoryMovType IMT (NOLOCK) ON (IM.InventMovTypeID = IMT.IDInventMovType)
			WHERE
				IM.StoreID = @IDStore
				AND IM.ModelID = @IDModel
				AND IMT.UpdateOnHand = 1
				AND (IMT.IDInventMovType in (4, 11, 19, 21) OR (IMT.IDInventMovType = 2 AND IM.Qty < 0))
				AND CONVERT(smalldatetime, CONVERT(varchar, IM.MovDate, 103), 103) = @ProcessDate
			GROUP BY
				IM.ModelID

			--PRINT 'Loja = ' + cast(@IDStore as varchar) + 'Qtd sem compras, etc = ' + cast(@MovQty as varchar)
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

			----------------------------------------------------------------------
			-- Pego a quantidade e o custo total comprado, transferido e importado
			SET @MovQty = 0
			SET @MovCost = 0
			SELECT
				@MovQty = SUM((2*IMT.UpdateOnHand-1) * IsNull(IM.Qty, 0)),
				@MovCost = SUM(IsNull(IM.CostPrice, 0) * ((2*IMT.UpdateOnHand-1) * IsNull(IM.Qty, 0)))
			FROM
				InventoryMov IM (NOLOCK) 
				JOIN InventoryMovType IMT (NOLOCK)  ON (IM.InventMovTypeID = IMT.IDInventMovType)
			WHERE
				IM.StoreID = @IDStore
				AND IM.ModelID = @IDModel
				AND IMT.UpdateOnHand = 1
				AND (IMT.IDInventMovType in (2, 5, 8) AND IM.Qty > 0)
				AND CONVERT(smalldatetime, CONVERT(varchar, IM.MovDate, 103), 103) = @ProcessDate
			GROUP BY
				IM.ModelID

			--PRINT 'Loja = ' + cast(@IDStore as varchar) + 'Qtd compras, etc = ' + cast(@MovQty as varchar)
			---------------------------------------------------------------------------------------------------
			-- Calculo a nova quantidade e valor total do estoque. Se a quantidade em estoque antes das compras
			-- for negativa, deve ser encontrado o custo médio das compras para achar o valor total de estoque
			-- com a diferença entre a quantidade anterior e a comprada.
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

			--PRINT 'Loja = ' + cast(@IDStore as varchar) + 'Qtd anterior = ' + cast(@ModelQty as varchar) + ' Qtd para somar = ' + cast(@MovQty as varchar)
			SET @ModelQty = IsNull(@ModelQty, 0) + IsNull(@MovQty, 0)

			------------------------------------------------------------------------------------------------
			-- Atualizo o saldo da data a processar calculando com base nas movimentações de entrada do dia.
			UPDATE
				Inv_ModelStoreBalance
			SET
				Qty = @ModelQty,
				AvgCostOut = (SELECT AvgCostOut FROM Inv_ModelBalance WHERE IDModel = @IDModel AND BalanceDate = (SELECT MAX(BalanceDate) FROM Inv_ModelBalance WHERE IDModel = @IDModel AND BalanceDate <= @ProcessDate)),
				BalanceTotal = @ModelQty * (SELECT AvgCostOut FROM Inv_ModelBalance WHERE IDModel = @IDModel AND BalanceDate = (SELECT MAX(BalanceDate) FROM Inv_ModelBalance WHERE IDModel = @IDModel AND BalanceDate <= @ProcessDate))
			WHERE
				IDStore = @IDStore
				AND IDModel = @IDModel
				AND BalanceDate = @ProcessDate

			-------------------------------------------------------------------------------------------------------
			-- Pego o total de quantidades de saída. Esta quantidade será removida da quantidade total de estoque,
			-- sem afetar o custo médio, desde que não zere a quantidade.
			SET @MovQty = 0
			SELECT
				@NewAvgCost = SUM((CASE WHEN IsNull(IM.Qty, 0) > 0 THEN (CASE WHEN @NewAvgCost > 0 THEN @NewAvgCost ELSE @AvgCostOut END) ELSE ISNULL(EXAVG.AvgCostOut, @AvgCostOut) END) * ((2*IMT.UpdateOnHand-1) * IsNull(IM.Qty, 0))),
				@MovQty = SUM((2*IMT.UpdateOnHand-1) * IsNull(IM.Qty, 0))
			FROM
				InventoryMov IM (NOLOCK) 
				JOIN InventoryMovType IMT (NOLOCK) ON (IM.InventMovTypeID = IMT.IDInventMovType)
				LEFT OUTER JOIN (SELECT ModelID, PreInventoryMovID, CONVERT(smalldatetime, CONVERT(varchar, MovDate, 103), 103) MovDate FROM InventoryMov (NOLOCK) WHERE StoreID = @IDStore AND ModelID = @IDModel) EX ON (IM.ModelID = EX.ModelID AND IM.IDPreInvMovExchange = EX.PreInventoryMovID)
				LEFT OUTER JOIN (SELECT IDModel, BalanceDate, AvgCostOut FROM Inv_ModelStoreBalance (NOLOCK) WHERE IDStore = @IDStore AND IDModel = @IDModel) EXAVG ON (IM.ModelID = EXAVG.IDModel AND CONVERT(smalldatetime, CONVERT(varchar, EX.MovDate, 103), 103) = EXAVG.BalanceDate)
			WHERE
				IM.StoreID = @IDStore
				AND IM.ModelID = @IDModel
				AND IMT.UpdateOnHand = 0
				AND IMT.IDInventMovType in (1, 3, 7, 12, 22)
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
	
				UPDATE Inv_ModelStoreBalance
				SET Qty = @ModelQty, AvgCostOut = (SELECT AvgCostOut FROM Inv_ModelBalance WHERE IDModel = @IDModel AND BalanceDate = (SELECT MAX(BalanceDate) FROM Inv_ModelBalance WHERE IDModel = @IDModel AND BalanceDate <= @ProcessDate)), BalanceTotal = @ModelQty * (SELECT AvgCostOut FROM Inv_ModelBalance WHERE IDModel = @IDModel AND BalanceDate = (SELECT MAX(BalanceDate) FROM Inv_ModelBalance WHERE IDModel = @IDModel AND BalanceDate <= @ProcessDate))
				WHERE IDStore = @IDStore AND IDModel = @IDModel AND BalanceDate = @ProcessDate
			END
		END

		FETCH NEXT FROM STORE_CUR INTO
			@IDStore
	END

	CLOSE STORE_CUR
	DEALLOCATE STORE_CUR

	FETCH NEXT FROM MODEL_CUR INTO
		@IDModel
END

CLOSE MODEL_CUR
DEALLOCATE MODEL_CUR
GO
