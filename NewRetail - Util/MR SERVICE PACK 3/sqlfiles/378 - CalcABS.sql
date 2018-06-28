if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Inventory_UpdateABC]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Inventory_UpdateABC]
GO

CREATE PROCEDURE sp_Inventory_UpdateABC
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
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
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	09 Sept 1999		Eduardo Costa		Criacao;
	25 June 2001		Davi Gouveia		Log de Return Values
	18 Aug 2004		Rodrigo Costa		Gravar error log
	18 Jan	2005		Rodrigo Costa		Gerar curva ABC por modo de caixa
	19 Dez	2005		Rodrigo Costa		Separar ABC por tipo de venda
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */


DECLARE @ErrorLevel 	int
DECLARE @SysError	int

DECLARE @QtyTotal	float 
DECLARE @Month		int

DECLARE @ClassA		int
DECLARE @ClassB		int

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
SELECT @ClassB = @ClassA + CONVERT(int, PropertyValue) FROM Sis_PropertyDomain WHERE Property = 'ClassBPerc'

--Create Temp Table
CREATE TABLE #ABCTemp
(
	IDModel int,
	SalePerc money,
	SalePrice money,
	TotalQtySold float
)

IF (SELECT Convert(int, SrvValue) FROM Param Where IDParam = 63) = 2
BEGIN

	--Calculo da Qty Total vendida
	SELECT
		@QtyTotal = SUM(Qty)
	FROM
		vwSaleItem IM
		JOIN Pessoa P ON (IM.ComissionID = P.IDPessoa AND IM.IDTipoPessoa = P.IDTipoPessoa)
		JOIN Model M ON (M.IDModel = IM.ModelID)
		JOIN TabGroup TG ON (IM.GroupID = TG.IDGroup)
	WHERE	
		IM.MovDate >= DATEADD(month, - @Month, GetDate())
		AND
		IM.MovDate < GetDate()+1
		AND
		IM.InventMovTypeID = 1
		AND
		TG.Service = 0

	--Insiro os percentuais de venda ordenado
	INSERT
		#ABCTemp (IDModel, SalePerc, SalePrice, TotalQtySold)
	SELECT
		IM.ModelID, -- Modelo ordenado DESC por profit
		(SUM(IM.Qty)/@QtyTotal) * 100, -- Percentual do toal da venda
		M.SellingPrice,
		SUM(IM.Qty)
	FROM
		vwSaleItem IM
		JOIN Pessoa P ON (IM.ComissionID = P.IDPessoa AND IM.IDTipoPessoa = P.IDTipoPessoa)
		JOIN Model M ON (M.IDModel = IM.ModelID)
		JOIN TabGroup TG ON (IM.GroupID = TG.IDGroup)
	WHERE	
		IM.MovDate >= DATEADD(month, -@Month, GetDate())
		AND
		IM.MovDate < GetDate()+1
		AND
		IM.InventMovTypeID = 1
		AND
		TG.Service = 0
	GROUP BY 
		IM.ModelID,
		M.SellingPrice

END
ELSE
BEGIN

	--Calculo da Qty Total vendida
	SELECT
		@QtyTotal = SUM(IM.Qty)
	FROM
		InventoryMov IM
		JOIN Model M ON (M.IDModel = IM.ModelID)
		JOIN TabGroup TG ON (M.GroupID = TG.IDGroup)
	WHERE	
		IM.MovDate >= DATEADD(month, - @Month, GetDate())
		AND
		IM.MovDate < GetDate()+1
		AND
		IM.InventMovTypeID = 1
		AND
		TG.Service = 0

	--Insiro os percentuais de venda ordenado
	INSERT
		#ABCTemp (IDModel, SalePerc, SalePrice, TotalQtySold)
	SELECT
		IM.ModelID, -- Modelo ordenado DESC por profit
		(SUM(IM.Qty)/@QtyTotal) * 100, -- Percentual do toal da venda
		IM.SalePrice,
		SUM(IM.Qty)
	FROM
		InventoryMov IM
		JOIN Model M ON (M.IDModel = IM.ModelID)
		JOIN TabGroup TG ON (M.GroupID = TG.IDGroup)
	WHERE	
		IM.MovDate >= DATEADD(month, - @Month, GetDate())
		AND
		IM.MovDate < GetDate()+1
		AND
		IM.InventMovTypeID = 1
		AND
		TG.Service = 0
	GROUP BY
		IM.ModelID,
		IM.SalePrice
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
		SalePerc DESC,
		SalePrice DESC

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

--Somente Para ver o resultado na tela
/*
SELECT
	M.Model,
	TG.Name as Category,
	ABCT.SalePerc,
	ABCT.SalePrice,
	ABCT.TotalQtySold,
	M.ClasseABC
FROM
	#ABCTemp ABCT
	JOIN Model M ON (ABCT.IDModel = M.IDModel)
	JOIN TabGroup TG ON (TG.IDGroup = M.GroupID)
ORDER BY
	ABCT.SalePerc DESC,
	SalePrice DESC
*/

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
