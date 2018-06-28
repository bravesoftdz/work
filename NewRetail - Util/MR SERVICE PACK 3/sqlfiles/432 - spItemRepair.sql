if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_ItemRepair]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_ItemRepair]
GO

CREATE PROCEDURE sp_PreSale_ItemRepair
			(
				@IDPreSale	int
			)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Deleto PreSerialMov

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro Inserir Repair
		-202  Erro em Atualizar Repair


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	03 Apr	2006		Rodrigo Costa		Criacao
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  
*/
 
DECLARE @ErrorLevel	int 
DECLARE @SysError	int
DECLARE @Obs		varchar(255)	
DECLARE @IDDefectType	int
DECLARE @RA		varchar(20)
DECLARE @IDVendor	int
DECLARE @ModelID	int
DECLARE @IDRepair	int
DECLARE @StoreID	int
DECLARE @MovDate	DateTime
DECLARE @CostPrice	Money
DECLARE	@Qty		Float
DECLARE @IDUser		int

SET @ErrorLevel = 0 


DECLARE InvRepair_Cursor CURSOR STATIC FOR 
	SELECT
		IR.Obs,
		IR.IDDefectType,
		IR.RA,
		IR.IDVendor,
		PIM.ModelID,
		PIM.StoreID,
		PIM.MovDate,
		PIM.CostPrice,
		ABS(PIM.Qty),
		PIM.UserID
	FROM
		Sal_ItemRepair IR
		JOIN PreInventoryMov PIM ON (PIM.IDPreInventoryMov = IR.IDPreInventoryMov)
	WHERE
		PIM.DocumentID = @IDPreSale
		AND 
		PIM.InventMovTypeID = 1

OPEN InvRepair_Cursor

--Inicialização de PreInv_Cursor
FETCH NEXT FROM InvRepair_Cursor INTO
		@Obs,
		@IDDefectType,
		@RA,
		@IDVendor,
		@ModelID,
		@StoreID,
		@MovDate,
		@CostPrice,
		@Qty,
		@IDUser

--Enquanto tem registros
WHILE @@FETCH_STATUS = 0
BEGIN

	EXEC sp_Sis_GetNextCode 'Repair.IDRepair', @IDRepair OUTPUT
	
	--Criar o Repair
	INSERT
		Repair
		(
		IDRepair, 
		IDModel, 
		IDStore, 
		Fase, 
		IDFornecedor, 
		RA, 
		SentDate, 
		IDUserSent, 
		LastCost, 
		Tipo, 
		Qty, 
		IDDefectType,
		TipoRepair,
		Desativado,
		Defect
		)
		VALUES
		(
		@IDRepair, 
		@ModelID, 
		@StoreID, 
		'Send to Vendor', 
		@IDVendor, 
		@RA, 
		@MovDate, 
		@IDUser, 
		@CostPrice, 
		2, 
		@Qty, 
		@IDDefectType,
		0,
		0,
		@Obs
		)


		SET @SysError = @@ERROR
		IF @SysError <> 0
		BEGIN
		            SET @ErrorLevel = -201
		            GOTO ERRO
		END

		EXEC sp_Repair_Do @IDRepair


		SET @SysError = @@ERROR
		IF @SysError <> 0
		BEGIN
		            SET @ErrorLevel = -202
		            GOTO ERRO
		END


            FETCH NEXT FROM InvRepair_Cursor INTO
			@Obs,
			@IDDefectType,
			@RA,
			@IDVendor,
			@ModelID,
			@StoreID,
			@MovDate,
			@CostPrice,
			@Qty,
			@IDUser
END

--fechamento do cursor
CLOSE InvRepair_Cursor
--Destruição do cursor
DEALLOCATE InvRepair_Cursor


SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END


OK:
	RETURN 0
ERRO:
	PRINT CAST(@ErrorLevel AS VARCHAR)
	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PreSale_ItemRepair', @ErrorLevelStr
	RETURN @ErrorLevel
GO
