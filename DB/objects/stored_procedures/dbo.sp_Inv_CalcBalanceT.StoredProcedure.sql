SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[sp_Inv_CalcBalanceT] (@IDModel int, @ProcessDate datetime)
AS

DECLARE @ErrorLevel	int
DECLARE @SysError	int
DECLARE @MovDate	datetime

SET @ErrorLevel = 0
SET @ProcessDate = 0

--------------------------------------------------------------------------------------------------------------
-- Serão processadas todas as datas que possuem movimentação, a partir da última data processada
DECLARE MOVDATE_CUR CURSOR FOR 
SELECT
	CONVERT(smalldatetime, CONVERT(varchar, MovDate, 103), 103)
FROM
	InventoryMov (NOLOCK)
WHERE
	ModelID = @IDModel
	AND CONVERT(smalldatetime, CONVERT(varchar, MovDate, 103), 103) >= @ProcessDate
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
	-- Calculo do saldo pelo estoque total
	exec sp_Inv_CalcModelBalanceT @IDModel, @MovDate
	
	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		SET @ErrorLevel = -203
		GOTO ERRO
	END
	
	------------------------------------------------------------------------------------------------------
	-- Calculo do saldo pelo estoque por loja
	exec sp_Inv_CalcModelStoreBalanceT @IDModel, @MovDate
	
	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		SET @ErrorLevel = -204
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
