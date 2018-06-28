SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_Invoice_SubPayComission]
		(
		@IDCentroCusto		int,
		@InvoiceID 			int,
		@ComissionID 			int,
		@PayDate 			smalldatetime
		)

AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Calcule the Comission over Invoice
		- Include the register on Lancamento

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em exec sp_Comission_CalcPayDate @ComissionID
		-202  Erro em INSERT Fin_Lancamento


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
	26 May  2000		Eduardo Costa		suporte ao novo financeiro
	25 June 2001		Davi Gouveia		Log de Return Values
	18 Aug 2004		Rodrigo Costa		Gravar error log
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */



DECLARE @DataPagamento  	smalldatetime
DECLARE @Comission		money
DECLARE @ErrorLevel 		int
DECLARE @SysError		int

SET @ErrorLevel = 0

if not (@ComissionID > 0)
   return

BEGIN TRAN

/*------------------------------------------------------------------------------*/
/*			    Calcule the Comission over Invoice	                */
/*------------------------------------------------------------------------------*/

SELECT @Comission =
		(
		SELECT
			IsNull	( SUM 	(
					(IsNull(GroupToComType.Comission, 0)/100) *
					( (IsNull(InvMov.SalePrice, 0) -                         
						  (TipoComissionado.ComissionOnProfit*IsNull(InvMov.CostPrice, 0)))*
                        					          IsNull(InvMov.Qty, 0) ) - IsNull(InvMov.Discount, 0)
                        					), 0)

		FROM
			dbo.InventoryMov InvMov (NOLOCK),
			dbo.Model Model (NOLOCK),
			dbo.GroupToComissionType GroupToComType (NOLOCK),
			dbo.vwComissionado Comis (NOLOCK),
			dbo.vwTipoComissionado TipoComissionado (NOLOCK) 

		WHERE
			InvMov.DocumentID = @InvoiceID
			AND
			InvMov.InventMovTypeID = 1
			AND
			InvMov.ModelID = Model.IDModel
			AND
			Comis.IDComissionado = @ComissionID
			AND
			GroupToComType.IDTipoComissionado = Comis.IDTipoComissionado
			AND
			TipoComissionado.IDTipoComissionado = Comis.IDTipoComissionado
			AND
			GroupToComType.GroupID = Model.GroupID
		)
 
/*------------------------------------------------------------------------------------------------------------------*/
/*	               Include the register on Lancamento                                 */
/*------------------------------------------------------------------------------------------------------------------*/

exec	sp_Comission_CalcPayDate 	@ComissionID,
					@PayDate,
					@DataPagamento output

SET @SysError = @@ERROR
IF @SysError <> 0 
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END

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
		@ComissionID,
		@PayDate,
		@DataPagamento,
		4, -- Dollares
		6, -- CotacaoPadrao do Dollar
		@Comission
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
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_Invoice_SubPayComission', @ErrorLevelStr

	RETURN @ErrorLevel
GO
