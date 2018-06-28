if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_AddCustomerCredit]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_AddCustomerCredit]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_AddParcela]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_AddParcela]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_DeleteDelayPayment]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_DeleteDelayPayment]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_DeleteSingleDelayPayment]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_DeleteSingleDelayPayment]
GO

CREATE PROCEDURE sp_PreSale_AddCustomerCredit
	(
	@IDPessoa		int,
	@IDUser		int,
	@IDStore		int,
	@CreditDate		datetime,
	@ExpirationDate	datetime,	
	@Amount		money,
	@IDLancamento	int,
	@IDCustomerCredit	int out
	)
AS

/* ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 	
	SUMARIO

		- Inserir novo crédito para o cliente

	TABELA DE ERROS PARA RETURN_VALUE
		 000	Ok
		-201	Erro em - Inserir novo crédito para o cliente


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	09 Nov 2004		Carlos Lima		Criacao;
	10 Nov 2004		Carlos Lima		Adicionado parâmetro @IDLancamento
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

DECLARE @ErrorLevel	int 
DECLARE @SysError	int

SET @ErrorLevel = 0 

BEGIN TRAN

EXEC sp_Sis_GetNextCode 'CustomerCredit.IDCustomerCredit',  @IDCustomerCredit output

INSERT CustomerCredit
	(
	IDCustomerCredit,
	IDPessoa,
	IDUser,
	IDStore,
	CreditDate,
	ExpirationDate,
	IsUsed,
	Amount,
	IDLancamento
	)
VALUES
	(
	@IDCustomerCredit,
	@IDPessoa,
	@IDUser,
	@IDStore,
	@CreditDate,
	@ExpirationDate,
	0,
	ABS(ISNULL(@Amount, 0)),
	@IDLancamento
	)


SET @SysError = @@ERROR

IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
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
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PreSale_AddCustomerCredit', @ErrorLevelStr

	RETURN @ErrorLevel
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
                        @PaymentPlace 		int
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
                        PaymentPlace
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
                        @PaymentPlace
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

IF (@Tipo = 5)  AND (@Value < 0)
BEGIN
	EXEC sp_PreSale_AddCustomerCredit @IDCliente, @IDUser, @IDStore, @PreSaleDate, NULL, @Value, @IDLancamento, @IDCustomerCredit OUTPUT

	IF @@ERROR <> 0
	BEGIN
	            SET @ErrorLevel = -204
	            GOTO ERRO
	END
END




OK:
            RETURN 0
ERRO:
            PRINT CAST(@ErrorLevel AS VARCHAR)
            RETURN @ErrorLevel
GO

CREATE PROCEDURE sp_PreSale_DeleteDelayPayment
			(
			@PreSaleID	int,
			@IDUser	int
			)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Update Cash RegisterMovent
		- Desquita os lancamentos
		- Deleta os lancamentos
		- Restaura Crédito do Cliente
		- Cancela Crédito do Cliente

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Deleta os registros de ligacao
		-202  Erro em Deleta os registros de quitacao
		-203  Erro em Deleta os registros de lançamento
		-204  Erro em Update Cash RegisterMovent
		-205  Erro em Restaura Crédito do Cliente
		-206  Erro em Cancela Crédito do Cliente



	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	22 Set  2004		Rodrigo Costa		Criação
	12 Nov 2004		Carlos Lima		Suporte a Crédito do Cliente
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */



BEGIN TRAN

DECLARE @ErrorLevel		int
DECLARE @SysError		int


-- Variáveis para o cursor Cursor_Lanc
DECLARE @IDPessoa			int
DECLARE @IDStore			int
DECLARE @CreditDate			datetime
DECLARE @ExpirationDate 		datetime
DECLARE @ValorNominal		money
DECLARE @IDCustomerCredit		int
DECLARE @IDLancamento		int
DECLARE @IDUserCredit		int

SET @ErrorLevel = 0

SET @ExpirationDate = NULL

DECLARE Cursor_Lanc CURSOR FOR
	SELECT
		Fin_Lancamento.IDPessoa,
		Invoice.IDStore,
		Fin_Lancamento.ValorNominal,		
		GETDATE(),
		CustomerCredit.IDUser,
		Fin_Lancamento.IDLancamento,
		IDCustomerCredit
	FROM
		Invoice
		INNER 	JOIN Fin_Lancamento 	ON (Invoice.IDPreSale = Fin_Lancamento.IDPreSale)
		INNER 	JOIN MeioPag 		ON (Fin_Lancamento.IDQuitacaoMeioPrevisto = MeioPag.IDMeioPag)
		LEFT 	JOIN CustomerCredit 	ON (Fin_Lancamento.IDLancamento = CustomerCredit.IDLancamento)
	WHERE
		Invoice.IDPreSale = @PreSaleID
		AND
		MeioPag.Tipo = 5

OPEN Cursor_Lanc

FETCH NEXT FROM Cursor_Lanc INTO
	@IDPessoa,
	@IDStore,
	@ValorNominal,
	@CreditDate,
	@IDUserCredit,
	@IDLancamento,
	@IDCustomerCredit

WHILE @@FETCH_STATUS = 0
BEGIN
	/*----------------------------------------------------------------*/
	/*	Restaura Crédito do Cliente	*/
	/*---------------------------------------------------------------*/
	
	IF (@ValorNominal > 0)
	BEGIN
		EXEC sp_PreSale_AddCustomerCredit @IDPessoa, @IDUserCredit,  @IDStore, @CreditDate, @ExpirationDate, @ValorNominal, NULL, @IDCustomerCredit OUTPUT
	
		SET @SysError = @@ERROR
		IF @SysError <> 0
		BEGIN
			CLOSE Cursor_Lanc
			DEALLOCATE Cursor_Lanc

			SET @ErrorLevel = -205
			GOTO ERRO
		END
	END
	
	/*----------------------------------------------------------------*/
	/*	Cancela Crédito do Cliente	*/
	/*---------------------------------------------------------------*/
	
	
	IF(@ValorNominal <= 0)
	BEGIN
		UPDATE 	CustomerCredit 
		SET		IsUsed = 1,
				IDLancamento = NULL
		WHERE	IDLancamento = @IDLancamento
	
		SET @SysError = @@ERROR
		IF @SysError <> 0
		BEGIN
			CLOSE Cursor_Lanc
			DEALLOCATE Cursor_Lanc

			SET @ErrorLevel = -206
			GOTO ERRO
		END
	END

	FETCH NEXT FROM Cursor_Lanc INTO
		@IDPessoa,
		@IDStore,
		@ValorNominal,
		@CreditDate,
		@IDUser,
		@IDLancamento,
		@IDCustomerCredit
END

CLOSE Cursor_Lanc
DEALLOCATE Cursor_Lanc

/*----------------------------------------------------------------*/
/*		Update Cash RegisterMovent do dia	     	  */
/*----------------------------------------------------------------*/ 
UPDATE
	CashRegMov	
SET
	CashRegMov.TotalSales = IsNull(CashRegMov.TotalSales, 0) - LM.TotalNominal
FROM
	(SELECT 
		IDCashRegMov,
		SUM(ISNULL(ValorNominal, 0)) AS TotalNominal
	 FROM
		Fin_Lancamento L 
		JOIN MeioPag MP ON (L.IDQuitacaoMeioPrevisto = MP.IDMeioPag 
			   AND (MP.Tipo IN (2,4)))
	 WHERE
		L.IDPreSale = @PreSaleID
	 GROUP BY
		IDCashRegMov) AS LM
WHERE
	CashRegMov.IDCashRegMov = LM.IDCashRegMov

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -204
	GOTO ERRO
END



/*----------------------------------------------------------------*/
/*	       Desquita os lancamentos         			  */
/*----------------------------------------------------------------*/

/*---------------- Deleta os registros de ligacao -------------------- */
DELETE
	LQ
FROM
	Fin_LancQuit LQ
	JOIN Fin_Lancamento L ON (L.IDLancamento = LQ.IDLancamento)
	JOIN MeioPag MP ON (L.IDQuitacaoMeioPrevisto = MP.IDMeioPag 
			   AND MP.Tipo IN (2,4))
WHERE
	L.IDPreSale = @PreSaleID

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END

/*--------------- Deleta os registros de quitacao -----------------*/
DELETE
	Q
FROM
	Fin_Quitacao Q
	JOIN Fin_Lancamento L ON (Q.SparrowInt = L.IDLancamento)
	JOIN MeioPag MP ON (L.IDQuitacaoMeioPrevisto = MP.IDMeioPag 
			   AND MP.Tipo IN (2,4))

WHERE
	L.IDPreSale = @PreSaleID

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -202
	GOTO ERRO
END

/*---------------- Deleta os registros de lançamento --------------------*/
DELETE
	L
FROM 
	Fin_Lancamento L
	JOIN MeioPag MP ON (L.IDQuitacaoMeioPrevisto = MP.IDMeioPag 
			   AND MP.Tipo IN (2,4))
WHERE
	L.IDPreSale = @PreSaleID



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
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PreSale_DelLancamento', @ErrorLevelStr

	RETURN @ErrorLevel

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

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Deleta os registros de ligacao
		-202  Erro em Deleta os registros de quitacao
		-203  Erro em Deleta os registros de lançamento
		-204  Erro em Update Cash RegisterMovent
		-205  Erro em Restaura Crédito do Cliente
		-206  Erro em Cancela Crédito do Cliente

	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	05 Oct  2004		Carlos Lima		Criação
	11 Nov 2004		Carlos Lima		Restaurar o Crédito do Cliente, caso a forma de
							pagamento for por Crédito de Cliente
	12 Nov 2004		Carlos Lima		Cancelar o Crédito do Cliente, caso a forma de
							pagamento for por Crédito de Cliente
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

/*---------------- Deleta o registro de ligacao -------------------- */
DELETE
	LQ
FROM
	Fin_LancQuit LQ
	JOIN Fin_Lancamento L ON (L.IDLancamento = LQ.IDLancamento)	
WHERE
	L.IDLancamento = @IDLancamento

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
	JOIN Fin_Lancamento L ON (Q.SparrowInt = L.IDLancamento)
WHERE
	L.IDLancamento = @IDLancamento

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
