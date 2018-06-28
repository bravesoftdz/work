IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[sp_Commission_PayVendedor]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[sp_Commission_PayVendedor]
GO

CREATE PROCEDURE sp_Commission_PayVendedor
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
	Store S
	JOIN MeioPagToStore MPS ON (S.IDStore = MPS.IDStore)
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
			Fin_Lancamento L
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
		IDLancPag
		)
		SELECT
			IM.PreInventoryMovID,
			@IDLancamento
		FROM
			InventoryMov IM (NOLOCK)
			JOIN SaleItemCommission SIC ON (SIC.IDInventoryMov = IM.IDInventoryMov)
			JOIN Invoice I ON (I.IDInvoice = IM.DocumentID)
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
			IDLancPag
			)
			SELECT
				IM.PreInventoryMovID,
				@IDLancamento
			FROM
				InventoryMov IM (NOLOCK)
				JOIN SaleItemCommission SIC ON (SIC.IDInventoryMov = IM.IDInventoryMov)
				JOIN Invoice I ON (I.IDInvoice = IM.DocumentID)
				LEFT OUTER JOIN ComisPaga CP ON (IM.IDInventoryMov = CP.IDDocumento)
			WHERE
				SIC.IDCommission = @IDVendedor
				AND IM.InventMovTypeID = 1
				AND I.PreSaleDate >= @DataIni
				AND I.PreSaleDate < @DataFim
				AND CP.IDLancPag IS NULL

		INSERT ComisPaga
			(
			IDDocumento,
			IDLancPag
			)
			SELECT
				PIM.IDPreInventoryMov,
				@IDLancamento
			FROM
				PreInventoryMov PIM (NOLOCK)
				JOIN SaleItemCommission SIC ON (SIC.IDPreInventoryMov = PIM.IDPreInventoryMov)
				JOIN Invoice I ON (I.IDPreSale = PIM.DocumentID)
				LEFT OUTER JOIN ComisPaga CP ON (PIM.IDPreInventoryMov = CP.IDDocumento)
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
			IDLancPag
			)
			SELECT
				IM.PreInventoryMovID,
				@IDLancamento
			FROM
				InventoryMov IM (NOLOCK)
				JOIN SaleItemCommission SIC ON (SIC.IDInventoryMov = IM.IDInventoryMov)
				JOIN Invoice I ON (I.IDInvoice = IM.DocumentID)
				LEFT OUTER JOIN ComisPaga CP ON (IM.IDInventoryMov = CP.IDDocumento)
			WHERE
				SIC.IDCommission = @IDVendedor
				AND IM.InventMovTypeID = 1
				AND I.PreSaleDate >= @DataIni
				AND I.PreSaleDate < @DataFim
				AND CP.IDLancPag IS NULL
				AND I.IDPreSale IN (SELECT IDPreSale FROM Fin_Lancamento)

		INSERT ComisPaga
			(
			IDDocumento,
			IDLancPag
			)
			SELECT
				PIM.IDPreInventoryMov,
				@IDLancamento
			FROM
				PreInventoryMov PIM (NOLOCK)
				JOIN SaleItemCommission SIC ON (SIC.IDPreInventoryMov = PIM.IDPreInventoryMov)
				JOIN Invoice I ON (I.IDPreSale = PIM.DocumentID)
				LEFT OUTER JOIN ComisPaga CP ON (PIM.IDPreInventoryMov = CP.IDDocumento)
			WHERE
				SIC.IDCommission = @IDVendedor
				AND PIM.InventMovTypeID = 1
				AND I.PreSaleDate >= @DataIni
				AND I.PreSaleDate < @DataFim
				AND CP.IDLancPag IS NULL
				AND I.IDPreSale IN (SELECT IDPreSale FROM Fin_Lancamento)

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
