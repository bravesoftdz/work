SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_Model_quQtyOnStore]
		(
		@ModelID 	int,
		@StoreID 	int
		)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Retorna Qtdes de um Model em sua determinada Loja


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

IF (@StoreID <> 0)
	SELECT
		QtyOnPreSale,
		QtyOnHand,
		QtyOnOrder,
		QtyOnPrePurchase -- CODIGO ANTES DA ALTERACAO
  	FROM
		dbo.Inventory Inventory (NOLOCK) 
  	WHERE
		Inventory.ModelID = @ModelID
		AND
  	 	Inventory.StoreID = @StoreID
ELSE
	SELECT
		QtyOnPreSale,
		QtyOnHand,
		QtyOnOrder,
		QtyOnPrePurchase
  	FROM
		dbo.Inventory Inventory (NOLOCK) 
  	WHERE
		Inventory.ModelID = @ModelID
GO
