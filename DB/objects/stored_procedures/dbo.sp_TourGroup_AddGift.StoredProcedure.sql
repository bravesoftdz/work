SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_TourGroup_AddGift] 
			(
			@IDTouristGroup 	int,
			@IDModel 		int,
			@IDStore 		int,
			@Qty 			float,
			@DataGift 		smalldatetime,
			@IDUser 		int 
			)
AS
/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		Três fases compreendem o gift, a movimentacao
		de inventario, o registro no cost do group e
		o registro no GroupCostGift para armazenar o
		Model e o User

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Registro no InventoryMov
		-202  Erro em Registra o cost
		-203  Erro em Registra o GroupCostGift


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
	27 June 2001		Davi Gouveia		Log de Return Values
	30 Oct	2003		Rodrigo Costa		Criacao o cursor InventoryMov_Cursor;
							Chama sp_GetNextCode;  
	18 Aug 2004		Rodrigo Costa		Gravar error log
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

DECLARE @ErrorLevel 		int
DECLARE @SysError		int

--Declaração de variáveis para o Cursor de InventoryMov
DECLARE @InventMovTypeID 	int 
DECLARE @DocumentID 	int 
DECLARE @CostPrice 		money 
DECLARE @SalePrice 		money 
DECLARE @Discount 		money 
DECLARE @IDInventoryMov 	int
DECLARE @IDCost 		int
DECLARE @IDGroupCostGift 	int


SET @ErrorLevel = 0

BEGIN TRAN

/* Registro no InventoryMov */

--Declaração do Cursor de InventoryMov

DECLARE InventoryMov_Cursor CURSOR FOR

	SELECT
		13, /* Tipo saida por gift */
		0,
		M.VendorCost,
		M.SellingPrice,
		M.SellingPrice * @Qty
	FROM
		Model M (NOLOCK) 
	WHERE
		IDModel = @IDModel

OPEN InventoryMov_Cursor

--Inicialização de InventoryMov_Cursor
FETCH NEXT FROM InventoryMov_Cursor INTO
	@InventMovTypeID,
	@DocumentID,
	@CostPrice,
	@SalePrice,
	@Discount

--Enquanto tem registros
WHILE
@@FETCH_STATUS = 0
BEGIN
	EXEC sp_Sis_GetNextCode'InventoryMov.IDInventoryMov', @IDInventoryMov OUTPUT

	INSERT InventoryMov
		(
		IDInventoryMov,
		InventMovTypeID,
		DocumentID,
		StoreID,
		ModelID,
		MovDate,
		Qty,
		CostPrice,
		SalePrice,
		Discount,
		IDUser
		)
	VALUES
		(
		@IDInventoryMov,
		@InventMovTypeID,
		@DocumentID,
		@IDStore,
		@IDModel,
		@DataGift,
		@Qty,
		@CostPrice,
		@SalePrice,
		@Discount,
		@IDUser
		)

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		CLOSE InventoryMov_Cursor
		DEALLOCATE InventoryMov_Cursor
		SET @ErrorLevel = -201
		GOTO ERRO
	END

	FETCH NEXT FROM InventoryMov_Cursor INTO
		@InventMovTypeID,
		@DocumentID,
		@CostPrice,
		@SalePrice,
		@Discount
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

/* Registra o cost */
EXEC sp_Sis_GetNextCode'GroupCost.IDCost', @IDCost OUTPUT
	INSERT GroupCost
		(
		IDCost,
		IDTouristGroup,
		IDCostType,
		CostDate,
		UnitCost,
		Quantity
		)
	SELECT
		@IDCost,
		@IDTouristGroup,
     		5, /* Tipo gift */
		@DataGift,
		M.VendorCost,
		@Qty
	FROM
		Model M
	WHERE
		IDModel = @IDModel

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -202
	GOTO ERRO
END

/* Registra o GroupCostGift */
EXEC sp_Sis_GetNextCode'GroupCostGift.IDGroupCostGift', @IDGroupCostGift OUTPUT
	INSERT GroupCostGift
		(
		IDGroupCostGift,
		IDGroupCost,
		IDModel,
		IDUser,
		Desativado
		)
	VALUES
		(
		@IDGroupCostGift,
		@IDCost,
		@IDModel,
		@IDUser,		0
		)

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
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_TourGroup_AddGift', @ErrorLevelStr

	RETURN @ErrorLevel
GO
