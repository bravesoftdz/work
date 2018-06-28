if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Inventory_Adjust]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Inventory_Adjust]
GO

CREATE PROCEDURE sp_Inventory_Adjust
		(
		@IDMovType   	int,
		@IDModel   	int,
		@IDStore   	int,
		@Qty	  	float,
		@IDUser		int,
		@Date		Datetime,
		@Notes		varchar(255)
		)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Ajuste estoque
		- Atualiza o Inventory

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Atualiza o Inventory


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	31 Mar  2006		Rodrigo Costa		Criacao;
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */


DECLARE @ErrorLevel 		int
DECLARE @SysError		int
DECLARE @IDInventoryMov	int

SET @ErrorLevel = 0

EXEC sp_Sis_GetNextCode 'InventoryMov.IDInventoryMov', @IDInventoryMov OUTPUT

INSERT InventoryMov 	(
			IDInventoryMov,
			InventMovTypeID,
			DocumentID,
			StoreID,
			ModelID,
			MovDate,
			Qty,
			IDUser,
			Notes
			)
			VALUES
			(
			@IDInventoryMov,
			@IDMovType,
			0,
			@IDStore,
			@IDModel,
			@Date,
			Abs(@Qty),
			@IDUser,
			@Notes
			)

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
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_Inventory_Adjust', @ErrorLevelStr

	RETURN @ErrorLevel

GO
