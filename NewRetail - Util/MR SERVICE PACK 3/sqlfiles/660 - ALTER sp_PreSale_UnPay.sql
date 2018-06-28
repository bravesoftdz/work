IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[sp_PreSale_UnPay]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[sp_PreSale_UnPay]
GO

CREATE PROCEDURE sp_PreSale_UnPay
			(
			@PreSaleID	int
			)
AS

/* ---------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Unmove os PreInventMov para o InventMov
		- Deleta os InventoryMovTax
		- Deleta os preInventory Movement
		- Desquita os lancamentos
		- Update Cash RegisterMovent
		- Transforma a PreSale em Sale

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Unmove os PreInventMov para o InventMov
		-202  Erro em Deleta os preInventory Movement
		-203  Erro em Deleta os registros de ligacao
		-204  Erro em Deleta os registros de quitacao
		-205  Erro em Troca o documento dos lancamentos
		-206  Erro em Deleta todos os lançamentos e Quitações
		-207  Erro em Transforma a PreSale em Sale
		-208  Erro em Deleta os InventoryMovTax
		-209  Erro em Alterar comissao


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	-----------------------	----------------------------------------------------------------------------------------------------------
	26 May	2000		Eduardo Costa		suporte ao novo financeiro e suporte a tratamento de erro
	26 June 2001		Davi Gouveia		Log de Return Values
	28 Oct	2003		Rodrigo Costa		Created Cursor for PreInvMov;
							Call sp_GetNextCode;
	18 Aug	2004		Rodrigo Costa		Gravar error log
	24 Mar	2005		Carlos Lima		Deleta os InventoryMovTax
	30 Mar  2005		Rodrigo Costa		Criar table temp para as quitacoes
	09 Dec	2005		Rodrigo Costa		Alterar comissao
	04 Jan	2007		Maximiliano Muniz	Retirada a transação;
	---------------------------------------------------------------------------------------------------------------------------------- */

DECLARE @IDInvoice 		int
DECLARE @ErrorLevel		int
DECLARE @SysError		int

--Declaração de variáveis para o Cursor de PreInventoryMov
DECLARE @InventMovTypeID 	int 
DECLARE @DocumentID 		int 
DECLARE @IDPessoa 		int 
DECLARE @StoreID 		int 
DECLARE @ModelID 		int 
DECLARE @BarCodeID 		char(20)
DECLARE @MovDate 		smalldatetime 
DECLARE @Qty 			float
DECLARE @CostPrice 		money 
DECLARE @SalePrice 		money 
DECLARE @Discount 		money 
DECLARE @ComissionID 		int 
DECLARE @UserID 		int 
DECLARE @IDPreInventoryMov	int
DECLARE @IDInventoryMov		int

SET @ErrorLevel = 0

SELECT 	@IDInvoice = IDInvoice
FROM		Invoice
WHERE 	IDPreSale = @PreSaleID

/* -------------------------------------------------------------*/
/*	Unmove os PreInventMov para o InventMov			*/
/* -------------------------------------------------------------*/
--Declaração do Cursor de PreInventoryMov

DECLARE PreInventoryMov_Cursor CURSOR FOR

	SELECT
		IM.IDInventoryMov,
		IM.InventMovTypeID,
		@PreSaleID,
		IM.IDPessoa,
		IM.StoreID,
		IM.ModelID,
		IM.BarCodeID,
		IM.MovDate,
		IM.Qty,
		IM.CostPrice,
		IM.SalePrice,
		IM.Discount,
		IM.IDUser

	FROM	
		InventoryMov IM
	WHERE   
		IM.DocumentID = @IDInvoice 
		AND
		IM.InventMovTypeID = 1

OPEN PreInventoryMov_Cursor

--Inicialização de PreInventoryMov_Cursor
FETCH NEXT FROM PreInventoryMov_Cursor INTO
	@IDInventoryMov,
	@InventMovTypeID,
	@DocumentID,
	@IDPessoa,
	@StoreID,
	@ModelID,
	@BarCodeID,
	@MovDate,
	@Qty,
	@CostPrice,
	@SalePrice,
	@Discount,
	@UserID
--Enquanto tem registros
WHILE @@FETCH_STATUS = 0
BEGIN
	EXEC sp_Sis_GetNextCode 'PreInventoryMov.IDPreInventoryMov', @IDPreInventoryMov OUTPUT

	INSERT PreInventoryMov
		(
		IDPreInventoryMov,
		InventMovTypeID,
		DocumentID,
		IDPessoa,
		StoreID,
		ModelID,
		BarCodeID,
		MovDate,
		Qty,
		CostPrice,
		SalePrice,
		Discount,
		UserID
		)
	VALUES 
		(
		@IDPreInventoryMov,
		@InventMovTypeID,
		@DocumentID,
		@IDPessoa,
		@StoreID,
		@ModelID,
		@BarCodeID,
		@MovDate,
		@Qty,
		@CostPrice,		@SalePrice,
		@Discount,
		@UserID	
		)

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		CLOSE PreInventoryMov_Cursor
		DEALLOCATE PreInventoryMov_Cursor
		SET @ErrorLevel = -201
		GOTO ERRO
	END

	--Atualizar os SaleItemCommisison
	UPDATE
		SaleItemCommission
	SET
		IDPreInventoryMov = @IDPreInventoryMov,	
		IDInventoryMov = Null
	WHERE
		IDInventoryMov = @IDInventoryMov

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		CLOSE PreInventoryMov_Cursor
		DEALLOCATE PreInventoryMov_Cursor
		SET @ErrorLevel = -209
		GOTO ERRO
	END


	FETCH NEXT FROM PreInventoryMov_Cursor INTO	
		@IDInventoryMov,
		@InventMovTypeID,
		@DocumentID,
		@IDPessoa,
		@StoreID,
		@ModelID,
		@BarCodeID,
		@MovDate,
		@Qty,
		@CostPrice,
		@SalePrice,
		@Discount,
		@UserID
END
--fechamento do cursor
CLOSE PreInventoryMov_Cursor
--Destruição do cursor
DEALLOCATE PreInventoryMov_Cursor

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END

/*----------------------------------------------------------------*/
/*	       Deleta os InventoryMovTax			  */
/*----------------------------------------------------------------*/


DELETE
	InventoryMovTax
FROM
	InventoryMov
WHERE
	InventoryMov.IDInventoryMov = InventoryMovTax.IDInventoryMov 
	AND
 	InventoryMov.DocumentID = @IDInvoice
	AND
	InventoryMov.InventMovTypeID = 1 

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -208
	GOTO ERRO
END

/*----------------------------------------------------------------*/
/*	       Deleta os preInventory Movement			  */
/*----------------------------------------------------------------*/

DELETE 
	InventoryMov
WHERE
 	InventoryMov.DocumentID = @IDInvoice
	AND
	InventoryMov.InventMovTypeID = 1 

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -202
	GOTO ERRO
END

/*----------------------------------------------------------------*/
/*	       Desquita os lancamentos         			  */
/*----------------------------------------------------------------*/

/*----------- Cria tabela com as quitacoes a serem deletadas ------------ */
SELECT
	Q.IDQuitacao
INTO
	#sp_PreSale_Remove_QuitToDelete
FROM
	Fin_Quitacao Q
	JOIN Fin_LancQuit LQ ON (LQ.IDQuitacao = Q.IDQuitacao)
	JOIN Fin_Lancamento L ON (LQ.IDLancamento = L.IDLancamento)
WHERE
	L.IDPreSale = @PreSaleID


/*---------------- Deleta os registros de ligacao -------------------- */
DELETE
	LQ
FROM
	Fin_LancQuit LQ
	JOIN
	Fin_Lancamento 	L ON (L.IDLancamento = LQ.IDLancamento)
WHERE
	L.IDPreSale = @PreSaleID

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -203
	GOTO ERRO
END

/*--------------- Deleta os registros de quitacao -----------------*/
DELETE
	Q
FROM
	Fin_Quitacao Q
	JOIN #sp_PreSale_Remove_QuitToDelete QTD ON (QTD.IDQuitacao = Q.IDQuitacao)

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -204
	GOTO ERRO
END

/*---------------- Troca o documento dos lancamentos --------------------*/
UPDATE
	Fin_Lancamento
SET
	NumDocumento = Convert(varchar(50), @PreSaleID)
WHERE
	IDPreSale = @PreSaleID

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -205
	GOTO ERRO
END

/*----------------------------------------------------------------------------------------------------------------------------------------------------------*/
/*          Deleta todos os lançamentos e Quitações                                                                                */
/*----------------------------------------------------------------------------------------------------------------------------------------------------------*/ 

EXEC sp_PreSale_DeletePayments @PreSaleID, 0

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
            SET @ErrorLevel = -206
            GOTO ERRO
END



/*----------------------------------------------------------------*/
/*		Transforma a PreSale em Sale    		  */
/*----------------------------------------------------------------*/
UPDATE dbo.Invoice
	SET	dbo.Invoice.IDInvoice    = null,
		dbo.Invoice.InvoiceDate  = null,
		dbo.Invoice.CashReceived = null,
		dbo.Invoice.IDStore	 = null,
		dbo.Invoice.CashRegMovID = null
	WHERE
	 	dbo.Invoice.IDPreSale 	= @PreSaleID

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -207
	GOTO ERRO
END

OK:
	RETURN 0
ERRO:
	RETURN @ErrorLevel
GO
