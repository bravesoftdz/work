if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Purchase_CriaPagamentoComImposto]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Purchase_CriaPagamentoComImposto]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Purchase_CriaPagamentoComImpostoRet]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Purchase_CriaPagamentoComImpostoRet]
GO

CREATE PROCEDURE sp_Purchase_CriaPagamentoComImposto
	(
	@IDPurchase	int
	)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
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
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	24 Dez  2004		Rodrigo Costa		Criacao;
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

DECLARE @ErrorLevel			int
DECLARE @SysError			int
DECLARE @IDLancamentoParent 		int
DECLARE @SubTotal			money
DECLARE @Freight			money
DECLARE @CriaDisbur			int

--Declaração de variáveis para o Cursor de Fin_Lancamento
DECLARE @Pagando 			bit 
DECLARE @IDLancamentoTipo 		int 
DECLARE @DataLancamento 		smalldatetime 
DECLARE @IDUsuarioLancamento 		int 
DECLARE @Previsao 			bit 
DECLARE @Situacao 			int 
DECLARE @IDPessoaTipo 			int 
DECLARE @IDPessoa 			int 
DECLARE @IDEmpresa 			int 
DECLARE @DataVencimento 		smalldatetime 
DECLARE @DataEmissao 			datetime 
DECLARE @IDDocumentoTipo 		int 
DECLARE @ValorNominal 			money 
DECLARE @NumDocumento 			varchar(20)
DECLARE @IDMoeda 			int 
DECLARE @IDMoedaCotacao 		int 
DECLARE @LancamentoType 		int 
DECLARE @IDLancamento			int
DECLARE @TotalDesdobramento		int
DECLARE @NumDesdobramento		varchar(10)
DECLARE @CountImposto			int
DECLARE @TotalImposto			money


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
		P.DocumentDueDate,
		P.DocumentDate,
		1002,  -- Vendor Invoice
		IsNull(PT.SubTotal, 0) + IsNull(P.Freight, 0) + IsNull(P.OtherCharges, 0),
		P.DocumentNumber,
		P.IDPurchase,
		4, -- Dollar
		6, -- Cotacao Default - Dollar
		1  -- Lancamento Parent
	FROM
		Pur_Purchase P
		JOIN Pur_PurchaseTotal PT ON (PT.IDPurchase = P.IDPurchase)
		JOIN Store S ON (P.IDStore = S.IDStore)
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
		@IDMoeda,
		@IDMoedaCotacao,
		@LancamentoType
END
--fechamento do cursor
CLOSE Fin_Lancamento_Cursor
--Destruição do cursor
DEALLOCATE Fin_Lancamento_Cursor


--Pega o IDLancamento do Pararent e os Valores para criar os disbursement frete
SELECT 
	@IDLancamentoParent = @IDLancamento,
	@SubTotal = IsNull(PT.SubTotal, 0),
	@Freight = IsNull(P.Freight, 0) + IsNull(P.OtherCharges, 0),
	@CriaDisbur = 1,
	@IDLancamentoTipo = 7 -- Cost of Good ## Davi
FROM
	Pur_Purchase P
	JOIN Pur_PurchaseTotal PT ON (PT.IDPurchase = P.IDPurchase)
WHERE
	P.IDPurchase = @IDPurchase
	AND
	P.DocumentType = 'Invoice'
	
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
		@TotalImposto = IsNull(SUM(ABS(IsNull(PIT.TaxValue,0))), 0)
	FROM 
		Pur_PurchaseItemTax PIT
	WHERE
		PIT.IDPurchase = @IDPurchase

	SET @TotalImposto = (@SubTotal-@TotalImposto)

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
			SUM(ABS(IsNull(PIT.TaxValue,0))) as Value
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

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
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

	Data			Programador	Modificação
	----------------------- --------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	14 Mar 	2005		Carlos Lima	Criação
    	-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

DECLARE @ErrorLevel			int
DECLARE @SysError			int
DECLARE @IDLancamentoParent		int
DECLARE @SubTotal			money
DECLARE @Freight			money
DECLARE @CriaDisbur			int

--Declaração de variáveis para o Cursor de Fin_Lancamento
DECLARE @Pagando			bit
DECLARE @IDLancamentoTipo		int
DECLARE @DataLancamento			smalldatetime
DECLARE @IDUsuarioLancamento		int
DECLARE @Previsao			bit
DECLARE @Situacao			int
DECLARE @IDPessoaTipo			int
DECLARE @IDPessoa			int
DECLARE @IDEmpresa			int
DECLARE @DataVencimento			smalldatetime
DECLARE @DataEmissao			datetime
DECLARE @IDDocumentoTipo		int
DECLARE @ValorNominal			money
DECLARE @NumDocumento			varchar(20)
DECLARE @IDMoeda			int
DECLARE @IDMoedaCotacao			int
DECLARE @LancamentoType			int
DECLARE @IDLancamento			int
DECLARE @TotalDesdobramento		int
DECLARE @NumDesdobramento		varchar(10)
DECLARE @CountImposto			int
DECLARE @TotalImposto			money


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
		4, -- Dollar
		6, -- Cotacao Default - Dollar
		1  -- Lancamento Parent
	FROM
		Pur_Purchase P
		JOIN Pur_PurchaseTotal PT ON (PT.IDPurchase = P.IDPurchase)
		JOIN Store S ON (P.IDStore = S.IDStore)
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
		@IDMoeda,
		@IDMoedaCotacao,
		@LancamentoType
END
--fechamento do cursor
CLOSE Fin_Lancamento_Cursor
--Destruição do cursor
DEALLOCATE Fin_Lancamento_Cursor


--Pega o IDLancamento do Pararent e os Valores para criar os disbursement frete
SELECT 
	@IDLancamentoParent = @IDLancamento,
	@SubTotal = IsNull(PT.SubTotalRet, 0) * -1,
	@Freight = (IsNull(P.FreightRet, 0) + IsNull(P.OtherChargesRet, 0)) * -1,
	@CriaDisbur = 1,
	@IDLancamentoTipo = 7 -- Cost of Good ## Davi
FROM
	Pur_Purchase P
	JOIN Pur_PurchaseTotal PT ON (PT.IDPurchase = P.IDPurchase)
WHERE
	P.IDPurchase = @IDPurchase
	AND
	P.DocumentType = 'Invoice'
	
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
 
	SET  @TotalDesdobramento =  @@ROWCOUNT

	--Descubro o total dos impostos para diminuir com o da fatura
	SELECT 
		@TotalImposto = ISNULL(SUM(ABS(IsNull(PIT.TaxValue,0))), 0) * (-1)
	FROM 
		Pur_PurchaseItemTaxRet PIT
	WHERE
		PIT.IDPurchase = @IDPurchase

	SET @TotalImposto = (@SubTotal-@TotalImposto)

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
			SUM(ABS(IsNull(PIT.TaxValue,0))) * (-1) as Value
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

OK:
	RETURN 0
ERRO:
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_Purchase_CriaPagamentoComImpostoRet', @ErrorLevelStr

	RETURN @ErrorLevel
GO