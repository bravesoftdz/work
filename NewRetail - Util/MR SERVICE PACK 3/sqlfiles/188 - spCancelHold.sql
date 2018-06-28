if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_CancelHold]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_CancelHold]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_CancelInvoice]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_CancelInvoice]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_UnPay]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_UnPay]
GO

CREATE PROCEDURE sp_PreSale_UnPay
			(
			@PreSaleID	int
			)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
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
		-206  Erro em Update Cash RegisterMovent
		-207  Erro em Transforma a PreSale em Sale
		-208  Erro em Deleta os InventoryMovTax


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	26 May	2000		Eduardo Costa		suporte ao novo financeiro e suporte a tratamento de erro
	26 June 2001		Davi Gouveia		Log de Return Values
	28 Oct	2003		Rodrigo Costa		Created Cursor for PreInvMov;
							Call sp_GetNextCode;
	18 Aug	2004		Rodrigo Costa		Gravar error log
	24 Mar	2005		Carlos Lima		Deleta os InventoryMovTax
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */



BEGIN TRAN

DECLARE @IDInvoice 		int
DECLARE @ErrorLevel		int
DECLARE @SysError		int

--Declaração de variáveis para o Cursor de PreInventoryMov
DECLARE @InventMovTypeID 	int 
DECLARE @DocumentID 	int 
DECLARE @IDPessoa 		int 
DECLARE @StoreID 		int 
DECLARE @ModelID 		int 
DECLARE @BarCodeID 		char(20)
DECLARE @MovDate 		smalldatetime 
DECLARE @Qty 		int 
DECLARE @CostPrice 		money 
DECLARE @SalePrice 		money 
DECLARE @Discount 		money 
DECLARE @ComissionID 	int 
DECLARE @UserID 		int 
DECLARE @IDPreInventoryMov	int


SET @ErrorLevel = 0

SELECT 	@IDInvoice = IDInvoice
FROM		Invoice
WHERE 	IDPreSale = @PreSaleID

/*----------------------------------------------------------------*/
/*	    Unmove os PreInventMov para o InventMov                */
/*----------------------------------------------------------------*/


--Declaração do Cursor de PreInventoryMov

DECLARE PreInventoryMov_Cursor CURSOR FOR

	SELECT
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
		IM.ComissionID,
		IM.IDUser

	FROM	dbo.InventoryMov IM
	WHERE   IM.DocumentID = @IDInvoice AND
		IM.InventMovTypeID = 1

OPEN PreInventoryMov_Cursor

--Inicialização de PreInventoryMov_Cursor
FETCH NEXT FROM PreInventoryMov_Cursor INTO
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
	@ComissionID,
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
		ComissionID,
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
		@CostPrice,
		@SalePrice,
		@Discount,
		@ComissionID,
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

	FETCH NEXT FROM PreInventoryMov_Cursor INTO
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
		@ComissionID,
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
	JOIN
	Fin_Lancamento L ON (Q.SparrowInt = L.IDLancamento)
WHERE
	L.IDPreSale = @PreSaleID

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

/*----------------------------------------------------------------*/
/*		Update Cash RegisterMovent    		     	  */
/*----------------------------------------------------------------*/ 
UPDATE
	dbo.CashRegMov
SET
	dbo.CashRegMov.TotalSales = IsNull(dbo.CashRegMov.TotalSales, 0) -
		   	  		    IsNull(IsNull(Inv.SubTotal, 0) - IsNull(Inv.ItemDiscount, 0) -
					    IsNull(Inv.Tax, 0), 0) 
FROM
	Invoice	Inv
WHERE
	Inv.IDPreSale = @PreSaleID
	AND
	CashRegMov.IDCashRegMov = Inv.CashRegMovID

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
	COMMIT TRAN
	RETURN 0
ERRO:
	ROLLBACK TRAN
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PreSale_UnPay', @ErrorLevelStr

	RETURN @ErrorLevel
GO

CREATE PROCEDURE sp_PreSale_CancelHold
                                   (
                                   	@IDPreSale int,
			@IDUser int
                                   )
AS


/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
            SUMARIO
 

                        - Update Cash RegisterMovent
                        - Desquita o lancamento
                        - Deleta o lancamento


            TABELA DE ERROS PARA RETURN_VALUE

                         000  Ok
                        -201  Erro em Inser no PreInventoryMov (Cancelamento)
                        -202  Erro em Delete no PreInventoryMov
                        -203  Erro em Delete nos registros de Lançamento e Quitação
                        -204  Erro em Update no Invoice


            LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
            --------------------------------------- 	--------------------------------------	-----------------------------------------------------------------------------------------------------
	15 Oct 2004		Carlos Lima		Criação
	27 Jan 2005		Rodrigo Costa		Inclusao do @IDUser para deletar os lancamentos
	01 Fev 2005		Rodrigo Costa		Criacao do Cursor para delecao do PreInvMov
            -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */


BEGIN TRAN

DECLARE @ErrorLevel	int
DECLARE @SysError	int
DECLARE @IDLancamento	int
 

-- Variaveis para o cursor PreInv_Cursor
DECLARE  @IDPreInventoryMov		int
DECLARE  @StoreID			int
DECLARE  @ModelID			int
DECLARE  @IDPessoa			int
DECLARE  @ComissionID			int
DECLARE  @UserID			int
DECLARE  @IDCotacao			int
DECLARE  @IDPreInventoryMovParent	int
DECLARE  @BarCodeID			TBarCode
DECLARE  @DocumentID			int
DECLARE  @MovDate			smalldatetime
DECLARE  @Qty				int
DECLARE  @CostPrice			money
DECLARE  @SalePrice			money
DECLARE  @Discount			money
DECLARE  @DateEstimatedMov		smalldatetime
DECLARE  @DateRealMov			smalldatetime
DECLARE  @QtyRealMov			int
DECLARE  @Marked			bit
DECLARE  @ExchangeInvoice		int
DECLARE  @SuggRetail			money
DECLARE  @IDParentPack			int
DECLARE  @IDModelService		int
DECLARE  @IDPreInvMovOld		int


SET @ErrorLevel = 0

/*----------------------------------------------------------------------------------------------------------------------------------------------------------*/
/*          Insere movimentaçao de cancelamento com base na movimentação anterior                    */
/*----------------------------------------------------------------------------------------------------------------------------------------------------------*/ 
--Declaração do Cursor de PreInv_Cursor
DECLARE PreInv_Cursor CURSOR FOR 
            SELECT                       
                        StoreID,
                        ModelID,
                        IDPessoa,
                        ComissionID,
                        UserID,
                        IDCotacao,
                        IDPreInventoryMovParent,
                        BarCodeID,
                        DocumentID,
                        MovDate,
                        Qty,
                        CostPrice,
                        SalePrice,
                        Discount,
                        DateEstimatedMov,
                        DateRealMov,
                        QtyRealMov,
                        Marked,
                        ExchangeInvoice,
                        SuggRetail,
                        IDParentPack,
                        IDModelService
            FROM
                        PreInventoryMov
            WHERE
                        DocumentID = @IDPreSale
                        AND 
			InventMovTypeID = 1

OPEN PreInv_Cursor

--Inicialização de PreInv_Cursor
FETCH NEXT FROM PreInv_Cursor INTO
            @StoreID,
            @ModelID,
            @IDPessoa,
            @ComissionID,
            @UserID,
            @IDCotacao,
            @IDPreInventoryMovParent,
            @BarCodeID,
            @DocumentID,
            @MovDate,
            @Qty,
            @CostPrice,
            @SalePrice,
            @Discount,
            @DateEstimatedMov,
            @DateRealMov,
            @QtyRealMov,
            @Marked,
            @ExchangeInvoice,
            @SuggRetail,
            @IDParentPack,
            @IDModelService

--Enquanto tem registros
WHILE @@FETCH_STATUS = 0
BEGIN
            EXEC sp_Sis_GetNextCode 'Preinventorymov.IDPreInventoryMov', @IDPreInventoryMov OUTPUT

            INSERT PreInventoryMov
                        (
                        IDPreInventoryMov,
                        InventMovTypeID,
                        StoreID,
                        ModelID,
                        IDPessoa,
                        ComissionID,
                        UserID,
                        IDCotacao,
                        IDPreInventoryMovParent,
                        BarCodeID,
                        DocumentID,
                        MovDate,
                        Qty,
                        CostPrice,
                        SalePrice,
                        Discount,
                        DateEstimatedMov,
                        DateRealMov,
                        QtyRealMov,
                        Marked,
                        ExchangeInvoice,
                        SuggRetail,
                        IDParentPack,
                        IDModelService
                        )
                        VALUES
                        (
                        @IDPreInventoryMov,
                        25,
                        @StoreID,
                        @ModelID,
                        @IDPessoa,
                        @ComissionID,
                        @UserID,
                        @IDCotacao,
                        @IDPreInventoryMovParent,
                        @BarCodeID,
                        @DocumentID,
                        @MovDate,
                        @Qty,
                        @CostPrice,
                        @SalePrice,
                        @Discount,
                        @DateEstimatedMov,
                        @DateRealMov,
                        @QtyRealMov,
                        @Marked,
                        @ExchangeInvoice,
                        @SuggRetail,
                        @IDParentPack,
                        @IDModelService
                        )

            FETCH NEXT FROM PreInv_Cursor INTO
                        @StoreID,
                        @ModelID,
                        @IDPessoa,
                        @ComissionID,
                        @UserID,
                        @IDCotacao,
                        @IDPreInventoryMovParent,
                        @BarCodeID,
                        @DocumentID,
                        @MovDate,
                        @Qty,
                        @CostPrice,
                        @SalePrice,
                        @Discount,
                        @DateEstimatedMov,
                        @DateRealMov,
                        @QtyRealMov,
                        @Marked,
                        @ExchangeInvoice,
                        @SuggRetail,
                        @IDParentPack,
                        @IDModelService
END

--fechamento do cursor
CLOSE PreInv_Cursor
--Destruição do cursor
DEALLOCATE PreInv_Cursor

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
            SET @ErrorLevel = -201
            GOTO ERRO
END

/*----------------------------------------------------------------------------------------------------------------------------------------------------------*/
/*          Deletar movimentaçao de cancelamento com base na movimentação anterior                    */
/*----------------------------------------------------------------------------------------------------------------------------------------------------------*/ 
--Declaração do Cursor de PreInvDel_Cursor
DECLARE PreInvDel_Cursor CURSOR STATIC FOR 
	SELECT
		IDPreInventoryMov
	FROM
		PreInventoryMov
	WHERE
		DocumentID = @IDPreSale
		AND 
		InventMovTypeID = 1

OPEN PreInvDel_Cursor

--Inicialização de PreInv_Cursor
FETCH NEXT FROM PreInvDel_Cursor INTO
            @IDPreInvMovOld

--Enquanto tem registros
WHILE @@FETCH_STATUS = 0
BEGIN
	--Deletar os items
	EXEC sp_PreSale_SubRemoveItem @IDPreInvMovOld

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
	            SET @ErrorLevel = -202
	            GOTO ERRO
	END

            FETCH NEXT FROM PreInvDel_Cursor INTO
                        @IDPreInvMovOld
END

--fechamento do cursor
CLOSE PreInvDel_Cursor
--Destruição do cursor
DEALLOCATE PreInvDel_Cursor

/*
DELETE FROM
            PreInventoryMov
WHERE
            DocumentID = @IDPreSale
            AND InventMovTypeID = 1

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
            SET @ErrorLevel = -202
            GOTO ERRO
END
*/

/*----------------------------------------------------------------------------------------------------------------------------------------------------------*/
/*          Deleta todos os lançamentos e Quitações                                                                                */
/*----------------------------------------------------------------------------------------------------------------------------------------------------------*/ 

--Declaração do Cursor de Lancamento_Cursor
DECLARE Lancamento_Cursor CURSOR FOR
            SELECT 
                        IDLancamento
            FROM
                        Fin_Lancamento
            WHERE
                        IDPreSale = @IDPreSale

OPEN Lancamento_Cursor

--Inicialização de Lancamento_Cursor
FETCH NEXT FROM Lancamento_Cursor INTO @IDLancamento

--Enquanto tem registros
WHILE @@FETCH_STATUS = 0
BEGIN
            EXEC sp_PreSale_DeleteSingleDelayPayment @IDLancamento, @IDUser
            FETCH NEXT FROM Lancamento_Cursor INTO 
                        @IDLancamento
END

--fechamento do cursor
CLOSE Lancamento_Cursor
--Destruição do cursor
DEALLOCATE Lancamento_Cursor

 
SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
            SET @ErrorLevel = -203
            GOTO ERRO
END
 
/*----------------------------------------------------------------------------------------------------------------------------------------------------------*/
/*          Atualiza Status de Cancelado no invoice                                                                       */
/*----------------------------------------------------------------------------------------------------------------------------------------------------------*/ 

UPDATE 
            Invoice
SET
            Canceled = 1
WHERE
            IDPreSale = @IDPreSale

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
            SET @ErrorLevel = -204
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
            EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PreSale_CancelHold', @ErrorLevelStr
            RETURN @ErrorLevel
GO

CREATE PROCEDURE sp_PreSale_CancelInvoice
	(
	@IDPreSale int,
	@IDUser int
	)
AS
/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Transforma Invoice em Hold (Quando necessario)
		- Cancela o Hold

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Transforma Invoice em Hold
		-202  Erro em Cancela o Hold

	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	24 Mar  2005		Carlos Lima		Criacao;
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

DECLARE @ErrorLevel	int
DECLARE @SysError	int

DECLARE @IDInvoice	int

SELECT
	@IDInvoice = IDInvoice
FROM
	Invoice
WHERE
	IDPreSale = @IDPreSale

/* Transforma Invoice em Hold */

IF @IDInvoice <> NULL
	EXEC sp_PreSale_Unpay @IDPreSale

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
            SET @ErrorLevel = -201
            GOTO ERRO
END

EXEC sp_PreSale_CancelHold @IDPreSale, @IDUser

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
            SET @ErrorLevel = -202
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
            EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PreSale_CancelInvoice', @ErrorLevelStr
            RETURN @ErrorLevel
GO
