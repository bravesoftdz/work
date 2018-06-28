SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_Commission_PayGuide]
		(
		@IDStore		int,
		@IDGuide 		int,
		@PayDate		smalldatetime,
		@IDMeioPag		int,
		@IDContaCorrente	int,
		@Commission		money,
		@Adjust		money,
		@DataIni		smalldatetime,
		@DataFim		smalldatetime,
		@IDTouristGroup	int,
		@IDUser		int,
		@Date			DateTime,
		@IDLancamento	int output
		)
AS



/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO
		
		- Deleto os InventoryMov
		- Incluo no Inventario se necessario

	TABELA DE ERROS PARA RETURN_VALUE
	
		 000  Ok
		-201  Erro em Select Centro Custo
		-202  Erro em Insert Fin_Lancamento
		-203  Erro em Insert Fin_Quitacao
		-204  Erro em Insert Fin_LancQuit
		-205  Erro em Insert Fin_GroupCoast
		-206  Erro em Update TouristGoup
		-207  Erro em Insert TouristGroup

	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	26 Maio 2000		Eduardo Costa		suporte ao novo financeiro;
	27 Oct	2003		André Bogado		Chamada a sp_Sis_GetNextCode
							Declaração de GroupCost_Cursor
							Declaração de TouristGroup_Cursor
	18 Aug 2004		Rodrigo Costa		Gravar error log
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */



DECLARE  	@IDQuitacao		int
DECLARE	@IDCentroCusto	int
DECLARE 	@IDEmpresa		int
DECLARE 	@ErrorLevel		int
DECLARE	@SysError		int

--Declaração de variáveis para o Cursor de GroupCost
DECLARE @IDCost 		int
DECLARE @IDCostType 	int 
DECLARE @CostDate 		smalldatetime 
DECLARE @UnitCost 		money 
DECLARE @Quantity 		float 

--Declaração de variáveis para o Cursor de TouristGroup
DECLARE @TipTouristGroup 		varchar(50)
DECLARE @IDAgency 			int 
DECLARE @EnterDate 			smalldatetime 
DECLARE @NumTourist 		int 
DECLARE @ComissaoSobreGuia 	money 
DECLARE @DescontaCoordenacao 	bit  
DECLARE @Permanente 		bit 
DECLARE @DiasValidade 		int 
DECLARE @TipGuide 			varchar(30)
DECLARE @TipAgency 			varchar(30)
DECLARE @IDHotel 			int 

IF NOT (@IDGuide > 0)
   RETURN

BEGIN TRAN


/*----------------------------------------------------------------*/
/*		Inclui o registro do pagamento			  */ 
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
EXEC sp_Sis_GetNextCode 'Fin_Lancamento.IDLancamento', @IDLancamento OUTPUT
INSERT Fin_Lancamento
		(
		IDLancamento,
		IDLancamentoTipo,
		Pagando,
		IDCentroCusto,
		IDPessoaTipo,
		IDPessoa,
		IDDocumentoTipo,
		IDMoeda,
		IDMoedaCotacao,
		DataLancamento,
		DataVencimento,
		ValorNominal,
		IDEmpresa,
		IDUsuarioLancamento
		)
		VALUES
		(
		@IDLancamento,
		6, --  \\Despesa\Comissoes\Pagamento Comissoes
		1,
		@IDCentroCusto,
		5, -- Guide
		@IDGuide,
		0, -- Temporario
		4, -- Dollares
		6, -- CotacaoPadrao do Dollar 
		@PayDate,
		@PayDate,
		@Commission,
		@IDEmpresa,
		@IDUser
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
EXEC sp_Sis_GetNextCode 'Fin_Quitacao.IDQuitacao', @IDQuitacao OUTPUT
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

/*----------------------------------------------------------------*/
/*		Inclui o Cost no GroupCost			  */
/*----------------------------------------------------------------*/
--Declaração do Cursor de GroupCost
DECLARE GroupCost_Cursor CURSOR FOR
SELECT
	TG.IDTouristGroup,
	3, -- Guide Commission
	MIN(TG.EnterDate),
	SUM(IsNull( C.MovCommission * (1-(TG.ComissaoSobreGuia*TG.DescontaCoordenacao/100)) ,0)) * @Adjust,
	1
FROM
	TouristGroup TG (NOLOCK)
	JOIN Pessoa P (NOLOCK)
		ON (TG.IDGuide = P.IDPessoa)
	JOIN Invoice I (NOLOCK)
		ON (TG.IDTouristGroup = I.IDTouristGroup)
	JOIN vwCommission C (NOLOCK)
		ON (C.DocumentID = I.IDInvoice AND C.InventMovTypeID=1 AND P.IDTipoPessoa = C.IDTipoPessoa)
WHERE
	TG.IDGuide = @IDGuide
	AND
	TG.EnterDate >= @DataIni
	AND
	TG.EnterDate <  @DataFim			
	AND
	TG.IDLancPagGuia IS NULL			
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
	EXEC sp_Sis_GetNextCode 'GroupCost.IDCost', @IDCost OUTPUT
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
	IDLancPagGuia = @IDLancamento
WHERE	
	IDTouristGroup = IsNull(@IDTouristGroup, IDTouristGroup) 
	AND
	IDGuide = @IDGuide 	 	AND
	EnterDate >= @DataIni	
	AND
	EnterDate <  @DataFim	
	AND
	IDLancPagGuia IS NULL	


SET @SysError = @@ERROR
IF @SysError <> 0  
BEGIN
	SET @ErrorLevel = -206
	GOTO ERRO
END

 

/*-------------------------------------------------------------------*/

/* Inclui um segundo grupo com as mesmas caracteristicas do primeiro */
/*-------------------------------------------------------------------*/
--Declaração do Cursor de TouristGroup
DECLARE TouristGroup_Cursor CURSOR FOR

		SELECT	
			TipTouristGroup, 
			IDGuide, 
			IDAgency, 
			EnterDate, 
			IDStore,
			NumTourist,
			ComissaoSobreGuia,
			DescontaCoordenacao,
			IDUser,
			Permanente,
			DiasValidade,
			TipGuide,
			TipAgency,
			IDHotel

		FROM	
			TouristGroup (NOLOCK)
		WHERE	
			IDLancPagGuia = @IDLancamento
			AND
			(
   			  (
      			    ( EnterDate >= dateadd(hour, -6,  @Date) )
      		    	    AND
      			    ( dateadd(day, - DiasValidade, EnterDate) < dateadd(hour, -6,  @Date) )
   			  )
   			  OR
   			  ( Permanente = 1 )
			)	
OPEN TouristGroup_Cursor

--Inicialização de TouristGroup_Cursor
FETCH NEXT FROM TouristGroup_Cursor INTO
	@TipTouristGroup,
	@IDGuide,
	@IDAgency,
	@EnterDate,
	@IDStore,
	@NumTourist,
	@ComissaoSobreGuia,
	@DescontaCoordenacao,
	@IDUser,
	@Permanente,
	@DiasValidade,
	@TipGuide,
	@TipAgency,
	@IDHotel
--Enquanto tem registros
WHILE @@FETCH_STATUS = 0
BEGIN
	EXEC sp_Sis_GetNextCode 'TouristGroup.IDTouristGroup', @IDTouristGroup OUTPUT
	INSERT TouristGroup
		(
		IDTouristGroup,
		TipTouristGroup,
		IDGuide,
		IDAgency,
		EnterDate,
		IDStore,
		NumTourist,
		ComissaoSobreGuia,
		DescontaCoordenacao,
		IDUser,
		Permanente,
		DiasValidade,
		TipGuide,
		TipAgency,
		IDHotel
		)
	VALUES
		(
		@IDTouristGroup,
		@TipTouristGroup,
		@IDGuide,
		@IDAgency,
		@EnterDate,
		@IDStore,
		@NumTourist,
		@ComissaoSobreGuia,
		@DescontaCoordenacao,
		@IDUser,
		@Permanente,
		@DiasValidade,
		@TipGuide,
		@TipAgency,
		@IDHotel	
		)
	
	SET @SysError = @@ERROR
	IF @SysError <> 0  
	BEGIN
		CLOSE TouristGroup_Cursor
		DEALLOCATE TouristGroup_Cursor
		SET @ErrorLevel = -206
		GOTO ERRO
	END

	FETCH NEXT FROM TouristGroup_Cursor INTO
		@TipTouristGroup,
		@IDGuide,
		@IDAgency,
		@EnterDate,
		@IDStore,
		@NumTourist,
		@ComissaoSobreGuia,
		@DescontaCoordenacao,
		@IDUser,
		@Permanente,
		@DiasValidade,
		@TipGuide,
		@TipAgency,
		@IDHotel
END

--fechamento do cursor
CLOSE TouristGroup_Cursor
--Destruição do cursor
DEALLOCATE TouristGroup_Cursor

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
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_Commission_PayGuide', @ErrorLevelStr

	RETURN @ErrorLevel
GO
