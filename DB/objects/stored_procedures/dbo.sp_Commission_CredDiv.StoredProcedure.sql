SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_Commission_CredDiv]
		(
		@IDStore		int,
		@IDPessoa 		int,
		@PayDate		smalldatetime,
		@IDMeioPag		int,
		@IDContaCorrente	int,
		@Commission		money
		)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Descobre o Centro de Custo
		- Inclui o Lancamento
		- Inclui a quitacao
		- Liga Lancamento com Quitacao

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Inclui o Lancamento
		-202  Erro em Inclui a quitacao
		-203  Erro em Liga Lancamento com Quitacao


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Rodrigo Costa		Criacao;
	22 June 2001		Davi Gouveia		Log de Return Values
	21 Oct	2003		André Bogado		Chamada a sp_Sis_GetNextCode
	18 Aug 2004		Rodrigo Costa		Gravar error log
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */


DECLARE  @IDLancamento	int
DECLARE  @IDQuitacao	int
DECLARE  @IDCentroCusto	int
DECLARE @ErrorLevel 		int
DECLARE @SysError		int

SET @ErrorLevel = 0

if not (@IDPessoa > 0)
   RETURN

/*
	Descobre o Centro de Custo
*/
SELECT @IDCentroCusto = ( SELECT IDCentroCusto FROM Store WHERE Store.IDStore = @IDStore )

/*
   	Inclui o Lancamento
*/
/******************************************************************************
	Obtenho o @IDLancamento
*******************************************************************************/

EXEC sp_Sis_GetNextCode 'Lancamento.IDLancamento', @IDLancamento OUTPUT

INSERT dbo.Lancamento
		(
		IDLancamento,
 		IDTipoLancamento,
		IDCentroCusto,
		IDPessoa,
		IDTipoDoc,
		DataLancamento,
		DataVencimento,
		ValorPrevisto
		)
		VALUES
		(
		@IDLancamento,
		12,
		@IDCentroCusto,
		@IDPessoa,
		0,
		@PayDate,
		@PayDate,
		@Commission
		)
SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END


/*
   	Inclui a quitacao */
/******************************************************************************
	Obtenho o @IDLancamento
*******************************************************************************/
EXEC sp_Sis_GetNextCode 'Quitacao.IDQuitacao', @IDQuitacao OUTPUT

INSERT	dbo.Quitacao
		(
		IDQuitacao,
		DataQuitacao,
		ValorQuitacao,
		IDMeioPag,
		TotalJuros,
		IDContaCorrente,
		DataDesbloqueio
		)
		VALUES
		(
		@IDQuitacao,
		@PayDate,
		@Commission,
		@IDMeioPag,
		0,
		@IDContaCorrente,
		@PayDate
		)

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -202
	GOTO ERRO
END

/*
	Liga Lancamento com Quitacao
*/
INSERT	dbo.LancamentoToQuit
		(
		IDLancamento,
		IDQuitacao,
		ValorQuitado,
		Juros
		)
		VALUES
		(
		@IDLancamento,
		@IDQuitacao,
		@Commission,
		0
		)

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -203
	GOTO ERRO
END


OK:
	RETURN 0

ERRO:
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_Commission_CredDiv', @ErrorLevelStr

	RETURN @ErrorLevel
GO
