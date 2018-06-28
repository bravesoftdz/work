IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[sp_Inv_CalcBalance]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[sp_Inv_CalcBalance]
GO

CREATE PROCEDURE sp_Inv_CalcBalance
AS
/* -----------------------------------------------------------------------------------------------------------
	SUMARIO

		Calculo dinamico de saldo de quantidade e valor em estoque
		por Maximiliano Muniz em 17 de Outubro de 2006.

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Se ainda não processou nenhuma vez, insiro em DailyMaintenanceReport com a data da primeira movimentação do sitema
		-202  Erro em Atualizar a última data processada em DailyMaintenanceReport
		-203  Erro em Calcular o saldo pelo estoque total
		-204  Erro em Calcular o saldo pelo estoque por loja
		-205  Erro em Altera o status do processamento após a conclusão

	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	-----------------------	-----------------------	------------------------------------------------------
	17 Oct	2006		Maximiliano Muniz	Criacao;
	14 May	2007		Maximiliano Muniz	Adicionado "exec" da nova SP para cálculo por loja;
	------------------------------------------------------------------------------------------------------ */

DECLARE @ErrorLevel	int
DECLARE @SysError	int
DECLARE @IDDayMaint	int
DECLARE @LastProcess	datetime
DECLARE @Today		datetime
DECLARE @MovDate	datetime

SET @ErrorLevel = 0
SET @LastProcess = 0

--------------------------------------------------------------------------------------------------------------
-- Pego a última data processada ou a primeira data a processar
SELECT @Today		= CONVERT(smalldatetime, CONVERT(varchar, GetDate(), 103), 103)
SELECT @LastProcess	= CONVERT(smalldatetime, CONVERT(varchar, MAX(Date), 103), 103) FROM DailyMaintenanceReport WHERE Maintenance = 'CalcInventoryBalance'

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
			'CalcInventoryBalance',
			@LastProcess,
			'Started'
			)
		
		SET @SysError = @@ERROR
		IF @SysError <> 0
		BEGIN
			SET @ErrorLevel = -201
			GOTO ERRO
		END
	END
END

--------------------------------------------------------------------------------------------------------------
-- Serão processadas todas as datas que possuem movimentação, a partir da última data processada
DECLARE MOVDATE_CUR CURSOR FOR 
SELECT
	CONVERT(smalldatetime, CONVERT(varchar, MovDate, 103), 103)
FROM
	InventoryMov
WHERE
	CONVERT(smalldatetime, CONVERT(varchar, MovDate, 103), 103) >= @LastProcess
GROUP BY
	CONVERT(smalldatetime, CONVERT(varchar, MovDate, 103), 103)
ORDER BY
	CONVERT(smalldatetime, CONVERT(varchar, MovDate, 103), 103)

OPEN MOVDATE_CUR

FETCH NEXT FROM MOVDATE_CUR INTO
	@MovDate

WHILE @@FETCH_STATUS = 0
BEGIN
	------------------------------------------------------------------------------------------------------
	-- Atualizar a última data processada em DailyMaintenanceReport
	UPDATE DailyMaintenanceReport SET [Date] = @MovDate, LastMessage = 'Started' WHERE Maintenance = 'CalcInventoryBalance'
	
	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		SET @ErrorLevel = -202
		GOTO ERRO
	END

	------------------------------------------------------------------------------------------------------
	-- Calculo do saldo pelo estoque total
	exec sp_Inv_CalcModelBalance @MovDate
	
	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		SET @ErrorLevel = -203
		GOTO ERRO
	END
	
	------------------------------------------------------------------------------------------------------
	-- Calculo do saldo pelo estoque por loja
	exec sp_Inv_CalcModelStoreBalance @MovDate
	
	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		SET @ErrorLevel = -204
		GOTO ERRO
	END
	
	------------------------------------------------------------------------------------------------------
	-- Altera o status do processamento após a conclusão
	UPDATE DailyMaintenanceReport SET LastMessage = 'Finished' WHERE Maintenance = 'CalcInventoryBalance'
	
	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		SET @ErrorLevel = -205
		GOTO ERRO
	END

	FETCH NEXT FROM MOVDATE_CUR INTO
		@MovDate
END

CLOSE MOVDATE_CUR
DEALLOCATE MOVDATE_CUR

OK:
	RETURN 0
ERRO:
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'System', 'Error: sp_Inv_CalcBalance', @ErrorLevelStr

	RETURN @ErrorLevel
GO
