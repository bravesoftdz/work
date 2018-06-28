SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_PreSale_MaxDiscount]
			(
			@PreSaleID		int, 
			@UserID		int,			 
			@MaxVendaMin  	money output,
			@MaxDiscount    	money output
			)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Find the Maximum Discount for invoice Range

	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */


DECLARE @ValInvoice money

/*-------------------------------------------------------*/ 
/*      Find the Maximum Discount for invoice Range      */ 
/*-------------------------------------------------------*/ 

SELECT @ValInvoice = 
 	(
	SELECT  sum( IsNull(PIM.Qty,0) * IsNull(PIM.SalePrice,0) * (IsNull(TG.PrcPartDiscount,0)/100) )
 
	FROM 	dbo.PreInventoryMov PIM (NOLOCK)
		JOIN Model MO (NOLOCK) ON (PIM.ModelID = MO.IDModel)
		JOIN TabGroup TG (NOLOCK) ON (MO.GroupID = TG.IDGroup)

	WHERE
		PIM.DocumentID = @PreSaleID
		AND 
		PIM.InventMovTypeID = 1
	) 

SELECT @MaxVendaMin =
	(
	SELECT  MAX(DRMax.TotVendaMin)

	FROM
		dbo.DiscRange DRMax (NOLOCK)  
		JOIN vwComissionado CO (NOLOCK)  ON (DRMax.IDTipoComissionado = CO.IDTipoComissionado)
		JOIN SystemUser SU (NOLOCK) ON (CO.IDComissionado = SU.ComissionID)

	WHERE
		SU.IDUser = @UserID
		 AND
   		DRMax.TotVendaMin <= IsNull(@ValInvoice, 0)
	)
 

SELECT @MaxDiscount =
	(
		(
		SELECT 	IsNull(DR.PercDiscMax, 0)

		FROM 	
			dbo.DiscRange  DR (NOLOCK) 
			JOIN dbo.vwComissionado  CO (NOLOCK) ON (DR.IDTipoComissionado = CO.IDTipoComissionado)
			JOIN dbo.SystemUser SU (NOLOCK)  ON (CO.IDComissionado = SU.ComissionID)

		WHERE
		 	SU.IDUser = @UserID
			AND
			DR.TotVendaMin = @MaxVendaMin
		) /100
	) * @ValInvoice
 

SELECT @MaxVendaMin = IsNull(@MaxVendaMin, 0) 
SELECT @MaxDiscount = IsNull(@MaxDiscount, 0)
GO
