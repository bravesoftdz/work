if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_CancelHold]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_CancelHold]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_DivideHold]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_DivideHold]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_Import_Estimated]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_Import_Estimated]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_Split]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_Split]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_UnPay]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_UnPay]
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
	30 Mar 2005		Rodrigo Costa		Chamada na sp para deletar os lancamentos
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

EXEC sp_PreSale_DeletePayments @IDPreSale, @IDUser

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

CREATE PROCEDURE sp_PreSale_DivideHold
	(
	@IDPreSale   int,
	@DeliverTypeID  int,
	@DeliverDate  dateTime,
	@DeliverAddress varchar(100),
	@DeliverOBS  varchar(255),
	@NewIDPreSale  int  output
	)
AS
 
/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	 SUMARIO
	 
	  - Cria um novo cabeçalho para o PreSale
	  - Inclui as quantidades dos items marcados para o novo PreSale
	  - Atualiza as quantiades do Antigo PreSale
	  - Remove os items marcados do Antigo PreSale
	  - Recalcula o total do novo PreSale
	  - Recalcula o total do antigo PreSale
	 
	 TABELA DE ERROS PARA RETURN_VALUE
	 
	   000  Ok
	  -201  Erro em Cria um novo cabeçalho para o PreSale
	  -202  Erro em Inclui as quantidades dos items marcados para o novo PreSale
	  -203  Erro em Atualiza as quantiades do Antigo PreSale
	  -204  Erro em Remove os items marcados do Antigo PreSale
	  -205  Erro em exec sp_PreSale_SubCalcTotal
	  -206  Erro em Recalcula o total do antigo PreSale
	  -207  Erro em atualizar a comissao
	 
	
	 LOG DE MODIFICAÇÕES
	 
	Data			Programador			Modificação
	-------------------------------------	--------------------------------------- 	-----------------------------------------------------------------------------------------------------
	22 Oct 	2004  		Carlos Lima  			Criação;
	29 Oct 	2004  		Rodrigo Costa  			Correcao;  Nao pode colocar a data do invoice, ainda nao e um invoice
	20 Jan	2005		Rodrigo Costa			Correcao; Removido o Discount + SalePrice do insert
	03 Fev  2005		Rodrigo Costa			Atualizao das garantias quando marcar entrega
	05 May	2005		Rodrigo Costa			Novo campo de desired markup
	12 May	2005		Rodrigo Costa			Removido o IDPreSale do Update IDPreInvParent para atualizar os desdobramentos
	01 Dec	2005		Leonardo Riego 			Removido campo de ComissionID da PreInventoryMov e atualizacao da SaleItemCommission com o novo IDPreInventoryMov
	-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */
 
DECLARE @ErrorLevel			int
DECLARE @SysError			int
 

--Declaração de variáveis para o Cursor de PreInventoryMov
DECLARE @IDPreInventoryMov		int
DECLARE @IDPreInvMovOld		int
DECLARE @InventMovTypeID		int
DECLARE @StoreID    			int
DECLARE @ModelID    			int
DECLARE @IDPessoa     		int
DECLARE @UserID     			int
DECLARE @IDCotacao    		int
DECLARE @IDPreInventoryMovParent  	int
DECLARE @BarCodeID    		TBarCode
DECLARE @DocumentID    		int
DECLARE @MovDate    		smalldatetime
DECLARE @Qty    			int
DECLARE @CostPrice    		money
DECLARE @SalePrice    		money
DECLARE @Discount     		money
DECLARE @DateEstimatedMov   	smalldatetime
DECLARE @DateRealMov   		smalldatetime
DECLARE @QtyRealMov    		int
DECLARE @Marked     			bit
DECLARE @ExchangeInvoice   		int
DECLARE @SuggRetail    		money
DECLARE @IDParentPack    		int
DECLARE @IDModelService    		int
DECLARE @DesiredMarkup		money
 
DECLARE @Date    			DateTime
DECLARE @SaleCode 			varchar(20)
DECLARE @IDStore 			int
 
SET @ErrorLevel = 0
 
BEGIN TRAN
 
/*------------------------------------------------------------------------------------------------------*/
/*      Cria um novo cabeçalho para o PreSale   */
/*-----------------------------------------------------------------------------------------------------*/ 
EXEC sp_Sis_GetNextCode'Invoice.IDPreSale', @NewIDPreSale OUTPUT

SELECT	
	@IDStore = IDStore
FROM
	Invoice
WHERE
	IDPreSale = @IDPreSale

EXEC SP_PreSale_GetNewSaleCode @IDPreSale, @IDStore, @SaleCode output
 
INSERT Invoice 
	(
	IDPreSale,
	CashRegMovID,
	SpecialPriceID,
	IDMeioPag,
	IDTouristGroup,
	DeliverTypeID,
	MediaID,
	IDCustomer,
	IDStore,
	IDInvoice,
	OtherComissionID,
	IDLancPagOtherCom,

	PreSaleDate,
	--InvoiceDate,  -Nao pode colocar a data do invoice, ainda nao e um invoice
	DeliverDate,
	DeliverAddress,
	Passport,
	PassportDate,
	Ticket,
	AirLine,
	CompanyName,
	CompanyCGC,
	DepositDate,
	Tax,
	SubTotal,
	Note,
	ItemDiscount,
	TaxIsent,
	--nOpenUser,
	--RefreshInvoice,
	Printed,
	CashReceived,
	EstimatedPay,
	CardNumber,
	OtherExpences,
	Address,
	TaxIsemptValue,
	TaxIsemptItemDiscount,
	Layaway,
	FirstName,
	LastName,
	ZIP,
	--nOpenHoldCaixa,
	PrintNotes,
	DeliverOBS,
	DeliverConfirmation,
	IDFormOfPayment,
	AditionalExpenses,
	Canceled,
	IDPreSaleParent,
	SaleCode
	)
	SELECT
		@NewIDPreSale,
		CashRegMovID,
		SpecialPriceID,
		IDMeioPag,
		IDTouristGroup,
		@DeliverTypeID,
		MediaID,
		IDCustomer,
		IDStore,
		IDInvoice,
		OtherComissionID,
		IDLancPagOtherCom,
		PreSaleDate,
		--GetDate(), -Nao pode colocar a data do invoice, ainda nao e um invoice
		@DeliverDate,
		@DeliverAddress,
		Passport,
		PassportDate,
		Ticket,
		AirLine,
		CompanyName,
		CompanyCGC,
		DepositDate,
		Tax,
		SubTotal,
		Note,
		ItemDiscount,
		TaxIsent,
		--nOpenUser,
		--RefreshInvoice,
		Printed,
		CashReceived,
		EstimatedPay,
		CardNumber,
		OtherExpences,
		Address,
		TaxIsemptValue,
		TaxIsemptItemDiscount,
		Layaway,
		FirstName,
		LastName,
		ZIP,
		--nOpenHoldCaixa,
		PrintNotes,
		@DeliverOBS,
		1,--O PreSale deve ser  criado com a entrega já confirmada, pois sua criação parte de uma confirmação de entrega
		IDFormOfPayment,
		AditionalExpenses,
		Canceled,
		@IDPreSale,
		@SaleCode
 
	FROM
		Invoice
	WHERE
		Invoice.IDPreSale = @IDPreSale
 
SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END
 

/*---------------------------------------------------------------------------------------------------*/
/*           Inclui os items marcados para o novo PreSale              */
/*---------------------------------------------------------------------------------------------------*/
--Declaração do Cursor de PreInventoryMov
DECLARE PreInventoryMov_Cursor CURSOR FOR
 
SELECT
	InventMovTypeID,
	StoreID,
	ModelID,
	IDPessoa,
	UserID,
	IDCotacao,
	IDPreInventoryMovParent,
	BarCodeID,
	@NewIDPreSale,
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
	IDModelService,
 	IDPreInventoryMov,
	DesiredMarkup
FROM
	dbo.PreInventoryMov
WHERE
	DocumentID = @IDPreSale
   	AND
   	Marked = 1
	AND
   	InventMovTypeID = 1
 

OPEN PreInventoryMov_Cursor
 
--Inicialização de PreInventoryMov_Cursor
FETCH NEXT FROM PreInventoryMov_Cursor INTO
	@InventMovTypeID,
	@StoreID,
	@ModelID,
	@IDPessoa,
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
	@IDModelService,
	@IDPreInvMovOld,
	@DesiredMarkup
--Enquanto tem registros
WHILE @@FETCH_STATUS = 0
BEGIN
	EXEC sp_Sis_GetNextCode'PreInventoryMov.IDPreInventoryMov', @IDPreInventoryMov OUTPUT
 
	--Inclui as quantidades dos items marcados para o novo PreSale
	INSERT PreInventoryMov
		(
		IDPreInventoryMov,
		InventMovTypeID,
		StoreID,
		ModelID,
		IDPessoa,
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
		IDModelService,
		DesiredMarkup
		)
	VALUES
		(
		@IDPreInventoryMov,
		@InventMovTypeID,
		@StoreID,
		@ModelID,
		@IDPessoa,
		@UserID,
		@IDCotacao,
		@IDPreInventoryMovParent,
		@BarCodeID,
		@DocumentID,
		@MovDate,
		@QtyRealMov,
		@CostPrice,
		@SalePrice,
		((@Discount / @Qty) * @QtyRealMov), --Desconto tem que ser dividido nos invoices
		@DateEstimatedMov,
		@DateRealMov,
		0,
		0,
		@ExchangeInvoice,
		@SuggRetail,
		@IDParentPack,
		@IDModelService,
		@DesiredMarkup
		)
 
	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		CLOSE PreInventoryMov_Cursor
		DEALLOCATE PreInventoryMov_Cursor
		SET @ErrorLevel = -202
		GOTO ERRO
	END


	--Atualizar os SaleItemCommisison
	UPDATE
		SaleItemCommission
	SET
		IDPreInventoryMov = @IDPreInventoryMov
	WHERE
		IDPreInventoryMov = @IDPreInvMovOld

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		CLOSE PreInventoryMov_Cursor
		DEALLOCATE PreInventoryMov_Cursor
		SET @ErrorLevel = -207
		GOTO ERRO
	END


	--Atualizar os IDPreInvParent
	UPDATE
		PreInventoryMov
	SET
		IDPreInventoryMovParent = @IDPreInventoryMov
	WHERE
		--DocumentID = @IDPreSale
   		--AND
   		InventMovTypeID = 1
		AND
		IDPreInventoryMovParent = @IDPreInvMovOld

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		CLOSE PreInventoryMov_Cursor
		DEALLOCATE PreInventoryMov_Cursor
		SET @ErrorLevel = -202
		GOTO ERRO
	END

 
	FETCH NEXT FROM PreInventoryMov_Cursor INTO
		@InventMovTypeID,
		@StoreID,
		@ModelID,
		@IDPessoa,
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
		@IDModelService,
		@IDPreInvMovOld,
		@DesiredMarkup
END
--fechamento do cursor
CLOSE PreInventoryMov_Cursor
--Destruição do cursor
DEALLOCATE PreInventoryMov_Cursor
 

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -202
	GOTO ERRO
END
 
/*---------------------------------------------------------------------------------------------------------*/
/*           Atualiza as quantiades do Antigo PreSale  e o Desconto      */
/*---------------------------------------------------------------------------------------------------------*/
UPDATE PreInventoryMov
SET	Qty = Qty - QtyRealMov,
	Discount = Discount - ((Discount / Qty) * QtyRealMov), --Desconto tem que ser dividido nos invoices
 	Marked = 0,
	QtyRealMov = 0
WHERE
	DocumentID = @IDPreSale
	AND
	Marked = 1
	AND
	InventMovTypeID = 1
 
SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -203
	GOTO ERRO
END
 
/*---------------------------------------------------------------------------------------------------------*/
/*           Remove os items marcados do Antigo PreSale   */
/*---------------------------------------------------------------------------------------------------------*/
 
DELETE PreInventoryMov
WHERE
	DocumentID = @IDPreSale
	AND
	Qty = 0
	AND 
	InventMovTypeID = 1
 
SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -204
	GOTO ERRO
END
 
/*---------------------------------------------------------------------------------------------------------*/
/*            Recalcula o total do novo PreSale                */
/*---------------------------------------------------------------------------------------------------------*/
SET @Date = getDate()
 
EXEC sp_PreSale_SubCalcTotal @NewIDPreSale , @Date
 
SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -205
	GOTO ERRO 
END
 
/*---------------------------------------------------------------------------------------------------------*/
/*            Recalcula o total do antigo PreSale                */
/*---------------------------------------------------------------------------------------------------------*/
SET @Date = getDate()
 
EXEC sp_PreSale_SubCalcTotal @IDPreSale , @Date
 
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
	 EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PreSale_DivideHold', @ErrorLevelStr
 
 	RETURN @ErrorLevel
GO

CREATE PROCEDURE sp_PreSale_Import_Estimated
			(
			@IDEstimated		int,
			@TaxIsent		bit,
			@MediaID		int,
			@IDStore		int,
			@IDUser		int,
			@NewIDPreSale	int   Output 			
			)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Cria um novo cabeçalho para o PreSale
		- Inclui os items do orcamento

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Cria um novo cabeçalho para o PreSale
		-202  Erro em Atualizar o Orcamento
		-203  Erro ao importas os items do orcamento
		-204  Erro em exec sp_PreSale_SubCalcTotal
		-205  Erro em passar Prospect para Cliente
		-206  Erro em inserir comissao


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	19 Aug  2005		Rodrigo Costa		Criacao;
	09 Dec	2005		Rodrigo Costa		Inclusao da comissao
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

DECLARE @ErrorLevel		int
DECLARE @SysError		int
--Declaração de variáveis para o Cursor de PreInventoryMov
DECLARE @InventMovTypeID 	int 
DECLARE @StoreID		int
DECLARE @DocumentID 		int 
DECLARE @ModelID 		int 
DECLARE @MovDate 		smalldatetime 
DECLARE @Qty 			int 
DECLARE @CostPrice 		money 
DECLARE @SalePrice 		money 
DECLARE @IDPessoa 		int 
DECLARE @DateEstimatedMov 	smalldatetime 
DECLARE @DateRealMov 		smalldatetime 
DECLARE @ComissionID 		int 
DECLARE @IDPreInventoryMov	int
DECLARE @DesiredMarkup		money
DECLARE @Date			DateTime
DECLARE @IDSaleItemCommission	int

SET @ErrorLevel = 0

BEGIN TRAN
 
/*---------------------------------------------------------------------*/
/*                  Cria um novo cabeçalho para o PreSale              */
/*---------------------------------------------------------------------*/ 

EXEC sp_Sis_GetNextCode 'Invoice.IDPreSale', @NewIDPreSale OUTPUT
INSERT Invoice	(
		IDPreSale,
		IDStore,
 		PreSaleDate,
		IDCustomer,
		TaxIsent,
		MediaID,
		FirstName,
		LastName,
		Layaway
		)
		SELECT
			@NewIDPreSale,
			E.IDStore,
 			GetDate(),
			IsNull(E.IDPessoa,0),
 			@TaxIsent,
			@MediaID,
			P.PessoaFirstName,
			P.PessoaLastName,
			1
		FROM
			Estimated E
			LEFT OUTER JOIN Pessoa P ON (P.IDPessoa = E.IDPessoa)
		WHERE
			E.IDEstimated = @IDEstimated

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END

-- Atualizo o orcamento
UPDATE
	Estimated
SET
	IDPreSale = @NewIDPreSale
WHERE
	IDEstimated = @IDEstimated


SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -202
	GOTO ERRO
END

-- Atualizo o Cliente
UPDATE
	Pessoa
SET
	IDTipoPessoa = 1
WHERE
	IDPessoa = (Select IDPessoa FROM Estimated Where IDEstimated = @IDEstimated)


SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -205
	GOTO ERRO
END


/*---------------------------------------------------------------------*/
/*           Inclui os items marcados para o novo PreSale              */
/*---------------------------------------------------------------------*/
--Declaração do Cursor de PreInventoryMov
DECLARE PreInventoryMov_Cursor CURSOR FOR

		SELECT
			1,
			@NewIDPreSale,
			@IDStore,
			EI.IDModel,
			GetDate(),
			EI.Qty,
			IsNull(M.VendorCost, M.VendorCost),
			M.SellingPrice,
			IsNull(E.IDPessoa,0),
			E.EstimatedDate,
			GetDate(),
			SU.ComissionID,
			TG.DesiredMarkup
		FROM
			EstimatedItem EI
			JOIN Model M ON (M.IDModel = EI.IDModel) 
			JOIN TabGroup TG ON (M.GroupID = TG.IDGroup) 
			JOIN Estimated E ON (E.IDEstimated = EI.IDEstimated)
			JOIN SystemUser SU ON (SU.IDUser = E.IDUser)
		WHERE
			EI.IDEstimated = @IDEstimated


OPEN PreInventoryMov_Cursor

--Inicialização de PreInventoryMov_Cursor
FETCH NEXT FROM PreInventoryMov_Cursor INTO
	@InventMovTypeID,
	@DocumentID,
	@StoreID,
	@ModelID,
	@MovDate,
	@Qty,
	@CostPrice,
	@SalePrice,
	@IDPessoa,
	@DateEstimatedMov,
	@DateRealMov,
	@ComissionID,
	@DesiredMarkup
--Enquanto tem registros
WHILE
@@FETCH_STATUS = 0
BEGIN
	EXEC sp_Sis_GetNextCode'PreInventoryMov.IDPreInventoryMov', @IDPreInventoryMov OUTPUT

	INSERT PreInventoryMov
		(
		IDPreInventoryMov,
		InventMovTypeID,
		UserID,
		DocumentID,
		StoreID,
		ModelID,
		MovDate,
		Qty,
		CostPrice,
		SalePrice,
		IDPessoa,
		DateEstimatedMov,
		DateRealMov,
		DesiredMarkup
		)
	VALUES
		(
		@IDPreInventoryMov,
		@InventMovTypeID,
		@IDUser,
		@DocumentID,
		@StoreID,
		@ModelID,
		@MovDate,
		@Qty,
		@CostPrice,
		@SalePrice,
		@IDPessoa,
		@DateEstimatedMov,
		@DateRealMov,
		@DesiredMarkup
		)

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		CLOSE PreInventoryMov_Cursor
		DEALLOCATE PreInventoryMov_Cursor
		SET @ErrorLevel = -203
		GOTO ERRO
	END

	
	/*****************************************************************************************
		Inclusão do Comissionado na tabela de SaleItemCommission
	******************************************************************************************/
	EXEC sp_Sis_GetNextCode'SaleItemCommission.IDSaleItemCommission', @IDSaleItemCommission OUTPUT
	INSERT INTO dbo.SaleItemCommission
		(
		 IDSaleItemCommission,
		 IDPreInventoryMov,
		 IDCommission,
		 CommissionPercent
		)
		VALUES
		(
		 @IDSaleItemCommission,
		 @IDPreInventoryMov,
		 @ComissionID,
		 100
		)
	
	SET @SysError = @@ERROR
	IF @SysError <> 0 
	BEGIN
		SET @ErrorLevel = -206
		GOTO ERRO
	END


	FETCH NEXT FROM PreInventoryMov_Cursor INTO
		@InventMovTypeID,
		@DocumentID,
		@StoreID,
		@ModelID,
		@MovDate,
		@Qty,
		@CostPrice,
		@SalePrice,
		@IDPessoa,
		@DateEstimatedMov,
		@DateRealMov,
		@ComissionID,
		@DesiredMarkup
END
--fechamento do cursor
CLOSE PreInventoryMov_Cursor
--Destruição do cursor
DEALLOCATE PreInventoryMov_Cursor

SET @Date = GetDate()
EXEC sp_PreSale_SubCalcTotal @NewIDPreSale, @Date

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
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PreSale_Import_Estimated', @ErrorLevelStr

	RETURN @ErrorLevel
GO

CREATE PROCEDURE sp_PreSale_Split
			(
			@IDPreSale 		int,
			@NewIDPreSale	int   Output 			
			)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Cria um novo cabeçalho para o PreSale
		- Inclui os items marcados para o novo PreSale
		- Remove os items marcados para o novo PreSale

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Cria um novo cabeçalho para o PreSale
		-202  Erro em Inclui os items marcados para o novo PreSale
		-203  Erro em Remove os items marcados para o novo PreSale
		-204  Erro em exec sp_PreSale_SubCalcTotal
		-205  Erro em exec sp_PreSale_SubCalcTotal


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
	26 June 2001		Davi Gouveia		Log de Return Values
	29 Oct 	2003		Rodrigo Costa		Removido SELECT @NewIDPreSale = @@IDENTITY;
							Chama sp_GetNextCode para IDPreSale
	18 Aug 2004		Rodrigo Costa		Gravar error log
	05 May	2005		Rodrigo Costa		Novo campo de desired markup
	09 Dec	2005		Rodrigo Costa		Inclusao das comissoes
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

DECLARE @ErrorLevel		int
DECLARE @SysError		int
--Declaração de variáveis para o Cursor de PreInventoryMov
DECLARE @InventMovTypeID 	int 
DECLARE @DocumentID 		int 
DECLARE @StoreID 		int 
DECLARE @ModelID 		int 
DECLARE @BarCodeID 		char(20)
DECLARE @MovDate 		smalldatetime 
DECLARE @Qty 			int 
DECLARE @CostPrice 		money 
DECLARE @SalePrice 		money 
DECLARE @Discount 		money 
DECLARE @IDPessoa 		int 
DECLARE @DateEstimatedMov 	smalldatetime 
DECLARE @DateRealMov 		smalldatetime 
DECLARE @QtyRealMov 		int 
DECLARE @ComissionID 		int 
DECLARE @IDPreInventoryMov	int
DECLARE @DesiredMarkup		money
DECLARE @Date			DateTime
DECLARE @IDPreInvMovOld		int


SET @ErrorLevel = 0

BEGIN TRAN
 
/*---------------------------------------------------------------------*/
/*                  Cria um novo cabeçalho para o PreSale              */
/*---------------------------------------------------------------------*/ 
EXEC sp_Sis_GetNextCode'Invoice.IDPreSale', @NewIDPreSale OUTPUT
INSERT Invoice	(
		IDPreSale,
		IDInvoice,
		IDMeioPag,
		SpecialPriceID,
 		IDTouristGroup,
 		PreSaleDate,
 		InvoiceDate,
		OtherComissionID,
		IDCustomer,
		DeliverTypeID,
		DeliverDate,
		DeliverAddress,
		Passport,
		PassportDate,
 		Ticket,
		AirLine,
		CompanyName,
		CompanyCGC,
		DepositDate,
		Note,
		TaxIsent,
		MediaID
		)
		SELECT
			@NewIDPreSale,
			IDInvoice,
			IDMeioPag,
			SpecialPriceID,
			IDTouristGroup,
 			PreSaleDate,
			InvoiceDate,
			OtherComissionID,
			IDCustomer,
			DeliverTypeID,
			DeliverDate,
			DeliverAddress,
			Passport,
			PassportDate,
			Ticket,
 			AirLine,
			CompanyName,
			CompanyCGC,
			DepositDate,
			Note,
 			TaxIsent,
			MediaID
		FROM
			Invoice
		WHERE
			Invoice.IDPreSale = @IDPreSale

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END


/*---------------------------------------------------------------------*/
/*           Inclui os items marcados para o novo PreSale              */
/*---------------------------------------------------------------------*/
--Declaração do Cursor de PreInventoryMov
DECLARE PreInventoryMov_Cursor CURSOR FOR

		SELECT
			IDPreInventoryMov,
			InventMovTypeID,
			@NewIDPreSale,
			StoreID,
			ModelID,
			BarCodeID,
			MovDate,
			Qty,
			CostPrice,
			SalePrice,
			Discount,
			IDPessoa,
			DateEstimatedMov,
			DateRealMov,
			QtyRealMov,
			DesiredMarkup
		FROM
			dbo.PreInventoryMov
		WHERE
			DocumentID = @IDPreSale
			AND
			Marked = 1
			AND
			InventMovTypeID = 1


OPEN PreInventoryMov_Cursor

--Inicialização de PreInventoryMov_Cursor
FETCH NEXT FROM PreInventoryMov_Cursor INTO
	@IDPreInvMovOld,
	@InventMovTypeID,
	@DocumentID,
	@StoreID,
	@ModelID,
	@BarCodeID,
	@MovDate,
	@Qty,
	@CostPrice,
	@SalePrice,
	@Discount,
	@IDPessoa,
	@DateEstimatedMov,
	@DateRealMov,
	@QtyRealMov,
	@DesiredMarkup
--Enquanto tem registros
WHILE
@@FETCH_STATUS = 0
BEGIN
	EXEC sp_Sis_GetNextCode'PreInventoryMov.IDPreInventoryMov', @IDPreInventoryMov OUTPUT

	INSERT PreInventoryMov
		(
		IDPreInventoryMov,
		InventMovTypeID,
		DocumentID,
		StoreID,
		ModelID,
		BarCodeID,
		MovDate,
		Qty,
		CostPrice,
		SalePrice,
		Discount,
		IDPessoa,
		DateEstimatedMov,
		DateRealMov,
		QtyRealMov,
		DesiredMarkup
		)
	VALUES
		(
		@IDPreInventoryMov,
		@InventMovTypeID,
		@DocumentID,
		@StoreID,
		@ModelID,
		@BarCodeID,
		@MovDate,
		@Qty,
		@CostPrice,
		@SalePrice,
		@Discount,
		@IDPessoa,
		@DateEstimatedMov,
		@DateRealMov,
		@QtyRealMov,
		@DesiredMarkup
		)

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		CLOSE PreInventoryMov_Cursor
		DEALLOCATE PreInventoryMov_Cursor
		SET @ErrorLevel = -202
		GOTO ERRO
	END

	--Atualizar os SaleItemCommisison
	UPDATE
		SaleItemCommission
	SET
		IDPreInventoryMov = @IDPreInventoryMov
	WHERE
		IDPreInventoryMov = @IDPreInvMovOld

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		CLOSE PreInventoryMov_Cursor
		DEALLOCATE PreInventoryMov_Cursor
		SET @ErrorLevel = -207
		GOTO ERRO
	END

	FETCH NEXT FROM PreInventoryMov_Cursor INTO
		@IDPreInvMovOld,
		@InventMovTypeID,
		@DocumentID,
		@StoreID,
		@ModelID,
		@BarCodeID,
		@MovDate,
		@Qty,
		@CostPrice,
		@SalePrice,
		@Discount,
		@IDPessoa,
		@DateEstimatedMov,
		@DateRealMov,
		@QtyRealMov,
		@DesiredMarkup
END
--fechamento do cursor
CLOSE PreInventoryMov_Cursor
--Destruição do cursor
DEALLOCATE PreInventoryMov_Cursor


SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -202
	GOTO ERRO
END

/*---------------------------------------------------------------------*/
/*           Remove os items marcados para o novo PreSale              */
/*---------------------------------------------------------------------*/
DELETE
	PreInventoryMov
WHERE
	DocumentID = @IDPreSale
	AND
	Marked = 1
	AND
	InventMovTypeID = 1

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -203
	GOTO ERRO
END

SET @Date = GetDate()

exec sp_PreSale_SubCalcTotal @IDPreSale, @Date

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -204
	GOTO ERRO
END

EXEC sp_PreSale_SubCalcTotal @NewIDPreSale, @Date 

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -205
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
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PreSale_Split', @ErrorLevelStr

	RETURN @ErrorLevel
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
		-209  Erro em Alterar comissao


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	26 May	2000		Eduardo Costa		suporte ao novo financeiro e suporte a tratamento de erro
	26 June 2001		Davi Gouveia		Log de Return Values
	28 Oct	2003		Rodrigo Costa		Created Cursor for PreInvMov;
							Call sp_GetNextCode;
	18 Aug	2004		Rodrigo Costa		Gravar error log
	24 Mar	2005		Carlos Lima		Deleta os InventoryMovTax
	30 Mar  2005		Rodrigo Costa		Criar table temp para as quitacoes
	09 Dec	2005		Rodrigo Costa		Alterar comissao
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */



BEGIN TRAN

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
DECLARE @Qty 			int 
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

/*----------------------------------------------------------------*/
/*	    Unmove os PreInventMov para o InventMov                */
/*----------------------------------------------------------------*/


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
		@CostPrice,
		@SalePrice,
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
