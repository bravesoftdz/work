SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
ALTER PROCEDURE [dbo].[sp_PreSale_CacheCommission]
	(
	@IDInvoice	int
	)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Insiro Commissao dos vendedores
		- Calcula a comissao do Guia
		- Calcula a comissao da Agencia

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Deleto de InvoiceCommission
		-202  Erro em Insiro Commissao dos vendedores
		-203  Erro em Calcula a comissao do Guia
		-204  Erro em Calcula a comissao da Agencia


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
	26 June 2001		Davi Gouveia		Log de Return Values
	18 Aug 2004		Rodrigo Costa		Gravar error log
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */


DECLARE @ComGuia		Money
DECLARE @ComAgency	Money
DECLARE @ErrorLevel		int
DECLARE @SysError		int

SET @ErrorLevel = 0


-- Deleto de InvoiceCommission
DELETE InvoiceCommission WHERE IDInvoice = @IDInvoice

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END

/*
	Insiro Commissao dos vendedores
*/

INSERT InvoiceCommission 		(
		IDInvoice,
		IDPessoa,
		Commission,
		Tipo 		)
		(
		SELECT
			@IDInvoice,
			InvMov.ComissionID,
			IsNull	( SUM 	(
					(IsNull(GroupToComType.Comission, 0)/100) *
					( 						(
							(
	 						IsNull(InvMov.SalePrice, 0)-
							(TipoComissionado.ComissionOnProfit*IsNull(InvMov.CostPrice, 0))
							)*IsNull(InvMov.Qty, 0)
						)-IsNull(InvMov.Discount, 0)
					) 				), 0) Comission,
			'S'
		FROM
			dbo.InventoryMov InvMov,
			dbo.Model Model,
			dbo.GroupToComissionType GroupToComType,
			dbo.vwComissionado Comis,
			dbo.vwTipoComissionado TipoComissionado
		WHERE
			InvMov.DocumentID = @IDInvoice 		    			
			AND
			InvMov.InventMovTypeID = 1      				
			AND
			InvMov.ModelID = Model.IDModel 					
			AND
			Comis.IDComissionado    = InvMov.ComissionID			
			AND
			GroupToComType.IDTipoComissionado = Comis.IDTipoComissionado 	
			AND
			TipoComissionado.IDTipoComissionado = Comis.IDTipoComissionado 	
			AND 			GroupToComType.GroupID = Model.GroupID
		GROUP BY 
			InvMov.ComissionID 		)

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -202
	GOTO ERRO
END

/*------------------------------------------------------------------------------*/
/*			   Calcula a comissao do Guia                 		*/
/*------------------------------------------------------------------------------*/
SELECT 	@ComGuia = IsNull (
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
		FROM 	dbo.TouristGroup 	 TouristGroup,
			dbo.Invoice 		 Invoice ,
			dbo.InventoryMov 	 InvMov,
			dbo.Model 		 Model,
			dbo.GroupToComissionType GroupToComType,
			dbo.vwComissionado 	 Comis,
			dbo.vwTipoComissionado 	 TipoComissionado (NOLOCK)

		WHERE	Invoice.IDInvoice = @IDInvoice					AND
			Invoice.IDTouristGroup = TouristGroup.IDTouristGroup		AND
			InvMov.DocumentID = @IDInvoice           			AND
			InvMov.InventMovTypeID = 1      				AND
			InvMov.ModelID = Model.IDModel 					AND
			Comis.IDComissionado = TouristGroup.IDGuide 			AND
			GroupToComType.IDTipoComissionado = Comis.IDTipoComissionado 	AND
			TipoComissionado.IDTipoComissionado = Comis.IDTipoComissionado 	AND
			GroupToComType.GroupID = Model.GroupID
		), 0)



INSERT InvoiceCommission
		(
		IDInvoice,
		IDPessoa,
		Commission,
		Tipo 
		)
		(
		SELECT 	@IDInvoice,
			TG.IDGuide,
			@ComGuia,
			'G'
		FROM 	TouristGroup TG JOIN Invoice I
				ON (TG.IDTouristGroup = I.IDTouristGroup)
		WHERE 	IDInvoice = @IDInvoice
			AND
			TG.IDGuide is not Null
		)


SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -203
	GOTO ERRO
END

/*------------------------------------------------------------------------------*/
/*			   Calcula a comissao da Agencia               		*/
/*------------------------------------------------------------------------------*/

INSERT InvoiceCommission
		(
		IDInvoice,
		IDPessoa,
		Commission,
		Tipo 
		)
		(
		SELECT 	@IDInvoice,
			TG.IDAgency,
			@ComGuia * (TG.ComissaoSobreGuia/100),
			'A'
		FROM 	TouristGroup TG JOIN Invoice I
				ON (TG.IDTouristGroup = I.IDTouristGroup)
		WHERE 	IDInvoice = @IDInvoice
			AND
			TG.IDAgency is not Null
		)

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -204
	GOTO ERRO
END


OK:
	RETURN 0
ERRO:
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PreSale_CacheCommission', @ErrorLevelStr

	RETURN @ErrorLevel
GO
