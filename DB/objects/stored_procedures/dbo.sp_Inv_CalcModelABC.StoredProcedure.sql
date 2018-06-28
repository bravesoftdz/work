SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_Inv_CalcModelABC]
AS

/* ----------------------------------------------------------------------------------------------------------------------
	SUMARIO

		Classifiçao ABC do Inventário

		- Crio uma tabela temporaria, ordenada descendentemente por Profit
		- Marco a Primeira fatia como A, a intermediaria como B e o resto como C
		- Uso a tabela temporaria para atualizar os modelos

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro inserir na tabela temporaria
		-202  Erro em Atualizo os Modelos
		-203  Erro no Cursor
		-204  Erro em atualizar o Model nao listados


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	-----------------------	-----------------------	-----------------------------------------------------------------
	09 Sep	1999		Eduardo Costa		Criacao;
	25 Jun	2001		Davi Gouveia		Log de Return Values;
	18 Aug	2004		Rodrigo Costa		Gravar error log;
	18 Jan	2005		Rodrigo Costa		Gerar curva ABC por modo de caixa;
	19 Dec	2005		Rodrigo Costa		Separar ABC por tipo de venda;
	24 Feb	2006		Maximiliano Muniz	Alterado o filtro por data no cálculo da média de vendas;
	06 Feb	2007		Maximiliano Muniz	Modificação do nome da SP;
							Classificação pelo faturamento e não pela quantidade vendida;
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
DECLARE @IDModel	int

DECLARE @CalcType	int
DECLARE @QtyTotal	money
DECLARE @QtyPerc	money
DECLARE @QtySold	money

DECLARE @Model		varchar(35)


SET @ErrorLevel = 0
SET @SalePercTotal = 0

-- Meses
SELECT @Month = CONVERT(int, PropertyValue) FROM Sis_PropertyDomain (NOLOCK)  WHERE Property = 'ABCCalcPeriodInMonth'
--Percentual de A
SELECT @ClassA = CONVERT(int, PropertyValue) FROM Sis_PropertyDomain (NOLOCK) WHERE Property = 'ClassAPerc'
--Percentual de B
SELECT @ClassB = CONVERT(int, PropertyValue) FROM Sis_PropertyDomain (NOLOCK) WHERE Property = 'ClassBPerc'
--Calculation Type
SELECT @CalcType = CONVERT(int, PropertyValue) FROM Sis_PropertyDomain (NOLOCK) WHERE Property = 'ABCCalcType'

--Create Temp Table
CREATE TABLE #ABCTemp
(
	IDModel int,
	SalePerc money,
	QtyPerc money,
	QtySold money
)

IF (SELECT Convert(int, SrvValue) FROM Param Where IDParam = 63) = 2
BEGIN

	--Calculo da Qty Total vendida
	SELECT
		@SaleTotal = SUM((SalePrice * Qty) - Discount),
		@QtyTotal = SUM(Qty) 
	FROM
		vwSaleItem IM (NOLOCK) 
		JOIN Pessoa P (NOLOCK)  ON (IM.ComissionID = P.IDPessoa AND IM.IDTipoPessoa = P.IDTipoPessoa)
		JOIN Model M (NOLOCK) ON (M.IDModel = IM.ModelID)
		JOIN TabGroup TG (NOLOCK) ON (IM.GroupID = TG.IDGroup)
	WHERE	
		IM.PreSaleDate >= CONVERT(datetime, CONVERT(varchar(11), DATEADD(month, - @Month, GetDate())))
		AND IM.PreSaleDate < GetDate()+1
		AND IM.InventMovTypeID = 1
		AND TG.Service = 0
		AND M.ClasseABC <> 'E'

	--Insiro os percentuais de venda ordenado
	INSERT
		#ABCTemp (IDModel, SalePerc, QtyPerc, QtySold)
	SELECT
		IM.ModelID, -- Modelo ordenado DESC por profit
		(SUM((IM.SalePrice * IM.Qty) - IM.Discount) / @SaleTotal) * 100, -- Percentual do total da venda por valor
		(SUM(IM.Qty) / @QtyTotal) * 100, -- Percentual do total da qtd vendida
		SUM(IM.Qty) -- Total Qty vebdida
	FROM
		vwSaleItem IM (NOLOCK) 
		JOIN Pessoa P (NOLOCK) ON (IM.ComissionID = P.IDPessoa AND IM.IDTipoPessoa = P.IDTipoPessoa)
		JOIN Model M (NOLOCK) ON (M.IDModel = IM.ModelID)
		JOIN TabGroup TG (NOLOCK) ON (IM.GroupID = TG.IDGroup)
	WHERE	
		IM.PreSaleDate >= CONVERT(datetime, CONVERT(varchar(11), DATEADD(month, - @Month, GetDate())))
		AND IM.PreSaleDate < GetDate()+1
		AND IM.InventMovTypeID = 1
		AND TG.Service = 0
		AND M.ClasseABC <> 'E'
	GROUP BY 
		IM.ModelID
END
ELSE
BEGIN
	--Calculo da Qty Total vendida
	SELECT
		@SaleTotal = SUM((IM.SalePrice * IM.Qty) - IM.Discount),
		@QtyTotal = SUM(Qty)
	FROM
		InventoryMov IM (NOLOCK) 
		JOIN Model M (NOLOCK) ON (M.IDModel = IM.ModelID)
		JOIN TabGroup TG (NOLOCK) ON (M.GroupID = TG.IDGroup)
	WHERE	
		IM.MovDate >= CONVERT(datetime, CONVERT(varchar(11), DATEADD(month, - @Month, GetDate())))
		AND IM.MovDate < GetDate()+1
		AND IM.InventMovTypeID = 1
		AND TG.Service = 0
		AND M.ClasseABC <> 'E'

	--Insiro os percentuais de venda ordenado
	INSERT
		#ABCTemp (IDModel, SalePerc, QtyPerc, QtySold)
	SELECT
		IM.ModelID, -- Modelo ordenado DESC por profit
		(SUM((IM.SalePrice * IM.Qty) - IM.Discount) / @SaleTotal) * 100, -- Percentual do total da venda por valor
		(SUM(IM.Qty) / @QtyTotal) * 100, -- Percentual do total da qtd vendida
		SUM(IM.Qty) -- Total Qty vebdida
	FROM
		InventoryMov IM (NOLOCK) 
		JOIN Model M (NOLOCK) ON (M.IDModel = IM.ModelID)
		JOIN TabGroup TG (NOLOCK) ON (M.GroupID = TG.IDGroup)
	WHERE	
		IM.MovDate >= CONVERT(datetime, CONVERT(varchar(11), DATEADD(month, - @Month, GetDate())))
		AND IM.MovDate < GetDate()+1
		AND IM.InventMovTypeID = 1
		AND TG.Service = 0
		AND M.ClasseABC <> 'E'
	GROUP BY
		IM.ModelID
END

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END

IF @CalcType = 1
BEGIN
	--Declaração do Cursor de InventoryMov
	DECLARE CalcABC_Cursor CURSOR FOR
	
		SELECT
			T.IDModel,
			T.SalePerc,
			T.QtyPerc
		FROM
			#ABCTemp T
		ORDER BY
			SalePerc DESC,
			QtyPerc DESC
	
	OPEN CalcABC_Cursor
	
	--Inicialização de CalcABC_Cursor
	FETCH NEXT FROM CalcABC_Cursor INTO
		@IDModel,
		@SalePerc,
		@QtyPerc
	
	--Enquanto tem registros
	WHILE
	@@FETCH_STATUS = 0
	BEGIN
	
		SET @SalePercTotal = @SalePercTotal + @SalePerc
		
		UPDATE
			Model
		SET
			Model.ClasseABC = CASE 
				WHEN (@SalePercTotal <= @ClassA) THEN 'A'
				WHEN ((@SalePercTotal > @ClassA) AND (@SalePercTotal <= @ClassA + @ClassB)) THEN 'B'
				ELSE 'C'
				END
		WHERE
			IDModel = @IDModel
			AND
			Model.ClasseABC <> 'E'
	
	
		SET @SysError = @@ERROR
		IF @SysError <> 0
		BEGIN
			CLOSE CalcABC_Cursor
			DEALLOCATE CalcABC_Cursor
			SET @ErrorLevel = -202
			GOTO ERRO
		END
	
		FETCH NEXT FROM CalcABC_Cursor INTO
			@IDModel,
			@SalePerc,
			@QtyPerc
	END
	--fechamento do cursor
	CLOSE CalcABC_Cursor
	
	--Destruição do cursor
	DEALLOCATE CalcABC_Cursor
END
ELSE
BEGIN
	--Declaração do Cursor de InventoryMov
	DECLARE CalcABC_Qty_Cursor CURSOR FOR
	
		SELECT
			T.IDModel,
			T.QtyPerc,
			T.QtySold
		FROM
			#ABCTemp T
		ORDER BY
			QtyPerc DESC,
			SalePerc DESC
	
	OPEN CalcABC_Qty_Cursor
	
	--Inicialização de CalcABC_Qty_Cursor
	FETCH NEXT FROM CalcABC_Qty_Cursor INTO
		@IDModel,
		@QtyPerc,
		@QtySold
	
	--Enquanto tem registros
	WHILE
	@@FETCH_STATUS = 0
	BEGIN
	
		SET @SalePercTotal = @SalePercTotal + @QtyPerc
		--PRINT CAST(@IDModel as varchar) + ' - ' + @Model + '. Total:' + CAST(@SalePercTotal as varchar) + ' %' + CAST(@QtyPerc as varchar)
		
		UPDATE
			Model
		SET
			Model.ClasseABC = CASE 
				WHEN (@SalePercTotal <= @ClassA) THEN 'A'
				WHEN ((@SalePercTotal > @ClassA) AND (@SalePercTotal <= @ClassA + @ClassB)) THEN 'B'
				ELSE 'C'
				END
		WHERE
			IDModel = @IDModel
			AND
			Model.ClasseABC <> 'E'
	
	
		SET @SysError = @@ERROR
		IF @SysError <> 0
		BEGIN
			CLOSE CalcABC_Qty_Cursor
			DEALLOCATE CalcABC_Qty_Cursor
			SET @ErrorLevel = -202
			GOTO ERRO
		END
	
		FETCH NEXT FROM CalcABC_Qty_Cursor INTO
			@IDModel,
			@QtyPerc,
			@QtySold
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
	Model
SET
	Model.ClasseABC = 'C'
WHERE
	IDModel NOT IN (SELECT IDModel FROM #ABCTemp)
	AND
	Model.ClasseABC <> 'E'

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
