if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_CashRegister_Quita_Invoice]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_CashRegister_Quita_Invoice]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_CashRegister_Quita_Lancamento]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_CashRegister_Quita_Lancamento]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_AddParcela]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_AddParcela]
GO

CREATE  PROCEDURE sp_CashRegister_Quita_Invoice
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
	21 Jul	2008		Rodrigo Costa		Inserir valor do MeioPag para loja
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
DECLARE @AdmTax				TValor
DECLARE @AdmTaxFlat			TValor
DECLARE	@DataVencimentoStore		smalldatetime


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
		L.IDCashRegMov,
		CASE IsNull(MPTS.AdmTax, 0) WHEN 0 THEN 0 ELSE SUM( L.ValorNominal * (IsNull(MPTS.AdmTax, 0)/100) ) END,
		CASE IsNull(MPTS.FlatFee, 0) WHEN 0 THEN 0 ELSE SUM( (IsNull(MPTS.AdmTax, 0)) ) END,
		DateAdd(Day, IsNull(MPTS.ReceivingDay,0), @Date )
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
		AND ((IsNull(MPB.TaxaAdmin, 0) <> 0 ) OR ((IsNull(MPTS.AdmTax, 0) <> 0)))
	GROUP BY
		DateAdd(Day, MP.PrazoRecebimento, @Date ),
		MP.IDMeioPag,
		MPTS.IDContaCorrente,
		CC.IDEmpresa,
		MPB.IDPessoa,
		P.IDTipoPessoa,
		MPB.IDLancamentoTipo,
		L.IDCashRegMov,
		MPTS.ReceivingDay,
		MPTS.AdmTax,
		MPTS.FlatFee
	
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
	@IDCashRegMov,
	@AdmTax,
	@AdmTaxFlat,
	@DataVencimentoStore

-- Enquanto tem registros
WHILE @@FETCH_STATUS = 0
BEGIN
/******************************************************************************
	Obtenho o @IDLancamento
*******************************************************************************/
	IF IsNull(@AdmTax,0) <> 0
	BEGIN
		SET @DataVencimento = @DataVencimentoStore
		IF IsNull(@AdmTaxFlat, 0) = 0
			SET @ValorNominal = @AdmTax
		ELSE
			SET @ValorNominal = @AdmTaxFlat
	END


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
		@IDCashRegMov,
		@AdmTax,
		@AdmTaxFlat,
		@DataVencimentoStore

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

CREATE  PROCEDURE sp_CashRegister_Quita_Lancamento
	(
	@IDUsuario		int,
	@Date			Datetime,
	@IDCashRegMovClosed int
	)
AS

/* ---------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Insere os registros de quitacao, para os invoices
		- Insiro os Account Payable com as taxas de admim
                - Insere as ligacoes entre Lancamento e Quitacao
		- Atualiza Fin_lancamento com o caixa no qual foi quitado

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Insere os registros de quitacao, para os invoices
		-202  Erro em Insiro os Account Payable com as taxas de admim
		-203  Erro em Insere as ligacoes entre Lancamento e Quitacao
		-204  Erro em Atualiza Fin_lancamento com o caixa no qual foi quitado


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	-----------------------	-----------------------	----------------------------------------------------------------
	27 Oct	2004		Carlos Lima		Criação
	17 Aug	2006		Maximiliano Muniz	Filtro pelo campo "PayOnCashRegClose" na carga dos cursores;
							O campo "PrazoRecebimento" agora é pego do MeioPag direto.
	02 Apr	2008		Maximiliano Muniz	Foi retirada uma condição na query que alimenta o cursor para
							inserir os pagamentos referentes aos impostos/taxas do tipo de
							pagamento. A condição limitava apenas lançamento com pagamento
							a vista, ou seja, cartões com vencimento para 30 dias não gerava.
	21 Jul	2008		Rodrigo Costa		Inserir valor do MeioPag para loja
	---------------------------------------------------------------------------------------------------------------- */

DECLARE @ErrorLevel 	INT
DECLARE @SysError	INT

SET @ErrorLevel = 0

/*--------------------------------------------------------------------------------------------------------*/
/*	       Quita os lancamentos         			  	*/
/*--------------------------------------------------------------------------------------------------------*/

-- Insere os registros de quitacao, para os invoices
-- Alterações de sp_Sis_GetNextCode
SET NOCOUNT ON
-- Variáveis de Fin_Quitacao
DECLARE @IDQuitacao 		Int
DECLARE @Pagando 		TBit
DECLARE @DataQuitacao 		smalldatetime
DECLARE @ValorQuitacao 		TValor
DECLARE @IDQuitacaoMeio 	int
DECLARE @IDUsuarioQuitacao 	int
DECLARE @ValorJuros 		TValor
DECLARE @NumeroMeioQuit 	TCodigoGeral
DECLARE @IDContaCorrente 	int
DECLARE @SparrowInt 		int

--Variáveis de Fin_Lancamento
DECLARE @IDLancamento			int
DECLARE @DataVencimento			smalldatetime
DECLARE @DataLancamento			smalldatetime
DECLARE @ValorNominal			TValor
DECLARE @IDQuitacaoMeioPrevisto		int
DECLARE @IDUsuarioLancamento		int
DECLARE @IDContaCorrentePrevista	int
DECLARE @IDEmpresa			int
DECLARE @IDPessoa 			int
DECLARE @IDPessoaTipo 			int 
DECLARE @IDLancamentoTipo 		int 
DECLARE @IDCashRegMov			int
DECLARE @SaleCode			varchar(10)
DECLARE @AdmTax				TValor
DECLARE @AdmTaxFlat			TValor
DECLARE	@DataVencimentoStore		smalldatetime


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
		#CloseCash CC
		JOIN Fin_Lancamento L (NOLOCK) ON (CC.IDlancamento = L.IDLancamento and CC.IDCashRegMov = L.IDCashRegMov)
		JOIN Invoice I (NOLOCK) ON ( I.IDPresale = L.IDPreSale )
		JOIN MeioPag MP (NOLOCK) ON ( MP.IDMeioPag = L.IDQuitacaoMeioPrevisto )
		JOIN MeioPag MPB (NOLOCK) ON ( MPB.IDMeioPag = MP.IDMeioPagBatch )
		JOIN MeioPagToStore MPTS (NOLOCK) ON (MPTS.IDMeioPag = MP.IDMeioPagBatch AND MPTS.IDStore = I.IDStore)
	WHERE
		L.DataVencimento = CONVERT(smalldatetime, CONVERT(varchar, @Date, 103), 103) -- Somente os lancamento a vista
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
		L.IDCashRegMov,
		CASE IsNull(MPTS.AdmTax, 0) WHEN 0 THEN 0 ELSE SUM( L.ValorNominal * (IsNull(MPTS.AdmTax, 0)/100) ) END,
		CASE IsNull(MPTS.FlatFee, 0) WHEN 0 THEN 0 ELSE SUM( (IsNull(MPTS.AdmTax, 0)) ) END,
		DateAdd(Day, IsNull(MPTS.ReceivingDay,0), @Date )
	FROM
		#CloseCash TCC
		JOIN Fin_Lancamento L (NOLOCK) ON (TCC.IDlancamento = L.IDLancamento and TCC.IDCashRegMov = L.IDCashRegMov)
		JOIN Invoice I (NOLOCK) ON ( I.IDPresale = L.IDPreSale )
		JOIN MeioPag MP (NOLOCK) ON ( MP.IDMeioPag = L.IDQuitacaoMeioPrevisto )
		JOIN MeioPag MPB (NOLOCK) ON ( MPB.IDMeioPag = MP.IDMeioPagBatch )
		JOIN MeioPagToStore MPTS (NOLOCK) ON (MPTS.IDMeioPag = MP.IDMeioPagBatch AND MPTS.IDStore = I.IDStore)
		JOIN Fin_ContaCorrente CC (NOLOCK) ON (MPTS.IDContaCorrente = CC.IDContaCorrente)
		JOIN Pessoa P (NOLOCK) ON (MPB.IDPessoa = P.IDPessoa)
	WHERE
		MPB.AutoDiscountFee = 1
		AND MPB.IDLancamentoTipo IS NOT NULL
		AND MPB.IDPessoa IS NOT NULL
		AND ((IsNull(MPB.TaxaAdmin, 0) <> 0 ) OR ((IsNull(MPTS.AdmTax, 0) <> 0)))
	GROUP BY
		DateAdd(Day, MP.PrazoRecebimento, @Date ),
		MP.IDMeioPag,
		MPTS.IDContaCorrente,
		CC.IDEmpresa,
		MPB.IDPessoa,
		P.IDTipoPessoa,
		MPB.IDLancamentoTipo,
		L.IDCashRegMov,
		MPTS.ReceivingDay,
		MPTS.AdmTax,
		MPTS.FlatFee
	
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
	@IDCashRegMov,
	@AdmTax,
	@AdmTaxFlat,
	@DataVencimentoStore

-- Enquanto tem registros
WHILE @@FETCH_STATUS = 0
BEGIN
/******************************************************************************
	Obtenho o @IDLancamento
*******************************************************************************/

	IF IsNull(@AdmTax,0) <> 0
	BEGIN
		SET @DataVencimento = @DataVencimentoStore
		IF IsNull(@AdmTaxFlat, 0) = 0
			SET @ValorNominal = @AdmTax
		ELSE
			SET @ValorNominal = @AdmTaxFlat
	END

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
		IDCashRegMov,
		Situacao
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
		@IDCashRegMov,
		1 --aberto
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
		@IDCashRegMov,
		@AdmTax,
		@AdmTaxFlat,
		@DataVencimentoStore


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
		#CloseCash TCC
		JOIN Fin_Lancamento L (NOLOCK) ON (TCC.IDlancamento = L.IDLancamento and TCC.IDCashRegMov = L.IDCashRegMov)
		JOIN MeioPag MP (NOLOCK) ON (L.IDQuitacaoMeioPrevisto = MP.IDMeioPag)
		JOIN Fin_Quitacao Q (NOLOCK) ON (MP.IDMeioPagBatch = Q.IDQuitacaoMeio and Q.SparrowInt = L.IDCashRegMov)
	WHERE
		Q.IDQuitacao NOT IN 
			(
			SELECT
				IDQuitacao	
			FROM
				Fin_LancQuit (NOLOCK)
			)
		AND
		L.DataVencimento = CONVERT(smalldatetime, CONVERT(varchar, @Date, 103), 103) -- Somente os lancamento a vista
		AND IsNull(MP.ParentType, 'Sale') = 'Sale'

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -203
	GOTO ERRO
END

/***************************************************************************************
	Atualiza Fin_lancamento com o caixa no qual foi quitado
****************************************************************************************/

UPDATE	
	Fin_Lancamento
SET	IDCashRegMovClosed = @IDCashRegMovClosed
FROM	
	#CloseCash
WHERE
	Fin_Lancamento.IDLancamento = #CloseCash.IDLancamento

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
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_CashRegister_Quita_Lancamento', @ErrorLevelStr

	RETURN @ErrorLevel

GO

CREATE    PROCEDURE sp_PreSale_AddParcela
	(
	@IDStore		int,
	@IDUser			int,
	@IDCliente		int,
	@PreSaleID		int,
	@PreSaleDate		smalldatetime,
	@ExpirationDate		smalldatetime,
	@IDMeioPag		int,
	@Value			money,
	@Authorization		varchar(50),
	@IDCashRegMov		int,
	@Parcela		varchar(20),
	@IDBankCheck		int,
	@CheckNumber		varchar(20),
	@CustomerDocument	varchar(20),
	@CustomerName		varchar(80),
	@CustomerPhone		varchar(20),
	@OBS			varchar(255),
	@PaymentPlace		int,
	@IsPreDatado		bit
	) AS

/* ----------------------------------------------------------------------------------------------------------------------
	SUMARIO
		- Pega as constantes
		- Insere o lancamento
		- Update CashReg TotalSales
		- Incluir crédito para o Cliente

	TABELA DE ERROS PARA RETURN_VALUE
		 000 Ok
		-201 Erro em Pega as constantes
		-202 Erro em Insere o lancamento
		-203 Erro em Update CashReg TotalSales
		-204 Erro em Incluir crédito para o Cliente
		-205 Erro em Incluir em Sal_AccountCard
		-206 Erro em Incluir em Sal_StoreAccount

	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	----------------------- ----------------------- -----------------------------------------------------------------
	26 May	2000		Eduardo Costa		Suporte ao novo financeiro;
	27 Jun	2001		Davi Gouveia		Log de Return Values;
	28 Jul	2001		Rodrigo Costa		Atualizar o CashReg TotalSales;
	21 Oct	2003		Rodrigo Costa		Chamada a sp_Sis_GetNextCode para @IDLancamento; 
							Criado @IDLancamento;
	15 Oct	2004		Carlos Lima		Incluídos novos campos no Fin_Lancamento;
	27 Sep	2004		Carlos Lima		Incluídos novo campo no no Fin_Lancamento (PaymentPlace);
	09 Nov	2004		Carlos Lima		Inclusão de Crédito;
	10 Nov	2004		Carlos Lima		Inclusão do campo IDLancamento quando inclui Crédito;
	07 Jan	2005		Carlos Lima		Inclusão do parâmetro IsPredatado;
	23 Mar	2006		Carlos Lima		Suporte ao Gift Card ( Chamada para a procedure que inclui em Sal_AccountCard );
	16 May	2006		Maximiliano Muniz	Calcula da data de vencimento do Lancamento, com base no MeioPag;
	16 Jun	2006		Rodrigo Costa		Adicionado os parametros para ErrorHistory;
	02 May	2007		Maximiliano Muniz	Alteração na query que pega as constantes;
	16 Jul	2007		Maximiliano Muniz	Pegar o IDCentroCusto do tipo de lançamento;
	07 Apr	2008		Rodrigo Costa		Inserir no Store Account;
	21 Jul	2008		Rodrigo Costa		Inserir valor do MeioPag para loja
	--------------------------------------------------------------------------------------------------------------- */

DECLARE @IDCentroCusto		int
DECLARE @IDCentroCustoSug	int
DECLARE @HasCentroCusto		bit
DECLARE @IDContaCorrente	int
DECLARE @IDEmpresa		int
DECLARE @ErrorLevel		int
DECLARE @IDLancamento		int
DECLARE @Tipo			int
DECLARE @IDCustomerCredit	int
DECLARE @IDStoreAccount		int
DECLARE @DueDate		smalldatetime
DECLARE @PrazoRec		int
DECLARE @SysError		int

SET @ErrorLevel = 0

-- Pega as constantes
SELECT
	@IDCentroCusto = S.IDCentroCusto,
	@IDEmpresa = S.IDEmpresa
FROM
	Store S (NOLOCK) 
WHERE
	S.IDStore = @IDStore

SELECT
	@HasCentroCusto = SugereCentroCusto,
	@IDCentroCustoSug = IDCentroCusto
FROM
	Fin_LancamentoTipo LT (NOLOCK) 
WHERE
	LT.IDLancamentoTipo = 2

IF @HasCentroCusto = 1
BEGIN
	SET @IDCentroCusto = @IDCentroCustoSug
END

SELECT
	@IDContaCorrente = IsNull(MPTS.IDContaCorrente, MP.IDContaCorrente),
	@PrazoRec = IsNull(MPTS.ReceivingDay, 0)
FROM
	MeioPag MP (NOLOCK) 
	LEFT JOIN MeioPag MPB (NOLOCK) ON (MPB.IDMeioPag = MP.IDMeioPagBatch)
	LEFT JOIN MeioPagToStore MPTS (NOLOCK) ON (MPTS.IDMeioPag = MP.IDMeioPagBatch AND MPTS.IDStore = @IDStore)
WHERE
	MP.IDMeioPag = @IDMeioPag

SELECT
	@Tipo = Tipo,
	@DueDate = DateAdd(Day, IsNull(PrazoRecebimento, 0), @ExpirationDate)
FROM
	MeioPag (NOLOCK) 
WHERE
	IDMeioPag = @IDMeioPag

IF (@PrazoRec <> 0)
	SET @DueDate = DateAdd(Day, @PrazoRec, @ExpirationDate)

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
            SET @ErrorLevel = -201
            GOTO ERRO
END
 
-- Insere o lancamento
EXEC sp_Sis_GetNextCode 'Fin_Lancamento.IDLancamento', @IDLancamento OUTPUT
INSERT Fin_Lancamento (
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
		IsPreDatado)
VALUES (
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
		@DueDate,
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
		@IsPreDatado)

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
            SET @ErrorLevel = -202
            GOTO ERRO
END

/*--------------------------------------------------------------------------------------------------------*/
/*                     Update Cash RegisterMovent se nao for Store Account                             */
/*--------------------------------------------------------------------------------------------------------*/
UPDATE
            CashRegMov
SET
            CashRegMov.TotalSales = IsNull(dbo.CashRegMov.TotalSales, 0) + ROUND(IsNull(@Value,0),2)
WHERE
            CashRegMov.IDCashRegMov = @IDCashRegMov 

SET @SysError = @@ERROR
IF @SysError <> 0
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

	SET @SysError = @@ERROR
	IF @SysError <> 0
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

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
	            SET @ErrorLevel = -205
	            GOTO ERRO
	END
END


/*----------------------------------------------------------------*/
/*		Store Account		*/
/*----------------------------------------------------------------*/
IF (@Tipo = 9)
BEGIN
	EXEC sp_PreSale_AddStoreAccount @IDCliente, @IDUser, @IDStore, @IDLancamento, @PreSaleDate, @Value, @IDStoreAccount OUTPUT

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
	            SET @ErrorLevel = -206
	            GOTO ERRO
	END
END

OK:
            RETURN 0
ERRO:
            PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(510)
	DECLARE @Params varchar(500)	

	SET @Params = ' [ @IDStore = ' + CAST(@IDStore AS VARCHAR) + 
			' @IDUser = ' + CAST(@IDUser AS VARCHAR) +  
			' @IDCliente = ' + CAST(@IDCliente AS VARCHAR) + 
			' @PreSaleID = '  + CAST(@PreSaleID AS VARCHAR) + 
			' @IDMeioPag = '  + CAST(@IDMeioPag AS VARCHAR) + 
			' @IDCashRegMov = '  + CAST(@IDCashRegMov AS VARCHAR) +
			' @IDBankCheck = '  + CAST(@IDBankCheck AS VARCHAR) + 
			' @Value = '  + CAST(@Value AS VARCHAR) +  ' ] '

	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR) + @Params
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PreSale_AddParcela', @ErrorLevelStr

	RETURN @ErrorLevel
GO

