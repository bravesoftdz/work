if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Invoice_CalcComission]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Invoice_CalcComission]
GO

CREATE PROCEDURE sp_Invoice_CalcComission
		(
		@IDCentroCusto	int,
		@IDInvoice   		int,
		@IDInventoryMov 	int,
		@IDTipoLanc		int
		)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Cria tabela temporaria para registrar o total de comissao do invoice
		para cada vendedor.
		- Calcula a dada de vencimento de cada vendedor
		- Certifica que exitem registros de lancamentos ja abertos para cada
		vendedor.
		Caso nao exista cria um novo registro.
		- Marca nas movimentacoes de inventario os arquivos de lancamentos corretos

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Preenche a tabela temporaria com as comissoes por vendedor
		-202  Erro em UPDATE	#InvComiss
		-203  Erro em INSERT	Fin_Lancamento
		-205  Erro em UPDATE	Fin_Lancamento
		-206  Erro em Marca nas movimentacoes de inventario os arquivos de lancamentos corretos


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	16 Nov  1999		Eduardo Costa		Criacao;
	26 May  2000		Eduardo Costa		suporte ao novo financeiro
	25 June 2001		Davi Gouveia		Log de Return Values
	29 oct  2003		Andre Bogado		Removido erro 204 (removido o update de IDLancamento)
							chamada a sp_Sis_GetNextCode em #InvComiss
							criado o cursor InvComiss_Cursor
	18 Aug 2004		Rodrigo Costa		Gravar error log
	22 Jan 2006		Leonardo Riego		Alterado o campo de Comissao da InventoryMov para SaleItemCommission
							sendo feito o novo calculo de multiplo comissionado na tabela #InvComiss
							e retirada a condicao do ID Comissionado na tabela #InvComiss e 
							InventoryMov nas movimentacoes de inventario os arquivos de lancamentos corretos.
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */



DECLARE @PayDate 	smalldatetime
DECLARE @ErrorLevel 	int
DECLARE @SysError	int

--Declaração de variáveis para o Cursor de #InvComiss
DECLARE @IDComission 	int
DECLARE @Comission 		money 
DECLARE @IDLancamento	int

SET @ErrorLevel = 0

BEGIN TRAN

if (SELECT PayComission FROM Media WHERE Media.IDMedia = (SELECT MediaID FROM Invoice WHERE IDInvoice = @IDInvoice)) = 1
BEGIN

/*

	--------------------------------------------------------------------
	Cria tabela temporaria para registrar o total de comissao do invoice
	para cada vendedor.

*/

CREATE TABLE #InvComiss
	(
	IDComission 	int 		NOT NULL ,
	Comission 	money 		NOT NULL ,
	VencDate	SmallDateTime	NULL,
	IDLancamento	int		NULL
	)



/*
	--------------------------------------------------------------------
	Preenche a tabela temporaria com as comissoes por vendedor

*/

--Declaração do Cursor de #InvComiss

DECLARE InvComiss_Cursor CURSOR FOR
(
		SELECT
			SIC.IDCommission,
			IsNull	( SUM 	(
					(( GroupToComType.Comission / ((100 / SIC.CommissionPercent) * 100) )) *
					(

						(
							(
	 						IsNull(InvMov.SalePrice, 0)-
							(TipoComissionado.ComissionOnProfit*IsNull(InvMov.CostPrice, 0))
							)*IsNull(InvMov.Qty, 0)
						)-IsNull(InvMov.Discount, 0)
					)
				), 0) Comission
		FROM 
			InventoryMov InvMov
			JOIN Model Model ON (InvMov.ModelID = Model.IDModel)
			JOIN SaleItemCommission SIC ON (SIC.IDInventoryMov = InvMov.IDInventoryMov)
			JOIN vwComissionado Comis ON (Comis.IDComissionado = SIC.IDCommission)
			JOIN GroupToComissionType GroupToComType ON (GroupToComType.GroupID = Model.GroupID AND GroupToComType.IDTipoComissionado = Comis.IDTipoComissionado )
			JOIN vwTipoComissionado TipoComissionado ON (TipoComissionado.IDTipoComissionado = Comis.IDTipoComissionado)
		WHERE	
			InvMov.DocumentID = @IDInvoice 
			AND
			InvMov.InventMovTypeID = 1
			AND
			InvMov.IDInventoryMov = IsNull(@IDInventoryMov, InvMov.IDInventoryMov)
		GROUP BY 
			SIC.IDCommission
		)
OPEN InvComiss_Cursor

--Inicialização de InvComiss_Cursor
FETCH NEXT FROM InvComiss_Cursor INTO
	@IDComission,
	@Comission
--Enquanto tem registros
WHILE
@@FETCH_STATUS = 0
BEGIN
	EXEC sp_Sis_GetNextCode'Fin_Lancamento.IDLancamento', @IDLancamento OUTPUT

	INSERT #InvComiss
		(
		IDLancamento,
		IDComission,
		Comission
		)
	VALUES
		(
		@IDLancamento,
		@IDComission,
		@Comission
		)

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		CLOSE InvComiss_Cursor
		DEALLOCATE InvComiss_Cursor
		SET @ErrorLevel = -201
		GOTO ERRO
	END

	FETCH NEXT FROM InvComiss_Cursor INTO
		@IDComission,
		@Comission
END
--fechamento do cursor
CLOSE InvComiss_Cursor
--Destruição do cursor
DEALLOCATE InvComiss_Cursor


SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END


/*
	--------------------------------------------------------------------
	Calcula a dada de vencimento de cada vendedor


*/

SELECT @PayDate = (SELECT InvoiceDate FROM Invoice WHERE IDInvoice = @IDInvoice)

UPDATE
	#InvComiss
SET
	VencDate = DateAdd	(
					Month,
					1,
					DateAdd	(
						day,
						- DatePart(Day, @PayDate),
						@PayDate
						)
					)

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -202
	GOTO ERRO
END

/*

	--------------------------------------------------------------------
	Certifica que exitem registros de lancamentos ja abertos para cada
	vendedor.
	Caso nao exista cria um novo registro.

*/


INSERT	Fin_Lancamento
		(
		IDLancamento,
		IDLancamentoTipo,
		IDCentroCusto,
 		IDDocumentoTipo,
		IDPessoa,
		IDMoeda,
		IDMoedaCotacao,
		DataLancamento,
		DataVencimento
		)
		(
		SELECT
			IDLancamento,
			@IDTipoLanc,	/* pagamento de Vendedor */
			@IDCentroCusto,
			0,	-- Temporario
			IC.IDComission,
			4, -- Dollares
			6, -- CotacaoPadrao do Dollar
			@PayDate,
			@PayDate
		FROM
			#InvComiss IC 		WHERE
			NOT EXISTS
				(
					SELECT
						L.IDLancamento
					FROM
						Fin_Lancamento L
					WHERE
						L.IDPessoa = IC.IDComission
						AND
						L.IDLancamentoTipo = @IDTipoLanc
						AND
						L.Situacao in (1,5) -- 1=Aberto, 5=ParteQuitado
						AND
						@PayDate < IC.VencDate
						AND
						L.Desativado = 0
				) 	)

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -203
	GOTO ERRO
END 

/*
	--------------------------------------------------------------------
	Agora todos os vendedores ja tem um registro de pagamento
	lancamento no financeiro.

	Falta atualizar o valor do lancamento, a partir da tabela
	temporaria, e atualizar a dada de pagamento do comissionado 

*/

UPDATE
	Fin_Lancamento
SET
	ValorNominal = ValorNominal + IC.Comission,
 	DataVencimento = IC.VencDate
FROM
	#InvComiss IC
WHERE
	IDLancamento = IC.IDLancamento 

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -205
	GOTO ERRO
END 

/*
	-------------------------------------------------------------------------
	Marca nas movimentacoes de inventario os arquivos de lancamentos corretos
*/


UPDATE
	InventoryMov
SET
	InventoryMov.IDLancPagCom = IC.IDLancamento
FROM	
	#InvComiss 		IC,
 	InventoryMov 	InvMov
WHERE
	InvMov.DocumentID = @IDInvoice
	AND
	InvMov.InventMovTypeID = 1
	
SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -206
	GOTO ERRO
END



/*

	--------------------------------------------------------------------
	Dropa a tabela temporaria

*/

DROP TABLE #InvComiss


END   /* End do if do MediaID */


OK:
	COMMIT TRAN
	RETURN 0

ERRO:
	ROLLBACK TRAN
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_Invoice_CalcComission', @ErrorLevelStr

	RETURN @ErrorLevel
GO
