if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Inventory_Tranfer_Import]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Inventory_Tranfer_Import]
GO

CREATE PROCEDURE sp_Inventory_Tranfer_Import
	(
	@IDTransfOUT	int,
	@IDTransfIN	int
	)
 AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Insiro a Transferencia


	TABELA DE ERROS PARA RETURN_VALUE

	 000  Ok
	-201  Erro em importar models
	-202  Erro em atualizar imported

	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------------------------------------------------------------------------------------------------------------
	16 Jul 2005		Rodrigo Costa		Criação;
        ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

DECLARE @ErrorLevel		int
DECLARE @SysError		int

--Declaração de variáveis para o Cursor de InventoryMov
DECLARE @ModelID 		int 
DECLARE @Qty 			int 
DECLARE @CostPrice		money
DECLARE @Tax			money 
DECLARE @IDModelTransfDet    	int

BEGIN TRAN

/*--------------------------------------------------------------*/
/*		Parte da Insercao do InventoryMov        	*/
/*--------------------------------------------------------------*/

--Declaração do Cursor de InventoryMov
DECLARE TransferItem_Cursor CURSOR FOR
	SELECT
		MTD.IDModel,
		MTD.Qty,
		MTD.Tax,
		MTD.CostPrice
	FROM
		ModelTransfDet MTD
	WHERE
		MTD.IDModelTransf = @IDTransfOUT

OPEN TransferItem_Cursor

--Inicialização de TransferItem_Cursor
FETCH NEXT FROM TransferItem_Cursor INTO
	@ModelID,
	@Qty,
	@Tax,
	@CostPrice
--Enquanto tem registros
WHILE
@@FETCH_STATUS = 0
BEGIN
--Inclusao da loja original
	EXEC sp_Sis_GetNextCode'ModelTransfDet.IDModelTransfDet', @IDModelTransfDet OUTPUT

	INSERT ModelTransfDet
		(
		IDModelTransfDet,
		IDModelTransf,
		IDModel,
		Qty,
		CostPrice,
		Tax
		)
	VALUES
		(
		@IDModelTransfDet,
		@IDTransfIN,
		@ModelID,
		@Qty,
		@CostPrice,
		@Tax
		)

	FETCH NEXT FROM TransferItem_Cursor INTO
		@ModelID,
		@Qty,
		@Tax,
		@CostPrice
END
--fechamento do cursor
CLOSE TransferItem_Cursor
--Destruição do cursor
DEALLOCATE TransferItem_Cursor

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO   ERRO
END

/*--------------------------------------------------------------*/
/*		Atualizo a importacao		        	*/
/*--------------------------------------------------------------*/

UPDATE
	ModelTransf
SET
	Imported = 1
WHERE
	IDModelTransf = @IDTransfOUT
	

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -202
	GOTO   ERRO
END


OK:
	COMMIT TRAN
	RETURN 0
ERRO:
	ROLLBACK TRAN
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_Inventory_Tranfer_Import', @ErrorLevelStr

	RETURN @ErrorLevel
GO
