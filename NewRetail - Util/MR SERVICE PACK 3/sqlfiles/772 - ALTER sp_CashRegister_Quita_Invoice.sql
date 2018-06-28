IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[sp_CashRegister_Quita_Invoice]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[sp_CashRegister_Quita_Invoice]
GO

CREATE PROCEDURE sp_CashRegister_Quita_Invoice
	(
	@IDCashRegMov	int,
	@IDUsuario	int,
	@Date		Datetime
	) AS

/* ----------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Insere os registros de quitacao, para os invoices
		- Insiro os Account Payable com as taxas de admim
		- Insere as ligacoes entre Lancamento e Quitacao
		- Upadate em Fin_Lancamento (CashRegMovClosed)

	TABELA DE ERROS PARA RETURN_VALUE

		 000	Ok
		-201	Erro em Insere os registros de quitacao, para os invoices
		-202	Erro em Insiro os Account Payable com as taxas de admim
		-203	Erro em Insere as ligacoes entre Lancamento e Quitacao
		-204	Erro Upadate em Fin_Lancamento (CashRegMovClosed)

	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	-----------------------	----------------------- -----------------------------------------------------------------
	15 May	2000		Rodrigo Costa		Criacao;
	22 June	2001		Davi Gouveia		Log de Return Values;
	21 Oct	2003		André Bogado		Chamada a sp_Sis_GetNextCode;
							Criado cursor para Fin_Quitacao e Fin_Lancamento;
	18 Aug	2004		Rodrigo Costa		Gravar error log;
	18 Jan	2005		Carlos Lima		Gravar em que caixa foi fechado;
	16 May	2006		Maximiliano Muniz	Filtro pelo campo "PayOnCashRegClose" na carga dos cursores;
							O campo "PrazoRecebimento" agora é pego do MeioPag direto.
	02 Apr	2008		Maximiliano Muniz	Foi retirada uma condição na query que alimenta o cursor para
							inserir os pagamentos referentes aos impostos/taxas do tipo de
							pagamento. A condição limitava apenas lançamento com pagamento
							a vista, ou seja, cartões com vencimento para 30 dias não gerava.
	----------------------------------------------------------------------------------------------------------------- */

DECLARE @ErrorLevel	int
DECLARE @SysError	int

SET @ErrorLevel = 0

/* ------------------------------------------------------------------------------------------------------------ */
/*		Quita os lancamentos										*/
/*------------------------------------------------------------------------------------------------------------- */

-- Insere os registros de quitacao, para os invoices
-- Alterações de sp_Sis_GetNextCode
SET NOCOUNT ON
-- Variáveis de Fin_Quitacao
DECLARE @IDQuitacao		int
DECLARE @Pagando		TBit
DECLARE @DataQuitacao		smalldatetime
DECLARE @ValorQuitacao		TValor
DECLARE @IDQuitacaoMeio		int
DECLARE @IDUsuarioQuitacao	int
DECLARE @ValorJuros		TValor
DECLARE @NumeroMeioQuit		TCodigoGeral
DECLARE @IDContaCorrente	int
DECLARE @SparrowInt		int

--Variáveis de Fin_Lancamento
DECLARE @IDLancamento			int
DECLARE @DataVencimento			smalldatetime
DECLARE @DataLancamento			smalldatetime
DECLARE @ValorNominal			TValor
DECLARE @IDQuitacaoMeioPrevisto		int
DECLARE @IDUsuarioLancamento		int
DECLARE @IDContaCorrentePrevista	int
DECLARE @IDEmpresa 			int
DECLARE @IDPessoa			int
DECLARE @IDPessoaTipo			int
DECLARE @IDLancamentoTipo		int

--Declaração do Cursor de Fin_Quitacao
DECLARE Fin_Quitacao_Cursor CURSOR FOR 
	(SELECT
		0,
		DateAdd(Day, MP.PrazoRecebimento, @Date ),
		0, -- A LancQuit ira atualizar corretamente este valor
		MP.IDMeioPagBatch,
		@IDUsuario,
		0,
		Convert(Varchar(20), L.IDCashRegMov),
		MPTS.IDContaCorrente,
		L.IDCashRegMov
	FROM
		Fin_Lancamento L (NOLOCK)
		JOIN Invoice I (NOLOCK) ON ( I.IDPresale = L.IDPreSale )
		JOIN MeioPag MP (NOLOCK) ON ( MP.IDMeioPag = L.IDQuitacaoMeioPrevisto )
		JOIN MeioPag MPB (NOLOCK) ON ( MPB.IDMeioPag = MP.IDMeioPagBatch )
		JOIN MeioPagToStore MPTS (NOLOCK) ON (MPTS.IDMeioPag = MP.IDMeioPagBatch AND MPTS.IDStore = I.IDStore)
	WHERE
		L.IDCashRegMov = @IDCashRegMov
		AND L.DataVencimento = CONVERT(smalldatetime, CONVERT(varchar, @Date, 103), 103) -- Somente os lancamento a vista
		AND MP.IDMeioPagBatch IS NOT NULL
		AND MP.PayOnCashRegClose = 1
	GROUP BY
		DateAdd(Day, MP.PrazoRecebimento, @Date ),
		MP.IDMeioPagBatch,
		Convert(Varchar(20), L.IDCashRegMov),
		MPTS.IDContaCorrente,
		L.IDCashRegMov
	)
-- Abertura do Cursor
OPEN Fin_Quitacao_Cursor
-- Inicialização do Cursor
FETCH NEXT FROM Fin_Quitacao_Cursor INTO  
		@Pagando,
		@DataQuitacao,
		@ValorQuitacao,
		@IDQuitacaoMeio,
		@IDUsuarioQuitacao ,
		@ValorJuros ,
		@NumeroMeioQuit,
		@IDContaCorrente,
		@SparrowInt
-- Enquanto tem registros
WHILE @@FETCH_STATUS = 0
BEGIN
/******************************************************************************
	Obtenho o @IDQuitacao
*******************************************************************************/
	EXEC sp_Sis_GetNextCode 'Fin_Quitacao.IDQuitacao', @IDQuitacao OUTPUT

	INSERT
		Fin_Quitacao
		(
		IDQuitacao,
		Pagando,
		DataQuitacao,
		ValorQuitacao,
		IDQuitacaoMeio,
		IDUsuarioQuitacao,
		ValorJuros,
		NumeroMeioQuit,
		IDContaCorrente,
		SparrowInt
 		)
	VALUES 
		(	
		@IDQuitacao, 
		@Pagando,
		@DataQuitacao,
		@ValorQuitacao,
		@IDQuitacaoMeio,
		@IDUsuarioQuitacao ,
		@ValorJuros ,
		@NumeroMeioQuit,
		@IDContaCorrente,
		@SparrowInt )
	-- leitura do próximo
	FETCH NEXT FROM Fin_Quitacao_Cursor INTO 

		@Pagando,
		@DataQuitacao,
		@ValorQuitacao,
		@IDQuitacaoMeio,
		@IDUsuarioQuitacao ,
		@ValorJuros ,
		@NumeroMeioQuit,
		@IDContaCorrente,
		@SparrowInt
END
-- fechamento do cursor
CLOSE Fin_Quitacao_Cursor
-- destruição do cursor
DEALLOCATE Fin_Quitacao_Cursor
SET NOCOUNT OFF

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END
/******************************************************************************
		Insiro os Account Payable com as taxas de admim
*******************************************************************************/
--Declaração do Cursor de Fin_Quitacao
DECLARE Fin_Lancamento_Cursor CURSOR FOR 
	SELECT	
		1,
		DateAdd(Day, MP.PrazoRecebimento, @Date ),
		@Date,
		SUM( L.ValorNominal * (IsNull(MPB.TaxaAdmin, 0)/100) ),
		MP.IDMeioPag,
		@IDUsuario,
		MPTS.IDContaCorrente,
		CC.IDEmpresa,
		MPB.IDPessoa,
		P.IDTipoPessoa,
		MPB.IDLancamentoTipo,
		L.IDCashRegMov
	FROM
		Fin_Lancamento L (NOLOCK)
		JOIN Invoice I (NOLOCK) ON ( I.IDPresale = L.IDPreSale )
		JOIN MeioPag MP (NOLOCK) ON ( MP.IDMeioPag = L.IDQuitacaoMeioPrevisto )
		JOIN MeioPag MPB (NOLOCK) ON ( MPB.IDMeioPag = MP.IDMeioPagBatch )
		JOIN MeioPagToStore MPTS (NOLOCK) ON (MPTS.IDMeioPag = MP.IDMeioPagBatch AND MPTS.IDStore = I.IDStore)
		JOIN Fin_ContaCorrente CC (NOLOCK) ON (MPTS.IDContaCorrente = CC.IDContaCorrente)
		JOIN Pessoa P (NOLOCK) ON (MPB.IDPessoa = P.IDPessoa)
	WHERE
		MPB.AutoDiscountFee = 1
		AND L.IDCashRegMov = @IDCashRegMov
		AND MPB.IDLancamentoTipo IS NOT NULL
		AND MPB.IDPessoa IS NOT NULL
		AND IsNull(MPB.TaxaAdmin, 0) <> 0
		AND MP.PayOnCashRegClose = 1
	GROUP BY
		DateAdd(Day, MP.PrazoRecebimento, @Date ),
		MP.IDMeioPag,
		MPTS.IDContaCorrente,
		CC.IDEmpresa,
		MPB.IDPessoa,
		P.IDTipoPessoa,
		MPB.IDLancamentoTipo,
		L.IDCashRegMov
	
-- Abertura do Cursor
OPEN Fin_Lancamento_Cursor
-- Inicialização do Cursor
FETCH NEXT FROM Fin_Lancamento_Cursor INTO  
	@Pagando,
	@DataVencimento,
	@DataLancamento,
	@ValorNominal,
	@IDQuitacaoMeioPrevisto,
	@IDUsuarioLancamento,
	@IDContaCorrentePrevista,
	@IDEmpresa,
	@IDPessoa,
	@IDPessoaTipo,
	@IDLancamentoTipo,
	@IDCashRegMov

-- Enquanto tem registros
WHILE @@FETCH_STATUS = 0
BEGIN
/******************************************************************************
	Obtenho o @IDLancamento
*******************************************************************************/
	EXEC sp_Sis_GetNextCode 'Fin_Lancamento.IDLancamento', @IDLancamento OUTPUT

	INSERT
		Fin_Lancamento
		(
		IDLancamento,
		Pagando,
		DataVencimento,
		DataLancamento,
		ValorNominal,
		IDQuitacaoMeioPrevisto,
		IDUsuarioLancamento,
		IDContaCorrentePrevista,
		IDEmpresa,
		IDPessoa,
		IDPessoaTipo,
		IDLancamentoTipo,
		IDCashRegMov
 		)
	VALUES	
		(
		@IDLancamento,
		@Pagando,
		@DataVencimento,
		@DataLancamento,
		@ValorNominal,
		@IDQuitacaoMeioPrevisto,
		@IDUsuarioLancamento,
		@IDContaCorrentePrevista,
		@IDEmpresa,
		@IDPessoa,
		@IDPessoaTipo,
		@IDLancamentoTipo,
		@IDCashRegMov 
		)

	-- leitura do próximo
	FETCH NEXT FROM Fin_Lancamento_Cursor INTO  
		@Pagando,
		@DataVencimento,
		@DataLancamento,
		@ValorNominal,
		@IDQuitacaoMeioPrevisto,
		@IDUsuarioLancamento,
		@IDContaCorrentePrevista,
		@IDEmpresa,
		@IDPessoa,
		@IDPessoaTipo,
		@IDLancamentoTipo,
		@IDCashRegMov
END-- fechamento do cursor
CLOSE Fin_Lancamento_Cursor
-- destruição do cursor
DEALLOCATE Fin_Lancamento_Cursor
SET NOCOUNT OFF

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
                SET @ErrorLevel = -202
                GOTO ERRO
END

/******************************************************************************
		Insere as ligacoes entre Lancamento e Quitacao
*******************************************************************************/
INSERT	
	Fin_LancQuit
	(
	IDLancamento,
	IDQuitacao,
	ValorQuitado,
	DataQuitacao,
	ValorJuros,
	IDUsuarioQuitacao
	)
	SELECT
		L.IDLancamento,
		Q.IDQuitacao,
		L.ValorNominal,
		@Date,
		0,
		@IDUsuario
	FROM
		Fin_Lancamento L (NOLOCK)
		JOIN MeioPag MP (NOLOCK) ON (L.IDQuitacaoMeioPrevisto = MP.IDMeioPag)
		JOIN Fin_Quitacao Q (NOLOCK) ON (MP.IDMeioPagBatch = Q.IDQuitacaoMeio)
	WHERE
		L.IDCashRegMov  = @IDCashRegMov
		AND L.DataVencimento = CONVERT(smalldatetime, CONVERT(varchar, @Date, 103), 103) -- Somente os lancamento a vista
		AND Q.SparrowInt = @IDCashRegMov
		AND MP.PayOnCashRegClose = 1
		AND IsNull(MP.ParentType, 'Sale') = 'Sale'

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -203
	GOTO ERRO
END

UPDATE 	Fin_Lancamento 
SET		 IDCashRegMovClosed = @IDCashRegMov
WHERE
		IDCashRegMov = @IDCashRegMov

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
	RETURN @ErrorLevel

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_CashRegister_Quita_Invoice', @ErrorLevelStr

	RETURN @ErrorLevel
GO
