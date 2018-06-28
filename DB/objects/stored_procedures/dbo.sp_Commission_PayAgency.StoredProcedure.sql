SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_Commission_PayAgency] 
		(
		@IDStore		int,
		@IDAgency 		int,
		@PayDate		smalldatetime,
		@IDMeioPag		int,
		@IDContaCorrente	int,
		@Commission		money,
		@Adjust		money,
		@DataIni		smalldatetime,
		@DataFim		smalldatetime,
		@IDUser		int,
		@IDLancamento	int	output
		)
AS


/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO
		
		- Deleto os InventoryMov
		- Incluo no Inventario se necessario

	TABELA DE ERROS PARA RETURN_VALUE
	
		 000  Ok
		-201  Erro em Centro Custo
		-202  Erro em Insert Fin_Lancamento
		-203  Erro em Insert Fin_Quitacao
		-204  Erro em Insert Fin_LancQuit
		-205  Erro em Insert Fin_GroupCoast
		-206  Erro em Update TouristGoup

	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	26 Maio 2000		Eduardo Costa		suporte ao novo financeiro;
	21 Oct	2003		André Bogado		Chamada a sp_Sis_GetNextCode
							Declaração do Cursor
	18 Aug 2004		Rodrigo Costa		Gravar error log
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */


DECLARE @IDQuitacao		int
DECLARE @IDCentroCusto	int
DECLARE @IDEmpresa		int
DECLARE @ErrorLevel		int

--Declaração de variáveis para o Cursor de GroupCost
DECLARE @IDCost 		int
DECLARE @IDTouristGroup 	int 
DECLARE @IDCostType 	int 
DECLARE @CostDate 		smalldatetime 
DECLARE @UnitCost 		money 
DECLARE @Quantity 		float 
DECLARE @SysError		int

if not (@IDAgency > 0)
   return

BEGIN TRAN


/*----------------------------------------------------------------*/
/*	Inclui o registro do pagamento  	*/ 
/*----------------------------------------------------------------*/
/*
	Descobre o Centro de Custo
*/ 

SELECT 	
	@IDCentroCusto = S.IDCentroCusto,
	@IDEmpresa = S.IDEmpresa
FROM 	
	Store S (NOLOCK)
WHERE 	
	S.IDStore = @IDStore

SET @SysError = @@ERROR
IF @SysError <> 0  
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END

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
		IDPessoaTipo,
		IDPessoa,
		IDEmpresa,
		IDUsuarioLancamento,
		IDDocumentoTipo,
		IDMoeda,
		IDMoedaCotacao,
		DataLancamento,
		DataVencimento,
		ValorNominal
		)
		VALUES
		(
		@IDLancamento,
		6, --  \\Despesa\Comissoes\Pagamento Comissoes
		1,
		@IDCentroCusto,
		6, -- Agency
		@IDAgency,
		@IDEmpresa,
		@IDUser,
		0, -- Temporario
		4, -- Dollares
		6, -- CotacaoPadrao do Dollar 
		@PayDate,
		@PayDate,
		@Commission
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
INSERT	
		Fin_Quitacao
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
		@Commission,
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
		VALUES
		(	
		@IDLancamento,
		@IDQuitacao,
		@Commission,
		0,
		@IDUser
		)

SET @SysError = @@ERROR
IF @SysError <> 0  
BEGIN
	SET @ErrorLevel = -204
	GOTO ERRO
END


/*----------------------------------------------------------------------------------------------------------------------*/
/*		Inclui o Cost no GroupCost			 	 */
/*----------------------------------------------------------------------------------------------------------------------*/
--Declaração do Cursor de GroupCost
DECLARE GroupCost_Cursor CURSOR FOR

SELECT
	TG.IDTouristGroup,
	4, -- Agency Commission
	MIN(TG.EnterDate),
	SUM(IsNull(C.MovCommission* (TG.ComissaoSobreGuia/100), 0)) * @Adjust,
	1
FROM
	TouristGroup TG (NOLOCK)
	JOIN Pessoa PG (NOLOCK)
		ON (TG.IDGuide = PG.IDPessoa)
	JOIN Invoice I (NOLOCK)
		ON (TG.IDTouristGroup = I.IDTouristGroup)
	JOIN vwCommission C (NOLOCK)
		ON (C.DocumentID = I.IDInvoice AND C.InventMovTypeID=1 AND PG.IDTipoPessoa = C.IDTipoPessoa)
WHERE
	TG.IDAgency = @IDAgency
	AND
	TG.EnterDate >= @DataIni
	AND
	TG.EnterDate <  @DataFim			
	AND
	TG.IDLancPagAgencia IS NULL			
GROUP BY 
	TG.IDTouristGroup

--Abertura do Cursor
OPEN GroupCost_Cursor 

--Inicialização de GroupCost_Cursor
FETCH NEXT FROM GroupCost_Cursor INTO
	@IDTouristGroup,
	@IDCostType,
	@CostDate,
	@UnitCost,
	@Quantity

--Enquanto tem registros
WHILE @@FETCH_STATUS = 0
BEGIN
	exec sp_Sis_GetNextCode 'GroupCost.IDCost', @IDCost OUTPUT

	INSERT GroupCost
		(
		IDCost,
		IDTouristGroup,
		IDCostType,
		CostDate,
		UnitCost,
		Quantity
		)
	VALUES
		(
		@IDCost,
		@IDTouristGroup,
		@IDCostType,
		@CostDate,
		@UnitCost,
		@Quantity	
		)

	SET @SysError = @@ERROR
	IF @SysError <> 0  
	BEGIN
		CLOSE GroupCost_Cursor
		DEALLOCATE GroupCost_Cursor
		SET @ErrorLevel = -205
		GOTO ERRO
	END
	FETCH NEXT FROM GroupCost_Cursor INTO
		@IDTouristGroup,
		@IDCostType,
		@CostDate,
		@UnitCost,
		@Quantity
END
--fechamento do cursor
CLOSE GroupCost_Cursor
--Destruição do cursor
DEALLOCATE GroupCost_Cursor

SET @SysError = @@ERROR
IF @SysError <> 0  
BEGIN
	SET @ErrorLevel = -205
	GOTO ERRO
END



/*----------------------------------------------------------------*/
/*		Registra o pagamento nos grupos			  */
/*----------------------------------------------------------------*/
UPDATE	
	TouristGroup
SET	
	IDLancPagAgencia = @IDLancamento
WHERE
	IDAgency = @IDAgency 	
	AND
	EnterDate >= @DataIni	
	AND
	EnterDate <  @DataFim	
	AND
	IDLancPagAgencia IS NULL

SET @SysError = @@ERROR
IF @SysError <> 0  
BEGIN
	SET @ErrorLevel = -206
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
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_Commission_PayAgency', @ErrorLevelStr

	RETURN @ErrorLevel
GO
