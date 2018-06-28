if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_CalcSalePrice]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_CalcSalePrice]
GO

CREATE PROCEDURE sp_PreSale_CalcSalePrice

		(
		@ModelID		int,
		@SpecialPriceID 	int,
		@SalePrice 		money Output,
		@CostPrice 		money Output,
		@AvgCostPrice 		money Output
		)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Calculo do valor no modelo e seu custo
		- Calculo o valor do grupo e do modelo


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */


DECLARE @Model	money
DECLARE @ModelSP 	money
DECLARE @GroupSP 	money

SET @Model = Null
SET @ModelSP = Null
SET @GroupSP = Null


---------------------------------------------------------------------------------------------------
-- Calculo do valor no modelo e seu custo

SELECT
	@CostPrice = (IsNull(M.VendorCost,0) + IsNull(M.OtherCost,0) + IsNull(M.FreightCost, 0)),
	@Model = IsNull(M.SellingPrice, 0),
	@AvgCostPrice = IsNull(M.AvgCost,0)

FROM
	Model M

WHERE
	M.IDModel = @ModelID

---------------------------------------------------------------------------------------------------
-- Calculo o valor do grupo e do modelo

IF IsNull(@SpecialPriceID,0) > 0
BEGIN


	SELECT
		@GroupSP = (1+(SP.SpecialMarkUp/100) ) * (MO.VendorCost+MO.OtherCost+MO.FreightCost)
	FROM
		Model MO
		JOIN SpecialPriceByGroup SP
			ON (MO.GroupID = SP.GroupID)
	WHERE
		MO.IDModel = @ModelID
		AND
		SP.SpecialPriceID = @SpecialPriceID


	SELECT
		@ModelSP = (1+(MTSP.MarkUp/100)) * (MO.VendorCost+MO.OtherCost+MO.FreightCost)
	FROM
		Model MO
		JOIN ModelToSpecialPrice MTSP
			ON (MO.IDModel = MTSP.IDModel)
	WHERE
		MO.IDModel = @ModelID
		AND
		MTSP.IDSpecialPrice = @SpecialPriceID
 END


SET @SalePrice = IsNull(@ModelSP, IsNull(@GroupSP, @Model))
GO
