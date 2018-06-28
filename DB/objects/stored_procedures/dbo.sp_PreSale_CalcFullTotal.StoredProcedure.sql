SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_PreSale_CalcFullTotal]
		(
		@IDPreSale 	int,
		@FullTotal 	money output
		)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Retorna o total de uma determinada venda

	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
	25 May  2004		Rodrigo Costa		Includ PackModel Calc
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */


SELECT	@FullTotal = 	(
			SELECT
				SUM(PreInventoryMov.Qty * Model.SellingPrice)
			FROM
				dbo.PreInventoryMov PreInventoryMov (NOLOCK) 
				JOIN dbo.Model Model (NOLOCK) ON (PreInventoryMov.ModelID = Model.IDModel)
			WHERE
 				PreInventoryMov.DocumentID  = @IDPreSale
 				AND
 				PreInventoryMov.InventMovTypeID = 1
				AND
				PreInventoryMov.IDParentPack IS Null
			)

SELECT @FullTotal = IsNull(@FullTotal, 0)
GO
