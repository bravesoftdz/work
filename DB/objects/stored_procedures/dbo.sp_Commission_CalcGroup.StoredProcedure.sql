SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_Commission_CalcGroup]

		(
		@IDTouristGroup	int,
		@Commission		money	output
		)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Calcula a comissao do Grupo


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Rodrigo Costa		Criacao;
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */


if not (@IDTouristGroup > 0)
   return

/*------------------------------------------------------------------------------*/
/*       Calcula a comissao do Grupo          		*/
/*-----------------------------------------------------------------------------*/

SELECT
	@Commission = IsNull (
	(
	SELECT
		IsNull	( SUM 	(
					(IsNull(GroupToComType.Comission, 0)/100) *
					(
						(
							(
		 					IsNull(InvMov.SalePrice, 0)-
							(TipoComissionado.ComissionOnProfit * IsNull(InvMov.CostPrice, 0))
							) * IsNull(InvMov.Qty, 0)
						) - IsNull(InvMov.Discount, 0)
					)
				), 0)
	FROM 	
		dbo.Invoice			Invoice (NOLOCK),
		dbo.InventoryMov		InvMov (NOLOCK),
		dbo.Model			Model (NOLOCK),
		dbo.GroupToComissionType	GroupToComType (NOLOCK),
		dbo.vwTipoComissionado 	TipoComissionado (NOLOCK)
	WHERE
		Invoice.IDTouristGroup = @IDTouristGroup
		AND
		InvMov.DocumentID = Invoice.IDInvoice
		AND
		InvMov.InventMovTypeID = 1
		AND
		InvMov.ModelID = Model.IDModel
		AND
		GroupToComType.IDTipoComissionado = 5
		AND
		TipoComissionado.IDTipoComissionado = 5
		AND
		GroupToComType.GroupID = Model.GroupID
	), 0)
GO
