if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SP_PreSale_GetNewInvoiceCode]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[SP_PreSale_GetNewInvoiceCode]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_Pay]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_Pay]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_quPreSaleItem]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_quPreSaleItem]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_quPreSaleItemSplited]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_quPreSaleItemSplited]
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


	LOG DE MODIFICA��ES

	Data		Programador	Modifica��o
	-------------------------- -------------------------- ---------------------------------------------------------------------------------------------------------------------------
	03 Nov  2004	Carlos Lima	Criacao;
	29 Nov	2006	Rodrigo Costa	Removido a transacao da sp, pois a PreSalePay e que tem a transacao
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

SET @ErrorLevel = 0
 
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
	RETURN 0
ERRO:
	PRINT CAST(@ErrorLevel AS VARCHAR)
 
	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: SP_PreSale_GetNewInvoiceCode', @ErrorLevelStr
 
	RETURN @ErrorLevel
GO

CREATE PROCEDURE sp_PreSale_Pay
			(
			@PreSaleID		int,
			@IDCashRegMov		int,
			@PayDate 		smalldatetime,
			@IDStore		int,
			@IDTouristGroup 	int,
			@OtherComID 		int,
			@CashReceived   	money,
			@Date			Datetime,
			@BonusBucks		money,
			@IDInvoice 		int output
			)
AS

/* ---------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO
	- Transforma a PreSale em Sale
	- Move os PreInventMov para o InventMov
	- Insert Encargos de Venda na tabela de Taxas InventoryMovTax
	- Insert Impostos de Venda na tabela de Taxas InventoryMovTax
	- Move os PreSerialMov para o SerialMov
	- Deleta os seriais do Inventario
	- Deleta Pre Inventory Movement
	- Marca os lancamentos como confimados, e troca o documento
	- Update Cash RegisterMovent
	- Atualiza o custo medio dos modelos
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
	-209  Erro as inserir as linhas de liga��o entre lancamento e quitacao
	-210  Erro ao atualizar o NumDocumento nas parcelas do Invoice
	-212  Erro ao Atualizar as comiss�es
	-213  Erro ao mover Model Pack de PreInvMov para InvMov
	-214  Erro ao Impostos
	-216  Erro ao Colocar PreInventMovParent para Null
	-217  Erro ao atualizar SaleItemCommission
	-218  Erro ao inserir em Sal_AccountCard
	-219  Erro ao Inserir em Repair
	-220  Erro ao Inserir em Sal_RebateDiscount
	-221  Erro nos totais de Invoice com os Lacamentos

	LOG DE MODIFICA��ES

	Data			Programador		Modifica��o
	-----------------------	-----------------------	----------------------------------------------------------------------------------
	26 May	2000		Eduardo Costa		Altera��o para suporte as novas tabelas do financeiro;
	27 May	2000   		Eduardo Costa		Cria��o da rotina de tratamento e retorno de erros;
	14 Aug	2000   		Eduardo Costa		A quita��o dos lancamentos do invoice foi transferida
							para o close da caixa registradora;
	15 Aug	2000		Rodrigo Costa		Novo campo SalesTax para calcular a tax;
	26 Jun	2001		Davi Gouveia		Log de Return Values;
	29 Jun	2001		Rodrigo Costa		Alteracao no delete Serial do Inventory, criado um join com a tbl PreSerialMov;
	29 Oct	2003		Rodrigo Costa		Criado sp_Sis_GetNextCode para Invoice; Cursor InventoryMov;
							Deletado INSERT InvoiceGen (BitGen) VALUES (1), SELECT @IDInvoice = @@IDENTITY; 
							Criado Cursor para InvMov;
	18 Dec	2003		Andre Bogado		Altera��o no cursor de InvMov para atualizar InventoryMovTax;
	22 Dec	2003		Rodrigo Costa		Incluir os Serias no Inventory se for Refound;
	25 May	2004		Rodrigo Costa		Mover PackModels do PreInvMov para o InvMov;
	18 Aug	2004		Rodrigo Costa		Gravar error log;
	20 Set	2004		Rodrigo Costa		Correcao do Calculo de InventoryMovTax (IM.SalePrice-IM.Discount);
	07 Dez	2004		Rodrigo Costa		Novo calculo das taxas;
	01 Fev	2005		Rodrigo Costa		Mover as QtyExchanged de Pre para Inv;
	25 Fev	2005		Rodrigo Costa		Quando finalizar o Invoice nao pode atualizar o IDStore;
	29 Mar	2005		Rodrigo Costa		Atualiza o custo medio dos modelos; gravar o custo medio na venda;
	11 Apr	2005		Rodrigo Costa		Inclusao do campo DesiredMarkup no PreInv e InventoryMov;
	17 May	2005		Rodrigo Costa		Cursor para alterar PreInvMovParent;
	01 Jul	2005		Rodrigo Costa		Gerar numero sequencial para Items de Servico;
	28 Nov	2005		Leonardo Riego		Atualiza SaleItemCommission;
	11 Jan	2006		Rodrigo Costa		Remover zerar o custo medio;
	23 Mar	2006		Carlos Lima		Suporte ao Gift Card ( Chamada para a procedure que inclui em Sal_AccountCard );
	03 Apr	2006		Rodrigo Costa		Inserir em Repair;
	29 Jun	2006		Rodrigo Costa		Retirado a transacao, tem que ser feita no Delphi;
	09 Aug	2006		Leonardo Riego		Adicionado a coluna de promo na PreInventory para InventoryMov;
	07 Nov	2006		Maximiliano Muniz	Inser��o na tabela Sal_RebateDiscount;
	16 Nov	2006		Maximiliano Muniz	Mudan�a do campo IDPreSale para IDPreSaleCreated e inclus�o do campo
							IDPreSaleUsed, na tabela Sal_RebateDiscount;
	23 Nov	2006		Maximiliano Muniz	Mudan�a na inser��o da tabela Sal_RebateDiscount, para gravar os novos
							campos (ValidFromDate, ExpirationDate)
	28 Nov	2006		Rodrigo Costa		Verificacao do total do invoice com os totais do pagamento
	---------------------------------------------------------------------------------------------------------------------------------- */

DECLARE @DataPagamento  	smalldatetime
DECLARE @ComissionPayed 	money
DECLARE @IDCentroCusto		int
DECLARE @ErrorLevel		int
DECLARE @SysError		int
DECLARE @InvoiceCode		varchar(20)
DECLARE @ServiceField		varchar(30)
DECLARE @SaleValue		money
DECLARE @BonusMinSaleValue	money
DECLARE @DaysToUseBonusBucks	int
DECLARE @ExpireDaysBonusBucks	int
--Declara��o de vari�veis para o Cursor de InventoryMov
DECLARE @InventMovTypeID	int
DECLARE @DocumentID		int
DECLARE @IDPessoa		int
DECLARE @ModelID		int
DECLARE @BarCodeID		char(20)
DECLARE @MovDate		smalldatetime
DECLARE @Qty 			float
DECLARE @CostPrice		money
DECLARE @SalePrice		money
DECLARE @Discount		money
DECLARE @PreInventoryMovID	int
DECLARE @IDUser			int
DECLARE @SalesTax		money
DECLARE @StoreID		int
DECLARE @IDInventoryMov		int
DECLARE @IDParentPack		int
DECLARE @QtyExchanged		float
DECLARE @IDPreInvMovExchange	int
DECLARE @AvgCost		money
DECLARE @DesiredMarkup		money
DECLARE @IsService		bit
DECLARE	@AutoCreateSrvNum	bit
DECLARE @ServiceNum		int
DECLARE	@IDGroup		int
DECLARE @CardNumber		varchar(20)
DECLARE @GiftValue		money
DECLARE @IDDepartment		int
DECLARE @Promo			bit
DECLARE @TotalPaid		money
DECLARE @TotalInvoice		money


SET @SaleValue = 0
SET @ErrorLevel = 0

-- Retorna o Centro de Custo referente a loja
SELECT @IDCentroCusto = (SELECT IDCentroCusto  FROM Store WHERE IDStore = @IDStore)

SET @SysError = @@ERROR
IF @SysError <> 0 GOTO ERRO


/*--------------------------------------------------------------------------------------------------------*/
/*		Valida as formas de pagamento								*/
/*--------------------------------------------------------------------------------------------------------*/


SELECT
	@TotalPaid = SUM(IsNull(ValorNominal, 0))
FROM
	Fin_Lancamento
WHERE
	IDPreSale =  @PreSaleID


SELECT
	@TotalInvoice = ((((IsNull(SubTotal,0) - IsNull(TaxIsemptItemDiscount,0)) - IsNull(ItemDiscount,0)) + IsNull(Tax,0)) + IsNull(AditionalExpenses,0))
FROM
	Invoice
WHERE
	IDPreSale =  @PreSaleID

SET @SysError = @@ERROR
IF (@SysError <> 0) OR (@TotalPaid <> @TotalInvoice)
BEGIN
	SET @ErrorLevel = -221
	GOTO ERRO
END


/*--------------------------------------------------------------------------------------------------------*/
/*		Transforma a PreSale em Sale    		  	*/
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
--Declara��o do Cursor de InventoryMov

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
			PIM.IDPreInventoryMov,
			PIM.UserID,
			IsNull((CASE WHEN (TC.SpecialDateStart <= @Date) AND (TC.SpecialDateEnd >= @Date) AND ( ISNULL((( ISNULL(PIM.SalePrice, 0) - ISNULL(PIM.Discount, 0)) / PIM.Qty), 0) < ISNULL(TC.MaxItemValue, 0))
				 THEN TC.SpecialTax ELSE TC.Tax END / 100.00),0)  as Tax,-- Tax
			PIM.IDParentPack,
			PIM.QtyExchanged,
			PIM.IDPreInvMovExchange,
			M.AvgCost,
			TG.DesiredMarkup,
			TG.ServiceAutoNumber,
			TG.Service,
			TG.IDGroup,
			PIM.IDDepartment,
			PIM.Promo
	FROM		
			dbo.PreInventoryMov PIM
			JOIN Model M ON ( PIM.ModelID = M.IDModel )
			JOIN TabGroup TG ON ( M.GroupID = TG.IDGroup )
			JOIN StoreToTabGroup STC ON ( STC.IDStore = PIM.StoreID AND STC.IDGroup = TG.IDGroup )
			LEFT JOIN TaxCategory TC ON ( TC.IDTaxCategory = STC.IDTaxCategory )

	WHERE   	PIM.DocumentID = @PreSaleID
			AND
			PIM.InventMovTypeID = 1

OPEN InventoryMov_Cursor

--Inicializa��o de InventoryMov_Cursor
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
	@PreInventoryMovID,
	@IDUser,
	@SalesTax,
	@IDParentPack,
	@QtyExchanged,
	@IDPreInvMovExchange,
	@AvgCost,
	@DesiredMarkup,
	@AutoCreateSrvNum,
	@IsService,
	@IDGroup,
	@IDDepartment,
	@Promo
--Enquanto tem registros
WHILE
@@FETCH_STATUS = 0BEGIN

	SET @ServiceNum = Null

	IF (@AutoCreateSrvNum = 1 AND @IsService = 1  )
	BEGIN
		SET @ServiceField = 'TabGroup.Service'+CAST(@IDGroup as Varchar(10))
		EXEC sp_Sis_GetNextCode @ServiceField, @ServiceNum OUTPUT
	END

	EXEC sp_Sis_GetNextCode 'InventoryMov.IDInventoryMov', @IDInventoryMov OUTPUT

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
		PreInventoryMovID,
		IDUser,
		SalesTax,
		IDParentPack,
		QtyExchanged,
		IDPreInvMovExchange,
		AvgCost,
		DesiredMarkup,
		SequencyNum,
		IDDepartment,
		Promo
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
		@PreInventoryMovID,
		@IDUser,
		@SalesTax,
		@IDParentPack,
		@QtyExchanged,
		@IDPreInvMovExchange,
		@AvgCost,
		@DesiredMarkup,
		@ServiceNum,
		@IDDepartment,
		@Promo
		)

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		CLOSE InventoryMov_Cursor
		DEALLOCATE InventoryMov_Cursor
		SET @ErrorLevel = -203
		GOTO ERRO
	END

	-- Incrementa valor total da venda
	SET @SaleValue = @SaleValue + (@SalePrice * @Qty)

	-- Atualiza SaleItemCommission
	UPDATE SaleItemCommission
	SET
	 	IDPreInventoryMov = NULL,
		IDInventoryMov = @IDInventoryMov
	WHERE
		IDPreInventoryMov = @PreInventoryMovID
	
	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		CLOSE InventoryMov_Cursor
		DEALLOCATE InventoryMov_Cursor
		SET @ErrorLevel = -217
		GOTO ERRO
	END

	-- Insert Encargos de Venda na tabela de Taxas InventoryMovTax
	INSERT INTO InventoryMovTax 
		(
		IDInventoryMov, 
		IDTaxCategory, 
		Tax, 
		TaxValue 
		)
	SELECT 
		IM.IDInventoryMov,
		ISNULL (TC.IDTaxCategory,0) AS IDTaxCategory,
		ISNULL (TC.Tax,0)/100 AS Tax,
		ISNULL (((IM.SalePrice * IM.Qty) - IM.Discount) * TC.Tax,0)/100 AS TaxValue

	FROM 	InventoryMov IM
		JOIN Model Mo ON (IM.ModelID = Mo.IDModel)
		JOIN StoreToTabGroup SG ON (SG.IDStore = IM.StoreID AND SG.IDGroup = Mo.GroupID )
		JOIN TaxCategory TC ON (SG.IDTaxCategory = TC.IDTaxCategoryParent)

	WHERE
	 	IM.IDInventoryMov = @IDInventoryMov

	-- Insert Impostos de Venda na tabela de Taxas InventoryMovTax
	INSERT INTO InventoryMovTax 
		(
		IDInventoryMov, 
		IDTaxCategory, 
		Tax, 
		TaxValue 
		)
	SELECT 
		IM.IDInventoryMov,
		ISNULL (TC.IDTaxCategory,0) AS IDTaxCategory,
		ISNULL (TC.Tax,0)/100 AS Tax,
		ISNULL (((IM.SalePrice * IM.Qty) - IM.Discount) * TC.Tax,0)/100 AS TaxValue

	FROM 	InventoryMov IM
		JOIN Model Mo ON (IM.ModelID = Mo.IDModel)
		JOIN StoreToTabGroup SG ON (SG.IDStore = IM.StoreID AND SG.IDGroup = Mo.GroupID )
		JOIN TaxCategory TC ON (SG.IDSaleTax = TC.IDTaxCategory)

	WHERE
	 	IM.IDInventoryMov = @IDInventoryMov



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
		@PreInventoryMovID,
		@IDUser,
		@SalesTax,
		@IDParentPack,
		@QtyExchanged,
		@IDPreInvMovExchange,
		@AvgCost,
		@DesiredMarkup,
		@AutoCreateSrvNum,
		@IsService,
		@IDGroup,
		@IDDepartment,
		@Promo
END
--fechamento do cursor
CLOSE InventoryMov_Cursor
--Destrui��o do cursor
DEALLOCATE InventoryMov_Cursor


SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -203
	GOTO ERRO
END


/*--------------------------------------------------------------------------------------------------------*/
/*	     Insere a movimenta��o de cr�dito na tabela de AccountCard                	*/
/*--------------------------------------------------------------------------------------------------------*/

EXEC sp_PreSale_ItemRepair @PreSaleID
SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -219
	GOTO ERRO
END


/*--------------------------------------------------------------------------------------------------------*/
/*	     Insere a movimenta��o de cr�dito na tabela de AccountCard                	*/
/*--------------------------------------------------------------------------------------------------------*/


DECLARE AccountMov_Cursor CURSOR FOR
	SELECT			
		PSM.SerialNumber,
		PIM.SalePrice - (PIM.Discount / PIM.Qty),
		PIM.UserID
	FROM		
		PreSerialMov PSM
		JOIN PreInventoryMov PIM ON (PSM.PreInventoryMovID = PIM.IDPreInventoryMov)
		JOIN Model M ON (PIM.ModelID = M.IDModel)
	WHERE 	
		PIM.DocumentID = @PreSaleID
		AND
		PIM.InventMovTypeID = 1
		AND
		M.ModelType = 'G'

OPEN AccountMov_Cursor

--Inicializa��o de PreInventoryMov_Cursor
FETCH NEXT FROM AccountMov_Cursor INTO @CardNumber, @GiftValue, @IDUser

WHILE @@FETCH_STATUS = 0
BEGIN

	EXEC sp_Sal_AccountCard_AddAmount @CardNumber, @GiftValue, @PreSaleID, NULL, @IDUser, 1, ''


	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		CLOSE AccountMov_Cursor
		DEALLOCATE AccountMov_Cursor
		SET @ErrorLevel = -218
		GOTO ERRO
	END

	FETCH NEXT FROM AccountMov_Cursor INTO @CardNumber, @GiftValue, @IDUser
END

CLOSE AccountMov_Cursor
DEALLOCATE AccountMov_Cursor


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
DECLARE @IDPreInventoryMov int

--Declara��o do Cursor de PreInventoryMov
DECLARE PreInventoryMovDelParent_Cursor CURSOR FOR

	SELECT
		IDPreInventoryMov
	FROM
		PreInventoryMov
	WHERE
		DocumentID = @PreSaleID

OPEN PreInventoryMovDelParent_Cursor

--Inicializa��o de PreInventoryMov_Cursor
FETCH NEXT FROM PreInventoryMovDelParent_Cursor INTO
	@IDPreInventoryMov

WHILE @@FETCH_STATUS = 0
BEGIN

	UPDATE 	
		PreInventoryMov
	SET
		PreInventoryMov.IDPreInventoryMovParent = NULL
	WHERE 	
		PreInventoryMov.IDPreInventoryMovParent = @IDPreInventoryMov

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		CLOSE PreInventoryMovDelParent_Cursor
		DEALLOCATE PreInventoryMovDelParent_Cursor
		SET @ErrorLevel = -216
		GOTO ERRO
	END


	FETCH NEXT FROM PreInventoryMovDelParent_Cursor INTO
		@IDPreInventoryMov

END
--fechamento do cursor
CLOSE PreInventoryMovDelParent_Cursor
--Destrui��o do cursor
DEALLOCATE PreInventoryMovDelParent_Cursor

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

/*----------------------------------------------------------------------------------------------*/
/*	Marca os lancamentos como confimados, e troca o documento				*/
/*----------------------------------------------------------------------------------------------*/

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

/*----------------------------------------------------------------------------------------------*/
/*		Insere o bonus bucks								*/
/*----------------------------------------------------------------------------------------------*/

IF (@BonusBucks > 0)
BEGIN
	SELECT @BonusMinSaleValue = CAST(PropertyValue as money)
	FROM Sis_PropertyDomain
	WHERE Property = 'BonusBuckMinSaleValue'
	
	IF (@SaleValue > @BonusMinSaleValue)
	BEGIN
		SELECT @DaysToUseBonusBucks = CAST(PropertyValue as int)
		FROM Sis_PropertyDomain
		WHERE Property = 'DaysToUseBonusBucks'
	
		SELECT @ExpireDaysBonusBucks = CAST(PropertyValue as money)
		FROM Sis_PropertyDomain
		WHERE Property = 'ExpireDaysBonusBucks'
	
		INSERT INTO Sal_RebateDiscount (IDPreSaleCreated, DiscountValue, ValidFromDate, ExpirationDate, IDPreSaleUsed)
		VALUES (@PreSaleID, @BonusBucks, DateAdd(Day, @DaysToUseBonusBucks, @PayDate), DateAdd(Day, @DaysToUseBonusBucks + @ExpireDaysBonusBucks, @PayDate), NULL)
		
		SET @SysError = @@ERROR
		IF @SysError <> 0
		BEGIN
			SET @ErrorLevel = -220
			GOTO ERRO
		END
	END
END


OK:
	RETURN 0
ERRO:
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PreSale_Pay', @ErrorLevelStr

	RETURN @ErrorLevel
GO

CREATE  PROCEDURE sp_PreSale_quPreSaleItem
	(
		@DocumentID       int,
		@IsPreSale  bit,
		@Date   DateTime
	)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

	- Retorna itens de um determinado PreSale

	TABELA DE ERROS PARA RETURN_VALUE

		000  Ok
		-201  Erro no 1o select
		-202  Erro no 2o select

	LOG DE MODIFICA��ES
 
	Data   Programador  Modifica��o
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000  Eduardo Costa  Criacao;
	15 Aug  2000  Rodrigo Costa  Feito o Join com a Tbl TaxCategory para pegar a tax do Item
	26 June 2001  Davi Gouveia  Log de Return Values
	26 May 2004  Rodrigo Costa  Not display Item Packs
	18 Aug 2004  Rodrigo Costa  Gravar error log
	21 Oct 2004  Rodrigo Costa  Criado PIM.InventMovTypeID IN (1,25) para mostrar itens cancelados
	07 Dez 2004  Rodrigo Costa  Novo calculo das taxas
	01 Dez 2005  Leonardo Riego  Modificado para pegar o nome do Comissionado da fun��o.
	17 Apr 2006  Leonardo Riego  Novo campo IDDepartment.
 -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

DECLARE @ErrorLevel int
DECLARE @SysError int

SET @ErrorLevel = 0

if @IsPreSale = 1
begin
	SELECT
		ModelID,
		M.Model,
		Description,
		(SELECT dbo.SalesPersonPreInvMov(IDPreInventoryMov)) AS SalesPerson,
		M.SuggRetail,
		SU.IDUser,
		0 as IDComission,
		Qty,
		ExchangeInvoice,
		SalePrice,
		CostPrice,
		Discount,
		PIM.IDPreInventoryMov IDInventoryMov,
		TG.SerialNumber,
		(CASE
			WHEN (TC.SpecialDateStart <=  @Date) AND (TC.SpecialDateEnd >= @Date) AND ( ISNULL((( ISNULL(PIM.SalePrice, 0) - ISNULL(PIM.Discount, 0)) / PIM.Qty), 0) < ISNULL(TC.MaxItemValue, 0)) THEN (IsNull(TC.SpecialTax,0) + IsNull(TCI.Tax, 0))
			ELSE (IsNull(TC.Tax,0) + IsNull(TCI.Tax,0))
		END) as Tax, -- Tax
		SZ.CodSize,
		SZ.SizeName,
		CL.CodColor,
		CL.Color,
		M.NotVerifyQty,
		PIM.IDDepartment,
		TG.RequestCustomer,
		TG.PuppyTracker,
		PIM.Promo,
		M.SellingPrice,
		PIM.IDPreInventoryMovParent as IDMovParent
	FROM
		PreInventoryMov PIM
		JOIN Model M ON ( PIM.ModelID = M.IDModel )
		LEFT OUTER JOIN InvSize SZ ON (M.IDSize = SZ.IDSize)
		LEFT OUTER JOIN InvColor CL ON (M.IDColor = CL.IDColor)
		JOIN SystemUser SU ON ( SU.IDUser = PIM.UserID )
		JOIN TabGroup TG ON ( M.GroupID = TG.IDGroup )
		JOIN StoreToTabGroup STC ON ( STC.IDStore = PIM.StoreID AND STC.IDGroup = TG.IDGroup )
		LEFT OUTER JOIN TaxCategory TC ON ( TC.IDTaxCategory = STC.IDTaxCategory )
		LEFT OUTER JOIN TaxCategory TCI ON ( TCI.IDTaxCategory = STC.IDSaleTax )
	WHERE
		PIM.DocumentID  = @DocumentID
		AND PIM.InventMovTypeID IN (1,25) --Sale and Canceled
		AND PIM.IDParentPack Is Null

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		SET @ErrorLevel = -201
		GOTO ERRO
	END
end
else
begin
	SELECT
		ModelID,
		M.Model,
		Description,
		(SELECT dbo.SalesPersonInvMov(IM.IDInventoryMov)) AS SalesPerson,
		M.SuggRetail,
		SU.IDUser,
		0 AS IDComission,
		Qty,
		ExchangeInvoice,
		SalePrice,
		CostPrice,
		Discount,
		IM.IDInventoryMov IDInventoryMov,
		TG.SerialNumber,
		IM.SalesTax as Tax, -- Tax
		SZ.CodSize,
		SZ.SizeName,
		CL.CodColor,
		CL.Color,
		M.NotVerifyQty,
		IM.IDDepartment,
		TG.RequestCustomer,
		TG.PuppyTracker,
		IM.Promo,
		M.SellingPrice,
		0 as IDMovParent
	FROM
		InventoryMov IM
		JOIN Model M ON ( IM.ModelID = M.IDModel )
		LEFT OUTER JOIN InvSize SZ ON (M.IDSize = SZ.IDSize)
		LEFT OUTER JOIN InvColor CL ON (M.IDColor = CL.IDColor)
		JOIN SystemUser SU ON ( SU.IDUser = IM.IDUser )
		JOIN TabGroup TG ON ( M.GroupID = TG.IDGroup )
		JOIN StoreToTabGroup STC ON ( STC.IDStore = IM.StoreID AND STC.IDGroup = TG.IDGroup )
		LEFT JOIN TaxCategory TC ON ( TC.IDTaxCategory = STC.IDTaxCategory )
WHERE
		IM.DocumentID  = @DocumentID
		AND IM.InventMovTypeID = 1
		AND IM.IDParentPack Is Null

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		SET @ErrorLevel = -202
		GOTO ERRO
	END
end

OK:
	RETURN 0
ERRO:
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PreSale_quPreSaleItem', @ErrorLevelStr

	RETURN @ErrorLevel
GO

CREATE PROCEDURE sp_PreSale_quPreSaleItemSplited
	(
		@DocumentID      	int,
		@IsPreSale		bit,
		@Date			DateTime
	)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Retorna itens de um determinado PreSale

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro Criando TempTable
		-202  Erro no 1o select
		-203  Erro no 2o select
		-204  Erro no 1o select
		-205  Erro no 2o select
		-205  Erro no Select Fields

	LOG DE MODIFICA��ES

	Data			Programador		Modifica��o
	-----------------------	-----------------------	-----------------------------------------------------------------
	27 Oct	2004		Rodrigo Costa		Criacao;
	07 Dez	2004		Rodrigo Costa		Novo calculo das taxas
	01 Jul	2005		Rodrigo Costa		Exibir campo auto incremental do item servico
	01 Dez	2005		Leonardo Riego		Modificado para pegar o nome do Comissionado da fun��o.
	24 Feb	2006		Maximiliano Muniz	Ordena��o dos selects por IDInvMov
	27 Oct	2006		Rodrigo Costa		Adicionar as colunas de Promo e Model SellingPrice
	----------------------------------------------------------------------------------------------------------------- */

DECLARE @ErrorLevel	int
DECLARE @SysError	int

SET @ErrorLevel = 0

-- Cria��o e carca da Tabela Tempor�ria e inclusao dos Items
CREATE TABLE #InventoryItems
	(
	IDItem 			int Null,
	IDModel 		int Null,
	IDSalesPerson		int Null,
	IDUser			int Null,
	IDStore			int Null,
	Qty			float Null,
	ExchangeInvoice		int Null,
	SalePrice		Money,
	CostPrice		Money,
	Discount		Money,
	Tax			Money,
	IsDelivered		bit,
	SaleCode		varchar(20),
	InvoiceCode		varchar(20),
	AutoServiceNum		int Null,
	SalesPerson		varchar(50),
	Promo			bit
	)

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END

-- Inclusao dos item do PreInventoryMov Parent
INSERT
	#InventoryItems 
	(
	IDItem, 
	IDModel,
	IDSalesPerson,
	IDUser,
	IDStore,
	Qty, 
	ExchangeInvoice, 
	SalePrice, 
	CostPrice, 
	Discount, 
	Tax,
	IsDelivered,
	SaleCode,
	InvoiceCode,
	AutoServiceNum,
	SalesPerson,
	Promo
	)
SELECT 
	PIM.IDPreInventoryMov, 
	PIM.ModelID,
	0 AS ComissionID, 
	PIM.UserID,
	PIM.StoreID,
	PIM.Qty, 
	PIM.ExchangeInvoice, 
	PIM.SalePrice,
	PIM.CostPrice, 
	PIM.Discount, 
 	 (CASE WHEN (TC.SpecialDateStart <=  @Date) AND (TC.SpecialDateEnd >= @Date) AND ( ISNULL((( ISNULL(PIM.SalePrice, 0) - ISNULL(PIM.Discount, 0)) / PIM.Qty), 0) < ISNULL(TC.MaxItemValue, 0))
		 THEN (IsNull(TC.SpecialTax,0) + IsNull(TCI.Tax, 0)) ELSE (IsNull(TC.Tax,0) + IsNull(TCI.Tax,0)) END) as Tax, -- Tax
	0,
	I.SaleCode,
	I.InvoiceCode,
	0,
	(SELECT dbo.SalesPersonPreInvMov(PIM.IDPreInventoryMov)) AS SalesPerson,
	PIM.Promo
FROM 
	PreInventoryMov PIM
	JOIN Model M ON ( PIM.ModelID = M.IDModel )
	JOIN TabGroup TG ON ( M.GroupID = TG.IDGroup )
	JOIN StoreToTabGroup STC ON ( STC.IDStore = PIM.StoreID AND STC.IDGroup = TG.IDGroup )
	LEFT OUTER JOIN TaxCategory TC ON ( TC.IDTaxCategory = STC.IDTaxCategory )
	LEFT OUTER JOIN TaxCategory TCI ON ( TCI.IDTaxCategory = STC.IDSaleTax )
	JOIN Invoice I ON (I.IDPreSale = PIM.DocumentID AND PIM.InventMovTypeID IN (1,25) ) 
WHERE 
	PIM.DocumentID = @DocumentID
	AND
	PIM.InventMovTypeID IN (1,25) --Sale and Canceled
	AND
	PIM.IDParentPack Is Null
ORDER BY
	PIM.IDPreInventoryMov

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -202
	GOTO ERRO
END
	 
-- Inclusao dos PreInventoryMov Splits
INSERT
	#InventoryItems 
	(
	IDItem, 
	IDModel,
	IDSalesPerson, 
	IDUser,
	IDStore,
	Qty, 
	ExchangeInvoice, 
	SalePrice, 
	CostPrice, 
	Discount, 
	Tax,
	IsDelivered,
	SaleCode,
	InvoiceCode,
	AutoServiceNum,
	SalesPerson,
	Promo
	)
SELECT 
	PIM.IDPreInventoryMov, 
	PIM.ModelID,
	0 AS ComissionID, 
	PIM.UserID,
	PIM.StoreID,	PIM.Qty, 
	PIM.ExchangeInvoice, 
	PIM.SalePrice,
	PIM.CostPrice, 
	PIM.Discount, 
 	 (CASE WHEN (TC.SpecialDateStart <=  @Date) AND (TC.SpecialDateEnd >= @Date) AND ( ISNULL((( ISNULL(PIM.SalePrice, 0) - ISNULL(PIM.Discount, 0)) / PIM.Qty), 0) < ISNULL(TC.MaxItemValue, 0))
	 THEN (IsNull(TC.SpecialTax,0) + IsNull(TCI.Tax, 0)) ELSE (IsNull(TC.Tax,0) + IsNull(TCI.Tax,0)) END) as Tax, -- Tax
	0,
	I.SaleCode,
	I.InvoiceCode,
	0,
	(SELECT dbo.SalesPersonPreInvMov(PIM.IDPreInventoryMov)) AS SalesPerson,
	PIM.Promo
FROM 
	PreInventoryMov PIM
	JOIN Model M ON ( PIM.ModelID = M.IDModel )
	JOIN TabGroup TG ON ( M.GroupID = TG.IDGroup )
	JOIN StoreToTabGroup STC ON ( STC.IDStore = PIM.StoreID AND STC.IDGroup = TG.IDGroup )
	LEFT OUTER JOIN TaxCategory TC ON ( TC.IDTaxCategory = STC.IDTaxCategory )
	LEFT OUTER JOIN TaxCategory TCI ON ( TCI.IDTaxCategory = STC.IDSaleTax )
	JOIN Invoice I ON (I.IDPreSale = PIM.DocumentID AND PIM.InventMovTypeID IN (1,25) ) 
WHERE 
	PIM.DocumentID IN (SELECT IDPreSale FROM Invoice where IDPreSaleParent = @DocumentID) 
	AND
	PIM.InventMovTypeID IN (1,25) --Sale and Canceled
	AND
	PIM.IDParentPack Is Null
ORDER BY
	PIM.IDPreInventoryMov
	
SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -203
	GOTO ERRO
END

-- Inclusao dos item do InventoryMov Parent
INSERT
	#InventoryItems 
	(
	IDItem, 
	IDModel,
	IDSalesPerson, 
	IDUser,
	IDStore,
	Qty, 
	ExchangeInvoice, 
	SalePrice, 
	CostPrice, 
	Discount, 
	Tax,
	IsDelivered,
	SaleCode,
	InvoiceCode,
	AutoServiceNum,
	SalesPerson,
	Promo
	)
SELECT 
	IM.IDInventoryMov, 
	IM.ModelID,
	0 AS ComissionID,  
	IM.IDUser,
	IM.StoreID,
	IM.Qty, 
	IM.ExchangeInvoice, 
	IM.SalePrice,
	IM.CostPrice, 
	IM.Discount,
	IM.SalesTax,
	1,
	I.SaleCode,
	I.InvoiceCode,
	IM.SequencyNum,
	(SELECT dbo.SalesPersonInvMov(IM.IDInventoryMov)) AS SalesPerson,
	IM.Promo
FROM 
	InventoryMov IM
	JOIN Invoice I ON (I.IDInvoice = IM.DocumentID AND IM.InventMovTypeID IN (1,25) ) 
WHERE 
	IM.DocumentID IN (SELECT IDInvoice FROM Invoice where IDPreSale = @DocumentID AND IDInvoice IS NOT NULL) 
	AND
	IM.InventMovTypeID = 1
	AND
	IM.IDParentPack Is Null
ORDER BY
	IM.IDInventoryMov

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -204
	GOTO ERRO
END

-- Inclusao dos InventoryMov Splits
INSERT
	#InventoryItems 
	(
	IDItem, 
	IDModel,
	IDSalesPerson, 
	IDUser,
	IDStore,
	Qty, 
	ExchangeInvoice, 
	SalePrice, 
	CostPrice, 
	Discount, 
	Tax,
	IsDelivered,
	SaleCode,
	InvoiceCode,
	AutoServiceNum,
	SalesPerson,
	Promo
	)
SELECT 
	IM.IDInventoryMov, 
	IM.ModelID,
	0 AS ComissionID, 
	IM.IDUser,
	IM.StoreID,
	IM.Qty, 
	IM.ExchangeInvoice, 
	IM.SalePrice,
	IM.CostPrice, 
	IM.Discount,
	IM.SalesTax,
	1,
	I.SaleCode,
	I.InvoiceCode,
	IM.SequencyNum,
	(SELECT dbo.SalesPersonInvMov(IM.IDInventoryMov)) AS SalesPerson,
	IM.Promo
FROM 
	InventoryMov IM
	JOIN Invoice I ON (I.IDInvoice = IM.DocumentID AND IM.InventMovTypeID IN (1,25) ) 
WHERE 
	IM.DocumentID IN (SELECT IDInvoice FROM Invoice where IDPreSaleParent = @DocumentID AND IDInvoice IS NOT NULL) 
	AND
	IM.InventMovTypeID = 1
	AND
	IM.IDParentPack Is Null
ORDER BY
	IM.IDInventoryMov
	
SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -205
	GOTO ERRO
END

SELECT
	IM.IDModel as ModelID,
	M.Model,
	M.Description ,
	SalesPerson ,
	M.SuggRetail ,
	SU.IDUser ,
	IM.IDSalesPerson as IDComission,
	IM.Qty ,
	IM.ExchangeInvoice,
	IM.SalePrice ,
	IM.CostPrice,
	IM.Discount ,
	IDItem as  IDInventoryMov,
	TG.SerialNumber,
	IM.Tax as Tax,
	SZ.CodSize,
	SZ.SizeName,
	CL.CodColor,
	CL.Color,
	IM.IsDelivered,
	IM.SaleCode,
	IM.InvoiceCode,
	IM.AutoServiceNum,
	IM.Promo,
	M.SellingPrice
FROM
	#InventoryItems IM
	JOIN Model M ON ( IM.IDModel = M.IDModel )
	LEFT OUTER JOIN InvSize SZ ON (M.IDSize = SZ.IDSize)
	LEFT OUTER JOIN InvColor CL ON (M.IDColor = CL.IDColor)
	JOIN SystemUser SU ON ( SU.IDUser = IM.IDUser )
	JOIN TabGroup TG ON ( M.GroupID = TG.IDGroup )
	JOIN StoreToTabGroup STC ON ( STC.IDStore = IM.IDStore AND STC.IDGroup = TG.IDGroup )
	LEFT JOIN TaxCategory TC ON ( TC.IDTaxCategory = STC.IDTaxCategory )
ORDER BY
	IM.IDItem

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -206
	GOTO ERRO
END

OK:
	RETURN 0
ERRO:
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PreSale_quPreSaleItemSplited', @ErrorLevelStr

	RETURN @ErrorLevel
GO