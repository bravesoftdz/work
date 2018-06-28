if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SP_PreSale_GetNewInvoiceCode]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[SP_PreSale_GetNewInvoiceCode]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SP_PreSale_GetNewSaleCode]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[SP_PreSale_GetNewSaleCode]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_CreateHold]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_CreateHold]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_Pay]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_Pay]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_DivideHold]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_DivideHold]
GO

CREATE PROCEDURE SP_PreSale_GetNewInvoiceCode
	(
	@IDStore 		int, 
	@InvoiceCode 		varchar(20) output
	) 
AS


DECLARE @MiddleSaleCode 	varchar(50)
DECLARE @ConcatStr 		varchar(50)

DECLARE @ErrorLevel  		int
DECLARE @SysError  		int


/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Obter novo InvoiceCode

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Obter novo InvoiceCode


	LOG DE MODIFICAÇÕES

	Data		Programador	Modificação
	-------------------------- -------------------------- ---------------------------------------------------------------------------------------------------------------------------
	03 Nov  2004	Carlos Lima	Criacao;
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

SET @ErrorLevel = 0
 
BEGIN TRAN

/*----------------------------------------------------------------*/
/*	Obter um novo InvoiceCode	*/
/*----------------------------------------------------------------*/

SET @ConcatStr = 'Invoice.InvoiceCode' + CONVERT(varchar, @IDStore)
EXEC sp_Sis_GetNextCode @ConcatStr, @MiddleSaleCode OUTPUT

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO 
END


SET @InvoiceCode = CONVERT(varchar(20), @MiddleSaleCode)

 
OK:
	COMMIT TRAN
	RETURN 0
ERRO:
	ROLLBACK TRAN
	PRINT CAST(@ErrorLevel AS VARCHAR)
 
	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: SP_PreSale_GetNewInvoiceCode', @ErrorLevelStr
 
	RETURN @ErrorLevel
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE SP_PreSale_GetNewSaleCode
	(
	@IDPreSaleParent 	int, 
	@IDStore 		int, 
	@SaleCode 		varchar(20) output
	) 
AS

DECLARE @ParentSaleCode 	varchar(20)
DECLARE @MiddleSaleCode 	varchar(50)
DECLARE @PartitionCount 	varchar
DECLARE @ConcatStr 		varchar(50)

DECLARE @ErrorLevel  		int
DECLARE @SysError  		int


/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Crio um novo SaleCode
		- Busco o SaleCode do pai

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Crio um novo SaleCode
		-202  Busco o SaleCode do pai


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	01 Nov  2000		Carlos Lima		Criacao;
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

SET @ErrorLevel = 0
 
BEGIN TRAN



IF @IDPreSaleParent IS NULL
	BEGIN
		SET @ConcatStr = 'Invoice.SaleCode' + CONVERT(varchar, @IDStore)
		EXEC sp_Sis_GetNextCode @ConcatStr, @MiddleSaleCode OUTPUT

		SET @SysError = @@ERROR
		IF @SysError <> 0
		BEGIN
			SET @ErrorLevel = -201
			GOTO ERRO 
		END
	END
ELSE
	BEGIN
		SELECT
			@ParentSaleCode = SaleCode
		FROM
			Invoice
		WHERE
			IDPreSale = @IDPreSaleParent


		SELECT
			@PartitionCount = (COUNT(*) + 1)
		FROM
			Invoice
		WHERE
			IDPreSaleParent = @IDPreSaleParent


		SET @MiddleSaleCode = @ParentSaleCode + '-' + CONVERT(varchar, @PartitionCount)

		SET @SysError = @@ERROR
		IF @SysError <> 0
		BEGIN
			SET @ErrorLevel = -202
			GOTO ERRO 
		END
	END

SET @SaleCode = CONVERT(varchar(20), @MiddleSaleCode)

 
OK:
	COMMIT TRAN
	RETURN 0
ERRO:
	ROLLBACK TRAN
	PRINT CAST(@ErrorLevel AS VARCHAR)
 
	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: SP_PreSale_GetNewSaleCode', @ErrorLevelStr
 
	RETURN @ErrorLevel
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE sp_PreSale_CreateHold
	(
	@IDCustomer 		int, 
	@IDTouristGroup 	int, 
	@PreSaleDate 		smalldatetime, 
	@MediaID		int, 
	@DeliverTypeID 		int, 
	@IDOtherCommission 	int, 
	@FirstName		varchar(20), 
	@LastName		varchar(20), 
	@Layaway		bit, 
	@IDStore		int, 
	@Zip			varchar(20),
	@Note			varchar(150), 
	@PrintNotes		bit,
	@IDPreSale		int output
	) 
AS

DECLARE @SaleCode	varchar(20)

DECLARE @ErrorLevel  	int
DECLARE @SysError  	int


/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO
		- Gero um novo número de Pedido
		- Crio um novo Invoice

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Gero um novo número de Pedido
		-202  Erro em Crio um novo Invoice


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	03 Nov  2000		Carlos Lima		Criacao;
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

SET @ErrorLevel = 0
 
BEGIN TRAN

EXEC sp_Sis_GetNextCode 'Invoice.IDPresale', @IDPreSale output

EXEC SP_PreSale_GetNewSaleCode NULL, @IDStore, @SaleCode output

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO 
END

INSERT Invoice 
	(
	IDPreSale, 
	IDCustomer, 
	IDTouristGroup, 
	PreSaleDate, 
	MediaID, 
	DeliverTypeID, 
	OtherComissionID, 
	FirstName, 
	LastName, 
	Layaway, 
	IDStore, 
	Zip, 
	Note, 
	PrintNotes,
	SaleCode
	) 
VALUES 
	(
	@IDPreSale, 
	@IDCustomer, 
	@IDTouristGroup, 
	@PreSaleDate, 
	@MediaID, 
	@DeliverTypeID, 
	@IDOtherCommission, 
	@FirstName, 
	@LastName, 
	@Layaway, 
	@IDStore, 
	@Zip, 
	@Note, 
	@PrintNotes,
	@SaleCode
	)

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
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PreSale_CreateHold', @ErrorLevelStr
 
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
	 
	
	 LOG DE MODIFICAÇÕES
	 
	 Data   Programador  Modificação
	 --------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	 22 Oct 2004  Carlos Lima  Criação
	 29 Oct 2004  Rodrigo Costa  Correcao;  Nao pode colocar a data do invoice, ainda nao e um invoice
 -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */
 
DECLARE @ErrorLevel			int
DECLARE @SysError			int
 

--Declaração de variáveis para o Cursor de PreInventoryMov
DECLARE @IDPreInventoryMov		int
DECLARE @InventMovTypeID		int
DECLARE @StoreID    			int
DECLARE @ModelID    			int
DECLARE @IDPessoa     		int
DECLARE @ComissionID   		int
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
	ComissionID,
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
	IDModelService
 
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
	EXEC sp_Sis_GetNextCode'PreInventoryMov.IDPreInventoryMov', @IDPreInventoryMov OUTPUT
 
	--Inclui as quantidades dos items marcados para o novo PreSale
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
		@InventMovTypeID,
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
		@QtyRealMov,
		@CostPrice,
		@SalePrice + (-1 * @Discount),
		0,  -- O pai terá o valor total do desconto, não sendo necessário no filho
		@DateEstimatedMov,
		@DateRealMov,
		0,
		0,
		@ExchangeInvoice,
		@SuggRetail,
		@IDParentPack,
		@IDModelService
		)
 
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
/*           Atualiza as quantiades do Antigo PreSale                             */
/*---------------------------------------------------------------------------------------------------------*/
UPDATE PreInventoryMov
SET	Qty = Qty - QtyRealMov,
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

CREATE PROCEDURE sp_PreSale_Pay
			(
			@PreSaleID		int,
			@IDCashRegMov 	int,
			@PayDate 		smalldatetime,
			@IDStore		int,
			@IDTouristGroup 	int,
			@OtherComID 		int,
			@CashReceived   	money,
			@Date			Datetime,
			@IDInvoice 		int output
			)
AS


/* --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO
        - Transforma a PreSale em Sale
	- Move os PreInventMov para o InventMov
	- Move os PreSerialMov para o SerialMov
	- Deleta os seriais do Inventario
	- Deleta Pre Inventory Movement
	- Marca os lancamentos como confimados, e troca o documento
	- Update Cash RegisterMovent
	- Calc commissions for report performace

	TABELA DE ERROS PARA RETURN_VALUE

	 000  Ok
	-201  Erro ao gerar novo IDInvoice
	-202  Erro ao transformar Hold em Invoice
	-203  Erro movendo os PreInventMov para o InventMov
	-204  Erro movendo os PreSerialMov para o SerialMov
	-205  Erro ao deletar/inserir os Seriais do Inventario
	-206  Erro ao deletar o PreSerialMov
	-207  Erro ao deletar o PreInventoryMov
	-208  Erro ao inserir as linhas de quitacao
	-209  Erro as inserir as linhas de ligação entre lancamento e quitacao
	-210  Erro ao atualizar o NumDocumento nas parcelas do Invoice
	-212  Erro ao Atualizar as comissões
	-213  Erro ao mover Model Pack de PreInvMov para InvMov


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	26 may  2000		Eduardo Costa		Alteração para suporte as novas tabelas do financeiro;
	27 may  2000   		Eduardo Costa		Criação da rotina de tratamento e retorno de erros;
	14 aug  2000   		Eduardo Costa		A quitação dos lancamentos do invoice foi transferida
							para o close da caixa registradora;
	15 aug  2000		Rodrigo Costa		Novo campo SalesTax para calcular a tax
	26 June 2001		Davi Gouveia		Log de Return Values
	29 June 2001		Rodrigo Costa		Alteracao no delete Serial do Inventory, criado um join com a tbl PreSerialMov
	29 Oct	2003		Rodrigo Costa		Criado sp_Sis_GetNextCode para Invoice; Cursor InventoryMov;
							Deletado INSERT InvoiceGen (BitGen) VALUES (1), SELECT @IDInvoice = @@IDENTITY; 
							Criado Cursor para InvMov
	18 Dec 2003		Andre Bogado		Alteração no cursor de InvMov para atualizar InventoryMovTax
	22 Dec 2003		Rodrigo Costa		Incluir os Serias no Inventory se for Refound
	25 May 2004		Rodrigo Costa		Mover PackModels do PreInvMov para o InvMov
	18 Aug 2004		Rodrigo Costa		Gravar error log
	20 Set 2004		Rodrigo Costa		Correcao do Calculo de InventoryMovTax (IM.SalePrice-IM.Discount)
    --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

DECLARE @DataPagamento  	smalldatetime
DECLARE @ComissionPayed 	money
DECLARE @IDCentroCusto	int
DECLARE @ErrorLevel		int
DECLARE @SysError		int
DECLARE @InvoiceCode	varchar(20)

--Declaração de variáveis para o Cursor de InventoryMov
DECLARE @InventMovTypeID 	int 
DECLARE @DocumentID 	int 
DECLARE @IDPessoa 		int 
DECLARE @ModelID 		int 
DECLARE @BarCodeID 		char(20)
DECLARE @MovDate 		smalldatetime 
DECLARE @Qty 		int 
DECLARE @CostPrice 		money 
DECLARE @SalePrice 		money 
DECLARE @Discount 		money 
DECLARE @ComissionID 	int 
DECLARE @PreInventoryMovID 	int 
DECLARE @IDUser 		int 
DECLARE @SalesTax 		money
DECLARE @StoreID 		int
DECLARE @IDInventoryMov	int
DECLARE @IDParentPack	int

--PRINT 'Starting transaction'
BEGIN TRAN

SET  @ErrorLevel = 0

-- Retorna o Centro de Custo referente a loja
SELECT @IDCentroCusto = (SELECT IDCentroCusto  FROM Store WHERE IDStore = @IDStore)

SET @SysError = @@ERROR
IF @SysError <> 0 GOTO ERRO


/*--------------------------------------------------------------------------------------------------------*/
/*		Transforma a PreSale em Sale    		  					*/
/*--------------------------------------------------------------------------------------------------------*/

-- Calcula o proximo IDInvoice
EXEC sp_Sis_GetNextCode 'InvoiceGen.IDInvoice', @IDInvoice OUTPUT

EXEC SP_PreSale_GetNewInvoiceCode @IDStore, @InvoiceCode OUTPUT

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END

 -- Transforma o hold em invoice
UPDATE Invoice
SET		Invoice.IDInvoice    	= @IDInvoice,
		Invoice.InvoiceDate  	= @PayDate,
		Invoice.CashReceived 	= @CashReceived,
		Invoice.IDStore	 	= @IDStore,
		Invoice.CashRegMovID 	= @IDCashRegMov,
		Invoice.InvoiceCode	= @InvoiceCode

WHERE 	Invoice.IDPreSale = @PreSaleID

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -202
	GOTO ERRO
END


/*--------------------------------------------------------------------------------------------------------*/
/*	     Move os PreInventMov para o InventMov                      */
/*------------------------------------------------------------------------------------------------------*/
--Declaração do Cursor de InventoryMov

DECLARE InventoryMov_Cursor CURSOR FOR

	SELECT	PIM.InventMovTypeID,
			@IDInvoice,
			PIM.IDPessoa,
			PIM.StoreID,
			PIM.ModelID,
			PIM.BarCodeID,
			@PayDate,
			PIM.Qty,
			PIM.CostPrice,
			PIM.SalePrice,
			PIM.Discount,
			PIM.ComissionID,
			PIM.IDPreInventoryMov,
			PIM.UserID,
			(CASE WHEN (TC.SpecialDateStart <= @Date) AND (TC.SpecialDateEnd >= @Date) AND ( ISNULL((( ISNULL(PIM.SalePrice, 0) - ISNULL(PIM.Discount, 0)) / PIM.Qty), 0) < ISNULL(TC.MaxItemValue, 0))
				 THEN TC.SpecialTax ELSE TC.Tax END / 100.00)  as Tax,-- Tax
			PIM.IDParentPack

	FROM		dbo.PreInventoryMov PIM
			JOIN Model M ON ( PIM.ModelID = M.IDModel )
			JOIN TabGroup TG ON ( M.GroupID = TG.IDGroup )
			JOIN StoreToTabGroup STC ON ( STC.IDStore = PIM.StoreID AND STC.IDGroup = TG.IDGroup )
			JOIN TaxCategory TC ON ( TC.IDTaxCategory = STC.IDTaxCategory )

	WHERE   	PIM.DocumentID = @PreSaleID
			AND
			PIM.InventMovTypeID = 1

OPEN InventoryMov_Cursor

--Inicialização de InventoryMov_Cursor
FETCH NEXT FROM InventoryMov_Cursor INTO
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
	@PreInventoryMovID,
	@IDUser,
	@SalesTax,
	@IDParentPack
--Enquanto tem registros
WHILE
@@FETCH_STATUS = 0
BEGIN
	EXEC sp_Sis_GetNextCode'InventoryMov.IDInventoryMov', @IDInventoryMov OUTPUT

	INSERT InventoryMov
		(
		IDInventoryMov,
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
		PreInventoryMovID,
		IDUser,
		SalesTax,
		IDParentPack
		)
	VALUES
		(
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
		@ComissionID,
		@PreInventoryMovID,
		@IDUser,
		@SalesTax,
		@IDParentPack
		)

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		CLOSE InventoryMov_Cursor
		DEALLOCATE InventoryMov_Cursor
		SET @ErrorLevel = -203
		GOTO ERRO
	END
	-- Insert na tabela de Taxas InventoryMovTax
	INSERT INTO InventoryMovTax 
		(
		IDInventoryMov, 
		IDTaxCategory, 
		Tax, 
		TaxValue 
		)
	SELECT 
		IM.IDInventoryMov,
		ISNULL (TC.IDTaxCategory,0)AS IDTaxCategory,
		ISNULL (TC.Tax,0)/100 AS Tax,
		ISNULL ((IM.SalePrice-IM.Discount) * IM.Qty * TC.Tax,0)/100 AS TaxValue

	FROM 	InventoryMov IM
		JOIN Model Mo ON (IM.ModelID = Mo.IDModel)
		JOIN StoreToTabGroup SG	ON (SG.IDStore = IM.StoreID AND SG.IDGroup = Mo.GroupID )
		JOIN TaxCategory TC ON (SG.IDTaxCategory = TC.IDTaxCategoryParent)

	WHERE 	IM.IDInventoryMov = @IDInventoryMov

	FETCH NEXT FROM InventoryMov_Cursor INTO
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
		@PreInventoryMovID,
		@IDUser,
		@SalesTax,
		@IDParentPack
END
--fechamento do cursor
CLOSE InventoryMov_Cursor
--Destruição do cursor
DEALLOCATE InventoryMov_Cursor


SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -203
	GOTO ERRO
END

/*--------------------------------------------------------------------------------------------------------*/
/*	     Move os PreSerialMov para o SerialMov                	*/
/*--------------------------------------------------------------------------------------------------------*/
INSERT 	dbo.SerialMov ( InventoryMovID,	SerialNumber )

	SELECT	IM.IDInventoryMov,
			PSM.SerialNumber

	FROM		PreSerialMov PSM
			JOIN InventoryMov IM ON (PSM.PreInventoryMovID = IM.PreInventoryMovID)

	WHERE 	IM.DocumentID = @IDInvoice
			AND
			IM.InventMovTypeID = 1

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -204
	GOTO ERRO
END

/*--------------------------------------------------------------------------------------------------------*/
/*	       Deleta/Insert os seriais do Inventario			*/
/*--------------------------------------------------------------------------------------------------------*/

DELETE	
		InventorySerial
FROM	
		PreInventoryMov PIM, PreSerialMov PSV
WHERE	
		PIM.DocumentID = @PreSaleID
		AND
		PIM.InventMovTypeID = 1
		AND
		InventorySerial.ModelID = PIM.ModelID
		AND
		InventorySerial.StoreID = @IDStore
		AND
		InventorySerial.Serial = PSV.SerialNumber
		AND
		PIM.Qty > 0

--Refound
INSERT
		InventorySerial (StoreID, ModelID, Serial)
SELECT
		@IDStore,
		PIM.ModelID,	
		PSV.SerialNumber
FROM
		PreInventoryMov PIM
		JOIN PreSerialMov PSV ON (PIM. IDPreInventoryMov = PSV.PreInventoryMovID)
WHERE	
		PIM.DocumentID = @PreSaleID
		AND
		PIM.InventMovTypeID = 1
		AND
		PIM.Qty < 0
		

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -205
	GOTO ERRO
END


/*--------------------------------------------------------------------------------------------------------*/
/*	       Deleta PreSerial Movement			*/
/*--------------------------------------------------------------------------------------------------------*/

DELETE 	
		PreSerialMov
FROM		
		PreInventoryMov PIM
WHERE 	
		PIM.DocumentID = @PreSaleID
		AND
		PIM.InventMovTypeID = 1

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -206
	GOTO ERRO
END

/*--------------------------------------------------------------------------------------------------------*/
/*	       Atualiza  os ModelsPack de InvMov			*/
/*--------------------------------------------------------------------------------------------------------*/

UPDATE 
	IMC 
SET 
	IMC.IDParentPack = IMP.IDInventoryMov
FROM 
	InventoryMov IMC
	JOIN InventoryMov IMP ON ( IMP.PreInventoryMovID = IMC.IDParentPack)
WHERE 
	IMC.DocumentID = @DocumentID
	AND
	IMC.InventMovTypeID = 1

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -213
	GOTO ERRO
END

/*--------------------------------------------------------------------------------------------------------*/
/*	       Deleta PreInventory Movement			*/
/*--------------------------------------------------------------------------------------------------------*/

DELETE 	
		PreInventoryMov
WHERE 	
		PreInventoryMov.DocumentID = @PreSaleID
		AND
		PreInventoryMov.InventMovTypeID = 1

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -207
	GOTO ERRO
END


/*--------------------------------------------------------------------------------------------------------*/
/*	Marca os lancamentos como confimados,  	  	*/
/*	e troca o documento					*/
/*--------------------------------------------------------------------------------------------------------*/


UPDATE
	Fin_Lancamento
SET
	NumDocumento = Convert(varchar(50), @IDInvoice),
	DataEmissao = @PayDate,
	Previsao = 0
WHERE
	IDPreSale =  @PreSaleID


SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -210
	GOTO ERRO
END


/*--------------------------------------------------------------------------------------------------------*/
/*	Calc commissions for report performace	     		*/
/*	Temporariamente desativa por motivo de performance     	*/
/*--------------------------------------------------------------------------------------------------------*/
/*
PRINT 'Calc Comissions'
EXEC sp_PreSale_CacheCommission @IDInvoice



IF @@ERROR <> 0
BEGIN
	SET @ErrorLevel = -212
	GOTO ERRO
END
*/

OK:
	COMMIT TRAN
	RETURN 0
ERRO:
	PRINT CAST(@ErrorLevel AS VARCHAR)
	ROLLBACK TRAN

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PreSale_Pay', @ErrorLevelStr

	RETURN @ErrorLevel
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

