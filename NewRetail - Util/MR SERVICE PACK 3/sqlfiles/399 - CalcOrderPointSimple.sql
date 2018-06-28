if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Inventory_UpdateABC]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Inventory_UpdateABC]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PO_CalcOrderPointSimple]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PO_CalcOrderPointSimple]
GO

CREATE PROCEDURE sp_Inventory_UpdateABC
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
	25 Jun	2001		Davi Gouveia		Log de Return Values
	18 Aug	2004		Rodrigo Costa		Gravar error log
	18 Jan	2005		Rodrigo Costa		Gerar curva ABC por modo de caixa
	19 Dec	2005		Rodrigo Costa		Separar ABC por tipo de venda
	24 Feb	2006		Maximiliano Muniz	Alterado o filtro por data no cálculo da média de vendas
	----------------------------------------------------------------------------------------------------------------- */

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
		IM.PreSaleDate >= DATEADD(month, - @Month, GetDate())
		AND
		IM.PreSaleDate < GetDate()+1
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
		IM.PreSaleDate >= DATEADD(month, -@Month, GetDate())
		AND
		IM.PreSaleDate < GetDate()+1
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

CREATE PROCEDURE sp_PO_CalcOrderPointSimple
	(
	@Date	DateTime = Null
	)
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
		-201  Erro em Insiro em DailyMaintenanceReport
		-202  Erro em calcular a media de entrega
		-203  Erro em calcular a media de vendas no periodo
		-204  Erro em calcular o ponto de pedido
		-205  Erro em Marca como terminado
		-206  Erro em Deleto todos os computer request
		-207  Erro em Incluo todos os modelos que estao com QtyOnHand, menor que Ponto de Pedido

	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	-----------------------	-----------------------	-----------------------------------------------------------------
	30 Jan	2006		Max e Rodrigo		Criacao;
	24 Feb	2006		Maximiliano Muniz	Alterado o filtro por data no cálculo da média de vendas
	----------------------------------------------------------------------------------------------------------------- */

DECLARE @ErrorLevel		int
DECLARE @SysError		int
DECLARE @IDDayMaint		int
DECLARE @DMP			int
DECLARE @Month			int
DECLARE @Type			int
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


SET @ErrorLevel = 0
SET @Type = (SELECT Convert(int, SrvValue) FROM Param Where IDParam = 63)

--Periodo
(SELECT @Month = CONVERT(int, PropertyValue) FROM Sis_PropertyDomain WHERE Property = 'ABCCalcPeriodInMonth')
(SELECT @SaleMonth = CONVERT(int, PropertyValue) FROM Sis_PropertyDomain WHERE Property = 'AutoRequestSalePeriodInMonth')

--Margem de seguranca
(SELECT @SafeMarginClassA = CONVERT(int, PropertyValue) FROM Sis_PropertyDomain WHERE Property = 'PercSecurityMarginClassA')
(SELECT @SafeMarginClassB = CONVERT(int, PropertyValue) FROM Sis_PropertyDomain WHERE Property = 'PercSecurityMarginClassB')
(SELECT @SafeMarginClassC = CONVERT(int, PropertyValue) FROM Sis_PropertyDomain WHERE Property = 'PercSecurityMarginClassC')

--Periodo para compra
(SELECT @POPeriodClassA = CONVERT(int, PropertyValue) FROM Sis_PropertyDomain WHERE Property = 'POTimeSetupClassAInDays')
(SELECT @POPeriodClassB = CONVERT(int, PropertyValue) FROM Sis_PropertyDomain WHERE Property = 'POTimeSetupClassBInDays')
(SELECT @POPeriodClassC = CONVERT(int, PropertyValue) FROM Sis_PropertyDomain WHERE Property = 'POTimeSetupClassCInDays')


SELECT @Date = IsNull(@Date, GetDate())

/* Testa se ja rodou hoje */
IF Exists 	(
		SELECT
			IDDailyMaintenanceReport
		FROM
			DailyMaintenanceReport
		WHERE
			Maintenance = 'CalcOrderPoint'
			AND
			Convert(Char(30), Date, 101) = Convert(Char(30), @Date, 101)
		) Return

-- Insiro em DailyMaintenanceReport
exec sp_Sis_GetNextCode 'DailyMaintenanceReport.IDDailyMaintenanceReport', @IDDayMaint OUTPUT
INSERT DailyMaintenanceReport 
	(
	IDDailyMaintenanceReport,
	Maintenance, 
	Date, 
	LastMessage
	)
	VALUES 
	(
	@IDDayMaint,
	'CalcOrderPoint', 
	@Date, 
	'Started'
	)

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END

SELECT @DMP = @IDDayMaint

-- SUM(DataCompra - DataPedido)/Count(Numero Compras)
-- Calculo Media Entrega [ME]
UPDATE
	M
SET
	M.TR = P.MediaPedido
FROM
	Model M
	JOIN(	SELECT
			PUI.IDModel,
			(SUM(DATEDIFF(Day, PO.DataPedido, PU.DatePreReceiving))/COUNT(PU.IDPurchase)) as MediaPedido
		FROM
			Pur_Purchase PU
			JOIN PO ON (PU.IDPO = PO.IDPO)
			JOIN Pur_PurchaseItem PUI ON (PUI.IDPurchase = PU.IDPurchase)
			JOIN Model M ON (M.IDModel = PUI.IDModel)
		WHERE
			PU.DatePreReceiving >= DATEADD(month, - @Month, GetDate())
		GROUP BY
			PUI.IDModel) P ON (M.IDModel = P.IDModel)

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -202
	GOTO ERRO
END

-- Calculo Media Venda [MV]
IF (@Type = 1)
BEGIN
	UPDATE
		Model
	SET	
		PVD = MT.Venda / MT.Period
	FROM	(
		SELECT
			IM.ModelID IDModel,
			SUM(Qty) Venda,
			DATEDIFF(Day, DATEADD(month, - @SaleMonth, GetDate()), GetDate()) as Period
		FROM	
			InventoryMov IM
			JOIN Model M ON (M.IDModel = IM.ModelID)
			JOIN TabGroup TG ON (M.GroupID = TG.IDGroup)
		WHERE
			InventMovTypeID = 1
			AND
			IM.MovDate >= DATEADD(month, - @SaleMonth, GetDate())
			AND
			TG.Service = 0
		GROUP BY
			IM.ModelID
		) MT
	WHERE
		MT.IDModel = Model.IDModel
END
ELSE
BEGIN
	UPDATE
		Model
	SET	
		PVD = MT.Venda / MT.Period
	FROM	(
		SELECT
			IM.ModelID IDModel,
			SUM(Qty) Venda,
			DATEDIFF(Day, DATEADD(month, - @SaleMonth, GetDate()), GetDate()) as Period
		FROM	
			vwSaleItem IM
			JOIN Pessoa P ON (IM.ComissionID = P.IDPessoa AND IM.IDTipoPessoa = P.IDTipoPessoa)

			JOIN Model M ON (M.IDModel = IM.ModelID)
			JOIN TabGroup TG ON (IM.GroupID = TG.IDGroup)
		WHERE
			IM.InventMovTypeID = 1
			AND
			IM.PreSaleDate >= DATEADD(month, - @SaleMonth, GetDate())
			AND
			TG.Service = 0
		GROUP BY
			IM.ModelID
		) MT
	WHERE
		MT.IDModel = Model.IDModel
END

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -203
	GOTO ERRO
END


-- Calculo da margem de suguranca do ponto de pedido [Round(ME*MV)] * (Margem/100)
UPDATE
	Model
SET
	ES = CASE ClasseABC 
			WHEN 'A' THEN Round(TR * PVD, 2) * (@SafeMarginClassA/100.0)
			WHEN 'B' THEN Round(TR * PVD, 2) * (@SafeMarginClassB/100.0)
			WHEN 'C' THEN Round(TR * PVD, 2) * (@SafeMarginClassC/100.0)
		END
				


-- Calculo Ponto do Pedido [Round(ME*MV+ES)]
UPDATE
	Model
SET
	PP = Round((TR * PVD) , 2)

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -204
	GOTO ERRO
END

/* Marca como terminado */

UPDATE  
	DailyMaintenanceReport
SET 
	LastMessage = 'Finished'
WHERE 
	IDDailyMaintenanceReport = @DMP

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -205
	GOTO ERRO
END

/* Deleto todos os computer request */
DELETE 
	POItemRequest
WHERE
	IDRequest IN (SELECT IDRequest FROM Request WHERE Type = 'C')
	
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
--Declaração do Cursor de Request
DECLARE Request_Cursor CURSOR FOR

SELECT	
		IDModel,
		Description,
		CASE ClasseABC 
			WHEN 'A' THEN Round(PVD * @POPeriodClassA,2)
			WHEN 'B' THEN Round(PVD * @POPeriodClassB,2)
			WHEN 'C' THEN Round(PVD * @POPeriodClassC,2)
		END

	FROM	
		Model
	WHERE	
		(PP + ES) >=	(CASE @Type
				WHEN 1 THEN TotQtyOnHand 
				ELSE TotQtyOnHand - TotQtyOnPreSale
				END)
		AND
		PP <> 0
		AND
		PP IS NOT NULL
		AND
		AutomaticRequest = 1
		AND 
		NOT EXISTS ( SELECT ModelID FROM PreInventoryMov PO WHERE PO.ModelID = Model.IDModel AND PO.InventMovTypeID = 2 AND (PO.Qty < PO.QtyRealMov))
		AND 
		NOT EXISTS ( SELECT ModelID FROM Request R  WHERE R.ModelID = Model.IDModel AND R.Type <> 'C')


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
		1
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

OK:
	RETURN 0
ERRO:
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'System', 'Error: sp_PO_CalcOrderPoint', @ErrorLevelStr

	RETURN @ErrorLevel
GO
