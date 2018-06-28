SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_PreSale_AddParcela]
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
	03 Set	2009		Rodrigo Costa		Inserir o valor do LancamentoTipo
	--------------------------------------------------------------------------------------------------------------- */

DECLARE @IDCentroCusto		int
DECLARE @IDCentroCustoSug	int
DECLARE @HasCentroCusto		bit
DECLARE @IDContaCorrente	int
DECLARE @IDEmpresa		int
DECLARE @ErrorLevel		int
DECLARE @Tipo			int
DECLARE @IDCustomerCredit	int
DECLARE @IDStoreAccount		int
DECLARE @DueDate		smalldatetime
DECLARE @PrazoRec		int
DECLARE @SysError		int
DECLARE @IDLancamento		int
DECLARE @IDLancamentoTipo	int

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
	@HasCentroCusto = LT.SugereCentroCusto,
	@IDCentroCustoSug = LT.IDCentroCusto,
	@IDLancamentoTipo = IsNull(LT.IDLancamentoTipo,2),
	@Tipo = MP.Tipo,
	@DueDate = DateAdd(Day, IsNull(MP.PrazoRecebimento, 0), @ExpirationDate)
FROM
	Fin_LancamentoTipo LT (NOLOCK)
	JOIN MeioPag MP (NOLOCK) ON (LT.IDLancamentoTipo = MP.IDLancamentoTipo)
WHERE
	MP.IDMeioPag = @IDMeioPag

IF (@PrazoRec <> 0)
	SET @DueDate = DateAdd(Day, @PrazoRec, @ExpirationDate)


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
		@IDLancamentoTipo,
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
