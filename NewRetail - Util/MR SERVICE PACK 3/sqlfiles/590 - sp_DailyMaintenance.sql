if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_DailyMaintenance]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_DailyMaintenance]
GO

CREATE PROCEDURE sp_DailyMaintenance
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		Deleta os holds antigos

		- Deleto PreInventoryMov
		- Deleto Invoice
		- Atualizo Model

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Deleto PreInventoryMov
		-202  Erro em Atualizo Model


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Rodrigo Costa		Criacao;
	25 June 2001		Davi Gouveia		Log de Return Values
	18 Aug 2004		Rodrigo Costa		Gravar error log
	05 Jan	2007		Rodrigo Costa		Deletar hold com um cursor
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */


DECLARE @IDPreSale	int
DECLARE @DelHoldDay	int
DECLARE @DelItemMonth	int
DECLARE @ErrorLevel 	int
DECLARE @SysError	int
DECLARE	@IDDayMaint	int
DECLARE	@Date		DateTime

SET @ErrorLevel = 0

SELECT 	@DelHoldDay = Convert(Int, SrvValue) FROM Param WHERE IDParam = 18
SELECT 	@DelItemMonth = Convert(Int, SrvValue) FROM Param WHERE IDParam = 17

-- Garanto que nao estao nulos
SELECT @DelHoldDay = IsNull(@DelHoldDay, 0) 
SELECT @DelItemMonth = IsNull(@DelItemMonth, 0)

SELECT @Date = GetDate()

/* Testa se ja rodou hoje */
IF Exists 	(
		SELECT
			IDDailyMaintenanceReport
		FROM
			DailyMaintenanceReport
		WHERE
			Maintenance = 'DailyMaintenance'
			AND
			Convert(Char(30), Date, 101) = Convert(Char(30), @Date, 101)
		) RETURN

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
	'DailyMaintenance', 
	@Date, 
	'Started'
	)

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END


BEGIN TRANSACTION

IF @DelHoldDay > 0
BEGIN

/*----------------------------------------------------------------------------------------------------------------------------------------------------------*/
/*          Deletar movimentaçao de cancelamento com base na movimentação anterior                    */
/*----------------------------------------------------------------------------------------------------------------------------------------------------------*/ 
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
	            SET @ErrorLevel = -201
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
		SET @ErrorLevel = -202
		GOTO ERRO
	END

	DROP TABLE #ModelToDelete
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
