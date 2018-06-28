SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[sp_PreSale_DeleteSingleDelayPayment]
			(
			@IDLancamento int,
			@IDUser int
			)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Update Cash RegisterMovent
		- Desquita o lancamento
		- Deleta o lancamento
		- Restaura Crédito do Cliente ou Cancela Crédito do Cliente
		- Restaura Crédito do Cartao ou Cancela Crédito do Cartao

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Deleta os registros de ligacao
		-202  Erro em Deleta os registros de quitacao
		-203  Erro em Deleta os registros de lançamento
		-204  Erro em Update Cash RegisterMovent
		-205  Erro em Restaura Crédito do Cliente
		-206  Erro em Cancela Crédito do Cliente
		-207  Erro em Restaura Crédito do Cartao
		-208  Erro em Cancela Crédito do Cartao
		-209  Erro em Cancela Store Account

	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	05 Oct  2004		Carlos Lima		Criação
	11 Nov 2004		Carlos Lima		Restaurar o Crédito do Cliente, caso a forma de
							pagamento for por Crédito de Cliente
	12 Nov 2004		Carlos Lima		Cancelar o Crédito do Cliente, caso a forma de
							pagamento for por Crédito de Cliente
	23 Mar	2006		Rodrigo Costa		Restaura e cancela o credito do cartao
	07 Apr	2008		Rodrigo Costa		Cancelar o Store Account
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */



BEGIN TRAN

DECLARE @ErrorLevel		int
DECLARE @SysError		int

DECLARE @IDPessoa		int
DECLARE @IDStore		int
DECLARE @CreditDate		datetime
DECLARE @ExpirationDate 	datetime
DECLARE @ValorNominal	money
DECLARE @IDCustomerCredit	int
DECLARE @Tipo		int
DECLARE @AccountNumber		varchar(20)

SET @ErrorLevel = 0


SELECT
	@IDPessoa 	= Fin_Lancamento.IDPessoa,
	@IDStore	= Invoice.IDStore,
	@ValorNominal	= Fin_Lancamento.ValorNominal,
	@Tipo		= MeioPag.Tipo,
	@CreditDate	= GETDATE()
FROM
	Invoice (NOLOCK) 
	INNER JOIN Fin_Lancamento (NOLOCK) ON (Invoice.IDPreSale = Fin_Lancamento.IDPreSale)
	INNER JOIN MeioPag (NOLOCK) ON (Fin_Lancamento.IDQuitacaoMeioPrevisto = MeioPag.IDMeioPag)
WHERE
	Fin_Lancamento.IDLancamento = @IDLancamento

SET @ExpirationDate = NULL


/*----------------------------------------------------------------*/
/*	Restaura Crédito do Cliente	*/
/*---------------------------------------------------------------*/

IF (@Tipo = 5) AND (@ValorNominal > 0)
BEGIN
	EXEC sp_PreSale_AddCustomerCredit @IDPessoa, @IDUser,  @IDStore, @CreditDate, @ExpirationDate, @ValorNominal, NULL, @IDCustomerCredit OUTPUT

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		SET @ErrorLevel = -205
		GOTO ERRO
	END
END

/*----------------------------------------------------------------*/
/*	Cancela Crédito do Cliente	*/
/*---------------------------------------------------------------*/


IF (@Tipo = 5) AND (@ValorNominal <= 0)
BEGIN
	UPDATE 	CustomerCredit 
	SET		IsUsed = 1,
			IDLancamento = NULL
	WHERE	IDLancamento = @IDLancamento

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		SET @ErrorLevel = -206
		GOTO ERRO
	END
END

/*----------------------------------------------------------------*/
/*	Restaura Crédito do Cartao	*/
/*---------------------------------------------------------------*/
IF (@Tipo = 6)
BEGIN
	SELECT
		@AccountNumber = AC.CardNumber
	FROM
		Sal_AccountCard AC (NOLOCK) 
		JOIN Sal_AccountCardMov ACM (NOLOCK) ON (AC.IDAccountCard = ACM.IDAccountCard)
	WHERE
		ACM.IDLancamento = @IDLancamento

	EXEC sp_Sal_AccountCard_AddAmount @AccountNumber, @ValorNominal, NULL, NULL, @IDUser, 1, ''

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		SET @ErrorLevel = -207
		GOTO ERRO
	END
END

/*----------------------------------------------------------------*/
/*	Cancela Crédito do Cartao	*/
/*---------------------------------------------------------------*/
IF (@Tipo = 6)
BEGIN
	UPDATE
		Sal_AccountCardMov
	SET
		IDLancamento = NULL
	WHERE
		IDLancamento = @IDLancamento

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		SET @ErrorLevel = -208
		GOTO ERRO
	END
END

/*----------------------------------------------------------------*/
/*	Cancela Store Account	*/
/*---------------------------------------------------------------*/
IF (@Tipo = 9)
BEGIN
	UPDATE
		Sal_StoreAccount
	SET
		IDLancamento = NULL,
		IsUsed = 1
	WHERE
		IDLancamento = @IDLancamento

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		SET @ErrorLevel = -209
		GOTO ERRO
	END
END


/*----------------------------------------------------------------------------------------------------------*/
/*		Update Cash RegisterMovent do dia se nao for Store Account     	  */
/*---------------------------------------------------------------------------------------------------------*/ 
IF (@Tipo <> 9)
BEGIN
	UPDATE
		CashRegMov	
	SET
		CashRegMov.TotalSales = IsNull(CashRegMov.TotalSales, 0) - Fin_Lancamento.ValorNominal
	FROM
		Fin_Lancamento (NOLOCK) 
	WHERE
		CashRegMov.IDCashRegMov = Fin_Lancamento.IDCashRegMov
		AND Fin_Lancamento.IDLancamento = @IDLancamento
	
	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		SET @ErrorLevel = -204
		GOTO ERRO
	END
END

/*--------------------------------------------------------------------------------------------*/
/*	       Desquita o lancamento         			  */
/*--------------------------------------------------------------------------------------------*/

/*----------- Cria tabela com as quitacoes a serem deletadas ------------ */
SELECT
	Q.IDQuitacao
INTO
	#sp_PreSale_Remove_QuitToDelete
FROM
	Fin_Quitacao Q (NOLOCK) 
	JOIN Fin_LancQuit LQ (NOLOCK) ON (LQ.IDQuitacao = Q.IDQuitacao)
	JOIN Fin_Lancamento L (NOLOCK) ON (LQ.IDLancamento = L.IDLancamento)
WHERE
	L.IDLancamento = @IDLancamento

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -207
	GOTO ERRO
END

/*---------------- Deleta o registro de ligacao -------------------- */
DELETE
	LQ
FROM
	Fin_LancQuit LQ
	--JOIN Fin_Lancamento L ON (L.IDLancamento = LQ.IDLancamento)
	JOIN #sp_PreSale_Remove_QuitToDelete QTD ON (QTD.IDQuitacao = LQ.IDQuitacao)
--WHERE
--	L.IDLancamento = @IDLancamento

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END

/*--------------- Deleta o registro de quitacao -----------------*/
DELETE
	Q
FROM
	Fin_Quitacao Q (NOLOCK) 
	JOIN #sp_PreSale_Remove_QuitToDelete QTD ON (QTD.IDQuitacao = Q.IDQuitacao)

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -202
	GOTO ERRO
END

/*---------------- Deleta o registro de lançamento --------------------*/
DELETE
	L
FROM 
	Fin_Lancamento L (NOLOCK)
WHERE
	L.IDLancamento = @IDLancamento


SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -203
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
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PreSale_DeleteSingleDelayPayment', @ErrorLevelStr

	RETURN @ErrorLevel
GO
