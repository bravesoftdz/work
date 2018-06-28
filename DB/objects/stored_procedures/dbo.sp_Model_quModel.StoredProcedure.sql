SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_Model_quModel]
		(
		@IDModel 	int
		)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Join do Model dado com sua categoria

	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
	01 July	2005		Rodrigo Costa		New Table SubGroup;
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

SELECT
	TG.Name,
	M.SellingPrice,
	M.Peso,
	M.Description,
	(M.VendorCost+M.OtherCost+M.FreightCost) as CurrentCost,
	M.VendorCost,
	M.OtherCost,
	M.FreightCost,
	M.LastCost,
	M.ReplacementCost,
	SG.SubGroup
FROM
	Model M (NOLOCK) 
	JOIN TabGroup TG (NOLOCK) ON ( TG.IDGroup = M.GroupID )
	LEFT OUTER JOIN SubGroup SG (NOLOCK) ON (SG.IDSubGroup = M.IDSubGroup)
WHERE
 	( IDModel = @IDModel )
GO
