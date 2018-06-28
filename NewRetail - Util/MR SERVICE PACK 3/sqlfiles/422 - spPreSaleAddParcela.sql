if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_AddParcela]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_AddParcela]
GO

CREATE PROCEDURE sp_PreSale_AddParcela
                        (
                        @IDStore                	int,
                        @IDUser                 	int,
                        @IDCliente		int,
                        @PreSaleID              	int,
                        @PreSaleDate		smalldatetime,
                        @ExpirationDate         	smalldatetime,
                        @IDMeioPag              	int,
                        @Value			money,
                        @Authorization		varchar(50),
                        @IDCashRegMov		int,
                        @Parcela			varchar(20),
                        @IDBankCheck		int,
                        @CheckNumber		varchar(20),
                        @CustomerDocument	varchar(20),
                        @CustomerName          	varchar(80),
                        @CustomerPhone         	varchar(20),
                        @OBS			varchar(255),
                        @PaymentPlace 		int,
                        @IsPreDatado 		bit
                        )
AS


/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
            SUMARIO
		- Pega as constantes
                        	- Insere o lancamento
		- Update CashReg TotalSales
		- Incluir crédito para o Cliente

            TABELA DE ERROS PARA RETURN_VALUE
                         	 000  Ok
                        	-201  Erro em Pega as constantes
                        	-202  Erro em Insere o lancamento
                        	-203  Erro em Update CashReg TotalSales
		-204  Erro em Incluir crédito para o Cliente
		-205 Erro em Incluir em Sal_AccountCard

            LOG DE MODIFICAÇÕES

	Data			Programador                 Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
            	26 May  2000		Eduardo Costa		suporte ao novo financeiro
            	27 June 2001		Davi Gouveia               	Log de Return Values
            	28 July 2001		Rodrigo Costa               	Atualizar o CashReg TotalSales
            	21 Oct  2003		Rodrigo Costa              	Chamada a sp_Sis_GetNextCode para @IDLancamento; 
                                                                                      	Criado @IDLancamento;
            	15 Oct 2004		Carlos Lima                   	Incluídos novos campos no Fin_Lancamento
            	27 Sep 2004		Carlos Lima                   	Incluídos novo campo no no Fin_Lancamento (PaymentPlace)
	09 Nov 2004		Carlos Lima                   	Inclusão de Crédito
	10 Nov 2004		Carlos Lima		Inclusão do campo IDLancamento quando inclui Crédito
	07 Jan 2005		Carlos Lima		Inclusão do parâmetro IsPredatado
	23 Mar 2006		Carlos Lima		Suporte ao Gift Card ( Chamada para a procedure que inclui em Sal_AccountCard ) 
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */


DECLARE @IDCentroCusto      	int
DECLARE @IDContaCorrente    	int
DECLARE @IDEmpresa          	int
DECLARE @ErrorLevel         	int
DECLARE @IDLancamento       	int
DECLARE @Tipo		int
DECLARE @IDCustomerCredit	int

SET @ErrorLevel = 0


-- Pega as constantes
SELECT
	@IDCentroCusto = S.IDCentroCusto,
	@IDContaCorrente = MPS.IDContaCorrente,
	@IDEmpresa = S.IDEmpresa
FROM
	Store S
	JOIN MeioPagToStore MPS ON (S.IDStore = MPS.IDStore)
WHERE
	S.IDStore = @IDStore
	AND
	MPS.IDMeioPag = @IDMeioPag

SELECT
	@Tipo = Tipo
FROM
	MeioPag
WHERE
	IDMeioPag = @IDMeioPag

IF @@ERROR <> 0
BEGIN
            SET @ErrorLevel = -201
            GOTO ERRO
END

 
-- Insere o lancamento
EXEC sp_Sis_GetNextCode 'Fin_Lancamento.IDLancamento', @IDLancamento OUTPUT
INSERT            Fin_Lancamento
                        (
                        IDLancamento,
                        IDLancamentoTipo,
                        Pagando,
                        Situacao,
                        IDCentroCusto,
                        IDContaCorrentePrevista,
                        IDDocumentoTipo,
                        NumDocumento,
                        IDEmpresa,
                        IDPreSale,
                        IDPessoaTipo,
                        IDPessoa,
                        IDMoeda,
                        IDMoedaCotacao,
                        DataLancamento,
                        DataVencimento,
                        ValorNominal,
                        IDQuitacaoMeioPrevisto,
                        IDUsuarioLancamento,
                        NumMeioQuitPrevisto,
                        IDCashRegMov,
                        NumDesdobramento,
                        IDDesdobramentoTipo,
                        IDBankCheck,
                        CheckNumber,
                        CustomerDocument,
                        CustomerName,
                        CustomerPhone,
                        Historico,
                        PaymentPlace,
                        IsPreDatado
                        )
                        VALUES
                        (
                        @IDLancamento,
                        2, -- \\Receitas\Vendas
                        0,
                        1,
                        @IDCentroCusto,
                        @IDContaCorrente,
                        1001, -- Sales Invoice
                        Convert(varchar(50), @PreSaleID),
                        @IDEmpresa,
                        @PreSaleID,
                        1, -- Sales Customer
                        @IDCliente,
                        4, -- Dollares
                        6, -- CotacaoPadrao do Dollar
                        @PreSaleDate,
                        @ExpirationDate,
                        @Value,
                        @IDMeioPag,
                        @IDUser, --Usuario do financeiro
                        @Authorization,
                        @IDCashRegMov,
                        @Parcela,
                        1001,
                        @IDBankCheck,
                        @CheckNumber,
                        @CustomerDocument,
                        @CustomerName,
                        @CustomerPhone,
                        @OBS,
                        @PaymentPlace,
                        @IsPreDatado
                        )

IF @@ERROR <> 0
BEGIN
            SET @ErrorLevel = -202
            GOTO ERRO
END

/*--------------------------------------------------------------------------------------------------------*/
/*                     Update Cash RegisterMovent                             */
/*--------------------------------------------------------------------------------------------------------*/

UPDATE
            CashRegMov
SET
            CashRegMov.TotalSales = IsNull(dbo.CashRegMov.TotalSales, 0) + ROUND(IsNull(@Value,0),2)
WHERE
            CashRegMov.IDCashRegMov = @IDCashRegMov 

IF @@ERROR <> 0
BEGIN
            SET @ErrorLevel = -203
            GOTO ERRO
END


/*----------------------------------------------------------------*/
/*		Customer Credit		*/
/*----------------------------------------------------------------*/
IF (@Tipo = 5)  AND (@Value < 0)
BEGIN
	EXEC sp_PreSale_AddCustomerCredit @IDCliente, @IDUser, @IDStore, @PreSaleDate, NULL, @Value, @IDLancamento, @IDCustomerCredit OUTPUT

	IF @@ERROR <> 0
	BEGIN
	            SET @ErrorLevel = -204
	            GOTO ERRO
	END
END


/*----------------------------------------------------------------*/
/*		Gift Card		*/
/*----------------------------------------------------------------*/
IF (@Tipo = 6)
BEGIN

	EXEC sp_Sal_AccountCard_AddAmount @CustomerDocument, @Value, @PreSaleID, @IDLancamento, @IDUser, 0, ''

	IF @@ERROR <> 0
	BEGIN
	            SET @ErrorLevel = -205
	            GOTO ERRO
	END

END




OK:
            RETURN 0
ERRO:
            PRINT CAST(@ErrorLevel AS VARCHAR)
            RETURN @ErrorLevel
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_DeleteSingleDelayPayment]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_DeleteSingleDelayPayment]
GO

CREATE PROCEDURE sp_PreSale_DeleteSingleDelayPayment
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

	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	05 Oct  2004		Carlos Lima		Criação
	11 Nov 2004		Carlos Lima		Restaurar o Crédito do Cliente, caso a forma de
							pagamento for por Crédito de Cliente
	12 Nov 2004		Carlos Lima		Cancelar o Crédito do Cliente, caso a forma de
							pagamento for por Crédito de Cliente
	23 Mar	2006		Rodrigo Costa		Restaura e cancela o credito do cartao
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
	Invoice
	INNER JOIN Fin_Lancamento ON (Invoice.IDPreSale = Fin_Lancamento.IDPreSale)
	INNER JOIN MeioPag ON (Fin_Lancamento.IDQuitacaoMeioPrevisto = MeioPag.IDMeioPag)
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
		Sal_AccountCard AC
		JOIN Sal_AccountCardMov ACM ON (AC.IDAccountCard = ACM.IDAccountCard)
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


/*----------------------------------------------------------------------------------------------------------*/
/*		Update Cash RegisterMovent do dia	     	  */
/*---------------------------------------------------------------------------------------------------------*/ 
UPDATE
	CashRegMov	
SET
	CashRegMov.TotalSales = IsNull(CashRegMov.TotalSales, 0) - Fin_Lancamento.ValorNominal
FROM
	Fin_Lancamento
WHERE
	CashRegMov.IDCashRegMov = Fin_Lancamento.IDCashRegMov
	AND Fin_Lancamento.IDLancamento = @IDLancamento

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -204
	GOTO ERRO
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
	Fin_Quitacao Q
	JOIN Fin_LancQuit LQ ON (LQ.IDQuitacao = Q.IDQuitacao)
	JOIN Fin_Lancamento L ON (LQ.IDLancamento = L.IDLancamento)
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
	Fin_Quitacao Q
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
	Fin_Lancamento L
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
