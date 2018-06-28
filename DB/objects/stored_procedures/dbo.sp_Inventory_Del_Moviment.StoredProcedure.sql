SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[sp_Inventory_Del_Moviment] (@IDInventoryMov int) AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO
		
		- Atualizo custo médio em Model
		- Atualizo custo médio em Inventory
		- Excluo InventoryMov

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Atualizo custo médio em Model
		-202  Erro em Atualizo custo médio em Inventory
		-203  Erro em Excluo InventoryMov

	LOG DE MODIFICAÇÕES

	Data		Programador				Modificação
	--------------- --------------------------------------- ------------------------------------------------------------------------------
	06 Jun 2006	Carlos Lima				Criação
	19 May 2006	Rodrigo Costa				Rebovido "begin tran" e "rollback"
	--------------------------------------------------------------------------------------------------------------------------------------*/

DECLARE @ErrorLevel	int
DECLARE @SysError	int
DECLARE @StoreID	int
DECLARE @ModelID	int
DECLARE @Qty		float
DECLARE @CostPrice	money
DECLARE @UpdateOnHand	int

SELECT
	@StoreID = StoreID,
	@ModelID = ModelID,
	@Qty = Qty,
	@CostPrice = CostPrice,
	@UpdateOnHand = (2 *IMT.UpdateOnHand-1)
FROM
	InventoryMov (NOLOCK) 
	INNER JOIN InventoryMovType IMT (NOLOCK) ON (InventoryMov.InventMovTypeID = IMT.IDInventMovType)
WHERE
	IDInventoryMov = @IDInventoryMov

	
UPDATE
	Model
SET
	Model.AvgCostTotal = IsNull(Model.AvgCostTotal, 0) - (@CostPrice * (@UpdateOnHand * @Qty)),
	Model.AvgCost = CASE WHEN (IsNull(Model.TotQtyOnHand, 0) - (@UpdateOnHand * @Qty)) = 0 
				THEN 0 
				ELSE (IsNull(Model.AvgCostTotal, 0) - (@CostPrice * (@UpdateOnHand * @Qty))) / (IsNull(Model.TotQtyOnHand, 0) - (@UpdateOnHand * @Qty)) 
			END
WHERE
	Model.IDModel = @ModelID

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END


UPDATE
	Inventory
SET
	Inventory.AvgCostTotal = IsNull(Inventory.AvgCostTotal, 0) - (@CostPrice * (@UpdateOnHand * @Qty)),
	Inventory.StoreAvgPrice =	CASE WHEN (IsNull(Inventory.QtyOnHand, 0) - (@UpdateOnHand * @Qty)) = 0 
						THEN 0 
						ELSE (IsNull(Inventory.AvgCostTotal, 0) - (@CostPrice * (@UpdateOnHand * @Qty))) / (IsNull(Inventory.QtyOnHand, 0) - (@UpdateOnHand * @Qty)) 
					END
WHERE
	Inventory.ModelID = @ModelID
	AND
	Inventory.StoreID = @StoreID

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -202
	GOTO ERRO
END


DELETE FROM
	InventoryMov
WHERE
	IDInventoryMov = @IDInventoryMov

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -203
	GOTO ERRO
END



OK:
	RETURN 0

ERRO:

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_Inventory_Del_Moviment', @ErrorLevelStr

	RETURN @ErrorLevel
GO
