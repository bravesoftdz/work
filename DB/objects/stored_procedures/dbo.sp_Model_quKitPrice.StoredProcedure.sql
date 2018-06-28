SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_Model_quKitPrice]
		(
		@IDModel	int
		)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO
		
		- Retorna Qtde e SellingPrice do Model dado em KitModel


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

SELECT
	Qty, SellingPrice
FROM
	KitModel (NOLOCK)
WHERE
	KitModel.IDModel = @IDModel
ORDER BY
	Qty
GO
