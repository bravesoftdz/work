if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Repair_Do]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Repair_Do]
GO

CREATE PROCEDURE sp_Repair_Do 
		(
		@IDRepair	int
		)

AS


/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Deleto os InventoryMov
		- Incluo no Inventario se necessario

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em DELETO O INVMOV
		-202  Erro em Send To Vendor
		-203  Erro em Back From Vendor


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 June 2001		Rodrigo Costa		Criacao;
	26 June 2001		Davi Gouveia		Log de Return Values
	28 Oct	2003		Rodrigo Costa		Criacao do InventoryMov Cursor;
							Chama sp_GetNextCode
	18 Aug 2004		Rodrigo Costa		Gravar error log
	19 Dec 2005		Carlos Lima		Correção dos campos do InventoryMov Cursor 
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

DECLARE @ErrorLevel		int
DECLARE @SysError		int

--Declaração de variáveis para o Cursor de InventoryMov
DECLARE @InventMovTypeID 	int 
DECLARE @DocumentID 	int 
DECLARE @StoreID 		int 
DECLARE @ModelID 		int 
DECLARE @IDPessoa 		int 
DECLARE @MovDate 		smalldatetime 
DECLARE @Qty 		float
DECLARE @IDUser 		int 
DECLARE @CostPrice 		money 
DECLARE @Notes 		varchar(255)
DECLARE @IDInventoryMov	int

BEGIN TRAN
---------------------------------------
-- DELETO O INVMOV
DELETE
	InventoryMov
WHERE
	IDRepair = @IDRepair

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END


---------------------------------------
--- Send To Vendor

--Declaração do Cursor de InventoryMov

DECLARE InventoryMov_Cursor CURSOR FOR

	SELECT
		9,   /* saida por Repair */
		R.IDRepair,
		R.IDRepair,
		R.IDStore,
		R.IDModel,
		0,
		R.SentDate, --Data que foi enviado o Item
		R.Qty,
		R.IDUserSent,
		R.LastCost,
		R.Defect
	FROM
		Repair R
	WHERE
		R.IDRepair = @IDRepair
		AND
		R.SentDate IS NOT NULL
		AND
		R.Tipo = 2 -- so atualiza se for Inventory

OPEN InventoryMov_Cursor

--Inicialização de InventoryMov_Cursor
FETCH NEXT FROM InventoryMov_Cursor INTO
	@InventMovTypeID,
	@IDRepair,
	@DocumentID,
	@StoreID,
	@ModelID,
	@IDPessoa,
	@MovDate,
	@Qty,
	@IDUser,
	@CostPrice,
	@Notes
--Enquanto tem registros
WHILE
@@FETCH_STATUS = 0
BEGIN
	EXEC sp_Sis_GetNextCode'InventoryMov.IDInventoryMov', @IDInventoryMov OUTPUT
	INSERT InventoryMov
		(
		IDInventoryMov,
		InventMovTypeID,
		IDRepair,
		DocumentID,
		StoreID,
		ModelID,
		IDPessoa,
		MovDate,
		Qty,
		IDUser,
		CostPrice,
		Notes
		)
	VALUES
		(
		@IDInventoryMov,
		@InventMovTypeID,
		@IDRepair,
		@DocumentID,
		@StoreID,
		@ModelID,
		@IDPessoa,
		@MovDate,
		@Qty,
		@IDUser,
		@CostPrice,
		@Notes
		)

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		CLOSE InventoryMov_Cursor
		DEALLOCATE InventoryMov_Cursor
		SET @ErrorLevel = -202
		GOTO ERRO
	END

	FETCH NEXT FROM InventoryMov_Cursor INTO
		@InventMovTypeID,
		@IDRepair,
		@DocumentID,
		@StoreID,
		@ModelID,
		@IDPessoa,
		@MovDate,
		@Qty,
		@IDUser,
		@CostPrice,
		@Notes
END
--fechamento do cursor
CLOSE InventoryMov_Cursor
--Destruição do cursor
DEALLOCATE InventoryMov_Cursor

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -202
	GOTO ERRO
END

---------------------------------------
--- Back From Vendor
--Declaração do Cursor de InventoryMov
DECLARE InventoryMov_Cursor CURSOR FOR

	SELECT
		(
		CASE TipoRepair
			WHEN 1 THEN 10   /* Exchanged - Back from Repair */
			WHEN 2 THEN 10   /* Fixed - Back from Repair */
			WHEN 3 THEN 16   /* Repair Damage*/
			WHEN 4 THEN 17   /* Vendor Credit - Repair */
		END
		) as RepairType,
		R.IDRepair,
		R.IDRepair,
		R.IDStore,
		R.IDModel,
		0,
		R.ReturnDate, --Data recebida do Vendor		
		R.Qty,
		R.IDUserReturn, --Usuario que enviou
		R.LastCost,
		R.OBSReturn

	FROM
		Repair R
	WHERE
		R.IDRepair = @IDRepair
		AND
		R.ReturnDate IS NOT NULL
		AND
		R.Tipo = 2 -- so atualiza se for Inventory

OPEN InventoryMov_Cursor

--Inicialização de InventoryMov_Cursor
FETCH NEXT FROM InventoryMov_Cursor INTO
	@InventMovTypeID,
	@IDRepair,
	@DocumentID,
	@StoreID,
	@ModelID,
	@IDPessoa,
	@MovDate,
	@Qty,
	@IDUser,
	@CostPrice,
	@Notes
--Enquanto tem registros
WHILE
@@FETCH_STATUS = 0
BEGIN
	EXEC sp_Sis_GetNextCode'InventoryMov.IDInventoryMov', @IDInventoryMov OUTPUT

	INSERT InventoryMov
		(
		IDInventoryMov,
		InventMovTypeID,
		IDRepair,
		DocumentID,
		StoreID,
		ModelID,
		IDPessoa,
		MovDate,
		Qty,
		IDUser,
		CostPrice,
		Notes
		)
	VALUES
		(
		@IDInventoryMov,
		@InventMovTypeID,
		@IDRepair,
		@DocumentID,
		@StoreID,
		@ModelID,
		@IDPessoa,
		@MovDate,
		@Qty,
		@IDUser,
		@CostPrice,
		@Notes
		)

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		CLOSE InventoryMov_Cursor
		DEALLOCATE InventoryMov_Cursor
		SET @ErrorLevel = -203
		GOTO ERRO
	END

	FETCH NEXT FROM InventoryMov_Cursor INTO
		@InventMovTypeID,
		@IDRepair,
		@DocumentID,
		@StoreID,
		@ModelID,
		@IDPessoa,
		@MovDate,
		@Qty,
		@IDUser,
		@CostPrice,
		@Notes
END
--fechamento do cursor
CLOSE InventoryMov_Cursor
--Destruição do cursor
DEALLOCATE InventoryMov_Cursor

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -203
	GOTO ERRO
END


OK:
	COMMIT TRAN
	RETURN 0
ERRO:
	ROLLBACK TRAN
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_Repair_Do', @ErrorLevelStr

	RETURN @ErrorLevel
GO
