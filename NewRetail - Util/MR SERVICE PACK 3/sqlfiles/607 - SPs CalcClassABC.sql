IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[sp_Inventory_UpdateABC]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[sp_Inventory_UpdateABC]
GO

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[sp_Inv_CalcModelABC]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[sp_Inv_CalcModelABC]
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
	----------------------------------------------------------------------------------------------------------------- */

DECLARE @ErrorLevel 	int
DECLARE @SysError	int

DECLARE @QtyTotal	float 
DECLARE @Month		int

DECLARE @ClassA		int
DECLARE @ClassB		int

DECLARE @SaleTotal	money
DECLARE @SalePercTotal	money
DECLARE @SalePerc	money
DECLARE @IDModel	int

SET @ErrorLevel = 0
SET @SalePercTotal = 0

-- Meses
SELECT @Month = CONVERT(int, PropertyValue) FROM Sis_PropertyDomain WHERE Property = 'ABCCalcPeriodInMonth'
--Percentual de A
SELECT @ClassA = CONVERT(int, PropertyValue) FROM Sis_PropertyDomain WHERE Property = 'ClassAPerc'
--Percentual de B
SELECT @ClassB = CONVERT(int, PropertyValue) FROM Sis_PropertyDomain WHERE Property = 'ClassBPerc'

--Create Temp Table
CREATE TABLE #ABCTemp
(
	IDModel int,
	SalePerc money
)

IF (SELECT Convert(int, SrvValue) FROM Param Where IDParam = 63) = 2
BEGIN

	--Calculo da Qty Total vendida
	SELECT
		@SaleTotal = SUM((SalePrice * Qty) - Discount)
	FROM
		vwSaleItem IM
		JOIN Pessoa P ON (IM.ComissionID = P.IDPessoa AND IM.IDTipoPessoa = P.IDTipoPessoa)
		JOIN Model M ON (M.IDModel = IM.ModelID)
		JOIN TabGroup TG ON (IM.GroupID = TG.IDGroup)
	WHERE	
		IM.PreSaleDate >= DATEADD(month, - @Month, GetDate())
		AND IM.PreSaleDate < GetDate()+1
		AND IM.InventMovTypeID = 1
		AND TG.Service = 0

	--Insiro os percentuais de venda ordenado
	INSERT
		#ABCTemp (IDModel, SalePerc)
	SELECT
		IM.ModelID, -- Modelo ordenado DESC por profit
		(SUM((IM.SalePrice * IM.Qty) - IM.Discount) / @SaleTotal) * 100 -- Percentual do total da venda por valor
	FROM
		vwSaleItem IM
		JOIN Pessoa P ON (IM.ComissionID = P.IDPessoa AND IM.IDTipoPessoa = P.IDTipoPessoa)
		JOIN Model M ON (M.IDModel = IM.ModelID)
		JOIN TabGroup TG ON (IM.GroupID = TG.IDGroup)
	WHERE	
		IM.PreSaleDate >= DATEADD(month, -@Month, GetDate())
		AND IM.PreSaleDate < GetDate()+1
		AND IM.InventMovTypeID = 1
		AND TG.Service = 0
	GROUP BY 
		IM.ModelID
END
ELSE
BEGIN
	--Calculo da Qty Total vendida
	SELECT
		@SaleTotal = SUM((IM.SalePrice * IM.Qty) - IM.Discount)
	FROM
		InventoryMov IM
		JOIN Model M ON (M.IDModel = IM.ModelID)
		JOIN TabGroup TG ON (M.GroupID = TG.IDGroup)
	WHERE	
		IM.MovDate >= DATEADD(month, - @Month, GetDate())
		AND IM.MovDate < GetDate()+1
		AND IM.InventMovTypeID = 1
		AND TG.Service = 0

	--Insiro os percentuais de venda ordenado
	INSERT
		#ABCTemp (IDModel, SalePerc)
	SELECT
		IM.ModelID, -- Modelo ordenado DESC por profit
		(SUM((IM.SalePrice * IM.Qty) - IM.Discount) / @SaleTotal) * 100 -- Percentual do total da venda por valor
	FROM
		InventoryMov IM
		JOIN Model M ON (M.IDModel = IM.ModelID)
		JOIN TabGroup TG ON (M.GroupID = TG.IDGroup)
	WHERE	
		IM.MovDate >= DATEADD(month, - @Month, GetDate())
		AND IM.MovDate < GetDate()+1
		AND IM.InventMovTypeID = 1
		AND TG.Service = 0
	GROUP BY
		IM.ModelID
END

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END

--Declaração do Cursor de InventoryMov

DECLARE CalcABC_Cursor CURSOR FOR

	SELECT
		IDModel,
		SalePerc
	FROM
		#ABCTemp
	ORDER BY
		SalePerc DESC

OPEN CalcABC_Cursor

--Inicialização de CalcABC_Cursor
FETCH NEXT FROM CalcABC_Cursor INTO
	@IDModel,
	@SalePerc

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
			WHEN ((@SalePercTotal > @ClassA) AND (@SalePercTotal <= @ClassB)) THEN 'B'
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
		@SalePerc
END
--fechamento do cursor
CLOSE CalcABC_Cursor

--Destruição do cursor
DEALLOCATE CalcABC_Cursor

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

UPDATE Inventory
SET ClassABC = 'C'
GO

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[sp_Inv_CalcStoreABC]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[sp_Inv_CalcStoreABC]
GO

CREATE PROCEDURE sp_Inv_CalcStoreABC
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
	----------------------------------------------------------------------------------------------------------------- */

DECLARE @ErrorLevel 	int
DECLARE @SysError	int

DECLARE @QtyTotal	float 
DECLARE @Month		int

DECLARE @ClassA		int
DECLARE @ClassB		int

DECLARE @SaleTotal	money
DECLARE @SalePercTotal	money
DECLARE @SalePerc	money
DECLARE @IDCurrentStore	int
DECLARE @IDStore	int
DECLARE @IDModel	int

SET @ErrorLevel = 0

-- Meses
SELECT @Month = CONVERT(int, PropertyValue) FROM Sis_PropertyDomain WHERE Property = 'ABCCalcPeriodInMonth'
--Percentual de A
SELECT @ClassA = CONVERT(int, PropertyValue) FROM Sis_PropertyDomain WHERE Property = 'ClassAPerc'
--Percentual de B
SELECT @ClassB = CONVERT(int, PropertyValue) FROM Sis_PropertyDomain WHERE Property = 'ClassBPerc'

--Create Temp Table
CREATE TABLE #ABCTemp
(
	IDStore int,
	IDModel int,
	SalePerc money
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
			@SaleTotal = SUM((SalePrice * Qty) - Discount)
		FROM
			vwSaleItem IM
			JOIN Pessoa P ON (IM.ComissionID = P.IDPessoa AND IM.IDTipoPessoa = P.IDTipoPessoa)
			JOIN Model M ON (M.IDModel = IM.ModelID)
			JOIN TabGroup TG ON (IM.GroupID = TG.IDGroup)
		WHERE	
			IM.PreSaleDate >= DATEADD(month, - @Month, GetDate())
			AND IM.PreSaleDate < GetDate()+1
			AND IM.InventMovTypeID = 1
			AND IM.StoreID = @IDStore
			AND TG.Service = 0
	
		--Insiro os percentuais de venda ordenado
		INSERT
			#ABCTemp (IDStore, IDModel, SalePerc)
		SELECT
			IM.StoreID,
			IM.ModelID, -- Modelo ordenado DESC por profit
			(SUM((IM.SalePrice * IM.Qty) - Discount)/@SaleTotal) * 100 -- Percentual do total da venda em valor
		FROM
			vwSaleItem IM
			JOIN Pessoa P ON (IM.ComissionID = P.IDPessoa AND IM.IDTipoPessoa = P.IDTipoPessoa)
			JOIN Model M ON (M.IDModel = IM.ModelID)
			JOIN TabGroup TG ON (IM.GroupID = TG.IDGroup)
		WHERE	
			IM.PreSaleDate >= DATEADD(month, -@Month, GetDate())
			AND IM.PreSaleDate < GetDate()+1
			AND IM.InventMovTypeID = 1
			AND IM.StoreID = @IDStore
			AND TG.Service = 0
		GROUP BY
			IM.StoreID,
			IM.ModelID,
			M.SellingPrice
	END
	ELSE
	BEGIN
		--Calculo da Qty Total vendida
		SELECT
			@SaleTotal = SUM((SalePrice * Qty) - Discount)
		FROM
			InventoryMov IM
			JOIN Model M ON (M.IDModel = IM.ModelID)
			JOIN TabGroup TG ON (M.GroupID = TG.IDGroup)
		WHERE	
			IM.MovDate >= DATEADD(month, - @Month, GetDate())
			AND IM.MovDate < GetDate()+1
			AND IM.InventMovTypeID = 1
			AND IM.StoreID = @IDStore
			AND TG.Service = 0
	
		--Insiro os percentuais de venda ordenado
		INSERT
			#ABCTemp (IDStore, IDModel, SalePerc)
		SELECT
			IM.StoreID,
			IM.ModelID, -- Modelo ordenado DESC por profit
			(SUM((IM.SalePrice * IM.Qty) - Discount)/@SaleTotal) * 100 -- Percentual do total da venda em valor
		FROM
			InventoryMov IM
			JOIN Model M ON (M.IDModel = IM.ModelID)
			JOIN TabGroup TG ON (M.GroupID = TG.IDGroup)
		WHERE	
			IM.MovDate >= DATEADD(month, - @Month, GetDate())
			AND IM.MovDate < GetDate()+1
			AND IM.InventMovTypeID = 1
			AND IM.StoreID = @IDStore
			AND TG.Service = 0
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
		SalePerc DESC

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
				WHEN ((@SalePercTotal > @ClassA) AND (@SalePercTotal <= @ClassB)) THEN 'B'
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
	Inventory I
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
