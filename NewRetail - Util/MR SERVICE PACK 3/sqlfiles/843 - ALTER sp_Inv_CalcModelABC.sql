if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Inv_CalcModelABC]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Inv_CalcModelABC]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Inv_CalcStoreABC]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Inv_CalcStoreABC]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PO_CalcOrderPointSimple]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PO_CalcOrderPointSimple]
GO

CREATE PROCEDURE sp_Inv_CalcModelABC
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

CREATE    PROCEDURE sp_Inv_CalcStoreABC
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

CREATE    PROCEDURE sp_PO_CalcOrderPointSimple
AS

/* ----------------------------------------------------------------------------------------------------------------------
	SUMARIO

		Calculo dinamico do Ponto de Pedido Simples

		por Maximiliano Muniz e Rodrigo Costa em 30 de janeiro de 2006.

		Esta procedure utiliza os seguintes parametros:		
			Month - Periodo utilizado para calcular as vendas do produto;
			Type - Tipo de tela;

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-200  Erro em Insiro em DailyMaintenanceReport
		-201  Erro em Atualizar a última data processada em DailyMaintenanceReport
		-202  Erro em calcular a media de entrega
		-203  Erro em calcular a media de vendas no periodo
		-204  Erro em calcular o ponto de pedido
		-205  Erro em Altera o status do processamento após a conclusão
		-206  Erro em Deleto todos os computer request
		-207  Erro em Incluo todos os modelos que estao com QtyOnHand, menor que Ponto de Pedido

	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	-----------------------	-----------------------	-----------------------------------------------------------------
	30 Jan	2006		Max e Rodrigo		Criacao;
	24 Feb	2006		Maximiliano Muniz	Alterado o filtro por data no cálculo da média de vendas;
	14 Jun	2006		Leonardo Riego		Verifica se é utilizado quantidade fracionária para o cálulo
							da Autoequisição;
	28 Jun	2006		Leonardo Riego		Adicionado filtro de inclusao de modelos filtrados por loja;
	27 Oct	2006		Maximiliano e Maic	Alterada condição para auto-requisitar, com base nos parâmetros
							de configuração de estoque. Apenas produtos de classes que
							auto-requisitam, serão selecionados;
	07 Feb	2007		Maximiliano Muniz	Adicionado cálculo de média de vendas, média de tempo de entrega,
							margem de segurança e ponto de pedido por loja;
	05 Mar	2007		Maximiliano Muniz	Correção na query que cria as auto-requisições;
	06 Mar	2007		Rodrigo Costa		Setar as Cotacoes para NULL
	10 Mar	2009		Rodrigo Costa		Criacao do Lead Time Padrao
	----------------------------------------------------------------------------------------------------------------- */

DECLARE @ErrorLevel		int
DECLARE @SysError		int
DECLARE @Today			datetime
DECLARE @LastProcess		datetime
DECLARE @IDDayMaint		int
DECLARE @Type			int
DECLARE @IDStore		int
DECLARE @IDRequest		int
DECLARE @IDModel 		int
DECLARE @Description		varchar(50)
DECLARE @Qty			float
DECLARE @SaleMonth		int
DECLARE @SafeMarginClassA	int
DECLARE @SafeMarginClassB	int
DECLARE @SafeMarginClassC	int
DECLARE @POPeriodClassA		int
DECLARE @POPeriodClassB		int
DECLARE @POPeriodClassC		int
DECLARE @DefaulLeadTime		int
DECLARE @StoreAutoRequest	int
DECLARE @QtyFrac		bit
DECLARE @AutoRequestClassA	bit
DECLARE @AutoRequestClassB	bit
DECLARE @AutoRequestClassC	bit

SET @ErrorLevel = 0
SET @LastProcess = 0
SET @Type = (SELECT Convert(int, SrvValue) FROM Param (NOLOCK) Where IDParam = 63)

--Periodo
(SELECT @SaleMonth = CONVERT(int, PropertyValue) FROM Sis_PropertyDomain (NOLOCK) WHERE Property = 'AutoRequestSalePeriodInMonth')

--Margem de seguranca
(SELECT @SafeMarginClassA = CONVERT(int, PropertyValue) FROM Sis_PropertyDomain (NOLOCK) WHERE Property = 'PercSecurityMarginClassA')
(SELECT @SafeMarginClassB = CONVERT(int, PropertyValue) FROM Sis_PropertyDomain (NOLOCK) WHERE Property = 'PercSecurityMarginClassB')
(SELECT @SafeMarginClassC = CONVERT(int, PropertyValue) FROM Sis_PropertyDomain (NOLOCK) WHERE Property = 'PercSecurityMarginClassC')

--Periodo para compra
(SELECT @POPeriodClassA = CONVERT(int, PropertyValue) FROM Sis_PropertyDomain (NOLOCK) WHERE Property = 'POTimeSetupClassAInDays')
(SELECT @POPeriodClassB = CONVERT(int, PropertyValue) FROM Sis_PropertyDomain (NOLOCK) WHERE Property = 'POTimeSetupClassBInDays')
(SELECT @POPeriodClassC = CONVERT(int, PropertyValue) FROM Sis_PropertyDomain (NOLOCK) WHERE Property = 'POTimeSetupClassCInDays')

--Classes que auto-requisitam
(SELECT @AutoRequestClassA = CONVERT(bit, PropertyValue) FROM Sis_PropertyDomain (NOLOCK) WHERE Property = 'AutoRequestClassA')
(SELECT @AutoRequestClassB = CONVERT(bit, PropertyValue) FROM Sis_PropertyDomain (NOLOCK) WHERE Property = 'AutoRequestClassB')
(SELECT @AutoRequestClassC = CONVERT(bit, PropertyValue) FROM Sis_PropertyDomain (NOLOCK) WHERE Property = 'AutoRequestClassC')

--Loja que vai ser à base do cálculo
(SELECT @StoreAutoRequest = CONVERT(int, PropertyValue) FROM Sis_PropertyDomain (NOLOCK) WHERE Property = 'StoreToAutoRequest')

--Lead Time Padrao
(SELECT @DefaulLeadTime = CONVERT(int, PropertyValue) FROM Sis_PropertyDomain (NOLOCK) WHERE Property = 'AutoRequestLeadTime')

--------------------------------------------------------------------------------------------------------------
-- Pego a última data processada ou a primeira data a processar
SELECT @Today	= CONVERT(smalldatetime, CONVERT(varchar, GetDate(), 103), 103)
SELECT @LastProcess	= CONVERT(smalldatetime, CONVERT(varchar, MAX(Date), 103), 103) FROM DailyMaintenanceReport (NOLOCK) WHERE Maintenance = 'CalcOrderPoint'

IF @LastProcess = @Today
	RETURN
ELSE
BEGIN
	IF @LastProcess > 0
		SET @LastProcess = DateAdd(DAY, 1, @LastProcess)
	ELSE
	BEGIN
		----------------------------------------------------------------------------------------------
		-- Se ainda não processou nenhuma vez, insiro em DailyMaintenanceReport
		-- com a data da primeira movimentação do sitema
		SELECT @LastProcess = CONVERT(smalldatetime, CONVERT(varchar, MIN(MovDate), 103), 103) FROM InventoryMov (NOLOCK) 

		exec sp_Sis_GetNextCode 'DailyMaintenanceReport.IDDailyMaintenanceReport', @IDDayMaint OUTPUT
		INSERT DailyMaintenanceReport 
			(
			IDDailyMaintenanceReport,
			Maintenance,
			[Date],
			LastMessage
			)
			VALUES
			(
			@IDDayMaint,
			'CalcOrderPoint',
			@LastProcess,
			'Started'
			)
		
		SET @SysError = @@ERROR
		IF @SysError <> 0
		BEGIN
			SET @ErrorLevel = -200
			GOTO ERRO
		END
	END
END

-----------------------------------------------------------------------------------------------------------------
-- Atualizar a última data processada em DailyMaintenanceReport
UPDATE DailyMaintenanceReport SET [Date] = @Today, LastMessage = 'Started' WHERE Maintenance = 'CalcOrderPoint'

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END

-- SUM(DataCompra - DataPedido)/Count(Numero Compras)
-- Calculo Media Entrega [ME] por produto
UPDATE
	M
SET
	M.TR = IsNull(P.MediaPedido, 0)
FROM
	Model M
	LEFT JOIN	(
		SELECT
			PUI.IDModel,
			(SUM(DATEDIFF(Day, PO.DataPedido, PU.DatePreReceiving))/COUNT(PU.IDPurchase)) as MediaPedido
		FROM
			Pur_Purchase PU (NOLOCK) 
			JOIN PO (NOLOCK) ON (PU.IDPO = PO.IDPO)
			JOIN Pur_PurchaseItem PUI (NOLOCK) ON (PUI.IDPurchase = PU.IDPurchase)
			JOIN Model M (NOLOCK) ON (M.IDModel = PUI.IDModel)
		WHERE
			PU.DatePreReceiving >= DATEADD(month, - @SaleMonth, GetDate())
		GROUP BY
			PUI.IDModel) P ON (M.IDModel = P.IDModel)

-- Calculo Media Entrega [ME] por loja e produto
UPDATE
	I
SET
	I.LeadTime = IsNull(P.MediaPedido, 0)
FROM
	Inventory I
	LEFT JOIN	(
		SELECT
			PU.IDStore,
			PUI.IDModel,
			(SUM(DATEDIFF(Day, PO.DataPedido, PU.DatePreReceiving))/COUNT(PU.IDPurchase)) as MediaPedido
		FROM
			Pur_Purchase PU (NOLOCK) 
			JOIN PO (NOLOCK) ON (PU.IDPO = PO.IDPO)
			JOIN Pur_PurchaseItem PUI (NOLOCK) ON (PUI.IDPurchase = PU.IDPurchase)
			JOIN Model M (NOLOCK) ON (M.IDModel = PUI.IDModel)
		WHERE
			PU.DatePreReceiving >= DATEADD(month, - @SaleMonth, GetDate())
		GROUP BY
			PU.IDStore,
			PUI.IDModel
		) P ON (I.StoreID = P.IDStore AND I.ModelID = P.IDModel)

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -202
	GOTO ERRO
END

-- Calculo Media Venda [MV]
IF (@Type = 1)
BEGIN
	-- por produto
	UPDATE
		M
	SET	
		PVD = CASE WHEN MT.Venda IS NULL THEN 0 ELSE MT.Venda / MT.Period END
	FROM
		Model M
		LEFT JOIN	(
			SELECT
				IM.ModelID IDModel,
				SUM(Qty) Venda,
				DATEDIFF(Day, DATEADD(month, - @SaleMonth, GetDate()), GetDate()) as Period
			FROM	
				InventoryMov IM (NOLOCK) 				JOIN Model M (NOLOCK) ON (M.IDModel = IM.ModelID)
				JOIN TabGroup TG (NOLOCK) ON (M.GroupID = TG.IDGroup)
			WHERE
				InventMovTypeID = 1
				AND IM.MovDate >= DATEADD(month, - @SaleMonth, GetDate())
				AND TG.Service = 0
			GROUP BY
				IM.ModelID
			) MT ON (M.IDModel = MT.IDModel)

	-- por loja e produto
	UPDATE
		I
	SET	
		DailySales = CASE WHEN MT.Venda IS NULL THEN 0 ELSE MT.Venda / MT.Period END
	FROM
		Inventory I
		LEFT JOIN	(
			SELECT
				IM.StoreID IDStore,
				IM.ModelID IDModel,
				SUM(Qty) Venda,
				DATEDIFF(Day, DATEADD(month, - @SaleMonth, GetDate()), GetDate()) as Period
			FROM	
				InventoryMov IM (NOLOCK) 
				JOIN Model M (NOLOCK) ON (M.IDModel = IM.ModelID)
				JOIN TabGroup TG (NOLOCK) ON (M.GroupID = TG.IDGroup)
			WHERE
				InventMovTypeID = 1
				AND IM.MovDate >= DATEADD(month, - @SaleMonth, GetDate())
				AND TG.Service = 0
			GROUP BY
				IM.StoreID,
				IM.ModelID
			) MT ON (MT.IDStore = I.StoreID AND MT.IDModel = I.ModelID)
END
ELSE
BEGIN
	-- por produto
	UPDATE
		M
	SET	
		PVD = CASE WHEN MT.Venda IS NULL THEN 0 ELSE MT.Venda / MT.Period END
	FROM
		Model M
		LEFT JOIN	(
			SELECT
				IM.ModelID IDModel,
				SUM(Qty) Venda,
				DATEDIFF(Day, DATEADD(month, - @SaleMonth, GetDate()), GetDate()) as Period
			FROM	
				vwSaleItem IM (NOLOCK) 
				JOIN Pessoa P (NOLOCK) ON (IM.ComissionID = P.IDPessoa AND IM.IDTipoPessoa = P.IDTipoPessoa)
				JOIN Model M (NOLOCK) ON (M.IDModel = IM.ModelID)
				JOIN TabGroup TG (NOLOCK) ON (IM.GroupID = TG.IDGroup)
			WHERE
				IM.InventMovTypeID = 1
				AND
				IM.PreSaleDate >= DATEADD(month, - @SaleMonth, GetDate())
				AND
				TG.Service = 0
			GROUP BY
				IM.ModelID
			) MT ON (MT.IDModel = M.IDModel)

	-- por loja
	UPDATE
		I
	SET	
		DailySales = CASE WHEN MT.Venda IS NULL THEN 0 ELSE MT.Venda / MT.Period END
	FROM
		Inventory I
		LEFT JOIN	(
			SELECT
				IM.StoreID IDStore,
				IM.ModelID IDModel,
				SUM(Qty) Venda,
				DATEDIFF(Day, DATEADD(month, - @SaleMonth, GetDate()), GetDate()) as Period
			FROM	
				vwSaleItem IM (NOLOCK) 
				JOIN Pessoa P (NOLOCK) ON (IM.ComissionID = P.IDPessoa AND IM.IDTipoPessoa = P.IDTipoPessoa)
				JOIN Model M (NOLOCK) ON (M.IDModel = IM.ModelID)
				JOIN TabGroup TG (NOLOCK) ON (IM.GroupID = TG.IDGroup)
			WHERE
				IM.InventMovTypeID = 1
				AND IM.PreSaleDate >= DATEADD(month, - @SaleMonth, GetDate())
				AND TG.Service = 0
			GROUP BY
				IM.StoreID,
				IM.ModelID
			) MT ON (MT.IDStore = I.StoreID AND MT.IDModel = I.ModelID)
END

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -203
	GOTO ERRO
END

-- Calculo da margem de suguranca do ponto de pedido [Round(ME*MV)] * (Margem/100)
-- por produto
UPDATE
	Model
SET
	ES = CASE ClasseABC 
			WHEN 'A' THEN Round(TR * PVD, 2) * (@SafeMarginClassA/100.0)
			WHEN 'B' THEN Round(TR * PVD, 2) * (@SafeMarginClassB/100.0)
			WHEN 'C' THEN Round(TR * PVD, 2) * (@SafeMarginClassC/100.0)
		END
				
-- por loja e produto
UPDATE
	Inventory
SET
	SafetyMargin = CASE ClassABC
			WHEN 'A' THEN Round((CASE LeadTime WHEN 0 THEN @DefaulLeadTime ELSE LeadTime END) * DailySales, 2) * (@SafeMarginClassA/100.0)
			WHEN 'B' THEN Round((CASE LeadTime WHEN 0 THEN @DefaulLeadTime ELSE LeadTime END) * DailySales, 2) * (@SafeMarginClassB/100.0)
			WHEN 'C' THEN Round((CASE LeadTime WHEN 0 THEN @DefaulLeadTime ELSE LeadTime END) * DailySales, 2) * (@SafeMarginClassC/100.0)
		END

-- Calculo Ponto do Pedido [Round(ME*MV+ES)]
-- por produto
UPDATE
	Model
SET
	PP = Round((TR * PVD) , 2)

-- por loja e produto
UPDATE
	Inventory
SET
	OrderPoint = Round(((CASE LeadTime WHEN 0 THEN @DefaulLeadTime ELSE LeadTime END) * DailySales) , 2)

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -204
	GOTO ERRO
END

/* Deleto todos os computer request */
DELETE 
	POItemRequest
WHERE
	IDRequest IN (SELECT IDRequest FROM Request WHERE Type = 'C')

/* Set as Cotacoes para NULL */
UPDATE
	CM
SET
	CM.IDRequest = NULL
FROM
	CotacaoToModel CM (NOLOCK) 
	JOIN Request R (NOLOCK) ON (R.IDRequest = CM.IDRequest)
	
DELETE 
	Request 
WHERE 
	Type = 'C'

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -206
	GOTO ERRO
END

/* Incluo todos os modelos que estao com QtyOnHand, menor que Ponto de Pedido */

-- Verifica se é utilizado quantidade fracionária.
SELECT
	@QtyFrac = CASE UPPER(SrvValue) WHEN 'TRUE' THEN 1 ELSE 0 END
FROM
	Param (NOLOCK) 
WHERE
	IDParam = 85


/* Incluo todos os modelos que estao com QtyOnHand, menor que Ponto de Pedido */
--Declaração do Cursor de Request

IF (@StoreAutoRequest = 0)
BEGIN
	DECLARE Store_Cursor CURSOR FOR

		SELECT
			IDStore
		FROM
			Store (NOLOCK) 
		ORDER BY
			IDStore

	OPEN Store_Cursor

	--Inicialização de Store_Cursor
	FETCH NEXT FROM Store_Cursor INTO
		@IDStore

	--Enquanto tem registros
	WHILE @@FETCH_STATUS = 0
	BEGIN
		DECLARE Request_Cursor CURSOR FOR

			SELECT
				I.ModelID,
				Model.Description,
				CASE I.ClassABC
					WHEN 'A' THEN Round(I.DailySales * @POPeriodClassA,2)
					WHEN 'B' THEN Round(I.DailySales * @POPeriodClassB,2)
					WHEN 'C' THEN Round(I.DailySales * @POPeriodClassC,2)
				END
			FROM
				Inventory I (NOLOCK) 
				JOIN Model Model (NOLOCK) ON (Model.IDModel = I.ModelID)
			WHERE
				(I.OrderPoint + I.SafetyMargin) >=	(CASE @Type
						WHEN 1 THEN I.QtyOnHand
						ELSE I.QtyOnHand - I.QtyOnPreSale
						END)
				AND I.OrderPoint <> 0
				AND I.OrderPoint IS NOT NULL
				AND AutomaticRequest = 1
				AND ((@AutoRequestClassA = 1 AND I.ClassABC = 'A') OR (@AutoRequestClassB = 1 AND I.ClassABC = 'B') OR (@AutoRequestClassC = 1 AND I.ClassABC = 'C'))
				AND I.StoreID = @IDStore
				AND NOT EXISTS ( SELECT ModelID FROM PreInventoryMov PO WHERE PO.ModelID = Model.IDModel AND PO.InventMovTypeID = 2 AND (PO.Qty < PO.QtyRealMov))
				AND NOT EXISTS ( SELECT ModelID FROM Request R  WHERE R.ModelID = Model.IDModel AND R.Type <> 'C')

		OPEN Request_Cursor

		--Inicialização de Request_Cursor
		FETCH NEXT FROM Request_Cursor INTO
			@IDModel,
			@Description,
			@Qty

		--Enquanto tem registros
		WHILE
		@@FETCH_STATUS = 0
		BEGIN
			EXEC sp_Sis_GetNextCode'Request.IDRequest', @IDRequest OUTPUT
		
			IF @QtyFrac = 0
			BEGIN
				SET @Qty = CEILING(@Qty)
			END

			INSERT Request
				(
				IDRequest,
				ModelID,
				Description,
				UserID,
				QtyReq,
				DateRequest,
				Type,
				StoreID
				)
			VALUES
				(
				@IDRequest,
				@IDModel,
				@Description,
				0,
				@Qty,
				GetDate(),
				'C',
				@IDStore
				)

			SET @SysError = @@ERROR
			IF @SysError <> 0
			BEGIN
				CLOSE Request_Cursor
				DEALLOCATE Request_Cursor
				SET @ErrorLevel = -213
				GOTO ERRO
			END

			FETCH NEXT FROM Request_Cursor INTO
				@IDModel,
				@Description,
				@Qty
		END
		--fechamento do cursor
		CLOSE Request_Cursor
		--Destruição do cursor
		DEALLOCATE Request_Cursor

		SET @SysError = @@ERROR
		IF @SysError <> 0
		BEGIN
			SET @ErrorLevel = -207
			GOTO ERRO
		END

		FETCH NEXT FROM Store_Cursor INTO
			@IDStore

	END

	--fechamento do cursor
	CLOSE Store_Cursor
	--Destruição do cursor
	DEALLOCATE Store_Cursor
END
ELSE
BEGIN
	DECLARE Request_Cursor CURSOR FOR

		SELECT	
			I.ModelID,
			Model.Description,
			CASE I.ClassABC
				WHEN 'A' THEN Round(I.DailySales * @POPeriodClassA,2)
				WHEN 'B' THEN Round(I.DailySales * @POPeriodClassB,2)
				WHEN 'C' THEN Round(I.DailySales * @POPeriodClassC,2)
			END
		FROM
			Inventory I (NOLOCK) 
			JOIN Model Model (NOLOCK) ON (Model.IDModel = I.ModelID)
		WHERE	
			(I.OrderPoint + I.SafetyMargin) >=	(CASE @Type
					WHEN 1 THEN I.QtyOnHand 
					ELSE I.QtyOnHand - I.QtyOnPreSale
					END)
			AND I.OrderPoint <> 0
			AND I.OrderPoint IS NOT NULL
			AND AutomaticRequest = 1
			AND ((@AutoRequestClassA = 1 AND I.ClassABC = 'A') OR (@AutoRequestClassB = 1 AND I.ClassABC = 'B') OR (@AutoRequestClassC = 1 AND I.ClassABC = 'C'))
			AND I.StoreID = @StoreAutoRequest
			AND NOT EXISTS ( SELECT ModelID FROM PreInventoryMov PO WHERE PO.ModelID = Model.IDModel AND PO.InventMovTypeID = 2 AND (PO.Qty < PO.QtyRealMov))
			AND NOT EXISTS ( SELECT ModelID FROM Request R  WHERE R.ModelID = Model.IDModel AND R.Type <> 'C')

	OPEN Request_Cursor

	--Inicialização de Request_Cursor
	FETCH NEXT FROM Request_Cursor INTO
		@IDModel,
		@Description,
		@Qty
	
	--Enquanto tem registros
	WHILE
	@@FETCH_STATUS = 0
	BEGIN
		EXEC sp_Sis_GetNextCode'Request.IDRequest', @IDRequest OUTPUT
	
		IF @QtyFrac = 0
		BEGIN
			SET @Qty = CEILING(@Qty)
		END
	
		INSERT Request
			(
			IDRequest,
			ModelID,
			Description,
			UserID,
			QtyReq,
			DateRequest,
			Type,
			StoreID
			)
		VALUES
			(
			@IDRequest,
			@IDModel,
			@Description,
			0,
			@Qty,
			GetDate(),
			'C',
			@StoreAutoRequest
			)
	
		SET @SysError = @@ERROR
		IF @SysError <> 0
		BEGIN
			CLOSE Request_Cursor
			DEALLOCATE Request_Cursor
			SET @ErrorLevel = -213
			GOTO ERRO
		END
	
		FETCH NEXT FROM Request_Cursor INTO
			@IDModel,
			@Description,
			@Qty
	
	END
	--fechamento do cursor
	CLOSE Request_Cursor
	--Destruição do cursor
	DEALLOCATE Request_Cursor
	
	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		SET @ErrorLevel = -207
		GOTO ERRO
	END
END

-------------------------------------------------------------------------------------------------
-- Altera o status do processamento após a conclusão
UPDATE DailyMaintenanceReport SET LastMessage = 'Finished' WHERE Maintenance = 'CalcOrderPoint'

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -205

	GOTO ERRO
END

OK:
	RETURN 0
ERRO:
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'System', 'Error: sp_PO_CalcOrderPoint', @ErrorLevelStr

	RETURN @ErrorLevel

GO
