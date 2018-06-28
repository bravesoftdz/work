SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[sp_Sys_Correct_Inventory_Balance] AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO
		
		- Calculo o balance

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro atualizar o balance
		-201  Erro recalcular o estoque

	LOG DE MODIFICAÇÕES

	Data		Programador				Modificação
	--------------- --------------------------------------- ------------------------------------------------------------------------------
	19 May 2008	Rodrigo Costa				Criação
	--------------------------------------------------------------------------------------------------------------------------------------*/


DECLARE @StoreID 	int 
DECLARE @IDInventoryMov	int
DECLARE @ModelID 	int
DECLARE @MovType	int 
DECLARE @MovDate 	datetime
DECLARE @Qty 		float
DECLARE @Bal 		float

DECLARE @ErrorLevel	int
DECLARE @SysError	int

DECLARE InventoryMov_Cursor CURSOR FOR

	SELECT 
		IDInventoryMov,
		StoreID,
		ModelID,
		MovDate,
		QTY
	FROM
		InventoryMov
	WHERE
		InventMovTypeID in (11, 12)
	ORDER BY
		MovDate,
		StoreID,
		ModelID
	
OPEN InventoryMov_Cursor

--Inicialização de InventoryMov_Cursor
FETCH NEXT FROM InventoryMov_Cursor INTO
	@IDInventoryMov,
	@StoreID,
	@ModelID,
	@MovDate,
	@Qty
--Enquanto tem registros
WHILE
@@FETCH_STATUS = 0
BEGIN

	
	EXEC sp_Sys_Get_Inventory_Balance @ModelID, @StoreID, @MovDate, @Bal output

	IF (@Bal >= 0)
		SET @MovType = 12 --Diminuído para Zero
	ELSE
		SET @MovType = 11 --Aumentado para Zero

	SET @Bal = IsNull(ABS(@Bal), 0)
	UPDATE InventoryMov
	SET Qty = @Bal, InventMovTypeID = @MovType
	WHERE IDInventoryMov = @IDInventoryMov


	FETCH NEXT FROM InventoryMov_Cursor INTO
		@IDInventoryMov,
		@StoreID,
		@ModelID,
		@MovDate,
		@Qty
END
--fechamento do cursor
CLOSE InventoryMov_Cursor
--Destruição do cursor
DEALLOCATE InventoryMov_Cursor

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END

EXEC sp_UpdateSystemQty

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -202
	GOTO ERRO
END


OK:
	RETURN 0

ERRO:

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_Sys_Correct_Inventory_Balance', @ErrorLevelStr

	RETURN @ErrorLevel
GO
