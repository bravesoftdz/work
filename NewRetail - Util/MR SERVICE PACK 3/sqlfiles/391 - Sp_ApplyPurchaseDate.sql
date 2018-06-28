if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Fin_CriaLacamento_Disburse]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Fin_CriaLacamento_Disburse]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Purchase_CriaPagamento]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Purchase_CriaPagamento]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Purchase_CriaPagamentoComImposto]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Purchase_CriaPagamentoComImposto]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Purchase_CriaPagamentoComImpostoRet]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Purchase_CriaPagamentoComImpostoRet]
GO

CREATE PROCEDURE sp_Fin_CriaLacamento_Disburse
	(
	@IDLancamentoParent 	int,
	@Total			money,
	@NumDuplicata		varchar(20),
	@IDLancamentoTipo	int
	)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Atualizo as informacoes dos lancamentos

	TABELA DE ERROS PARA RETURN_VALUE

		 000	Ok
		-201	Erro em incluo o lancamento Disbursement

	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	-----------------------	-----------------------	-------------------------------------------------------------------------------------------------------------------------------------
	13 May	2002		Rodrigo Costa		Criacao
	21 Oct	2003		André Bogado		Chamada a sp_Sis_GetNextCode
							Declaração de Fin_Lancamento_Cursor
	18 Aug	2004		Rodrigo Costa		Gravar error log
	24 Dez	2004		Rodrigo Costa		Novo parametro @IDLancamentoTipo
	22 Feb	2006		Maximiliano Muniz	Removido o cursor Fin_Lancamento_Cursor
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

DECLARE @ErrorLevel		int
DECLARE @SysError		int
DECLARE @IDLancamento		int

SET @ErrorLevel = 0

EXEC sp_Sis_GetNextCode 'Fin_Lancamento.IDLancamento', @IDLancamento OUTPUT
INSERT Fin_Lancamento
	(
	IDLancamento,
	Pagando,
	IDLancamentoTipo,
	DataLancamento,
	IDUsuarioLancamento,
	Previsao,
	Situacao,
	IDPessoaTipo,
	IDPessoa,
	IDEmpresa,
	DataVencimento,
	DataEmissao,
	IDDocumentoTipo,
	ValorNominal,
	NumDocumento,
	IDPurchase,
	IDMoeda,
	IDMoedaCotacao,
	LancamentoType,
	IDLancamentoParent,
	NumeroDuplicata
	)
	(
	SELECT
		@IDLancamento,
		LP.Pagando,
		@IDLancamentoTipo,
		LP.DataLancamento,
		LP.IDUsuarioLancamento,
		LP.Previsao,
		LP.Situacao,
		LP.IDPessoaTipo,
		LP.IDPessoa,
		LP.IDEmpresa,
		LP.DataVencimento,
		LP.DataEmissao,
		LP.IDDocumentoTipo,
		@Total,
		LP.NumDocumento,
		LP.IDPurchase,
		LP.IDMoeda,
		LP.IDMoedaCotacao,
		2, -- Lancamento Tipo Desdrobramento
		LP.IDLancamento,
		@NumDuplicata
	FROM
		Fin_Lancamento LP
	WHERE
		LP.IDLancamento = @IDLancamentoParent
	)

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END

OK:
	RETURN 0
ERRO:
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'OfficeManager', 'Error: sp_Fin_CriaLacamento_Disburse', @ErrorLevelStr

	RETURN @ErrorLevel
GO

CREATE PROCEDURE sp_Purchase_CriaPagamento
	(
	@IDPurchase	int
	)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Atualizo as informacoes dos lancamentos

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em update os lancamentos anteriores
		-202  Erro em incluo o lancamento Parent
		-203  Erro Preenchando valores default
		-204  Erro em incluo o lancamento Disbursement SubTotal
		-205  Erro em incluo o lancamento Disbursement Freight


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	-----------------------	-----------------------	--------------------------------------------------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
	26 June 2001		Davi Gouveia		Log de Return Values
	13 May	2002		Rodrigo Costa		Inserir Lancamentos com Disbursements
	28 Oct	2003		Rodrigo Costa		Create sp_GetNexCode
	18 Aug	2004		Rodrigo Costa		Gravar error log
	21 Feb	2006		Maximiliano Muniz	Inserir lançamentos com base na Pur_PurchaseDueDate
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

DECLARE @ErrorLevel		int
DECLARE @SysError		int
DECLARE @IDLancamentoParent	int
DECLARE @SubTotal		money
DECLARE @Freight		money
DECLARE @CriaDisbur		int

--Declaração de variáveis para o Cursor de Fin_Lancamento
DECLARE @Pagando		bit
DECLARE @IDLancamentoTipo	int
DECLARE @DataLancamento		smalldatetime
DECLARE @IDUsuarioLancamento	int
DECLARE @Previsao		bit
DECLARE @Situacao		int
DECLARE @IDPessoaTipo 		int 
DECLARE @IDPessoa		int
DECLARE @IDEmpresa		int
DECLARE @DataVencimento		smalldatetime
DECLARE @DataEmissao		datetime
DECLARE @IDDocumentoTipo	int
DECLARE @ValorNominal		money
DECLARE @NumDocumento 		varchar(20)
DECLARE @IDMoeda		int
DECLARE @IDMoedaCotacao		int
DECLARE @LancamentoType		int
DECLARE @IDLancamento		int
DECLARE @IDPurchaseDueDate	int

SET @ErrorLevel = 0
SET @CriaDisbur = 0

IF EXISTS (SELECT IDLancamento FROM Fin_Lancamento WHERE IDPurchase = @IDPurchase)
BEGIN
	-- Atualizo as informacoes do Lancamento Parent
	UPDATE
		L
	SET
		L.DataVencimento = PDD.Date,
		L.DataEmissao = P.DocumentDate,
		L.NumDocumento = P.DocumentNumber,
		L.ValorNominal = PDD.Amount + ((PDD.Amount/PT.SubTotal)*IsNull(P.Freight, 0)) + ((PDD.Amount/PT.SubTotal)*IsNull(P.OtherCharges, 0)),
		L.IDPessoa = P.IDFornecedor,
		L.DataLancamento =IsNull(P.DateFinalReceiving, P.DatePreReceiving),
		L.IDUsuarioLancamento = IsNull(P.IDUserFinalReceiving, P.IDUserPreReceiving)
	FROM
		Fin_Lancamento L
		JOIN Pur_Purchase P ON (L.IDPurchase = P.IDPurchase)
		JOIN Pur_PurchaseTotal PT ON (PT.IDPurchase = P.IDPurchase)
		JOIN Pur_PurchaseDueDate PDD ON (PDD.IDPurchase = P.IDPurchase)
	WHERE
		P.IDPurchase = @IDPurchase
		AND
		L.LancamentoType <> 2 -- Diferente de LancamentoFilho

	-- Atualizo as informacoes do Lancamento Filho
	UPDATE
		L
	SET
		L.DataVencimento = PDD.Date,
		L.DataEmissao = P.DocumentDate,
		L.NumDocumento = P.DocumentNumber,
		L.ValorNominal = PDD.Amount,
		L.IDPessoa = P.IDFornecedor,
		L.DataLancamento =IsNull(P.DateFinalReceiving, P.DatePreReceiving),
		L.IDUsuarioLancamento = IsNull(P.IDUserFinalReceiving, P.IDUserPreReceiving)
	FROM
		Fin_Lancamento L
		JOIN Pur_Purchase P ON (L.IDPurchase = P.IDPurchase)
		JOIN Pur_PurchaseTotal PT ON (PT.IDPurchase = P.IDPurchase)
		JOIN Pur_PurchaseDueDate PDD ON (PDD.IDPurchase = P.IDPurchase)
	WHERE
		P.IDPurchase = @IDPurchase
		AND
		L.LancamentoType = 2 -- Lancamento Filho primeira parcela
		AND
		L.NumeroDuplicata = '1/2'


	-- Atualizo as informacoes do Lancamento Filho
	UPDATE
		L
	SET
		L.DataVencimento = PDD.Date,
		L.DataEmissao = P.DocumentDate,
		L.NumDocumento = P.DocumentNumber,
		L.ValorNominal = ((PDD.Amount/PT.SubTotal)*IsNull(P.Freight, 0)) + ((PDD.Amount/PT.SubTotal)*IsNull(P.OtherCharges, 0)),
		L.IDPessoa = P.IDFornecedor,
		L.DataLancamento =IsNull(P.DateFinalReceiving, P.DatePreReceiving),
		L.IDUsuarioLancamento = IsNull(P.IDUserFinalReceiving, P.IDUserPreReceiving)
	FROM
		Fin_Lancamento L
		JOIN Pur_Purchase P ON (L.IDPurchase = P.IDPurchase)
		JOIN Pur_PurchaseTotal PT ON (PT.IDPurchase = P.IDPurchase)
		JOIN Pur_PurchaseDueDate PDD ON (PDD.IDPurchase = P.IDPurchase)
	WHERE
		P.IDPurchase = @IDPurchase
		AND
		L.LancamentoType = 2 -- Lancamento Filho segunda parcela
		AND
		L.NumeroDuplicata = '2/2'

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		SET @ErrorLevel = -201
		GOTO ERRO
	END
END
ELSE
BEGIN
	-- Incluo o lancamento parent
	--Declaração do Cursor de Fin_Lancamento
	DECLARE Fin_Lancamento_Cursor CURSOR FOR
	
		SELECT
			1,
			7,  -- Cost of Good ## Davi
			IsNull(P.DateFinalReceiving, P.DatePreReceiving),
			IsNull(P.IDUserFinalReceiving, P.IDUserPreReceiving),
			1,  -- Nao approvado
			1,  -- Aberto
			2,  -- Vendor
			P.IDFornecedor,
			S.IDEmpresa,
			PDD.Date,
			P.DocumentDate,
			1002,  -- Vendor Invoice
			PDD.Amount + ((PDD.Amount/PT.SubTotal)*IsNull(P.Freight, 0)) + ((PDD.Amount/PT.SubTotal)*IsNull(P.OtherCharges, 0)),
			P.DocumentNumber,
			P.IDPurchase,
			PDD.IDPurchaseDueDate,
			4, -- Dollar
			6, -- Cotacao Default - Dollar
			1  -- Lancamento Parent
		FROM
			Pur_Purchase P
			JOIN Pur_PurchaseTotal PT ON (PT.IDPurchase = P.IDPurchase)
			JOIN Store S ON (P.IDStore = S.IDStore)
			JOIN Pur_PurchaseDueDate PDD ON (PDD.IDPurchase = P.IDPurchase)
		WHERE
			P.IDPurchase = @IDPurchase
			AND
			DocumentType = 'Invoice'

	OPEN Fin_Lancamento_Cursor
	
	--Inicialização de Fin_Lancamento_Cursor
	FETCH NEXT FROM Fin_Lancamento_Cursor INTO
		@Pagando,
		@IDLancamentoTipo,
		@DataLancamento,
		@IDUsuarioLancamento,
		@Previsao,
		@Situacao,
		@IDPessoaTipo,
		@IDPessoa,
		@IDEmpresa,
		@DataVencimento,
		@DataEmissao,
		@IDDocumentoTipo,
		@ValorNominal,
		@NumDocumento,
		@IDPurchase,
		@IDPurchaseDueDate,
		@IDMoeda,
		@IDMoedaCotacao,
		@LancamentoType
	--Enquanto tem registros
	WHILE @@FETCH_STATUS = 0
	BEGIN
		EXEC sp_Sis_GetNextCode 'Fin_Lancamento.IDLancamento', @IDLancamento OUTPUT
		INSERT Fin_Lancamento(
			IDLancamento,
			Pagando,
			IDLancamentoTipo,
			DataLancamento,
			IDUsuarioLancamento,
			Previsao,
			Situacao,
			IDPessoaTipo,
			IDPessoa,
			IDEmpresa,
			DataVencimento,
			DataEmissao,
			IDDocumentoTipo,
			ValorNominal,
			NumDocumento,
			IDPurchase,
			IDMoeda,
			IDMoedaCotacao,
			LancamentoType
			)
		VALUES 
			(
			@IDLancamento,
			@Pagando,
			@IDLancamentoTipo,
			@DataLancamento,
			@IDUsuarioLancamento,
			@Previsao,
			@Situacao,
			@IDPessoaTipo,
			@IDPessoa,
			@IDEmpresa,
			@DataVencimento,
			@DataEmissao,
			@IDDocumentoTipo,
			@ValorNominal,
			@NumDocumento,
			@IDPurchase,
			@IDMoeda,
			@IDMoedaCotacao,
			@LancamentoType	
			)

		SET @SysError = @@ERROR
		IF @SysError <> 0
		BEGIN
			CLOSE Fin_Lancamento_Cursor
			DEALLOCATE Fin_Lancamento_Cursor
			SET @ErrorLevel = -202
			GOTO ERRO
		END

		--Pega o IDLancamento do Pararent e os Valores para criar os disbursement
		SELECT 
			@IDLancamentoParent = @IDLancamento,
			@SubTotal = PDD.Amount,
			@Freight = ((PDD.Amount/PT.SubTotal)*IsNull(P.Freight, 0)) + ((PDD.Amount/PT.SubTotal)*IsNull(P.OtherCharges, 0)),
			@CriaDisbur = 1,
			@IDLancamentoTipo = 7 -- Cost of Good ## Davi
		FROM
			Pur_Purchase P
			JOIN Pur_PurchaseTotal PT ON (PT.IDPurchase = P.IDPurchase)
			JOIN Pur_PurchaseDueDate PDD ON (PDD.IDPurchase = P.IDPurchase)
		WHERE
			P.IDPurchase = @IDPurchase
			AND
			P.DocumentType = 'Invoice'
			AND
			PDD.IDPurchaseDueDate = @IDPurchaseDueDate
	
		SET @SysError = @@ERROR

		IF @SysError <> 0
		BEGIN
			SET @ErrorLevel = -203
			GOTO ERRO
		END

		IF (@CriaDisbur = 1)
		BEGIN
			--Cria desdobramento do Sub Total
			EXEC sp_Fin_CriaLacamento_Disburse @IDLancamentoParent, @SubTotal, '1/2', @IDLancamentoTipo

			SET @SysError = @@ERROR
			IF @SysError <> 0
			BEGIN
				SET @ErrorLevel = -204
				GOTO ERRO
			END

			--Cria desdobramento do Freight
			EXEC sp_Fin_CriaLacamento_Disburse @IDLancamentoParent, @Freight, '2/2', @IDLancamentoTipo

			SET @SysError = @@ERROR
			IF @SysError <> 0
			BEGIN
				SET @ErrorLevel = -205
				GOTO ERRO
			END
		END

		FETCH NEXT FROM Fin_Lancamento_Cursor INTO
			@Pagando,
			@IDLancamentoTipo,
			@DataLancamento,
			@IDUsuarioLancamento,
			@Previsao,
			@Situacao,
			@IDPessoaTipo,
			@IDPessoa,
			@IDEmpresa,
			@DataVencimento,
			@DataEmissao,
			@IDDocumentoTipo,
			@ValorNominal,
			@NumDocumento,
			@IDPurchase,
			@IDPurchaseDueDate,
			@IDMoeda,
			@IDMoedaCotacao,
			@LancamentoType
	END
	--fechamento do cursor
	CLOSE Fin_Lancamento_Cursor
	--Destruição do cursor
	DEALLOCATE Fin_Lancamento_Cursor

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		SET @ErrorLevel = -202
		GOTO ERRO
	END
END

OK:
	RETURN 0
ERRO:
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_Purchase_CriaPagamento', @ErrorLevelStr

	RETURN @ErrorLevel

GO

CREATE PROCEDURE sp_Purchase_CriaPagamentoComImposto
	(
	@IDPurchase	int
	)
AS

/* ----------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Deletar os lancamentos se precisar
		- Inserir as informacoes dos lancamentos
		- Inserir os desdobramentos nos lancamentos

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Deletar os lancamentos anteriores
		-202  Erro em incluo o lancamento Parent
		-203  Erro Preenchando valores default
		-204  Erro em incluo o lancamento Disbursement SubTotal
		-205  Erro em incluo o lancamento Disbursement Freight
		-206  Erro em incluo os lancamentos Disbursement Impostos

	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	-----------------------	-----------------------	-----------------------------------------------------------------
	24 Dez	2004		Rodrigo Costa		Criacao;
	22 Feb	2006		Maximiliano Muniz	Inserir lançamentos com base na Pur_PurchaseDueDate
	----------------------------------------------------------------------------------------------------------------- */

DECLARE @ErrorLevel		int
DECLARE @SysError		int
DECLARE @IDLancamentoParent	int
DECLARE @SubTotal		money
DECLARE @PercSubTotal		float
DECLARE @Freight		money
DECLARE @CriaDisbur		int

--Declaração de variáveis para o Cursor de Fin_Lancamento
DECLARE @Pagando		bit
DECLARE @IDLancamentoTipo	int 
DECLARE @DataLancamento		smalldatetime 
DECLARE @IDUsuarioLancamento	int 
DECLARE @Previsao		bit 
DECLARE @Situacao		int 
DECLARE @IDPessoaTipo		int 
DECLARE @IDPessoa		int 
DECLARE @IDEmpresa		int 
DECLARE @DataVencimento		smalldatetime 
DECLARE @DataEmissao		datetime 
DECLARE @IDDocumentoTipo	int 
DECLARE @ValorNominal		money 
DECLARE @NumDocumento		varchar(20)
DECLARE @IDMoeda		int 
DECLARE @IDMoedaCotacao		int 
DECLARE @LancamentoType		int 
DECLARE @IDLancamento		int
DECLARE @TotalDesdobramento	int
DECLARE @NumDesdobramento	varchar(10)
DECLARE @CountImposto		int
DECLARE @TotalImposto		money
DECLARE @IDPurchaseDueDate	int

SET @ErrorLevel = 0
SET @CriaDisbur = 0

-- Deleto os Lancamentos Filhos
DELETE 
FROM 
	Fin_Lancamento  
WHERE
	IDPurchase = @IDPurchase

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END

-- Incluo o lancamento parent
--Declaração do Cursor de Fin_Lancamento
DECLARE Fin_Lancamento_Cursor CURSOR FOR
	
	SELECT
		1,
		7,  -- Cost of Good ## Davi
		IsNull(P.DateFinalReceiving, P.DatePreReceiving),
		IsNull(P.IDUserFinalReceiving, P.IDUserPreReceiving),
		1,  -- Nao approvado
		1,  -- Aberto
		2,  -- Vendor
		P.IDFornecedor,
		S.IDEmpresa,
		PDD.Date,
		P.DocumentDate,
		1002,  -- Vendor Invoice
		PDD.Amount + ((PDD.Amount/IsNull(PT.SubTotal, 0))*IsNull(P.Freight, 0)) + ((PDD.Amount/IsNull(PT.SubTotal, 0))*IsNull(P.OtherCharges, 0)),
		P.DocumentNumber,
		P.IDPurchase,
		PDD.IDPurchaseDueDate,
		4, -- Dollar
		6, -- Cotacao Default - Dollar
		1  -- Lancamento Parent
	FROM
		Pur_Purchase P
		JOIN Pur_PurchaseTotal PT ON (PT.IDPurchase = P.IDPurchase)
		JOIN Store S ON (P.IDStore = S.IDStore)
		JOIN Pur_PurchaseDueDate PDD ON (PDD.IDPurchase = P.IDPurchase)
	WHERE
		P.IDPurchase = @IDPurchase
		AND
		DocumentType = 'Invoice'
	
	
OPEN Fin_Lancamento_Cursor
	
--Inicialização de Fin_Lancamento_Cursor
FETCH NEXT FROM Fin_Lancamento_Cursor INTO
	@Pagando,
	@IDLancamentoTipo,
	@DataLancamento,
	@IDUsuarioLancamento,
	@Previsao,
	@Situacao,
	@IDPessoaTipo,
	@IDPessoa,
	@IDEmpresa,
	@DataVencimento,
	@DataEmissao,
	@IDDocumentoTipo,
	@ValorNominal,
	@NumDocumento,
	@IDPurchase,
	@IDPurchaseDueDate,
	@IDMoeda,
	@IDMoedaCotacao,
	@LancamentoType
--Enquanto tem registros
WHILE @@FETCH_STATUS = 0
BEGIN
	EXEC sp_Sis_GetNextCode 'Fin_Lancamento.IDLancamento', @IDLancamento OUTPUT
	INSERT Fin_Lancamento(
		IDLancamento,
		Pagando,
		IDLancamentoTipo,
		DataLancamento,
		IDUsuarioLancamento,
		Previsao,
		Situacao,
		IDPessoaTipo,
		IDPessoa,
		IDEmpresa,
		DataVencimento,
		DataEmissao,
		IDDocumentoTipo,
		ValorNominal,
		NumDocumento,
		IDPurchase,
		IDMoeda,
		IDMoedaCotacao,
		LancamentoType
		)
	VALUES 
		(
		@IDLancamento,
		@Pagando,
		@IDLancamentoTipo,
		@DataLancamento,
		@IDUsuarioLancamento,
		@Previsao,
		@Situacao,
		@IDPessoaTipo,
		@IDPessoa,
		@IDEmpresa,
		@DataVencimento,
		@DataEmissao,
		@IDDocumentoTipo,
		@ValorNominal,
		@NumDocumento,
		@IDPurchase,
		@IDMoeda,
		@IDMoedaCotacao,
		@LancamentoType	
		)

		SET @SysError = @@ERROR
		IF @SysError <> 0
			BEGIN
				CLOSE Fin_Lancamento_Cursor
				DEALLOCATE Fin_Lancamento_Cursor
				SET @ErrorLevel = -202
				GOTO ERRO
			END

-------------------------------------------------------------------------------------------------------------------------
	-- Pega o IDLancamento do Pararent e os Valores para criar os disbursement frete
	SELECT 
		@IDLancamentoParent = @IDLancamento,
		@PercSubTotal = PDD.Amount/IsNull(PT.SubTotal, 0),
		@SubTotal = PDD.Amount,
		@Freight = (PDD.Amount/IsNull(PT.SubTotal, 0)*IsNull(P.Freight, 0)) + (PDD.Amount/IsNull(PT.SubTotal, 0)*IsNull(P.OtherCharges, 0)),
		@CriaDisbur = 1,
		@IDLancamentoTipo = 7 -- Cost of Good ## Davi
	FROM
		Pur_Purchase P
		JOIN Pur_PurchaseTotal PT ON (PT.IDPurchase = P.IDPurchase)
		JOIN Pur_PurchaseDueDate PDD ON (P.IDPurchase = PDD.IDPurchase)
	WHERE
		P.IDPurchase = @IDPurchase
		AND
		P.DocumentType = 'Invoice'
		AND
		PDD.IDPurchaseDueDate = @IDPurchaseDueDate

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		SET @ErrorLevel = -203
		GOTO ERRO
	END
	
	IF (@CriaDisbur = 1)
	BEGIN
		--Contar total de parcelas
		--@TotalDesdobramento
		SELECT 
			COUNT (*)
		FROM 
			Pur_PurchaseItemTax PIT
		WHERE
			PIT.IDPurchase = @IDPurchase
		GROUP BY
			PIT.IDVendorTax 
 
		SET  @TotalDesdobramento =  @@ROWCOUNT

		--Descubro o total dos impostos para diminuir com o da fatura
		SELECT 
			@TotalImposto = IsNull(SUM(ABS(IsNull(PIT.TaxValue,0))),0)
		FROM 
			Pur_PurchaseItemTax PIT
		WHERE
			PIT.IDPurchase = @IDPurchase

		SET @TotalImposto = (@SubTotal - (@PercSubTotal*@TotalImposto))

		--Cria desdobramento do Sub Total
		SET @NumDesdobramento = '1/'+Convert(VarChar(10),@TotalDesdobramento)
		EXEC sp_Fin_CriaLacamento_Disburse @IDLancamentoParent, @TotalImposto, @NumDesdobramento, @IDLancamentoTipo
	
		SET @SysError = @@ERROR
		IF @SysError <> 0
		BEGIN
			SET @ErrorLevel = -204
			GOTO ERRO
		END

		--Cria desdobramento do Freight
		SET @NumDesdobramento = '2/'+Convert(VarChar(10),@TotalDesdobramento)
		EXEC sp_Fin_CriaLacamento_Disburse @IDLancamentoParent, @Freight, @NumDesdobramento, @IDLancamentoTipo

		SET @SysError = @@ERROR
		IF @SysError <> 0
		BEGIN
			SET @ErrorLevel = -205
			GOTO ERRO
		END

		--Setar o contador para os desdobramentos de impostos
		SET @CountImposto = 3

		--Cursor para impostos
		--Declaração do Cursor de Purchase_ItemTax_Cursor
		DECLARE Purchase_ItemTax_Cursor CURSOR FOR

			SELECT
				CT.IDLancamentoTipo,
				(@PercSubTotal*IsNull(SUM(ABS(IsNull(PIT.TaxValue,0))),0)) as Value
			FROM
				Pur_PurchaseItemTax PIT
				LEFT OUTER JOIN VendorTax VT ON (VT.IDVendorTax = PIT.IDVendorTax)
				LEFT OUTER JOIN TaxCategory CT ON (CT.IDTaxCategory = VT.IDTaxCategory)
			WHERE
				PIT.IDPurchase = @IDPurchase
			GROUP BY
				CT.IDLancamentoTipo,
				PIT.IDVendorTax 		
		
		OPEN Purchase_ItemTax_Cursor

		--Inicialização de Purchase_ItemTax_Cursor
		FETCH NEXT FROM Purchase_ItemTax_Cursor INTO
			@IDLancamentoTipo,
			@ValorNominal
		--Enquanto tem registros
		WHILE @@FETCH_STATUS = 0
		BEGIN
			--Cria desdobramento dos impostos
			SET @NumDesdobramento = Convert(VarChar(10),@CountImposto)+'/'+Convert(VarChar(10),@TotalDesdobramento)
			EXEC sp_Fin_CriaLacamento_Disburse @IDLancamentoParent, @ValorNominal, @NumDesdobramento, @IDLancamentoTipo

			SET @SysError = @@ERROR
			IF @SysError <> 0
			BEGIN
				SET @ErrorLevel = -206
				GOTO ERRO
			END

			--Incrementar o desdobramento
			SET @CountImposto = @CountImposto + 1

		FETCH NEXT FROM Purchase_ItemTax_Cursor INTO
				@IDLancamentoTipo,
				@ValorNominal
		END
		--fechamento do cursor
		CLOSE Purchase_ItemTax_Cursor
		--Destruição do cursor
		DEALLOCATE Purchase_ItemTax_Cursor

END
-------------------------------------------------------------------------------------------------------------------------

FETCH NEXT FROM Fin_Lancamento_Cursor INTO
		@Pagando,
		@IDLancamentoTipo,
		@DataLancamento,
		@IDUsuarioLancamento,
		@Previsao,
		@Situacao,
		@IDPessoaTipo,
		@IDPessoa,
		@IDEmpresa,
		@DataVencimento,
		@DataEmissao,
		@IDDocumentoTipo,
		@ValorNominal,
		@NumDocumento,
		@IDPurchase,
		@IDPurchaseDueDate,
		@IDMoeda,
		@IDMoedaCotacao,
		@LancamentoType
END
--fechamento do cursor
CLOSE Fin_Lancamento_Cursor
--Destruição do cursor
DEALLOCATE Fin_Lancamento_Cursor

OK:
	RETURN 0
ERRO:
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_Purchase_CriaPagamentoComImposto', @ErrorLevelStr

	RETURN @ErrorLevel
GO

CREATE PROCEDURE sp_Purchase_CriaPagamentoComImpostoRet
	(
	@IDPurchase	int
	)
AS

/* ----------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Inserir as informacoes dos lancamentos
		- Inserir os desdobramentos nos lancamentos

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-202  Erro em incluo o lancamento Parent
		-203  Erro Preenchando valores default
		-204  Erro em incluo o lancamento Disbursement SubTotal
		-205  Erro em incluo o lancamento Disbursement Freight
		-206  Erro em incluo os lancamentos Disbursement Impostos


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	-----------------------	-----------------------	-----------------------------------------------------------------
	14 Mar 	2005		Carlos Lima		Criação
	22 Feb	2006		Maximiliano Muniz	Inserir lançamentos com base na Pur_PurchaseDueDate
    	-----------------------------------------------------------------------------------------------------------------  */

DECLARE @ErrorLevel		int
DECLARE @SysError		int
DECLARE @IDLancamentoParent	int
DECLARE @SubTotal		money
DECLARE @PercSubTotal		money
DECLARE @Freight		money
DECLARE @CriaDisbur		int

--Declaração de variáveis para o Cursor de Fin_Lancamento
DECLARE @Pagando		bit
DECLARE @IDLancamentoTipo	int
DECLARE @DataLancamento		smalldatetime
DECLARE @IDUsuarioLancamento	int
DECLARE @Previsao		bit
DECLARE @Situacao		int
DECLARE @IDPessoaTipo		int
DECLARE @IDPessoa		int
DECLARE @IDEmpresa		int
DECLARE @DataVencimento		smalldatetime
DECLARE @DataEmissao		datetime
DECLARE @IDDocumentoTipo	int
DECLARE @ValorNominal		money
DECLARE @NumDocumento		varchar(20)
DECLARE @IDMoeda		int
DECLARE @IDMoedaCotacao		int
DECLARE @LancamentoType		int
DECLARE @IDLancamento		int
DECLARE @TotalDesdobramento	int
DECLARE @NumDesdobramento	varchar(10)
DECLARE @CountImposto		int
DECLARE @TotalImposto		money
DECLARE @IDPurchaseDueDate	int

SET @ErrorLevel = 0
SET @CriaDisbur = 0

-- Incluo o lancamento parent
--Declaração do Cursor de Fin_Lancamento
DECLARE Fin_Lancamento_Cursor CURSOR FOR	
	SELECT
		1,
		7,  -- Cost of Good ## Davi
		IsNull(P.DateFinalReceiving, P.DatePreReceiving),
		IsNull(P.IDUserFinalReceiving, P.IDUserPreReceiving),
		1,  -- Nao approvado
		1,  -- Aberto
		2,  -- Vendor
		P.IDFornecedor,
		S.IDEmpresa,
		P.DocumentDueDate,
		P.DocumentDate,
		1002,  -- Vendor Invoice
		(IsNull(PT.SubTotalRet, 0) + IsNull(P.FreightRet, 0) + IsNull(P.OtherChargesRet, 0)) * -1,
		P.DocumentNumberRet,
		P.IDPurchase,
		PDD.IDPurchaseDueDate,
		4, -- Dollar
		6, -- Cotacao Default - Dollar
		1  -- Lancamento Parent
	FROM
		Pur_Purchase P
		JOIN Pur_PurchaseTotal PT ON (PT.IDPurchase = P.IDPurchase)
		JOIN Store S ON (P.IDStore = S.IDStore)
		JOIN Pur_PurchaseDueDate PDD ON (PDD.IDPurchase = P.IDPurchase)
	WHERE
		P.IDPurchase = @IDPurchase
		AND
		DocumentType = 'Invoice'
	
	
OPEN Fin_Lancamento_Cursor
	
--Inicialização de Fin_Lancamento_Cursor
FETCH NEXT FROM Fin_Lancamento_Cursor INTO
	@Pagando,
	@IDLancamentoTipo,
	@DataLancamento,
	@IDUsuarioLancamento,
	@Previsao,
	@Situacao,
	@IDPessoaTipo,
	@IDPessoa,
	@IDEmpresa,
	@DataVencimento,
	@DataEmissao,
	@IDDocumentoTipo,
	@ValorNominal,
	@NumDocumento,
	@IDPurchase,
	@IDPurchaseDueDate,
	@IDMoeda,
	@IDMoedaCotacao,
	@LancamentoType
--Enquanto tem registros
WHILE @@FETCH_STATUS = 0
BEGIN
	EXEC sp_Sis_GetNextCode 'Fin_Lancamento.IDLancamento', @IDLancamento OUTPUT
	INSERT Fin_Lancamento(
		IDLancamento,
		Pagando,
		IDLancamentoTipo,
		DataLancamento,
		IDUsuarioLancamento,
		Previsao,
		Situacao,
		IDPessoaTipo,
		IDPessoa,
		IDEmpresa,
		DataVencimento,
		DataEmissao,
		IDDocumentoTipo,
		ValorNominal,
		NumDocumento,
		IDPurchase,
		IDMoeda,
		IDMoedaCotacao,
		LancamentoType
		)
	VALUES 
		(
		@IDLancamento,
		@Pagando,
		@IDLancamentoTipo,
		@DataLancamento,
		@IDUsuarioLancamento,
		@Previsao,
		@Situacao,
		@IDPessoaTipo,
		@IDPessoa,
		@IDEmpresa,
		@DataVencimento,
		@DataEmissao,
		@IDDocumentoTipo,
		@ValorNominal,
		@NumDocumento,
		@IDPurchase,
		@IDMoeda,
		@IDMoedaCotacao,
		@LancamentoType	
		)

		SET @SysError = @@ERROR
		IF @SysError <> 0
			BEGIN
				CLOSE Fin_Lancamento_Cursor
				DEALLOCATE Fin_Lancamento_Cursor
				SET @ErrorLevel = -202
				GOTO ERRO
			END

-------------------------------------------------------------------------------------------------------------------------	
	--Pega o IDLancamento do Pararent e os Valores para criar os disbursement frete
	SELECT 
		@IDLancamentoParent = @IDLancamento,
		@PercSubTotal = (PDD.Amount/IsNull(PT.SubTotalRet, 0)),
		@SubTotal = PDD.Amount * -1,
		@Freight = ((PDD.Amount/IsNull(PT.SubTotalRet, 0)*IsNull(P.FreightRet, 0)) + (PDD.Amount/IsNull(PT.SubTotalRet, 0)*IsNull(P.OtherChargesRet, 0))) * -1,
		@CriaDisbur = 1,
		@IDLancamentoTipo = 7 -- Cost of Good ## Davi
	FROM
		Pur_Purchase P
		JOIN Pur_PurchaseTotal PT ON (PT.IDPurchase = P.IDPurchase)
		JOIN Pur_PurchaseDueDate PDD ON (PDD.IDPurchase = P.IDPurchase)
	WHERE
		P.IDPurchase = @IDPurchase
		AND
		P.DocumentType = 'Invoice'
		AND
		PDD.IDPurchaseDueDate = @IDPurchaseDueDate

	SET @SysError = @@ERROR

	IF @SysError <> 0
	BEGIN
		SET @ErrorLevel = -203
		GOTO ERRO
	END

	IF (@CriaDisbur = 1)
	BEGIN
		--Contar total de parcelas
		--@TotalDesdobramento
		SELECT
			COUNT (*)
		FROM
			Pur_PurchaseItemTaxRet PIT
		WHERE
			PIT.IDPurchase = @IDPurchase
		GROUP BY
			PIT.IDVendorTax

		SET @TotalDesdobramento = @@ROWCOUNT

		--Descubro o total dos impostos para diminuir com o da fatura
		SELECT
			@TotalImposto = IsNull(SUM(ABS(IsNull(PIT.TaxValue,0))),0) * (-1)
		FROM
			Pur_PurchaseItemTaxRet PIT
		WHERE
			PIT.IDPurchase = @IDPurchase

		SET @TotalImposto = (@SubTotal - (@PercSubTotal*@TotalImposto))

		--Cria desdobramento do Sub Total
		SET @NumDesdobramento = '1/'+Convert(VarChar(10),@TotalDesdobramento)
		EXEC sp_Fin_CriaLacamento_Disburse @IDLancamentoParent, @TotalImposto, @NumDesdobramento, @IDLancamentoTipo
	
		SET @SysError = @@ERROR
		IF @SysError <> 0
		BEGIN
			SET @ErrorLevel = -204
			GOTO ERRO
		END

		--Cria desdobramento do Freight
		SET @NumDesdobramento = '2/'+Convert(VarChar(10),@TotalDesdobramento)
		EXEC sp_Fin_CriaLacamento_Disburse @IDLancamentoParent, @Freight, @NumDesdobramento, @IDLancamentoTipo

		SET @SysError = @@ERROR
		IF @SysError <> 0
		BEGIN
			SET @ErrorLevel = -205
			GOTO ERRO
		END

		--Setar o contador para os desdobramentos de impostos
		SET @CountImposto = 3

		--Cursor para impostos
		--Declaração do Cursor de Purchase_ItemTax_Cursor
		DECLARE Purchase_ItemTax_Cursor CURSOR FOR

			SELECT 
				CT.IDLancamentoTipo,
				(@PercSubTotal*IsNull(SUM(ABS(IsNull(PIT.TaxValue,0))),0)) * (-1) as Value
			FROM 
				Pur_PurchaseItemTaxRet PIT
				LEFT OUTER JOIN VendorTax VT ON (VT.IDVendorTax = PIT.IDVendorTax)
				LEFT OUTER JOIN TaxCategory CT ON (CT.IDTaxCategory = VT.IDTaxCategory)
			WHERE
				PIT.IDPurchase = @IDPurchase
			GROUP BY
				CT.IDLancamentoTipo,
				PIT.IDVendorTax 		

		OPEN Purchase_ItemTax_Cursor

		--Inicialização de Purchase_ItemTax_Cursor
		FETCH NEXT FROM Purchase_ItemTax_Cursor INTO
			@IDLancamentoTipo,
			@ValorNominal
		--Enquanto tem registros
		WHILE @@FETCH_STATUS = 0
		BEGIN
			--Cria desdobramento dos impostos

			SET @NumDesdobramento = Convert(VarChar(10),@CountImposto)+'/'+Convert(VarChar(10),@TotalDesdobramento)
			EXEC sp_Fin_CriaLacamento_Disburse @IDLancamentoParent, @ValorNominal, @NumDesdobramento, @IDLancamentoTipo

			SET @SysError = @@ERROR
			IF @SysError <> 0
			BEGIN
				SET @ErrorLevel = -206
				GOTO ERRO
			END

			--Incrementar o desdobramento
			SET @CountImposto = @CountImposto + 1

		FETCH NEXT FROM Purchase_ItemTax_Cursor INTO
			@IDLancamentoTipo,
			@ValorNominal
		END
		--fechamento do cursor
		CLOSE Purchase_ItemTax_Cursor
		--Destruição do cursor
		DEALLOCATE Purchase_ItemTax_Cursor
END
-------------------------------------------------------------------------------------------------------------------------

FETCH NEXT FROM Fin_Lancamento_Cursor INTO
		@Pagando,
		@IDLancamentoTipo,
		@DataLancamento,
		@IDUsuarioLancamento,
		@Previsao,
		@Situacao,
		@IDPessoaTipo,
		@IDPessoa,
		@IDEmpresa,
		@DataVencimento,
		@DataEmissao,
		@IDDocumentoTipo,
		@ValorNominal,
		@NumDocumento,
		@IDPurchase,
		@IDPurchaseDueDate,
		@IDMoeda,
		@IDMoedaCotacao,
		@LancamentoType
END
--fechamento do cursor
CLOSE Fin_Lancamento_Cursor
--Destruição do cursor
DEALLOCATE Fin_Lancamento_Cursor

OK:
	RETURN 0
ERRO:
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_Purchase_CriaPagamentoComImpostoRet', @ErrorLevelStr

	RETURN @ErrorLevel
GO
