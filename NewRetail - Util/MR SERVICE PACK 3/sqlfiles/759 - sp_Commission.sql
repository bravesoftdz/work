if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Commission_CalcVendedor]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Commission_CalcVendedor]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Commission_PayVendedor]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Commission_PayVendedor]
GO

CREATE  PROCEDURE sp_Commission_CalcVendedor
		(
		@IDVendedor	int,
		@DataInicio	SmallDateTime,
		@DataFim	SmallDateTime,
		@IsPre		bit,
		@IsPaid		bit,
		@Commission	money output,
		@Extorno	money output,
		@Correcao	money output
		)
AS

/* ---------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Calcula a comissao do Sales Person
		- Calcula a divida do Vendedor
		- Calcula o Extorno do Vendedor
		- Calcula o Credito do Vendedor


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	-----------------------	-----------------------	----------------------------------------------------------------------------------
	19 Jun	2001		Eduardo Costa		Criação;
	14 Apr	2005		Rodrigo Costa		Calculo de comissao incluindo o PreSale;
	10 Sep	2007		Maximiliano Muniz	Cálculo por pagamento cadastrado;
	---------------------------------------------------------------------------------------------------------------------------------- */

IF NOT (@IDVendedor > 0)
	RETURN

----------------------------------------------------------------------------------
--			Calcula a comissao do Sales Person			--
----------------------------------------------------------------------------------
-- Lembrar de caso esteja setado no grupo, descontar a coordenacao da agencia da comissao do guia

IF @IsPre = 0
BEGIN
	SELECT
		@Commission = IsNull(SUM(IsNull(C.MovCommission * M.PayComission, 0)), 0)
	FROM
		Invoice I (NOLOCK)
		JOIN Media M (NOLOCK) ON (I.MediaID = M.IDMedia)
		JOIN vwCommission C (NOLOCK) ON (C.InventMovTypeID = 1 AND I.IDInvoice = C.DocumentID)
		JOIN Pessoa PSP (NOLOCK) ON (C.ComissionID = PSP.IDPessoa AND C.IDTipoPessoa = PSP.IDTipoPessoa)
		LEFT OUTER JOIN ComisPaga CP (NOLOCK) ON (C.IDPreInventoryMov = CP.IDDocumento AND CP.IDPessoa = @IDVendedor)
	WHERE
		C.ComissionID = @IDVendedor
		AND I.InvoiceDate >= @DataInicio
		AND I.InvoiceDate < @DataFim
		AND CP.IDLancPag IS NULL
		AND IsNull(I.Canceled, 0) = 0
END
ELSE
BEGIN
	IF @IsPaid = 0
	BEGIN
		SELECT
			@Commission = IsNull(SUM(IsNull(C.MovCommission * M.PayComission, 0)), 0)
		FROM
			Invoice I (NOLOCK)
			JOIN Media M (NOLOCK) ON (I.MediaID = M.IDMedia)
			JOIN vwCommission C (NOLOCK) ON (C.InventMovTypeID = 1 AND I.IDInvoice = C.DocumentID)
			JOIN Pessoa PSP (NOLOCK) ON (C.ComissionID = PSP.IDPessoa AND C.IDTipoPessoa = PSP.IDTipoPessoa)
			LEFT OUTER JOIN ComisPaga CP (NOLOCK) ON (C.IDPreInventoryMov = CP.IDDocumento AND CP.IDPessoa = @IDVendedor)
		WHERE
			C.ComissionID = @IDVendedor
			AND I.PreSaleDate >= @DataInicio
			AND I.PreSaleDate < @DataFim
			AND CP.IDLancPag IS NULL
			AND IsNull(I.Canceled, 0) = 0

		SELECT
			@Commission = @Commission + IsNull(SUM(IsNull(C.ItemCommis * M.PayComission,0)), 0)
		FROM
			Invoice I (NOLOCK)
			JOIN Media M (NOLOCK) ON (I.MediaID = M.IDMedia)
			JOIN vwSaleItem C (NOLOCK) ON (I.IDPreSale = C.DocumentID AND C.Invoice = 0)
			JOIN Pessoa PSP (NOLOCK) ON (C.ComissionID = PSP.IDPessoa AND C.IDTipoPessoa = PSP.IDTipoPessoa)
			LEFT OUTER JOIN ComisPaga CP (NOLOCK) ON (C.IDPreInventoryMov = CP.IDDocumento AND CP.IDPessoa = @IDVendedor)
		WHERE
			C.ComissionID = @IDVendedor
			AND I.PreSaleDate >= @DataInicio
			AND I.PreSaleDate < @DataFim
			AND CP.IDLancPag IS NULL
			AND IsNull(I.Canceled, 0) = 0
	END
	ELSE
	BEGIN
		SELECT
			@Commission = IsNull(SUM(IsNull(C.MovCommission * M.PayComission, 0)), 0)
		FROM
			Invoice I (NOLOCK)
			JOIN Media M (NOLOCK) ON (I.MediaID = M.IDMedia)
			JOIN vwCommission C (NOLOCK) ON (C.InventMovTypeID = 1 AND I.IDInvoice = C.DocumentID)
			JOIN Pessoa PSP (NOLOCK) ON (C.ComissionID = PSP.IDPessoa AND C.IDTipoPessoa = PSP.IDTipoPessoa)
			LEFT OUTER JOIN ComisPaga CP (NOLOCK) ON (C.IDPreInventoryMov = CP.IDDocumento AND CP.IDPessoa = @IDVendedor)
		WHERE
			C.ComissionID = @IDVendedor
			AND I.PreSaleDate >= @DataInicio
			AND I.PreSaleDate < @DataFim
			AND CP.IDLancPag IS NULL
			AND IsNull(I.Canceled, 0) = 0
			AND I.IDPreSale IN (SELECT IDPreSale FROM Fin_Lancamento)

		SELECT
			@Commission = @Commission + IsNull(SUM(IsNull(C.ItemCommis * M.PayComission,0)), 0)
		FROM
			Invoice I (NOLOCK)
			JOIN Media M (NOLOCK) ON (I.MediaID = M.IDMedia)
			JOIN vwSaleItem C (NOLOCK) ON (I.IDPreSale = C.DocumentID AND C.Invoice = 0)
			JOIN Pessoa PSP (NOLOCK) ON (C.ComissionID = PSP.IDPessoa AND C.IDTipoPessoa = PSP.IDTipoPessoa)
			LEFT OUTER JOIN ComisPaga CP (NOLOCK) ON (C.IDPreInventoryMov = CP.IDDocumento AND CP.IDPessoa = @IDVendedor)
		WHERE
			C.ComissionID = @IDVendedor
			AND I.PreSaleDate >= @DataInicio
			AND I.PreSaleDate < @DataFim
			AND CP.IDLancPag IS NULL
			AND IsNull(I.Canceled, 0) = 0
			AND I.IDPreSale IN (SELECT IDPreSale FROM Fin_Lancamento)
	END
END

--------------------------------------------------------------------------
--			Calcula a divida do Vendedor			--
--------------------------------------------------------------------------

--EXEC sp_Commission_CalcDivida @IDVendedor, @Date, @Divida

--------------------------------------------------------------------------
--			Calcula o Extorno do Vendedor			--
--------------------------------------------------------------------------
SELECT	@Extorno = IsNull((
				SELECT
					SUM (L.ValorNominal - L.TotalQuitado)
				FROM
					Fin_Lancamento L (NOLOCK)
				WHERE
					L.IDPessoa = @IDVendedor
					AND L.Situacao in (1, 5) --1=Aberto, 5=ParteQuitado
					AND L.IDLancamentoTipo = 3 --Despesas\Extorno de Comissao
			), 0)

--------------------------------------------------------------------------
--			Calcula o Credito do Vendedor			--
--------------------------------------------------------------------------
SELECT	@Correcao = IsNull((
				SELECT
					SUM (L.ValorNominal - L.TotalQuitado)
				FROM
					Fin_Lancamento L (NOLOCK)
				WHERE
					L.IDPessoa = @IDVendedor
					AND L.Situacao in (1, 5)  --1=Aberto, 5=ParteQuitado
					AND L.IDLancamentoTipo = 5 --Despesas\Correcao de comissao
			), 0)


GO

CREATE  PROCEDURE sp_Commission_PayVendedor
	(
	@IDStore		int,
	@IDVendedor		int,
	@PayDate		smalldatetime,
	@IDMeioPag		int,
	@IDContaCorrente	int,
	@Commission		money,
	@DataIni		smalldatetime,
	@DataFim		smalldatetime,
	@IDUser			int,
	@IsPre			bit,
	@IsPaid			bit,
	@IDLancamento		int output
	)
AS

/* ---------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Seleciono os Centro de Custo
		- Incluo no Fin_Lancamento

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Select Centro Custo
		-202  Erro em Insert Fin_Lancamento
		-203  Erro em Insert Fin_Quitacao
		-204  Erro em Insert ComisPaga InvMov
		-206  Erro em Insert ComisPaga PreInvMov

	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	-----------------------	-----------------------	----------------------------------------------------------------------------------
	26 May	2000		Eduardo Costa		Suporte ao novo financeiro;
	27 Oct	2003		André Bogado		Chamada a sp_Sis_GetNextCode;
	18 Aug	2004		Rodrigo Costa		Gravar error log;
	08 Apr	2005		Rodrigo Costa		Gravar Comis Pag para PreInvMov;
	10 Sep	2007		Maximiliano Muniz	Insert de pagamento para pedidos pagos conforme novo parametro;
	---------------------------------------------------------------------------------------------------------------------------------- */

DECLARE @IDQuitacao	int
DECLARE @IDCentroCusto	int
DECLARE @IDEmpresa	int
DECLARE @ErrorLevel	int
DECLARE @SysError	int

IF NOT (@IDVendedor > 0)
	RETURN

BEGIN TRAN

-- Pega as constantes
SELECT 	
	@IDCentroCusto = S.IDCentroCusto,
	@IDEmpresa = S.IDEmpresa
FROM
	Store S (NOLOCK)
	JOIN MeioPagToStore MPS (NOLOCK) ON (S.IDStore = MPS.IDStore)
WHERE
	S.IDStore = @IDStore
	AND MPS.IDMeioPag = @IDMeioPag

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END

----------------------------------------------------------
--		Inclui o registro do pagamento		--
----------------------------------------------------------

-- Obtenho o @IDLancamento
exec sp_Sis_GetNextCode 'Fin_Lancamento.IDLancamento', @IDLancamento OUTPUT

INSERT Fin_Lancamento
		(
		IDLancamento,
		IDLancamentoTipo,
		Pagando,
		IDCentroCusto,
		IDEmpresa,
		IDPessoaTipo,
		IDPessoa,
		IDDocumentoTipo,
		IDMoeda,
		IDMoedaCotacao,
		DataLancamento,
		DataVencimento,
		ValorNominal,
		IDUsuarioLancamento,
		Situacao
		)
		VALUES
		(
		@IDLancamento,
		6, --  \\Despesa\Comissoes\Pagamento Comissoes
		1,
		@IDCentroCusto,
		@IDEmpresa,
		4, -- Sales Person
		@IDVendedor,
		0, -- Temporario
		4, -- Dollares
		6, -- CotacaoPadrao do Dollar 
		@PayDate,
		@PayDate,
		@Commission,
		@IDUser,
		1 -- Situacao esta aberto
		)

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -202
	GOTO ERRO
END

--------------------------------------------------
--		Inclui a quitacao		--
--------------------------------------------------

-- Obtenho o @IDQuitacao
exec sp_Sis_GetNextCode 'Fin_Quitacao.IDQuitacao', @IDQuitacao OUTPUT

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
		0, --Valor da comissao tem que ser 0, pois a trigger da LancQuit vai atualizar esse valor
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

-- Liga as duas
INSERT	Fin_LancQuit
		(
		IDLancamento,
		IDQuitacao,
		ValorQuitado,
		ValorJuros,
		IDUsuarioQuitacao
		)
		(
		SELECT
			L.IDLancamento,
			@IDQuitacao,
			(L.ValorNominal - L.TotalQuitado),
			0,
			@IDUser
		FROM
			Fin_Lancamento L (NOLOCK)
		WHERE
			L.IDPessoa = @IDVendedor
			AND L.Situacao in (1, 5) --1=Aberto, 5=ParteQuitado
			AND	(
				L.IDLancamento = @IDLancamento
				OR L.IDLancamentoTipo = 3 -- Correcao de comissao
				OR L.IDLancamentoTipo = 5 -- Extorno de comissao
				)
		)

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -204
	GOTO ERRO
END

--------------------------------------------------------------------------
--		Registra o pagamento nas linhas de inventario		--
--------------------------------------------------------------------------
IF @IsPre = 0
BEGIN
	INSERT ComisPaga
		(
		IDDocumento,
		IDLancPag,
		IDPessoa
		)
		SELECT
			IM.PreInventoryMovID,
			@IDLancamento,
			@IDVendedor
		FROM
			InventoryMov IM (NOLOCK)
			JOIN SaleItemCommission SIC (NOLOCK) ON (SIC.IDInventoryMov = IM.IDInventoryMov)
			JOIN Invoice I (NOLOCK) ON (I.IDInvoice = IM.DocumentID)
			LEFT OUTER JOIN ComisPaga CP ON (IM.IDInventoryMov = CP.IDDocumento )
		WHERE
			SIC.IDCommission = @IDVendedor
			AND IM.InventMovTypeID = 1
			AND I.InvoiceDate >= @DataIni
			AND I.InvoiceDate < @DataFim
			AND CP.IDLancPag IS NULL

	SET @SysError = @@ERROR
	IF @SysError <> 0  
	BEGIN
		SET @ErrorLevel = -205
		GOTO ERRO
	END
END
ELSE
BEGIN
	IF @IsPaid = 0
	BEGIN
		INSERT ComisPaga
			(
			IDDocumento,
			IDLancPag,
			IDPessoa
			)
			SELECT
				IM.PreInventoryMovID,
				@IDLancamento,
				@IDVendedor
			FROM
				InventoryMov IM (NOLOCK)
				JOIN SaleItemCommission SIC (NOLOCK) ON (SIC.IDInventoryMov = IM.IDInventoryMov)
				JOIN Invoice I (NOLOCK) ON (I.IDInvoice = IM.DocumentID)
				LEFT OUTER JOIN ComisPaga CP (NOLOCK) ON (IM.IDInventoryMov = CP.IDDocumento)
			WHERE
				SIC.IDCommission = @IDVendedor
				AND IM.InventMovTypeID = 1
				AND I.PreSaleDate >= @DataIni
				AND I.PreSaleDate < @DataFim
				AND CP.IDLancPag IS NULL

		INSERT ComisPaga
			(
			IDDocumento,
			IDLancPag,
			IDPessoa
			)
			SELECT
				PIM.IDPreInventoryMov,
				@IDLancamento,
				@IDVendedor
			FROM
				PreInventoryMov PIM (NOLOCK)
				JOIN SaleItemCommission SIC (NOLOCK) ON (SIC.IDPreInventoryMov = PIM.IDPreInventoryMov)
				JOIN Invoice I (NOLOCK) ON (I.IDPreSale = PIM.DocumentID)
				LEFT OUTER JOIN ComisPaga CP (NOLOCK) ON (PIM.IDPreInventoryMov = CP.IDDocumento)
			WHERE
				SIC.IDCommission = @IDVendedor
				AND PIM.InventMovTypeID = 1
				AND I.PreSaleDate >= @DataIni
				AND I.PreSaleDate < @DataFim
				AND CP.IDLancPag IS NULL

		SET @SysError = @@ERROR
		IF @SysError <> 0
		BEGIN
			SET @ErrorLevel = -206
			GOTO ERRO
		END
	END
	ELSE
	BEGIN
		INSERT ComisPaga
			(
			IDDocumento,
			IDLancPag,
			IDPessoa
			)
			SELECT
				IM.PreInventoryMovID,
				@IDLancamento,
				@IDVendedor
			FROM
				InventoryMov IM (NOLOCK)
				JOIN SaleItemCommission SIC (NOLOCK) ON (SIC.IDInventoryMov = IM.IDInventoryMov)
				JOIN Invoice I (NOLOCK) ON (I.IDInvoice = IM.DocumentID)
				LEFT OUTER JOIN ComisPaga CP (NOLOCK) ON (IM.IDInventoryMov = CP.IDDocumento)
			WHERE
				SIC.IDCommission = @IDVendedor
				AND IM.InventMovTypeID = 1
				AND I.PreSaleDate >= @DataIni
				AND I.PreSaleDate < @DataFim
				AND CP.IDLancPag IS NULL
				AND I.IDPreSale IN (SELECT IDPreSale FROM Fin_Lancamento (NOLOCK))

		INSERT ComisPaga
			(
			IDDocumento,
			IDLancPag,
			IDPessoa
			)
			SELECT
				PIM.IDPreInventoryMov,
				@IDLancamento,
				@IDVendedor
			FROM
				PreInventoryMov PIM (NOLOCK)
				JOIN SaleItemCommission SIC (NOLOCK) ON (SIC.IDPreInventoryMov = PIM.IDPreInventoryMov)
				JOIN Invoice I (NOLOCK) ON (I.IDPreSale = PIM.DocumentID)
				LEFT OUTER JOIN ComisPaga CP (NOLOCK) ON (PIM.IDPreInventoryMov = CP.IDDocumento)
			WHERE
				SIC.IDCommission = @IDVendedor
				AND PIM.InventMovTypeID = 1
				AND I.PreSaleDate >= @DataIni
				AND I.PreSaleDate < @DataFim
				AND CP.IDLancPag IS NULL
				AND I.IDPreSale IN (SELECT IDPreSale FROM Fin_Lancamento (NOLOCK))

		SET @SysError = @@ERROR
		IF @SysError <> 0
		BEGIN
			SET @ErrorLevel = -206
			GOTO ERRO
		END
	END
END

OK:
	COMMIT TRAN
	RETURN 0
ERRO:
	ROLLBACK TRAN
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_Commission_PayVendedor', @ErrorLevelStr

	RETURN @ErrorLevel
GO
