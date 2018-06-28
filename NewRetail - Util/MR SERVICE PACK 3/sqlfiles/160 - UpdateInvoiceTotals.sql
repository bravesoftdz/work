if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_DivideHold]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_DivideHold]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_SubCalcAdditionalExpenses]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_SubCalcAdditionalExpenses]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_SubCalcItemDiscount]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_SubCalcItemDiscount]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_SubCalcTax]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_SubCalcTax]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_SubCalcTotal]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_SubCalcTotal]
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
	 
	Data			Programador			Modificação
	-------------------------------------	--------------------------------------- 	-----------------------------------------------------------------------------------------------------
	22 Oct 	2004  		Carlos Lima  			Criação;
	29 Oct 	2004  		Rodrigo Costa  			Correcao;  Nao pode colocar a data do invoice, ainda nao e um invoice
	20 Jan	2005		Rodrigo Costa			Correcao; Removido o Discount + SalePrice do insert
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
		@SalePrice,
		((@Discount / @Qty) * @QtyRealMov), --Desconto tem que ser dividido nos invoices
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

CREATE PROCEDURE sp_PreSale_SubCalcAdditionalExpenses
                                   (
                                   @IDPreSale int
                                   )
AS


/* --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
            SUMARIO

                        - Adiciona e calcula Despesas Adicionais

            TABELA DE ERROS PARA RETURN_VALUE
                         000  Ok
                        -201  Erro ao pegar o novo IDInvoiceCost
                        -202  Erro em UPDATE Invoice SET AditionalExpenses

            LOG DE MODIFICAÇÕES

            Data			Programador		Modificação
            --------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
            19 Jan 2005		Rodrigo Costa		Criação
            ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- */
 

DECLARE @IDInvoiceCost 	int
DECLARE @ErrorLevel  	int
DECLARE @SysError   	int
 
SET @ErrorLevel = 0

-- É necessário a atualização de um campo: AditionalExpenses
UPDATE
            Invoice
SET 
            Invoice.AditionalExpenses =  ICT.TotAddExpenses
FROM
            (SELECT
                        IDPreSale, 
                        SUM(ISNULL(Amount, 0)) TotAddExpenses
            FROM
                        InvoiceToCostType
            GROUP BY
                        IDPreSale) ICT
WHERE
	ICT.IDPreSale = Invoice.IDPreSale 
	AND
	(
	Invoice.IDPreSale = @IDPreSale
	OR
	Invoice.IDPreSaleParent = @IDPreSale
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
            DECLARE @ErrorLevelStr varchar(10)
            SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
            EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PreSale_SubCalcAdditionalExpenses', @ErrorLevelStr
            RETURN @ErrorLevel
GO

CREATE PROCEDURE sp_PreSale_SubCalcItemDiscount
		(
			@PreSaleID Int
		)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Atualizo Invoice

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro no Update


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
	26 June 2001		Davi Gouveia		Log de Return Values
	18 Aug 2004		Rodrigo Costa		Gravar error log
	26 Oct 	2004		Carlos Lima		Calcular Discount, incluindo os Invoices filhos
	20 Jan	2005		Rodrigo Costa		Calcular Discount pegando os valores do InventoryMov
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

DECLARE @ErrorLevel	int
DECLARE @SysError	int
DECLARE @TotalDiscount	money
DECLARE @TotalDiscExemp	money

SET @ErrorLevel = 0

--Valores do PreInventoryMov
SET @TotalDiscount = 
		IsNull((
		SELECT
			Sum(IsNull(PIM.Discount,0))
		FROM
			Invoice INV
			JOIN
			PreInventoryMov PIM
				ON (INV.IDPreSale = PIM.DocumentID)
			JOIN
			Model MO
				ON (PIM.ModelID = MO.IDModel)
			JOIN
			TabGroup TG
				ON (MO.GroupID = TG.IDGroup)
		WHERE
			(
				INV.IDPreSale = @PreSaleID
				OR
				INV.IDPreSaleParent = @PreSaleID-- Calcula todos os invoices filhos deste PreSale
			)
			AND
			PIM.InventMovTypeID = 1
			AND
			TG.Taxable = 1
		),0)

SET @TotalDiscExemp =
		IsNull((
			SELECT
				Sum(IsNull(PIM.Discount,0))
			FROM				
				Invoice INV
				JOIN
				PreInventoryMov PIM
					ON (INV.IDPreSale = PIM.DocumentID)
				JOIN
				Model MO
					ON (PIM.ModelID = MO.IDModel)
				JOIN
				TabGroup TG
					ON (MO.GroupID = TG.IDGroup)
 			WHERE
				(
					INV.IDPreSale = @PreSaleID
					OR
					INV.IDPreSaleParent = @PreSaleID-- Calcula todos os invoices filhos deste PreSale
				)
				AND
				PIM.InventMovTypeID = 1
				AND
				TG.Taxable = 0
		),0)


--Valores do InventoryMov
SET @TotalDiscount = @TotalDiscount +
		IsNull((
		SELECT
			Sum(IsNull(IM.Discount,0))
		FROM
			Invoice INV
			JOIN
			InventoryMov IM
				ON (INV.IDInvoice = IM.DocumentID)
			JOIN
			Model MO
				ON (IM.ModelID = MO.IDModel)
			JOIN
			TabGroup TG
				ON (MO.GroupID = TG.IDGroup)
		WHERE
			(
				INV.IDPreSale = @PreSaleID
				OR
				INV.IDPreSaleParent = @PreSaleID-- Calcula todos os invoices filhos deste PreSale
			)
			AND
			IM.InventMovTypeID = 1
			AND
			TG.Taxable = 1
		),0)

SET @TotalDiscExemp = @TotalDiscExemp + 
		IsNull((
			SELECT
				Sum(IsNull(IM.Discount,0))
			FROM				
				Invoice INV
				JOIN
				InventoryMov IM
					ON (INV.IDInvoice = IM.DocumentID)
				JOIN
				Model MO
					ON (IM.ModelID = MO.IDModel)
				JOIN
				TabGroup TG
					ON (MO.GroupID = TG.IDGroup)
 			WHERE
				(
					INV.IDPreSale = @PreSaleID
					OR
					INV.IDPreSaleParent = @PreSaleID-- Calcula todos os invoices filhos deste PreSale
				)
				AND
				IM.InventMovTypeID = 1
				AND
				TG.Taxable = 0
		),0)


UPDATE
	dbo.Invoice
SET
	dbo.Invoice.ItemDiscount =
		convert(money, convert(numeric(20, 0), @TotalDiscount * 100) / 100),

	dbo.Invoice.TaxIsemptItemDiscount =
		convert(money, convert(numeric(20, 0), @TotalDiscExemp * 100) / 100)
WHERE
	dbo.Invoice.IDPreSale = @PreSaleID

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
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PreSale_SubCalcItemDiscount', @ErrorLevelStr

	RETURN @ErrorLevel
GO

CREATE PROCEDURE sp_PreSale_SubCalcTax
			(
			@PreSaleID 	int,
			@Date		DateTime
			)
AS

/* --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Calculo Tax

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em UPDATE Invoice
		-202  Erro em UPDATE I SET TaxIsemptValue

	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	14 agosto 2000   	Eduardo Costa		Suporte ao tax categories, agora é taxa é definda na tabela de
							TaxCategory. Cada conjunto de Store e TabGroup define uma
							TaxCategory;
	26 June 2001		Davi Gouveia		Log de Return Values
	18 Aug 2004		Rodrigo Costa		Gravar error log
	26 Oct 	2004		Carlos Lima		Calcular Tax, incluindo os Invoices filhos
	07 Dez 2004		Rodrigo Costa		Novo calculo das taxas
	20 Jan	2005		Rodrigo Costa		Calculo das taxas do InventoryMov para somar com o total do invoice
    --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

DECLARE @LocalTax 		money
DECLARE @ErrorLevel		int
DECLARE @SysError		int
DECLARE @TaxTotal		money
DECLARE @TaxTotalExp	money

SET @ErrorLevel = 0

-- Caso o invoice esteja marcado como TaxIsempt, não calculo nada
IF (SELECT IV.TaxIsent FROM dbo.Invoice IV WHERE IV.IDPreSale = @PreSaleID ) = 1
BEGIN
	UPDATE
		Invoice
	SET
		Invoice.Tax = 0
	WHERE
		Invoice.IDPreSale = @PreSaleID
		OR
		Invoice.IDPreSaleParent = @PreSaleID

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		SET @ErrorLevel = -201
		GOTO ERRO
	END
	ELSE
		GOTO OK
END

-- É necessário a atualização de dois campos: TaxIsemptValue, e Tax
--Calculo do tax exempt
SET @TaxTotalExp = 
	IsNull((SELECT	
		SUM(IsNull(IMX.TaxValue,0))
	FROM	
		Invoice INV
		JOIN
		InventoryMov IM ON (INV.IDInvoice = IM.DocumentID)
		JOIN
		InventoryMovTax IMX ON (IM.IDInventoryMov = IMX.IDInventoryMov)
	WHERE	
		(
		INV.IDPreSale = @PreSaleID
		OR
		INV.IDPreSaleParent = @PreSaleID-- Calcula todos os invoices filhos deste PreSale
		)
               	AND
		IM.InventMovTypeID = 1
		AND
		INV.TaxIsent = 1
	),0)

--Calculo da taxa
SET @TaxTotal = 
	IsNull((SELECT	
		SUM(IsNull(IMX.TaxValue,0))
	FROM	
		Invoice INV
		JOIN
		InventoryMov IM ON (INV.IDInvoice = IM.DocumentID)
		JOIN
		InventoryMovTax IMX ON (IM.IDInventoryMov = IMX.IDInventoryMov)
	WHERE	
		(
		INV.IDPreSale = @PreSaleID
		OR
		INV.IDPreSaleParent = @PreSaleID-- Calcula todos os invoices filhos deste PreSale
		)
               	AND
		IM.InventMovTypeID = 1
		AND
		INV.TaxIsent = 0
	),0)

UPDATE
	I
SET
	TaxIsemptValue =
	ROUND(
	(
	SELECT	ISNULL(
			SUM	(
				(PIM.Qty * ISNULL(PIM.SalePrice, 0) - ISNULL(PIM.Discount, 0))  -- Subtotal da linha do inventario
			 	* (CASE WHEN (TC.SpecialDateStart <= @Date) AND (TC.SpecialDateEnd >= @Date) THEN (IsNull(TC.SpecialTax,0) + IsNull(TCI.Tax, 0)) ELSE (IsNull(TC.Tax,0) + IsNull(TCI.Tax,0)) END / 100.00)  -- Tax
				),0)
	FROM	
		Invoice INV
		JOIN
		PreInventoryMov PIM ON (INV.IDPreSale = PIM.DocumentID)
		JOIN
		Model M ON (M.IDModel = PIM.ModelID)
		JOIN
		StoreToTabGroup STG ON (STG.IDGroup = M.GroupID AND STG.IDStore = I.IDStore)
		JOIN
		TaxCategory TC ON (STG.IDTaxCategory = TC.IDTaxCategory)
		LEFT OUTER JOIN 
		TaxCategory TCI ON ( TCI.IDTaxCategory = STG.IDSaleTax )

	WHERE	
		(
		INV.IDPreSale = @PreSaleID
		OR
		INV.IDPreSaleParent = @PreSaleID-- Calcula todos os invoices filhos deste PreSale
		)
               	AND
		PIM.InventMovTypeID = 1
		AND
		TC.TaxExempt = 1
	) + @TaxTotalExp, 2),
        		Tax =
	ROUND(
	(
	SELECT	ISNULL(
			SUM	(
				(PIM.Qty * ISNULL(PIM.SalePrice, 0) - ISNULL(PIM.Discount, 0))  -- Subtotal da linha do inventario
			 	* (CASE WHEN (TC.SpecialDateStart <= @Date) AND (TC.SpecialDateEnd >= @Date) AND ( ISNULL((( ISNULL(PIM.SalePrice, 0) - ISNULL(PIM.Discount, 0)) / PIM.Qty), 0) < ISNULL(TC.MaxItemValue, 0))
					 THEN (IsNull(TC.SpecialTax,0) + IsNull(TCI.Tax, 0)) ELSE (IsNull(TC.Tax,0) + IsNull(TCI.Tax,0)) END / 100.00)  -- Tax
				),0)
	FROM	Invoice INV
		JOIN PreInventoryMov PIM ON (INV.IDPreSale = PIM.DocumentID)
		JOIN Model M ON (M.IDModel = PIM.ModelID)
		JOIN StoreToTabGroup STG ON (STG.IDGroup = M.GroupID AND STG.IDStore = I.IDStore)
		JOIN TaxCategory TC ON (STG.IDTaxCategory = TC.IDTaxCategory)
		LEFT OUTER JOIN TaxCategory TCI ON ( TCI.IDTaxCategory = STG.IDSaleTax )
	WHERE
		(
		INV.IDPreSale = @PreSaleID
		OR
		INV.IDPreSaleParent = @PreSaleID-- Calcula todos os invoices filhos deste PreSale
		)
		AND
		PIM.InventMovTypeID = 1
		AND
		TC.TaxExempt = 0
	) + @TaxTotal, 2)
FROM
	Invoice I
WHERE
	I.IDPreSale = @PreSaleID

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

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PreSale_SubCalcTax', @ErrorLevelStr

	RETURN @ErrorLevel
GO

CREATE PROCEDURE sp_PreSale_SubCalcTotal
		(
		@PreSaleID Int,
		@Date	DateTime
		)
AS
 /* ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
	SUMARIO

		- Atualizo Invoice

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em UPDATE dbo.Invoice
		-202  Erro em exec sp_PreSale_SubCalcItemDiscount
		-203  Erro em exec sp_PreSale_SubCalcTax
		-204  Erro em exec sp_PreSale_SubCalcAdditionalExpenses


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
	26 June 2001		Davi Gouveia		Log de Return Values
	18 Aug 	2004		Rodrigo Costa		Gravar error log
	26 Oct 	2004		Carlos Lima		Calcular total, incluindo os Invoices filhos
	19 Jan	2005		Rodrigo Costa		Calcular os totais das outras despesas
	20 Jan	2005		Rodrigo Costa		Calcular os totais do InvMov para somar no total da nota
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */
DECLARE @ErrorLevel	int 
DECLARE @SysError	int
DECLARE @SubTotal	money
SET @ErrorLevel = 0 

BEGIN TRAN 

--Calculo do PreInventoryMov
SET @SubTotal = 
		IsNull((
		SELECT
			SUM((IsNull(PIM.SalePrice, 0)*IsNull(PIM.Qty, 0)))
		FROM
			dbo.Invoice INV
			LEFT JOIN dbo.PreInventoryMov PIM ON (INV.IDPreSale = PIM.DocumentID)
		WHERE
			(
			INV.IDPreSale = @PreSaleID
			OR
			INV.IDPreSaleParent = @PreSaleID -- Calcula todos os invoices filhos deste PreSale
			)						
			AND
			PIM.InventMovTypeID = 1
		),0)

--Calculo do InventoryMov
SET @SubTotal = @SubTotal + 
		IsNull((
		SELECT
			SUM((IsNull(IM.SalePrice, 0)*IsNull(IM.Qty, 0)))
			FROM
			dbo.Invoice INV
			LEFT JOIN InventoryMov IM ON (INV.IDInvoice = IM.DocumentID)
		WHERE
			(
			INV.IDPreSale = @PreSaleID
			OR
			INV.IDPreSaleParent = @PreSaleID -- Calcula todos os invoices filhos deste Invoice
			)						
			AND
			IM.InventMovTypeID = 1
		),0)


UPDATE
	dbo.Invoice
SET
	dbo.Invoice.SubTotal = convert(money, convert(numeric(20, 0), @SubTotal * 100) / 100)
WHERE 	
	dbo.Invoice.IDPreSale = @PreSaleID  

IF @@ERROR <> 0 BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END 

exec sp_PreSale_SubCalcItemDiscount @PreSaleID

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -202
	GOTO ERRO
END

exec sp_PreSale_SubCalcTax @PreSaleID, @Date

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -203
	GOTO ERRO
END

exec sp_PreSale_SubCalcAdditionalExpenses @PreSaleID

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
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PreSale_SubCalcTotal', @ErrorLevelStr

	RETURN @ErrorLevel
GO
