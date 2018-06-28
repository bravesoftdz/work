if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_CashRegister_Quita_Lancamento]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_CashRegister_Quita_Lancamento]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_CashRegister_SubClose]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_CashRegister_SubClose]
GO

CREATE PROCEDURE sp_CashRegister_Quita_Lancamento
	(
	@IDUsuario		int,
	@Date			Datetime
	)
 AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Insere os registros de quitacao, para os invoices
		- Insiro os Account Payable com as taxas de admim
                - Insere as ligacoes entre Lancamento e Quitacao

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Insere os registros de quitacao, para os invoices
		-202  Erro em Insiro os Account Payable com as taxas de admim
		-203  Erro em Insere as ligacoes entre Lancamento e Quitacao


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	27 Oct	2004		Carlos Lima		Criação
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

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
DECLARE @IDLancamento 			int
DECLARE @DataVencimento 		smalldatetime
DECLARE @DataLancamento 		smalldatetime
DECLARE @ValorNominal 			TValor
DECLARE @IDQuitacaoMeioPrevisto 	int
DECLARE @IDUsuarioLancamento 		int
DECLARE @IDContaCorrentePrevista	int
DECLARE @IDEmpresa 			int
DECLARE @IDPessoa 			int
DECLARE @IDPessoaTipo 			int 
DECLARE @IDLancamentoTipo 		int 
DECLARE @IDCashRegMov			int

--Declaração do Cursor de Fin_Quitacao
DECLARE Fin_Quitacao_Cursor CURSOR FOR 
	(SELECT
		0,
		DateAdd(Day, MPB.PrazoRecebimento, @Date ),
		0, -- A LancQuit ira atualizar corretamente este valor
		MP.IDMeioPagBatch,
		@IDUsuario,
		0,
		Convert(Varchar(20), L.IDCashRegMov),
		MPTS.IDContaCorrente,
		L.IDCashRegMov
	FROM
		#CloseCash CC
		JOIN
		Fin_Lancamento L on (CC.IDlancamento = L.IDLancamento and CC.IDCashRegMov = L.IDCashRegMov)
		JOIN
		Invoice I on ( I.IDPresale = L.IDPreSale )
		JOIN 
		MeioPag MP on ( MP.IDMeioPag = L.IDQuitacaoMeioPrevisto )
		JOIN 
		MeioPag MPB on ( MPB.IDMeioPag = MP.IDMeioPagBatch )
		JOIN 
		MeioPagToStore MPTS ON (MPTS.IDMeioPag = MP.IDMeioPagBatch AND MPTS.IDStore = I.IDStore)
	WHERE
		L.DataLancamento = L.DataVencimento -- Somente os lancamento a vista
		AND
		MP.IDMeioPagBatch IS NOT NULL
	GROUP BY
		DateAdd(Day, MPB.PrazoRecebimento, @Date ),
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
		DateAdd(Day, MPB.PrazoRecebimento, @Date ),
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
		#CloseCash TCC
		JOIN
		Fin_Lancamento L on (TCC.IDlancamento = L.IDLancamento and TCC.IDCashRegMov = L.IDCashRegMov)
		JOIN 
		Invoice I on ( I.IDPresale = L.IDPreSale )
		JOIN 
		MeioPag MP on ( MP.IDMeioPag = L.IDQuitacaoMeioPrevisto )
		JOIN 
		MeioPag MPB on ( MPB.IDMeioPag = MP.IDMeioPagBatch )
		JOIN 
		MeioPagToStore MPTS ON (MPTS.IDMeioPag = MP.IDMeioPagBatch AND MPTS.IDStore = I.IDStore)
		JOIN 
		Fin_ContaCorrente CC ON (MPTS.IDContaCorrente = CC.IDContaCorrente)
		JOIN 
		Pessoa P ON (MPB.IDPessoa = P.IDPessoa)
	WHERE
		MPB.AutoDiscountFee = 1
		AND
		L.DataLancamento = L.DataVencimento -- Somente os lancamento a vista
		AND
		MPB.IDLancamentoTipo IS NOT NULL
		AND
		MPB.IDPessoa IS NOT NULL
		AND
		IsNull(MPB.TaxaAdmin, 0) <> 0
	GROUP BY
		DateAdd(Day, MPB.PrazoRecebimento, @Date ),
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
	EXEC sp_Sis_GetNextCode 'Fin_Quitacao.IDLancamento', @IDLancamento OUTPUT

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
		#CloseCash TCC
		JOIN
		Fin_Lancamento L ON (TCC.IDlancamento = L.IDLancamento and TCC.IDCashRegMov = L.IDCashRegMov)
		JOIN
		MeioPag MP ON (L.IDQuitacaoMeioPrevisto = MP.IDMeioPag)
		JOIN
		Fin_Quitacao Q ON (MP.IDMeioPagBatch = Q.IDQuitacaoMeio and Q.SparrowInt = L.IDCashRegMov)
	WHERE
		Q.IDQuitacao NOT IN 
			(
			SELECT
				IDQuitacao	
			FROM
				Fin_LancQuit
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
	RETURN @ErrorLevel

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_CashRegister_Quita_Lancamento', @ErrorLevelStr

	RETURN @ErrorLevel
GO

CREATE PROCEDURE sp_CashRegister_SubClose
		(
		@IDCashRegMov   	int,
		@IDUser		int,
		@IDUsuario		int,
		@TotalCash		money,
		@TotalCard		money,
		@TotalCardPre		money,
		@TotalCheck		money,
		@TotalOther 		money,
		@FinalCount		money,
		@LogDocument		varchar(20),
		@Date			Datetime,
		@IDCashRegLog	int  output
		)
AS


/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO
		
		- Testa se o final deposit ja foi feito
		- Update Final Deposit no CashRegMov
		- Insere no CashRegLog
		- Executa sp_CashRegister_Quita_Lancamento


	TABELA DE ERROS PARA RETURN_VALUE
	
		 000  Ok
		-001  Se deposito final ja foi feito
		-201  Erro em Update Final Deposit no CashRegMov
		-202  Erro em Insere no CashRegLog
		-203  Erro em Executa sp_CashRegister_Quita_Lancamento


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	21 Oct 2000		Carlos Lima		Criacao;
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */


DECLARE @ErrorLevel 	int
DECLARE @SysError 	INT

SET @ErrorLevel = 0

/* Testa se o final deposit ja foi feito */
if EXISTS (SELECT IDCashRegLog FROM CashRegLog WHERE IDCashRegMov = @IDCashRegMov AND IDCashRegTipoLog = 4) 
   RETURN -1


/*	Update Final Deposit no CashRegMov    */
BEGIN TRANSACTION 

UPDATE
	CashRegMov 
SET	
	FinalWidraw      		= @TotalCash + @TotalCard + @TotalCardPre + @TotalCheck + @TotalOther,
	FinalCount     		= @FinalCount,   	
	IDCashRegStatus  	= 2 
WHERE 
	IDCashRegMov = @IDCashRegMov

PRINT 'Update Final Deposit no CashRegMov'

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END

/*	Insere no CashRegLog            */
/******************************************************************************
	Obtenho o @IDCashRegLog
*******************************************************************************/

EXEC sp_Sis_GetNextCode 'CashRegLog.IDCashRegLog', @IDCashRegLog OUTPUT
INSERT CashRegLog
	(
	IDCashRegLog,
	IDCashRegMov,
	IDCashRegTipoLog,
	LogTime,
	IDUser,
	Bill100,
	Bill50,
	Bill20,
	Bill10,
	Bill5,
	Bill2,
	Bill1,
	Coin1,
	Coin050,
	Coin025,
	Coin010,
	Coin005,
	Coin001,
	TotalCash,		
	TotalCard,
	TotalCardPre,	
	TotalCheck,
	TotalOther,
	LogDocument		
	)
	VALUES
	(
	@IDCashRegLog,
	@IDCashRegMov,
	4,
	@Date,
	@IDUser,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	@TotalCash,		
	@TotalCard,
	@TotalCardPre,
	@TotalCheck,
	@TotalOther,
	@LogDocument
	)

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -202
	GOTO ERRO
END

EXEC sp_CashRegister_Quita_Lancamento @IDUser, @Date

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -203
	GOTO ERRO
END

OK:	
	COMMIT TRANSACTION 
	RETURN 0


ERRO:
	ROLLBACK
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_CashRegister_SubClose', @ErrorLevelStr

	RETURN @ErrorLevel
GO
