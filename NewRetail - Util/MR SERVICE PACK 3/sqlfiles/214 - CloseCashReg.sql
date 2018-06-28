if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Cashregister_GetPayments]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Cashregister_GetPayments]
GO

CREATE PROCEDURE sp_Cashregister_GetPayments(
	@Caixa 		int, 
	@CaixaFechado 	int, 
	@TipoPag 		int, 
	@IsFechado 		bit,
	@IDStore 		int
	) AS
/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Delete em #Lancamentos_Caixa
		- Insert em #Lancamentos_Caixa

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Delete em #Lancamentos_Caixa
		-202  Erro em Insert em #Lancamentos_Caixa

	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	----------------- --------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May 	2000		Carlos Lima		Criacao;
	27 Abr	2005		Rodrigo Costa		Inclusao do filtro por loja
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

DECLARE @ErrorLevel 	INT
DECLARE @SysError	INT

SET @ErrorLevel = 0

DELETE FROM #Lancamentos_Caixa

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END

INSERT INTO #Lancamentos_Caixa
	(
		IDLancamento,
		CheckNumber,
		CustomerDocument,
		CustomerName,
		CustomerPhone,
		ValorNominal,
		DataVencimento,
		IDPreSale,
		IDCashRegMov,
		Banco,
		Tipo,
		MeioPag,
		IDCashRegMovClosed,
		SaleCode,
		InvoiceTotal,
		PreSaleDate,
		NumDesdobramento
	)
	SELECT
		Fin_Lancamento.IDLancamento,
		Fin_Lancamento.CheckNumber,
		Fin_Lancamento.CustomerDocument,
		Fin_Lancamento.CustomerName,
		Fin_Lancamento.CustomerPhone,
		Fin_Lancamento.ValorNominal,
		Fin_Lancamento.DataVencimento,
		Fin_Lancamento.IDPreSale,
		Fin_Lancamento.IDCashRegMov,
		Fin_Banco.Banco,
		MeioPag.Tipo,
		MeioPag.MeioPag,
		IDCashRegMovClosed,
		I.SaleCode,
		((((I.SubTotal - I.ItemDiscount) - I.TaxIsemptItemDiscount) + I.AditionalExpenses) + I.Tax) as InvTotal,
		I.PreSaleDate,
		NumDesdobramento
	FROM
		Fin_Lancamento
		INNER JOIN Invoice I ON Fin_Lancamento.IDPreSale = I.IDPreSale
		INNER JOIN MeioPag ON Fin_Lancamento.IDQuitacaoMeioPrevisto = MeioPag.IDMeioPag
		LEFT JOIN Fin_Banco
			ON Fin_Lancamento.IDBankCheck = Fin_Banco.IDBanco
	WHERE
		I.IDStore = IsNull(@IDStore, I.IDStore)
		AND
		(
			@TipoPag IS NULL
			OR
			MeioPag.Tipo = @TipoPag
		)
	
		AND
	
	  	(
			(MeioPag.Tipo NOT IN (2, 4))
			OR 
			Convert(DateTime, Convert(VARCHAR, Fin_Lancamento.DataLancamento, 103), 103) < getDate()
		)
	
		AND
	
	  	(
			(
				Fin_Lancamento.IDCashRegMovClosed = @CaixaFechado
				AND
				ISNULL(@IsFechado, 0) = 1
			)
			OR
			(
				Fin_Lancamento.IDCashRegMovClosed IS NULL 
				AND
				(
					--Traz os lançamentos não quitados desse caixa	
				  	Fin_Lancamento.IDCashRegMov = @Caixa
					
			  		OR -- Ou de outro caixa, desde que...
			  		(
			  			(Fin_Lancamento.PaymentPlace = 0) -- Local pagamento seja a loja
			  			OR -- Ou
			  			(
							Fin_Lancamento.DataLancamento <= getDate() -- Data do Lançamento seja menor que hoje
			   				AND Fin_Lancamento.PaymentPlace <> 0 -- Em qualquer lugar que não seja na loja
			  			)
			  		)
				)
			)
	  	)

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -202
	GOTO ERRO
END


OK:
	RETURN 0

ERRO:
	PRINT CAST(@ErrorLevel AS VARCHAR)
	RETURN @ErrorLevel

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_Cashregister_GetPayments', @ErrorLevelStr

	RETURN @ErrorLevel
GO
