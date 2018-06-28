IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[sp_Sys_DailyMaintenance]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[sp_Sys_DailyMaintenance]
GO

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[sp_PO_CalcOrderPointSimple]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[sp_PO_CalcOrderPointSimple]
GO

CREATE PROCEDURE sp_PO_CalcOrderPointSimple
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
DECLARE @StoreAutoRequest	int
DECLARE @QtyFrac		bit
DECLARE @AutoRequestClassA	bit
DECLARE @AutoRequestClassB	bit
DECLARE @AutoRequestClassC	bit

SET @ErrorLevel = 0
SET @LastProcess = 0
SET @Type = (SELECT Convert(int, SrvValue) FROM Param Where IDParam = 63)

--Periodo
(SELECT @SaleMonth = CONVERT(int, PropertyValue) FROM Sis_PropertyDomain WHERE Property = 'AutoRequestSalePeriodInMonth')

--Margem de seguranca
(SELECT @SafeMarginClassA = CONVERT(int, PropertyValue) FROM Sis_PropertyDomain WHERE Property = 'PercSecurityMarginClassA')
(SELECT @SafeMarginClassB = CONVERT(int, PropertyValue) FROM Sis_PropertyDomain WHERE Property = 'PercSecurityMarginClassB')
(SELECT @SafeMarginClassC = CONVERT(int, PropertyValue) FROM Sis_PropertyDomain WHERE Property = 'PercSecurityMarginClassC')

--Periodo para compra
(SELECT @POPeriodClassA = CONVERT(int, PropertyValue) FROM Sis_PropertyDomain WHERE Property = 'POTimeSetupClassAInDays')
(SELECT @POPeriodClassB = CONVERT(int, PropertyValue) FROM Sis_PropertyDomain WHERE Property = 'POTimeSetupClassBInDays')
(SELECT @POPeriodClassC = CONVERT(int, PropertyValue) FROM Sis_PropertyDomain WHERE Property = 'POTimeSetupClassCInDays')

--Classes que auto-requisitam
(SELECT @AutoRequestClassA = CONVERT(bit, PropertyValue) FROM Sis_PropertyDomain WHERE Property = 'AutoRequestClassA')
(SELECT @AutoRequestClassB = CONVERT(bit, PropertyValue) FROM Sis_PropertyDomain WHERE Property = 'AutoRequestClassB')
(SELECT @AutoRequestClassC = CONVERT(bit, PropertyValue) FROM Sis_PropertyDomain WHERE Property = 'AutoRequestClassC')

--Loja que vai ser à base do cálculo
(SELECT @StoreAutoRequest = CONVERT(int, PropertyValue) FROM Sis_PropertyDomain WHERE Property = 'StoreToAutoRequest')

--------------------------------------------------------------------------------------------------------------
-- Pego a última data processada ou a primeira data a processar
SELECT @Today		= CONVERT(smalldatetime, CONVERT(varchar, GetDate(), 103), 103)
SELECT @LastProcess	= CONVERT(smalldatetime, CONVERT(varchar, MAX(Date), 103), 103) FROM DailyMaintenanceReport WHERE Maintenance = 'CalcOrderPoint'

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
		SELECT @LastProcess = CONVERT(smalldatetime, CONVERT(varchar, MIN(MovDate), 103), 103) FROM InventoryMov

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
			Pur_Purchase PU
			JOIN PO ON (PU.IDPO = PO.IDPO)
			JOIN Pur_PurchaseItem PUI ON (PUI.IDPurchase = PU.IDPurchase)
			JOIN Model M ON (M.IDModel = PUI.IDModel)
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
			Pur_Purchase PU
			JOIN PO ON (PU.IDPO = PO.IDPO)
			JOIN Pur_PurchaseItem PUI ON (PUI.IDPurchase = PU.IDPurchase)
			JOIN Model M ON (M.IDModel = PUI.IDModel)
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
				InventoryMov IM
				JOIN Model M ON (M.IDModel = IM.ModelID)
				JOIN TabGroup TG ON (M.GroupID = TG.IDGroup)
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
				InventoryMov IM
				JOIN Model M ON (M.IDModel = IM.ModelID)
				JOIN TabGroup TG ON (M.GroupID = TG.IDGroup)
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
				vwSaleItem IM
				JOIN Pessoa P ON (IM.ComissionID = P.IDPessoa AND IM.IDTipoPessoa = P.IDTipoPessoa)
				JOIN Model M ON (M.IDModel = IM.ModelID)
				JOIN TabGroup TG ON (IM.GroupID = TG.IDGroup)
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
			WHEN 'A' THEN Round(LeadTime * DailySales, 2) * (@SafeMarginClassA/100.0)
			WHEN 'B' THEN Round(LeadTime * DailySales, 2) * (@SafeMarginClassB/100.0)
			WHEN 'C' THEN Round(LeadTime * DailySales, 2) * (@SafeMarginClassC/100.0)
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
	OrderPoint = Round((LeadTime * DailySales) , 2)

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
	CotacaoToModel CM
	JOIN Request R ON (R.IDRequest = CM.IDRequest)
	
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
	Param
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
				Inventory I
				JOIN Model Model ON (Model.IDModel = I.ModelID)
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
			Inventory I	
			JOIN Model Model ON (Model.IDModel = I.ModelID)
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

CREATE PROCEDURE sp_Sys_DailyMaintenance
			(
			@CalcABC	bit = 1,
			@CalcAvg	bit = 1,
			@DelHold	bit = 1
			)
AS

/* ---------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		Deleta os holds antigos

		- Deleto PreInventoryMov
		- Deleto Invoice
		- Atualizo Model

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-200  Erro em Insiro em DailyMaintenanceReport
		-201  Erro em Calcular ABC dos modelos
		-202  Erro em Calcular ABC dos modelos por loja
		-203  Erro em Calcular ponto de pedido e criar auto-requisições
		-204  Erro em Calcular o saldo em estoque e o custo médio
		-205  Erro em Atualizar a última data processada em DailyMaintenanceReport
		-206  Erro em Deleto PreInventoryMov
		-207  Erro em Atualizo Model
		-208  Erro em Altera o status do processamento após a conclusão


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	-----------------------	-----------------------	----------------------------------------------------------------------------------
	15 May	2000		Rodrigo Costa		Criacao;
	25 Jun	2001		Davi Gouveia		Log de Return Values;
	18 Aug	2004		Rodrigo Costa		Gravar error log;
	05 Jan	2007		Rodrigo Costa		Deletar hold com um cursor;
	09 Feb	2007		Maximiliano Muniz	Inclusão de apenas um registro na tabela DailyMaintenanceReport;
	16 Feb	2007		Maximiliano Muniz	Chamada da SP de cálculo de saldo de estoque e custo médio;
	06 Mar	2007		Rodrigo Costa		Criado parametros para executar as opcoes
	---------------------------------------------------------------------------------------------------------------------------------- */

DECLARE @IDPreSale	int
DECLARE @DelHoldDay	int
DECLARE @DelItemMonth	int
DECLARE @ErrorLevel 	int
DECLARE @SysError	int
DECLARE @Today		datetime
DECLARE @LastProcess	datetime
DECLARE	@IDDayMaint	int
DECLARE	@Date		DateTime

SET @ErrorLevel = 0

SELECT 	@DelHoldDay = Convert(Int, SrvValue) FROM Param WHERE IDParam = 18
SELECT 	@DelItemMonth = Convert(Int, SrvValue) FROM Param WHERE IDParam = 17

-- Garanto que nao estao nulos
SELECT @DelHoldDay = IsNull(@DelHoldDay, 0) 
SELECT @DelItemMonth = IsNull(@DelItemMonth, 0)

-------------------------------------------------------------------------------------------------------------------------
-- Pego a última data processada ou a primeira data a processar
SELECT @Today		= CONVERT(smalldatetime, CONVERT(varchar, GetDate(), 103), 103)
SELECT @LastProcess	= CONVERT(smalldatetime, CONVERT(varchar, MAX(Date), 103), 103) FROM DailyMaintenanceReport WHERE Maintenance = 'DailyMaintenance'

IF @LastProcess = @Today
	RETURN
ELSE
BEGIN
	IF @LastProcess > 0
		SET @LastProcess = DateAdd(DAY, 1, @LastProcess)
	ELSE
	BEGIN
		----------------------------------------------------------------------------------------------------------
		-- Se ainda não processou nenhuma vez, insiro em DailyMaintenanceReport
		-- com a data da primeira movimentação do sitema
		SELECT @LastProcess = @Today

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
			'DailyMaintenance',
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



IF @CalcABC = 1
BEGIN
	-------------------------------------------------------------------------------------------------
	-- Calcular ABC dos modelos
	exec sp_Inv_CalcModelABC
	
	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		SET @ErrorLevel = -201
	
		GOTO ERRO
	END
	
	-------------------------------------------------------------------------------------------------
	-- Calcular ABC dos modelos por loja
	exec sp_Inv_CalcStoreABC
	
	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		SET @ErrorLevel = -202
	
		GOTO ERRO
	END
	
	-------------------------------------------------------------------------------------------------
	-- Calcular ponto de pedido e criar auto-requisições
	exec sp_PO_CalcOrderPointSimple
	
	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		SET @ErrorLevel = -203
	
		GOTO ERRO
	END
END



IF @CalcAvg = 1
BEGIN
	-------------------------------------------------------------------------------------------------
	-- Calcular o saldo em estoque e o custo médio
	exec sp_Inv_CalcBalance
	
	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		SET @ErrorLevel = -204
	
		GOTO ERRO
	END
END

BEGIN TRANSACTION

-----------------------------------------------------------------------------------------------------------------
-- Atualizar a última data processada em DailyMaintenanceReport
UPDATE DailyMaintenanceReport SET [Date] = @Today, LastMessage = 'Started' WHERE Maintenance = 'DailyMaintenance'

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -205
	GOTO ERRO
END



IF @DelHold = 1
BEGIN

	IF @DelHoldDay > 0
	BEGIN
	
	/* ------------------------------------------------------------------------------------ */
	/*	Deletar movimentaçao de cancelamento com base na movimentação anterior		*/
	/* ------------------------------------------------------------------------------------ */ 
	--Declaração do Cursor de HoldDel_Cursor
	DECLARE HoldDel_Cursor CURSOR STATIC FOR 
		SELECT
			IDPreSale
		FROM
			Invoice
		WHERE
			Invoice.IDInvoice IS NULL
			AND
			DateAdd(dd, @DelHoldDay, IsNull(EstimatedPay, Invoice.PreSaleDate)) < GetDate()
			AND
			Layaway <> 1
	
	OPEN HoldDel_Cursor
	
	--Inicialização de PreInv_Cursor
	FETCH NEXT FROM HoldDel_Cursor INTO
	            @IDPreSale
	
	--Enquanto tem registros
	WHILE @@FETCH_STATUS = 0
	BEGIN
		--Deletar os items
		EXEC sp_PreSale_Remove @IDPreSale, 0
	
		SET @SysError = @@ERROR
		IF @SysError <> 0
		BEGIN
		            SET @ErrorLevel = -206
		            GOTO ERRO
		END
	
	
		FETCH NEXT FROM HoldDel_Cursor INTO
	                        @IDPreSale
	END
	
	--fechamento do cursor
	CLOSE HoldDel_Cursor
	--Destruição do cursor
	DEALLOCATE HoldDel_Cursor
	
	END
	
	IF @DelItemMonth > 0
	BEGIN
		SELECT
			IDModel
		INTO 
			#ModelToDelete
		FROM
			Model 
			JOIN Inventory I ON (Model.IDModel = I.ModelID)
		WHERE
			DateAdd(mm, @DelItemMonth, Model.LastMovDate) < GetDate()
			AND
			Model.LastMovDate IS NOT NULL
			AND
			Desativado = 0
		GROUP BY 
			IDModel
		HAVING
			SUM(IsNull(I.QtyOnHand,0)) = 0
	
		/*
	  	INSERT 	InventoryMov (InventMovTypeID, DocumentID, StoreID, ModelID, MovDate, Qty)
	        SELECT  20, 1, 1, IDModel, GetDate(), 0
		FROM	#ModelToDelete
		*/
	
		-- Atualizo Model
		UPDATE
			Model
		SET
			Desativado = 1
		FROM
			#ModelToDelete MTD
		WHERE
			Model.IDModel = MTD.IDModel
	
		SET @SysError = @@ERROR
		IF @SysError <> 0
		BEGIN
			SET @ErrorLevel = -207
			GOTO ERRO
		END
	
		DROP TABLE #ModelToDelete
	END
END

-------------------------------------------------------------------------------------------------
-- Altera o status do processamento após a conclusão
UPDATE DailyMaintenanceReport SET LastMessage = 'Finished' WHERE Maintenance = 'DailyMaintenance'

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -208

	GOTO ERRO
END

OK:
	COMMIT TRANSACTION
	RETURN 0

ERRO:
	ROLLBACK TRANSACTION
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'System', 'Error: sp_DailyMaintenance', @ErrorLevelStr

	RETURN @ErrorLevel

GO
