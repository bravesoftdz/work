if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Commission_CalcVendedor]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Commission_CalcVendedor]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Commission_PayVendedor]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Commission_PayVendedor]
GO

CREATE PROCEDURE sp_Commission_CalcVendedor
		(
		@IDVendedor 		int,
		@DataInicio		SmallDateTime,
		@DataFim		SmallDateTime,
		@IsPre			bit,
		@Commission		money	output,
		@Extorno 		money	output,
		@Correcao 		money	output
		)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Calcula a comissao do Sales Person
		- Calcula a divida do Vendedor
		- Calcula o Extorno do Vendedor
		- Calcula o Credito do Vendedor


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	19 June 2001   		Eduardo Costa		Criação;
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */



if not (@IDVendedor > 0)
   return


-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 	Calcula a comissao do Sales Person
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


-- Lembrar de caso esteja setado no grupo, descontar a coordenacao da agencia da comissao do guia

SELECT
	@Commission = IsNull(SUM(IsNull(C.MovCommission*M.PayComission,0)),0)
FROM
	Invoice I
	JOIN Media M
		ON (I.MediaID = M.IDMedia)
	JOIN vwCommission C
		ON (I.IDInvoice = C.DocumentID AND C.InventMovTypeID=1 )
	JOIN Pessoa PSP
		ON (C.ComissionID = PSP.IDPessoa AND C.IDTipoPessoa = PSP.IDTipoPessoa)
	LEFT OUTER JOIN ComisPaga CP
		ON (C.IDPreInventoryMov = CP.IDDocumento)
WHERE
	C.ComissionID = @IDVendedor
	AND
	I.InvoiceDate >= @DataInicio
	AND
	I.InvoiceDate < @DataFim
	AND
   	CP.IDLancPag IS NULL

IF (@IsPre=1)
BEGIN

	SELECT
		@Commission = @Commission + IsNull(SUM(IsNull(C.ItemCommis * M.PayComission,0)),0)
	FROM
		Invoice I
		JOIN Media M
			ON (I.MediaID = M.IDMedia)
		JOIN vwSaleItem C
			ON (I.IDPreSale = C.DocumentID AND C.Invoice=0 )
		JOIN Pessoa PSP
			ON (C.ComissionID = PSP.IDPessoa AND C.IDTipoPessoa = PSP.IDTipoPessoa)
		LEFT OUTER JOIN ComisPaga CP
			ON (C.IDPreInventoryMov = CP.IDDocumento)
	WHERE
		C.ComissionID = @IDVendedor
		AND
		I.PreSaleDate >= @DataInicio
		AND
		I.PreSaleDate < @DataFim
		AND
	   	CP.IDLancPag IS NULL
	
END

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 	Calcula a divida do Vendedor
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--EXEC sp_Commission_CalcDivida @IDVendedor, @Date, @Divida


/*------------------------------------------------------------------------------*/
/*  Calcula o Extorno do Vendedor		*/
/*------------------------------------------------------------------------------*/
SELECT	@Extorno = IsNull(
			(
			SELECT 	SUM ( L.ValorNominal - L.TotalQuitado)

			FROM 		Fin_Lancamento L

			WHERE	L.IDPessoa = @IDVendedor
					AND
					L.Situacao in (1,5)  --  1=Aberto, 5=ParteQuitado
					AND
					L.IDLancamentoTipo = 3    -- \\Despesas\Extorno de Comissao
			), 0)

/*------------------------------------------------------------------------------*/
/*  Calcula o Credito do Vendedor	 		*/
/*------------------------------------------------------------------------------*/
SELECT	@Correcao = IsNull(
			(
			SELECT 	SUM ( L.ValorNominal - L.TotalQuitado)

			FROM 		Fin_Lancamento L

			WHERE	L.IDPessoa = @IDVendedor
					AND
					L.Situacao in (1,5)  --  1=Aberto, 5=ParteQuitado
					AND
					L.IDLancamentoTipo = 5    -- \\Despesas\Correcao de comissao
			), 0)
GO

CREATE PROCEDURE sp_Commission_PayVendedor
		(
		@IDStore		int,
		@IDVendedor 		int,
		@PayDate		smalldatetime,
		@IDMeioPag		int,
		@IDContaCorrente   	int,
		@Commission		money,
		@DataIni		smalldatetime,
		@DataFim		smalldatetime,
		@IDUser		int,
		@IsPre			bit,
		@IDLancamento	int output
		)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
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
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	26 Maio 2000		Eduardo Costa		suporte ao novo financeiro;
	27 Oct	2003		André Bogado		Chamada a sp_Sis_GetNextCode
	18 Aug 2004		Rodrigo Costa		Gravar error log
	08 Apr	2005		Rodrigo Costa		Gravar Comis Pag para PreInvMov
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */


DECLARE @IDQuitacao		int
DECLARE @IDCentroCusto 	int
DECLARE @IDEmpresa		int
DECLARE @ErrorLevel		int
DECLARE @SysError		int

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
	AND
	MPS.IDMeioPag = @IDMeioPag

SET @SysError = @@ERROR
IF @SysError <> 0  
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END

/*----------------------------------------------------------------*/
/*		Inclui o registro do pagamento			  */
/*----------------------------------------------------------------*/



/*
   	Inclui o Lancamento
*/
/******************************************************************************
	Obtenho o @IDLancamento
*******************************************************************************/
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


/*
   	Inclui a quitacao
*/
/******************************************************************************
	Obtenho o @IDQuitacao
*******************************************************************************/
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

/*
	Liga as duas
*/
INSERT	Fin_LancQuit
		(
		IDLancamento,
		IDQuitacao,
		ValorQuitado,
		ValorJuros,
		IDUsuarioQuitacao
		)
		(
		SELECT 	L.IDLancamento,
				@IDQuitacao,
				(L.ValorNominal - L.TotalQuitado),
				0,
				@IDUser
		FROM		
				Fin_Lancamento L
		WHERE	
				L.IDPessoa = @IDVendedor
				AND
				L.Situacao in (1,5) -- 1=Aberto, 5=ParteQuitado
				AND
				(
				L.IDLancamento = @IDLancamento
				OR
				L.IDLancamentoTipo = 3 -- Correcao de comissao
				OR
				L.IDLancamentoTipo = 5 -- Extorno de comissao
				)
		)


SET @SysError = @@ERROR
IF @SysError <> 0  
BEGIN
	SET @ErrorLevel = -204
	GOTO ERRO
END

/*----------------------------------------------------------------*/
/*	Registra o pagamento nas linhas de inventario             */
/*----------------------------------------------------------------*/
INSERT ComisPaga
	(
	IDDocumento,
	IDLancPag
	)
	SELECT
		InvMov.PreInventoryMovID,
		@IDLancamento
	FROM
		dbo.InventoryMov         InvMov  (NOLOCK)
		JOIN Invoice I ON (I.IDInvoice = InvMov.DocumentID)
		LEFT OUTER JOIN 
		ComisPaga ON (InvMov.IDInventoryMov = ComisPaga.IDDocumento )
	WHERE
		( InvMov.ComissionID = @IDVendedor )
		AND	
		( InvMov.InventMovTypeID = 1 )
		AND
		( I.InvoiceDate >= @DataIni )
		AND
		( I.InvoiceDate < @DataFim )
		AND
		( ComisPaga.IDLancPag IS NULL )

SET @SysError = @@ERROR
IF @SysError <> 0  
BEGIN
	SET @ErrorLevel = -205
	GOTO ERRO
END

IF (@IsPre = 1)
BEGIN

	INSERT ComisPaga
		(
		IDDocumento,
		IDLancPag
		)
		SELECT
			PIM.IDPreInventoryMov,
			@IDLancamento
		FROM
			PreInventoryMov PIM  (NOLOCK)
			JOIN Invoice I ON (I.IDPreSale = PIM.DocumentID)
			LEFT OUTER JOIN ComisPaga ON (PIM.IDPreInventoryMov = ComisPaga.IDDocumento )
		WHERE
			( PIM.ComissionID = @IDVendedor )
			AND	
			( PIM.InventMovTypeID = 1 )
			AND
			( I.PreSaleDate >= @DataIni )
			AND
			( I.PreSaleDate < @DataFim )
			AND
			( ComisPaga.IDLancPag IS NULL )
	
	SET @SysError = @@ERROR
	IF @SysError <> 0  
	BEGIN
		SET @ErrorLevel = -206
		GOTO ERRO
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
