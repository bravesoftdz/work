SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_Commission_CalcGuideAgency]
		(
		@IDAgency 		int,
		@IDGuide		int,
		@DataInicio		SmallDateTime,
		@DataFim		SmallDateTime,
		@Commission		money	output
		)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Calcula a comissao da Agencia
		- Calcula a comissao do Guia


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Rodrigo Costa		Criacao;
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */


/*------------------------------------------------------------------------------*/
/*			   Calcula a comissao da Agencia			*/
/*------------------------------------------------------------------------------*/

SELECT @Commission = 0

if @IDGuide = null
begin
	SELECT
		@Commission = IsNull (
			(
			SELECT 	IsNull	( SUM 	(
						(TouristGroup.ComissaoSobreGuia / 100 )   *
						(IsNull(GroupToComType.Comission, 0)/100) *
						(
							(
								(
		 						IsNull(InvMov.SalePrice, 0)-
								(TipoComissionado.ComissionOnProfit*IsNull(InvMov.CostPrice, 0))
								)*IsNull(InvMov.Qty, 0)
							)-IsNull(InvMov.Discount, 0)
						)
					), 0)
			FROM
				dbo.TouristGroup 	 TouristGroup (NOLOCK),
				dbo.Invoice 		 Invoice (INDEX = PI_Invoice_IDTouristGroup),
				dbo.InventoryMov 	 InvMov (NOLOCK),
				dbo.Model 		 Model (NOLOCK),
				dbo.GroupToComissionType GroupToComType (NOLOCK),
				dbo.vwComissionado 	 Comis (NOLOCK),
				dbo.vwTipoComissionado 	 TipoComissionado (NOLOCK)
			WHERE
				TouristGroup.IDLancPagAgencia IS NULL
				AND
				TouristGroup.IDAgency = IsNull(@IDAgency, TouristGroup.IDAgency)
				AND
				TouristGroup.EnterDate > @DataInicio
				AND
				TouristGroup.EnterDate < @DataFim
				AND
				Invoice.IDTouristGroup = TouristGroup.IDTouristGroup
				AND
				InvMov.DocumentID = Invoice.IDInvoice
				AND
				InvMov.InventMovTypeID = 1
				AND
				InvMov.ModelID = Model.IDModel
				AND
				Comis.IDComissionado = TouristGroup.IDGuide
				AND
				GroupToComType.IDTipoComissionado = Comis.IDTipoComissionado
				AND
				TipoComissionado.IDTipoComissionado = Comis.IDTipoComissionado
				AND
				GroupToComType.GroupID = Model.GroupID
			), 0)
end


/*------------------------------------------------------------------------------*/
/*			   Calcula a comissao do Guia                 		*/
/*------------------------------------------------------------------------------*/
SELECT
	@Commission = @Commission +
		IsNull (
		(
		SELECT 	IsNull	( SUM 	(
						(IsNull(GroupToComType.Comission, 0)/100) *
						( 
							( 
								(
		 						IsNull(InvMov.SalePrice, 0)-
								(TipoComissionado.ComissionOnProfit*IsNull(InvMov.CostPrice, 0))
								)*IsNull(InvMov.Qty, 0)
							)-IsNull(InvMov.Discount, 0)
						)
					), 0)
		FROM
			dbo.TouristGroup 	 TouristGroup (NOLOCK),
			dbo.Invoice 		 Invoice (INDEX = PI_Invoice_IDTouristGroup),
			dbo.InventoryMov 	 InvMov (NOLOCK),
			dbo.Model 		 Model (NOLOCK),
			dbo.GroupToComissionType GroupToComType (NOLOCK),
			dbo.vwComissionado 	 Comis (NOLOCK),
			dbo.vwTipoComissionado 	 TipoComissionado (NOLOCK)
		WHERE
			TouristGroup.IDLancPagGuia IS NULL
			AND
			TouristGroup.IDGuide  = IsNull(@IDGuide,  TouristGroup.IDGuide)
			AND
			TouristGroup.IDAgency = IsNull(@IDAgency, TouristGroup.IDAgency)
			AND
			TouristGroup.EnterDate > @DataInicio
			AND
			TouristGroup.EnterDate < @DataFim
			AND
			Invoice.IDTouristGroup = TouristGroup.IDTouristGroup
			AND
			InvMov.DocumentID = Invoice.IDInvoice
			AND
			InvMov.InventMovTypeID = 1
			AND
			InvMov.ModelID = Model.IDModel
			AND
			Comis.IDComissionado = TouristGroup.IDGuide
			AND
			GroupToComType.IDTipoComissionado = Comis.IDTipoComissionado
			AND
			TipoComissionado.IDTipoComissionado = Comis.IDTipoComissionado
			AND
			GroupToComType.GroupID = Model.GroupID
		), 0)
GO
