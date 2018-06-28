SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_Invoice_SubPayGuideAgency]
		(
		@IDCentroCusto	int,
		@InvoiceID 		int,
 		@IDTouristGroup	int,
		@IDGuide 		int,
		@IDAgency 		int,
		@PayDate		SmallDateTime
		)

AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Calcula a comissao do Guia e da Agencia
		- Pega a comissao da coordenacao
		- Inclui a comissao do Guia
		- Inclui a comissao do Agencia

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Inclui a comissao do Guia
		-202  Erro em Inclui a comissao do Agencia


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	26 May  2000		Eduardo Costa		suporte ao novo financeiro
	25 June 2001		Davi Gouveia		Log de Return Values
	18 Aug 2004		Rodrigo Costa		Gravar error log
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */



DECLARE @DescontaCoordenacao 	bit
DECLARE @Comission			money
DECLARE @Coordenacao		money
DECLARE @ErrorLevel 			int
DECLARE @SysError			int

SET @ErrorLevel = 0


IF not (@IDGuide > 0)
   RETURN

BEGIN TRAN

/*------------------------------------------------------------------------------*/
/*			   Calcula a comissao do Guia e da Agencia		*/
/*------------------------------------------------------------------------------*/

SELECT 	@Comission =
		(
		SELECT 	
			IsNull	( SUM 	(
					(IsNull(GroupToComType.Comission, 0)/100) *
					( (IsNull(InvMov.SalePrice, 0) - 						  (TipoComissionado.ComissionOnProfit*IsNull(InvMov.CostPrice, 0)))* 					          IsNull(InvMov.Qty, 0) ) - IsNull(InvMov.Discount, 0) 					), 0)
		FROM 	
			dbo.InventoryMov InvMov (NOLOCK) , 
			dbo.Model Model (NOLOCK) ,
			dbo.GroupToComissionType GroupToComType (NOLOCK) , 
			dbo.vwComissionado Comis (NOLOCK) ,
			dbo.vwTipoComissionado TipoComissionado (NOLOCK) 
		WHERE
			InvMov.DocumentID = @InvoiceID 		    			
			AND
			InvMov.InventMovTypeID = 1      				
			AND
			InvMov.ModelID = Model.IDModel 					
			AND
			Comis.IDComissionado = @IDGuide 				
			AND
			GroupToComType.IDTipoComissionado = Comis.IDTipoComissionado 	
			AND
			TipoComissionado.IDTipoComissionado = Comis.IDTipoComissionado 	
			AND
			GroupToComType.GroupID = Model.GroupID
		)
 
/*------------------------------------------------------------------------------*/
/*	                   Pega a comissao da coordenacao                       */
/*------------------------------------------------------------------------------*/

SELECT 	@Coordenacao =
		(
		SELECT	
			IsNull 	(( TouristGroup.ComissaoSobreGuia / 100), 0)
		FROM	
			TouristGroup (NOLOCK) 
		WHERE
			TouristGroup.IDTouristGroup = @IDTouristGroup
		)

/*------------------------------------------------------------------------------*/
/*	            Deve descontar a Coordenacao do Guia?                       */
/*------------------------------------------------------------------------------*/

SELECT 	@DescontaCoordenacao =
		(
		SELECT
			TouristGroup.DescontaCoordenacao
		FROM	
			TouristGroup (NOLOCK) 
		WHERE
			TouristGroup.IDTouristGroup = @IDTouristGroup
		)


/*------------------------------------------------------------------------------*/
/*	                   Inclui a comissao do Guia                            */
/*------------------------------------------------------------------------------*/
 
INSERT Fin_Lancamento
		(
		IDLancamentoTipo,
		IDCentroCusto,
		IDDocumentoTipo,
		NumDocumento,
		IDPessoa,
 		DataLancamento,
 		DataVencimento,
		IDMoeda,
		IDMoedaCotacao,
		ValorNominal
		)
		VALUES
		(
		6, -- \\Despesas\Comissao\Pagamento de Comissao
		@IDCentroCusto,
		0, -- Temporiario, 
		Convert(VarChar(50), @InvoiceID),
		@IDGuide,
		@PayDate,
		@PayDate,
		4, -- Dollares
		6, -- CotacaoPadrao do Dollar
		@Comission * (1 - @Coordenacao*@DescontaCoordenacao)
		)

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END

/*------------------------------------------------------------------------------*/
/*	                   Inclui a comissao do Agencia                         */
/*------------------------------------------------------------------------------*/
 
INSERT Fin_Lancamento
		(
		IDLancamentoTipo,
		IDCentroCusto,
		IDDocumentoTipo,
		NumDocumento,
		IDPessoa,
 		DataLancamento,
 		DataVencimento,
		IDMoeda,
		IDMoedaCotacao,
		ValorNominal
		)
		VALUES
		(
		6, -- \\Despesas\Comissao\Pagamento de Comissao
		@IDCentroCusto,
		0, -- Temporiario,
		Convert(VarChar(50), @InvoiceID),
		@IDAgency,
		@PayDate,
		@PayDate,
		4, -- Dollares
		6, -- CotacaoPadrao do Dollar
		@Comission * @Coordenacao
		)

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -202
	GOTO ERRO
END


OK:
	COMMIT TRAN
	RETURN 0
ERRO:
	ROLLBACK TRAN
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_Invoice_SubPayGuideAgency', @ErrorLevelStr

	RETURN @ErrorLevel
GO
