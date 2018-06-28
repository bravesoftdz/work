SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_Model_Adjust]
		(
		@QtyOnOrder        	float,
		@QtyOnRepair       	float,
		@QtyOnPrePurchase  	float,
		@IDModel    	   	int,
		@IDStore      	   	int,
		@Difference 	   	float,
		@IDUser			int,
		@Date			Datetime,
		@Notes			varchar(255), -- Davi
		@IDMovReason		int
		)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Ajuste por entrada ou saida de estoque
		- Atualiza o Inventory

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Ajuste por entrada de estoque
		-202  Erro em Ajuste por saida de estoque
		-203  Erro em Atualiza o Inventory
		-204  Erro em Inserir o InventoryMovReason
		


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
	25 June 2001		Davi Gouveia		Log de Return Values
 	21 Oct	2003		Rodrigo Costa		Chamada a sp_Sis_GetNextCode para @IDInventoryMov; 
							Criado @IDInventoryMov;
	18 Aug 2004		Rodrigo Costa		Gravar error log
	02 Jun 2006		Rodrigo Costa		Inserir o Inventory Mov Reason 
	05 Jun 2006		Carlos Lima		Adicionado Custo médio na inserção de InventoryMov
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */


DECLARE @ErrorLevel 	int
DECLARE @SysError	int
DECLARE @IDInventoryMov	int
DECLARE @AvgCost	money

SET @ErrorLevel = 0

SELECT @AvgCost = StoreAvgPrice FROM Inventory (NOLOCK) WHERE StoreID = @IDStore AND ModelID = @IDModel 

EXEC sp_Sis_GetNextCode 'InventoryMov.IDInventoryMov', @IDInventoryMov OUTPUT
IF @Difference > 0
BEGIN
	/*	Ajuste por entrada de estoque	*/
	INSERT InventoryMov 	(
				IDInventoryMov,
				InventMovTypeID,
				DocumentID,
				StoreID,
				ModelID,
				MovDate,
				Qty,
				IDUser,
				AvgCost
				)
				VALUES
				(
				@IDInventoryMov,
				4,
				0,
				@IDStore,
				@IDModel,
				@Date,
				Abs(@Difference),
				@IDUser,
				@AvgCost
				)

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		SET @ErrorLevel = -201
		GOTO ERRO
	END


	INSERT Inv_MovComplement 	(
				IDInventoryMov,
				IDMovReason,
				Notes
				)
				VALUES
				(
				@IDInventoryMov,
				@IDMovReason,
				@Notes
				)


	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		SET @ErrorLevel = -204
		GOTO ERRO
	END


END
ELSE
BEGIN
	/*	Ajuste por saida de estoque	*/
	INSERT InventoryMov 	(
				IDInventoryMov,
				InventMovTypeID,
				DocumentID,
				StoreID,
				ModelID,
				MovDate,
				Qty,
				IDUser,
				AvgCost
				)
				VALUES
				(
				@IDInventoryMov,
				3,
				0,
				@IDStore,
				@IDModel,
				@Date,
				Abs(@Difference),
				@IDUser,
				@AvgCost
				)

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		SET @ErrorLevel = -202
		GOTO ERRO
	END

	INSERT Inv_MovComplement 	(
				IDInventoryMov,
				IDMovReason,
				Notes
				)
				VALUES
				(
				@IDInventoryMov,
				@IDMovReason,
				@Notes
				)


	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		SET @ErrorLevel = -204
		GOTO ERRO
	END


END

OK:
	RETURN 0
ERRO:
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_Model_Adjust', @ErrorLevelStr

	RETURN @ErrorLevel
GO
