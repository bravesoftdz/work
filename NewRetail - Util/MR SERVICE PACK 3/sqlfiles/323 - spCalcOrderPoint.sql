if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PO_CalcOrderPoint]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PO_CalcOrderPoint]
GO


CREATE  PROCEDURE sp_PO_CalcOrderPoint
	(
	@Date	DateTime = Null
	)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		Calculo dinamico do Ponto de Pedido

		por Maurfcio Pimenta Lima e Eduardo Costa em 9 de agosto de 1999.

		Esta procedure utiliza os seguintes parametros:

		N    - N•mero de dias a serem utilizados no cßlculo do desvio padrao da demanda
		Alfa - Fator a ser utilizado no mTdia amortizada da demanada
		K    - Fator em funtao do Nfvel de servito
		TR   - N•mero de dias entre o pedido e o recebimento

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Insiro em DailyMaintenanceReport
		-202  Erro em Os campos utilizado para o calculo sao zerados
		-203  Erro em Acumular a venda diaria VD
		-204  Erro em Acumulo a venda anterior ao periodo selecionado VP
		-205  Erro em Calcular a previsao diaria para o proximo dia PVD
		-206  Erro em Calculo SX
		-207  Erro em Calculo SX2
		-208  Erro em Calculo DP
		-209  Erro em Calcular o estoque de seguranta
		-210  Erro em Calcular o Ponto de Pedido
		-211  Erro em Marca como terminado
		-212  Erro em Deleto todos os computer request
		-213  Erro em Incluo todos os modelos que estao com QtyOnHand, menor que Ponto de Pedido


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
	26 June 2001		Davi Gouveia		Log de Return Values
	29 Oct 	2003		Rodrigo Costa		Criado sp_Sis_GetNextCode;
	                      				Criado cursor Request_Cursor;
	18 Nov  2005		Leonardo Riego		Modificação no Update dos campos SX, SX2 e DP;
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */


DECLARE @N 			int
DECLARE @Alfa  		money
DECLARE @KA			money
DECLARE @KB			money
DECLARE @KC			money
DECLARE @TR			int
DECLARE @PVD 		money
DECLARE @SX 		int
DECLARE @SX2		int
DECLARE @DP			money
DECLARE @DMP		int
DECLARE @ErrorLevel		int
--Declaração de variáveis para o Cursor de Request
DECLARE @ModelID 		int 
DECLARE @Description 	varchar(50)
DECLARE @IDDayMaint	int
DECLARE @IDRequest		int 

SET @ErrorLevel = 0

SELECT @N = 5
SELECT @Alfa = .25
SELECT @TR = 2

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

IF @@ERROR <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END

SELECT @DMP = @@Identity

SELECT @KA = Convert(Float, SrvValue) FROM Param WHERE IDParam = 28
SELECT @KB = Convert(Float, SrvValue) FROM Param WHERE IDParam = 29
SELECT @KC = Convert(Float, SrvValue) FROM Param WHERE IDParam = 30

/* Os campos utilizado para o calculo sao zerados */

UPDATE
	Model
SET
	VD = 0, -- Venda dirária
	VP = 0, -- Venda passada ( N dias atrás )
	InicioPontoPedido = IsNull(InicioPontoPedido, @Date)

IF @@ERROR <> 0
BEGIN
	SET @ErrorLevel = -202
	GOTO ERRO
END

/* Acumular a venda diaria VD */
UPDATE
	Model
SET	
	VD = MT.Venda
FROM	(
	SELECT
		IM.ModelID IDModel,
		SUM(Qty) Venda
	FROM	
		InventoryMov IM
	WHERE
		InventMovTypeID = 1		AND
		DateAdd(Day, -1, Convert(Char(30), @Date, 101)) <= IM.MovDate
		AND
		DateAdd(Day, 0, Convert(Char(30), @Date, 101)) > IM.MovDate
	GROUP BY
		IM.ModelID
	) MT
WHERE
	MT.IDModel = Model.IDModel

IF @@ERROR <> 0
BEGIN
	SET @ErrorLevel = -203
	GOTO ERRO
END


/* Acumulo a venda anterior ao periodo selecionado VP */
UPDATE
	Model
SET
	VP = MT.Venda
FROM	(
	SELECT
		IM.ModelID IDModel,
		SUM(Qty) Venda
	FROM
		InventoryMov IM
	WHERE
		InventMovTypeID = 1
		AND 
		DateAdd(Day, (@N * -1) -1, Convert(Char(30), @Date, 101)) <= IM.MovDate
		AND
		DateAdd(Day, @N * -1, Convert(Char(30), @Date, 101)) > IM.MovDate
	GROUP BY
		IM.ModelID
	) MT
WHERE
	MT.IDModel = Model.IDModel
	AND
	DateDiff(Day, InicioPontoPedido, @Date) >= (@N)

IF @@ERROR <> 0
BEGIN
	SET @ErrorLevel = -204
	GOTO ERRO
END


/* Calcular a previsao diaria para o proximo dia PVD */
/*     PVD = ALFA * VD + (1 - ALFA) * PVD     */
/*     Inicializado com VD */


UPDATE
	Model
SET	
	PVD = @Alfa * VD + (1 - @Alfa) * IsNull(PVD, VD)

IF @@ERROR <> 0
BEGIN
	SET @ErrorLevel = -205
	GOTO ERRO
END


/* Calcular o desvio padrao DP  */
-- Calculo SX
UPDATE
	Model
SET
	SX = IsNull((SX + VD - VP), VD)
WHERE
	VD < 46000
	AND
	VD >= 0

IF @@ERROR <> 0
BEGIN
	SET @ErrorLevel = -206
	GOTO ERRO
END

-- Calculo SX2
UPDATE
	Model
SET
	SX2 = POWER(VD,2)
WHERE
	VD < 46000
	AND
	VD >= 0

IF @@ERROR <> 0
BEGIN
	SET @ErrorLevel = -207
	GOTO ERRO
END

-- Calculo DP
UPDATE
	Model
SET
	DP = CASE
		WHEN DateDiff(Day, InicioPontoPedido, @Date) < (@N-1) THEN 0
		WHEN (@N * SX2 - POWER(SX, 2)) < 0 THEN 1
		ELSE
			SQRT((@N * SX2 - POWER(SX, 2))/(@N*(@N-1)))
	      END
WHERE
	SX >= 0

IF @@ERROR <> 0
BEGIN
	SET @ErrorLevel = -208
	GOTO ERRO
END


/* Calcular o estoque de seguranta  */
/*     ES = K * DP * (TR^.5)  */

UPDATE
	Model
SET	
	ES = (	CASE Model.ClasseABC
			WHEN 'A' THEN @KA
			WHEN 'E' THEN @KA
			WHEN 'B'THEN @KB
			ELSE @KC
		END ) * DP * SQRT(@TR)

IF @@ERROR <> 0
BEGIN
	SET @ErrorLevel = -209
	GOTO ERRO
END


/* Calcular o Ponto de Pedido */
/*     PP = TR * PVD + ES     */

UPDATE
	Model
SET	
	PP = Model.TR * PVD + ES

IF @@ERROR <> 0
BEGIN
	SET @ErrorLevel = -210
	GOTO ERRO
END


/* Marca como terminado */

UPDATE  
	DailyMaintenanceReport
SET 
	LastMessage = 'Finished'
WHERE 
	IDDailyMaintenanceReport = @DMP

IF @@ERROR <> 0
BEGIN
	SET @ErrorLevel = -211
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

IF @@ERROR <> 0
BEGIN
	SET @ErrorLevel = -212
	GOTO ERRO
END

/* Incluo todos os modelos que estao com QtyOnHand, menor que Ponto de Pedido */
--Declaração do Cursor de Request
DECLARE Request_Cursor CURSOR FOR

	SELECT	
		IDModel,
		Description
	FROM	
		Model
	WHERE	
		TotQtyOnHand < PP
		AND
		PP <> 0
		AND
		PP IS NOT NULL
		AND 
		AutomaticRequest = 1
		AND 
		NOT EXISTS ( SELECT ModelID FROM PreInventoryMov PO WHERE PO.ModelID = Model.IDModel AND PO.InventMovTypeID = 2 )
		AND 
		NOT EXISTS ( SELECT ModelID FROM Request R  WHERE R.ModelID = Model.IDModel AND R.Type <> 'C')

OPEN Request_Cursor

--Inicialização de Request_Cursor
FETCH NEXT FROM Request_Cursor INTO
	@ModelID,
	@Description
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
		@ModelID,
		@Description,
		0,
		1,
		GetDate(),
		'C',
		1
		)

	IF @@ERROR <> 0
	BEGIN
		CLOSE Request_Cursor
		DEALLOCATE Request_Cursor
		SET @ErrorLevel = -213
		GOTO ERRO
	END

	FETCH NEXT FROM Request_Cursor INTO
		@ModelID,
		@Description
END
--fechamento do cursor
CLOSE Request_Cursor
--Destruição do cursor
DEALLOCATE Request_Cursor


IF @@ERROR <> 0
BEGIN
	SET @ErrorLevel = -213
	GOTO ERRO
END

OK:
	RETURN 0
ERRO:
	PRINT CAST(@ErrorLevel AS VARCHAR)
	RETURN @ErrorLevel


GO
