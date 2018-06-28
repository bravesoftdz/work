SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE    PROCEDURE [dbo].[sp_Inv_CalcStoreABC]
AS

/* ----------------------------------------------------------------------------------------------------------------------
	SUMARIO

		Classifiçao ABC do Inventário por loja

		- Crio uma tabela temporaria, ordenada descendentemente por Profit
		- Marco a Primeira fatia como A, a intermediaria como B e o resto como C
		- Uso a tabela temporaria para atualizar os modelos

	TABELA DE ERROS PARA RETURN_VALUE

		 000 Ok
		-201 Erro inserir na tabela temporaria
		-202 Erro em Atualizo os Modelos
		-203 Erro no Cursor
		-204 Erro em atualizar o Model nao listados

	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	-----------------------	-----------------------	-----------------------------------------------------------------
	06 Feb	2007		Maximiliano Muniz	Criação;
	02 Mar	2007		Maximiliano Muniz	Na hora de classificar os itens, nunca classificava os de
							classe B pois a fórmula estava incorreta;
	20 May	2008		Rodrigo Costa		Calcular ABC por tipo
	10 Mar	2009		Rodrigo Costa		Eliminar produtos Estrategicos (ClasseABC <> 'E')
	----------------------------------------------------------------------------------------------------------------- */

DECLARE @ErrorLevel 	int
DECLARE @SysError	int

DECLARE @Month		int

DECLARE @ClassA		int
DECLARE @ClassB		int

DECLARE @SaleTotal	money
DECLARE @SalePercTotal	money
DECLARE @SalePerc	money
DECLARE @IDCurrentStore	int
DECLARE @IDStore	int
DECLARE @IDModel	int

DECLARE @CalcType	int
DECLARE @QtyTotal	float
DECLARE @QtyPerc	float

SET @ErrorLevel = 0

-- Meses
SELECT @Month = CONVERT(int, PropertyValue) FROM Sis_PropertyDomain (NOLOCK) WHERE Property = 'ABCCalcPeriodInMonth'
--Percentual de A
SELECT @ClassA = CONVERT(int, PropertyValue) FROM Sis_PropertyDomain (NOLOCK) WHERE Property = 'ClassAPerc'
--Percentual de B
SELECT @ClassB = CONVERT(int, PropertyValue) FROM Sis_PropertyDomain (NOLOCK) WHERE Property = 'ClassBPerc'
--Calculation Type
SELECT @CalcType = CONVERT(int, PropertyValue) FROM Sis_PropertyDomain (NOLOCK) WHERE Property = 'ABCCalcType'


--Create Temp Table
CREATE TABLE #ABCTemp
(
	IDStore int,
	IDModel int,
	SalePerc money,
	QtyPerc float
)

DECLARE Store_Cursor CURSOR FOR

	SELECT
		IDStore
	FROM
		Store
	ORDER BY
		IDStore

OPEN Store_Cursor

--Inicialização de Store_Cursor
FETCH NEXT FROM Store_Cursor INTO
	@IDStore

--Enquanto tem registros
WHILE @@FETCH_STATUS = 0
BEGIN
	IF (SELECT Convert(int, SrvValue) FROM Param Where IDParam = 63) = 2
	BEGIN
		--Calculo da Qty Total vendida
		SELECT
			@SaleTotal = SUM((SalePrice * Qty) - Discount),
			@QtyTotal = SUM(Qty)
		FROM
			vwSaleItem IM (NOLOCK) 
			JOIN Pessoa P (NOLOCK) ON (IM.ComissionID = P.IDPessoa AND IM.IDTipoPessoa = P.IDTipoPessoa)
			JOIN Model M (NOLOCK) ON (M.IDModel = IM.ModelID)
			JOIN TabGroup TG (NOLOCK) ON (IM.GroupID = TG.IDGroup)
		WHERE	
			IM.PreSaleDate >= CONVERT(datetime, CONVERT(varchar(11), DATEADD(month, - @Month, GetDate())))
			AND IM.PreSaleDate < GetDate()+1
			AND IM.InventMovTypeID = 1
			AND IM.StoreID = @IDStore
			AND TG.Service = 0
			AND M.ClasseABC <> 'E'
	
		--Insiro os percentuais de venda ordenado
		INSERT
			#ABCTemp (IDStore, IDModel, SalePerc, QtyPerc)
		SELECT
			IM.StoreID,
			IM.ModelID, -- Modelo ordenado DESC por profit
			(SUM((IM.SalePrice * IM.Qty) - Discount)/@SaleTotal) * 100, -- Percentual do total da venda em valor
			(SUM(IM.Qty) / @QtyTotal) * 100 -- Percentual do total da qtd vendida
		FROM
			vwSaleItem IM (NOLOCK) 
			JOIN Pessoa P (NOLOCK) ON (IM.ComissionID = P.IDPessoa AND IM.IDTipoPessoa = P.IDTipoPessoa)
			JOIN Model M (NOLOCK) ON (M.IDModel = IM.ModelID)
			JOIN TabGroup TG (NOLOCK) ON (IM.GroupID = TG.IDGroup)
		WHERE	
			IM.PreSaleDate >= CONVERT(datetime, CONVERT(varchar(11), DATEADD(month, - @Month, GetDate())))
			AND IM.PreSaleDate < GetDate()+1
			AND IM.InventMovTypeID = 1
			AND IM.StoreID = @IDStore
			AND TG.Service = 0
			AND M.ClasseABC <> 'E'
		GROUP BY
			IM.StoreID,
			IM.ModelID,
			M.SellingPrice
	END
	ELSE
	BEGIN
		--Calculo da Qty Total vendida
		SELECT
			@SaleTotal = SUM((SalePrice * Qty) - Discount),
			@QtyTotal = SUM(Qty)
		FROM
			InventoryMov IM (NOLOCK) 
			JOIN Model M (NOLOCK) ON (M.IDModel = IM.ModelID)
			JOIN TabGroup TG (NOLOCK) ON (M.GroupID = TG.IDGroup)
		WHERE	
			IM.MovDate >= CONVERT(datetime, CONVERT(varchar(11), DATEADD(month, - @Month, GetDate())))
			AND IM.MovDate < GetDate()+1
			AND IM.InventMovTypeID = 1
			AND IM.StoreID = @IDStore
			AND TG.Service = 0
			AND M.ClasseABC <> 'E'
	
		--Insiro os percentuais de venda ordenado
		INSERT
			#ABCTemp (IDStore, IDModel, SalePerc, QtyPerc)
		SELECT
			IM.StoreID,
			IM.ModelID, -- Modelo ordenado DESC por profit
			(SUM((IM.SalePrice * IM.Qty) - Discount)/@SaleTotal) * 100, -- Percentual do total da venda em valor
			(SUM(IM.Qty) / @QtyTotal) * 100 -- Percentual do total da qtd vendida
		FROM
			InventoryMov IM (NOLOCK) 
			JOIN Model M (NOLOCK) ON (M.IDModel = IM.ModelID)
			JOIN TabGroup TG (NOLOCK) ON (M.GroupID = TG.IDGroup)
		WHERE	
			IM.MovDate >= CONVERT(datetime, CONVERT(varchar(11), DATEADD(month, - @Month, GetDate())))
			AND IM.MovDate < GetDate()+1
			AND IM.InventMovTypeID = 1
			AND IM.StoreID = @IDStore
			AND TG.Service = 0
			AND M.ClasseABC <> 'E'
		GROUP BY
			IM.StoreID,
			IM.ModelID
	END
	
	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		SET @ErrorLevel = -201
		GOTO ERRO
	END

	FETCH NEXT FROM Store_Cursor INTO
		@IDStore
END

--fechamento do cursor
CLOSE Store_Cursor

--Destruição do cursor
DEALLOCATE Store_Cursor

SET @IDCurrentStore = -1

IF @CalcType = 1
BEGIN
	
	--Declaração do Cursor de CalcABC
	DECLARE CalcABC_Cursor CURSOR FOR
	
		SELECT
			IDStore,
			IDModel,
			SalePerc
		FROM
			#ABCTemp
		ORDER BY
			IDStore,
			SalePerc DESC,
			QtyPerc DESC
	
	OPEN CalcABC_Cursor
	
	--Inicialização de CalcABC_Cursor
	FETCH NEXT FROM CalcABC_Cursor INTO
		@IDStore,
		@IDModel,
		@SalePerc
	
	--Enquanto tem registros
	WHILE @@FETCH_STATUS = 0
	BEGIN
		IF @IDStore <> @IDCurrentStore
		BEGIN
			SET @SalePercTotal = 0
			SET @IDCurrentStore = @IDStore
		END
	
		SET @SalePercTotal = @SalePercTotal + @SalePerc
	
		UPDATE
			Inventory
		SET
			ClassABC =
				CASE
					WHEN (@SalePercTotal <= @ClassA) THEN 'A'
					WHEN ((@SalePercTotal > @ClassA) AND (@SalePercTotal <= @ClassA + @ClassB)) THEN 'B'
					ELSE 'C'
				END
		WHERE
			StoreID = @IDStore
			AND ModelID = @IDModel
			AND ClassABC <> 'E'
	
		SET @SysError = @@ERROR
		IF @SysError <> 0
		BEGIN
			CLOSE CalcABC_Cursor
			DEALLOCATE CalcABC_Cursor
			SET @ErrorLevel = -202
			GOTO ERRO
		END
	
		FETCH NEXT FROM CalcABC_Cursor INTO
			@IDStore,
			@IDModel,
			@SalePerc
	END
	
	--fechamento do cursor
	CLOSE CalcABC_Cursor
	
	--Destruição do cursor
	DEALLOCATE CalcABC_Cursor
END
ELSE
BEGIN

	--Declaração do Cursor de CalcABC
	DECLARE CalcABC_Qty_Cursor CURSOR FOR
	
		SELECT
			IDStore,
			IDModel,
			QtyPerc
		FROM
			#ABCTemp
		ORDER BY
			IDStore,
			QtyPerc DESC,
			SalePerc DESC
	
	OPEN CalcABC_Qty_Cursor
	
	--Inicialização de CalcABC_Qty_Cursor
	FETCH NEXT FROM CalcABC_Qty_Cursor INTO
		@IDStore,
		@IDModel,
		@QtyPerc
	
	--Enquanto tem registros
	WHILE @@FETCH_STATUS = 0
	BEGIN
		IF @IDStore <> @IDCurrentStore
		BEGIN
			SET @SalePercTotal = 0
			SET @IDCurrentStore = @IDStore
		END
	
		SET @SalePercTotal = @SalePercTotal + @QtyPerc
	
		UPDATE
			Inventory
		SET
			ClassABC =
				CASE
					WHEN (@SalePercTotal <= @ClassA) THEN 'A'
					WHEN ((@SalePercTotal > @ClassA) AND (@SalePercTotal <= @ClassA + @ClassB)) THEN 'B'
					ELSE 'C'
				END
		WHERE
			StoreID = @IDStore
			AND ModelID = @IDModel
			AND ClassABC <> 'E'
	
		SET @SysError = @@ERROR
		IF @SysError <> 0
		BEGIN
			CLOSE CalcABC_Qty_Cursor
			DEALLOCATE CalcABC_Qty_Cursor
			SET @ErrorLevel = -202
			GOTO ERRO
		END
	
		FETCH NEXT FROM CalcABC_Qty_Cursor INTO
			@IDStore,
			@IDModel,
			@QtyPerc
	END
	
	--fechamento do cursor
	CLOSE CalcABC_Qty_Cursor
	
	--Destruição do cursor
	DEALLOCATE CalcABC_Qty_Cursor

END

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -203
	GOTO ERRO
END

--Atualiza os modelos que nao estao nesta listagem
UPDATE
	I
SET
	ClassABC = 'C'
FROM
	Inventory I (NOLOCK) 
	LEFT JOIN #ABCTemp T ON (I.StoreID = T.IDStore AND I.ModelID = T.IDModel)
WHERE
	T.IDStore IS NULL
	AND T.IDModel IS NULL
	AND ClassABC <> 'E'

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -204
	GOTO ERRO
END

-- Drop a tabela temporaria
DROP TABLE #ABCTemp

OK:
	RETURN 0
ERRO:
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_Inventory_UpdateABC', @ErrorLevelStr

	RETURN @ErrorLevel
GO
