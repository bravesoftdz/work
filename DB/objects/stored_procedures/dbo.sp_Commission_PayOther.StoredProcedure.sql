SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_Commission_PayOther]
		(
		@IDStore		int,
		@IDOtherComission	int,
		@PayDate		smalldatetime,
		@IDMeioPag		int,
		@IDContaCorrente	int,
		@Commission		money,
		@DataIni		smalldatetime,
		@DataFim		smalldatetime,
		@IDUser		int,
		@IDLancamento	int output
		)
AS


/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO
		
		- Deleto os InventoryMov
		- Incluo no Inventario se necessario

	TABELA DE ERROS PARA RETURN_VALUE
	
		 000  Ok
		-201  Erro em Select Centro Custo
		-202  Erro em Insert Fin_Lancamento
		-203  Erro em Insert Fin_Quitacao
		-204  Erro em Update Invoice

	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	26 Maio 2000		Eduardo Costa		suporte ao novo financeiro;
	27 Oct	2003		André Bogado		Chamada a sp_Sis_GetNextCode;
							Removed SELECT @IDQuitacao = MAX(IDQuitacao) FROM Fin_Quitacao
 	18 Aug 2004		Rodrigo Costa		Gravar error log
   -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */


 
DECLARE @IDQuitacao		int
DECLARE @IDCentroCusto	int
DECLARE @IDEmpresa		int
DECLARE @ErrorLevel		int
DECLARE @SysError		int

IF not (@IDOtherComission > 0)
   RETURN

BEGIN TRAN

/*----------------------------------------------------------------*/
/*		Inclui o registro do pagamento			  */
/*----------------------------------------------------------------*/
/*
	Descobre o Centro de Custo e Empresa
*/

SELECT 	
	@IDCentroCusto = S.IDCentroCusto,
	@IDEmpresa = S.IDEmpresa
FROM 	
	Store S (NOLOCK)
WHERE 	
	S.IDStore = @IDStore


SET @SysError = @@ERROR
IF @SysError <> 0  
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END

/*
   	Inclui o Lancamento
*/
/******************************************************************************
	Obtenho o @IDLancamento
*******************************************************************************/
EXEC sp_Sis_GetNextCode 'Fin_Lancamento.IDLancamento', @IDLancamento OUTPUT
INSERT Fin_Lancamento
		(
		IDLancamento,
		IDLancamentoTipo,
		Pagando,
		IDCentroCusto,
		IDPessoaTipo,
		IDPessoa,
		IDDocumentoTipo,
		IDMoeda,
		IDMoedaCotacao,
		DataLancamento,
		DataVencimento,
		ValorNominal,
		IDEmpresa,
		IDUsuarioLancamento
		)
		VALUES
		(
		@IDLancamento,
		6, --  \\Despesa\Comissoes\Pagamento Comissoes
		1,
		@IDCentroCusto,
		9, -- Other
		@IDOtherComission,
		0, -- Temporario
		4, -- Dollares
		6, -- CotacaoPadrao do Dollar 
		@PayDate,
		@PayDate,
		@Commission,
		@IDEmpresa,
		@IDUser
		)

SET @SysError = @@ERROR
IF @SysError <> 0  
BEGIN
	SET @ErrorLevel = -202
	GOTO ERRO
END


/*
   	Inclui a quitacao
*/
/******************************************************************************
	Obtenho o @IDQuitacao
*******************************************************************************/
EXEC sp_Sis_GetNextCode 'Fin_Quitacao.IDQuitacao', @IDQuitacao OUTPUT
INSERT	Fin_Quitacao
		(
		IDQuitacao,
		DataQuitacao,
		Pagando,
		ValorQuitacao,
		IDQuitacaoMeio,
		ValorJuros,
		IDContaCorrente,
		IDUsuarioQuitacao
		)
		VALUES
		(
		@IDQuitacao,
		@PayDate,
		1,
		@Commission,
		@IDMeioPag,
		0,
		@IDContaCorrente,
		@IDUser
		)

SET @SysError = @@ERROR
IF @SysError <> 0  
BEGIN
	SET @ErrorLevel = -203
	GOTO ERRO
END

/*
	Liga as duas
*/

INSERT	Fin_LancQuit
		(
		IDLancamento,
		IDQuitacao,
		ValorQuitado,
		ValorJuros,
		IDUsuarioQuitacao
		)
		VALUES
		(	
		@IDLancamento,
		@IDQuitacao,
		@Commission,
		0,
		@IDUser
		)



SET @SysError = @@ERROR
IF @SysError <> 0  
BEGIN
	SET @ErrorLevel = -204
	GOTO ERRO
END


/*----------------------------------------------------------------*/
/*	Registra o pagamento nas linhas de inventario             */
/*----------------------------------------------------------------*/
UPDATE	
	Invoice
SET	
	IDLancPagOtherCom = @IDLancamento
FROM	
	InventoryMov (NOLOCK)
WHERE
	InventoryMov.DocumentID = Invoice.IDInvoice     
	AND
	InventoryMov.InventMovTypeID = 1 		
	AND
	InventoryMov.MovDate >= @DataIni		
	AND
	InventoryMov.MovDate <  @DataFim		
	AND
	Invoice.OtherComissionID = @IDOtherComission 	
	AND
	Invoice.IDLancPagOtherCom IS NULL

OK:
	COMMIT TRAN 
	RETURN 0

ERRO:
	ROLLBACK TRAN 
	PRINT CAST(@ErrorLevel AS VARCHAR) 

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_Commission_PayOther', @ErrorLevelStr

	RETURN @ErrorLevel
GO
