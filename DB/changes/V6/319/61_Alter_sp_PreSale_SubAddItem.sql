SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_PreSale_SubAddItem]
	(
	@PreSaleID		int,
	@IDCliente		int,
	@ModelID		int,
	@StoreID		int,
	@UserID			int,
	@IDComission		int,
	@Qty			float,
	@SalePrice		money,
	@CostPrice		money = Null,
	@Discount		money,
	@MovDate		smalldatetime,
	@IDPreInvMovExchange	int,
	@PreInvMovParentID	int,
	@IDDepartment		int,
	@Promo			bit,
	@IDDescriptionPrice	int,
	@IDVendorPrice		int,
	@SuggPrice		int,
	@DocumentNumber		varchar(20),
	@IDDocumentType		int,
	@SequencyNum		int,
	@TotParcial		varchar(10),
	@DiscountPromo		money = 0,
	@UnitDiscount       money =0,
	@PreInventMovID		int = NULL Output,
	@ManualDiscount money = NULL,
	@IDSpecialPrice int = NULL,
    @ManualPrice money = NULL
	)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMMARY

		- Insert on Inventory Movement
		- Insert on Customer Credit
		- Insert quantities to exchange

	TABLE OF ERRORS FOR RETURN_VALUE

		 000  Ok
        -201 Error on Insert Inventory Movement
        -203 Error Adding Models of PacketModel
        -204 Error on Insert in the Customer Credit
        -205 Error on Insert in the Customer Credit PackModel
        -206 Error on Insert quantities required to change PreInvMov
        -207 Error on Insert the quantities in exchange InvMov
        -208 Error on Insert SaleItemCommission
        -209 Error on Insert SaleItemCommission relating to the Kit item
        -210 Error on Insert Inv_MovPrice
        -211 Error on Insert Inv_MovDocument
	
	MODIFICATION LOG

	Data			Programador		Modificação
	-----------------------	-----------------------	-----------------------------------------------------------------
	15 May	2000		Eduardo Costa		Criacao;
	26 Jun	2001		Davi Gouveia		Log de Return Values;
	29 Oct	2003		Rodrigo Costa		Criado sp_Sis_GetNextCod;
	24 May	2004		André Bogado		Criado Cursor para KitModel;
	18 Aug	2004		Rodrigo Costa		Gravar error log;
	01 Dec	2004		Rodrigo Costa		Gravar no Customer Credit;
	01 Feb	2005		Rodrigo Costa		Inclusao do campo @IDPreInvMovExchange;
	11 Apr	2005		Rodrigo Costa		Inclusao do campo DesiredMarkup no PreInvMov;
	28 Nov	2005		Leonardo Riego		Gravar na SaleItemCommission;
	12 Apr  2006		Leonardo Riego		Novo campo @IDDepartment;
	16 Jun	2006		Rodrigo Costa		Adicionado os parametros para ErrorHistory;
	20 Jul	2007		Maximiliano Muniz	Novos parâmetros @IDDescriptionPrice, @IDVendorPrice e @SuggPrice;
							Inserção na tabeça Inv_MovPrice;
	08 Aug	2007		Maximiliano Muniz	Novos parâmetros @DocumentNumber e @IDDocumentType;
							Inserção na tabeça Inv_MovDocument;
	24 Aug	2009		Rodrigo Costa		Inclusao dos campos TotParcial e SequencyNum para o PAF-ECF
	19 Jan  2010		Eliandro Souza		Inclusão do Parametro @DiscountPromo
    10 Dec  2012        Antonio M F Souza   added UnitDiscount parameter	
	----------------------------------------------------------------------------------------------------------------- */

DECLARE @ComissionID		int
DECLARE @IDMovPrice		int
DECLARE @IDMovDocument		int
DECLARE @ErrorLevel		int
DECLARE @SysError		int
DECLARE @IDSaleItemCommission   int
DECLARE @IsNewPIM             boolean
--Declaration of variables for ModelChild cursor
DECLARE @ModelIDChild  	int 
DECLARE @QtyChild  		float
DECLARE @PreInvMovIDPack	int



SET @ErrorLevel = 0
-- set @my_tran_count = @@trancount;
-- BEGIN TRAN



/*-------------------------------------------------------------*/
/*      Possible insert on PreInventory Movement               */
/*-------------------------------------------------------------*/
/*
 * A PreInventoryMov row may or may not exist. If a PreInventMovID parameter
 * was passed in, use that for looking up the PreInventoryMov row, but do
 * not assume it exists. If PreInventMovID was not passed in, try searching
 * for an existing row with several other parameters (ModelID, UserID, etc.).
 * If a row is found, the quantity will be increased (i.e. each time add-item
 * is called, it increases quantity by the amount passed in, e.g. one).
 * If no row is found in either case, then @FoundIDPreInventoryMov will be
 * null, so a new PreInventoryMov row is be created.
 * In all cases, @PreInventMovID is set to the passed-in, found, or newly-
 * created PreInventoryMov row.
 */
 
-- There a small issue with the SP for the cash register: when you add in
-- the same item multiple times using the same user, it adds in the user,
-- multiple times, in the "Sales Person" column. It should only add more
-- than one user if there are multiple different users associated with the
-- item.

DECLARE @FoundIDPreInventoryMov int
DECLARE @OutIDPreInventoryMov int
DECLARE @FinalQty decimal (38,4)

set @IsNewPIM = 0;
IF (@PreInventMovID is null)
BEGIN
    set @IsNewPIM = 1;
    
    SELECT @FoundIDPreInventoryMov = dbo.PreInventoryMov.IDPreInventoryMov
       FROM dbo.PreInventoryMov 
    LEFT OUTER JOIN dbo.ManualPrice 
       ON dbo.PreInventoryMov.IDPreInventoryMov = dbo.ManualPrice.IDPreInventoryMov
    WHERE dbo.PreInventoryMov.ModelID = @ModelID
    AND dbo.PreInventoryMov.UserID = @UserID 
    AND dbo.PreInventoryMov.DocumentID = @PreSaleID
    AND dbo.PreInventoryMov.StoreID = @StoreID
    AND dbo.PreInventoryMov.InventMovTypeID = 1
    AND dbo.ManualPrice.ManualPrice IS NULL;
END
ELSE
BEGIN
    -- Check the passed-in ID exists in the table or not.
    select @FoundIDPreInventoryMov = @PreInventMovID
    from PreInventoryMov
    where IDPreInventoryMov = @PreInventMovID
END

IF (@FoundIDPreInventoryMov IS NOT NULL)
BEGIN
    -- print 'Already have preinventorymov, add or remove to existing quantity.'
    -- print 'FoundIDPreInventoryMov: ' + coalesce(cast(@FoundIDPreInventoryMov as varchar), 'null')
    -- print 'PreInventMovID: ' + coalesce(cast(@PreInventMovID as varchar), 'null')
    IF (@PreInventMovID IS NOT NULL)
    BEGIN
		SELECT @FinalQty  = @Qty
	END
	ELSE
	BEGIN
		SELECT @FinalQty  = [Qty] + @Qty FROM [dbo].[PreInventoryMov]
		WHERE IDPreInventoryMov = @FoundIDPreInventoryMov
	END
    
    SET @PreInventMovID = @FoundIDPreInventoryMov;
    SET @IsNewPIM = 0;
    
    END
ELSE
BEGIN
    --print 'No preinventorymov yet, insert new row.'
    SET @FinalQty  = @Qty;
    EXEC sp_Sis_GetNextCode'PreInventoryMov.IDPreInventoryMov', @PreInventMovID OUTPUT;
    --print 'Got new PreInventMovID: ' + cast(@PreInventMovID as varchar);
    
    insert into PreInventoryMov
	    (
	    IDPreInventoryMov,
	    InventMovTypeID,
	    IDPessoa,
	    DocumentID,
	    ModelID,
	    StoreID,
	    MovDate,
 	    Qty,
	    SalePrice,
	    Discount,
	    CostPrice,
	    UserID,
	    IDPreInvMovExchange,
	    IDPreInventoryMovParent,
	    IDDepartment,
	    Promo,
	    DesiredMarkup,
	    SequencyNum,
	    TotParcial,
	    DiscountPromo,
	    UnitDiscount
	    )
	    SELECT
		    @PreInventMovID,
		    1,
		    @IDCliente,
 		    @PreSaleID,
		    @ModelID,
		    @StoreID,
		    @MovDate,
		    @Qty,
		    @SalePrice,
 		    @Discount+@DiscountPromo,
		    coalesce(@CostPrice, (M.VendorCost+M.OtherCost+M.FreightCost)) as CostPrice,
		    @UserID,
		    @IDPreInvMovExchange,
		    @PreInvMovParentID,
		    @IDDepartment,
		    @Promo,
		    TG.DesiredMarkup,
		    @SequencyNum,
		    @TotParcial,
		    @DiscountPromo,
		    @UnitDiscount
	    FROM
 		    dbo.Model M
		    JOIN TabGroup TG ON (TG.IDGroup = M.GroupID)
 	    WHERE
		    M.IDModel = @ModelID;
	
    -- if @@rowcount == 0, the insert failed;
    -- Can't do this check here though, becuase nested begin/end have to be closed first.
    -- need to do better error handling.
    if @@rowcount = 0
    begin
        print 'PreInventoryMov insert did not create rows; did the Model and TabGroup rows exist?';
	    -- set @ErrorLevel = -201;
	    -- goto ERRO 
    end
    

	
	-- select count(*) from PreInventoryMov where IDPreInventoryMov = @PreInventMovID;
    
END

SET @SysError = @@ERROR
IF @SysError <> 0 
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END

if @ManualDiscount is not null
begin
    delete from ManualDiscount
    where IDPreInventoryMov = @PreInventMovID

    insert into ManualDiscount (
        IDPreInventoryMov,
        ManualDiscount
    )
    values (
        @PreInventMovID,
        @ManualDiscount
    );
end

/*
 * IDParam 118 is "Calculate discounts on Finalization Only", which controls
 * whether discounts are calculated after each item addition, or just at order
 * finalization. The two valid values are 'Item' (default) or 'Sale'. 
 */
declare @UpdateDiscounts char(4)
select @UpdateDiscounts = SrvValue from Param where IDParam = 118;
if @UpdateDiscounts <> 'Sale'
begin
    exec sp_PreSale_SetDiscount @PreSaleID
end

/*
 * After (optionally) updating discounts, recalculate prices with the
 * potentially-new quantity value.
 */
declare @OutPrice money
declare @OutCost money
declare @tablevar table(
    Price money, SellingPrice money, ManualPrice money, SpecialPrice money,
    Finalcost money, SpecialPriceID int, StoreSellingPrice int,
    MinQuantity decimal (38,4), QtyBreakPriceDiscount money, QtyBreakPrice money,
    PromotionPrice money
)
insert into @tablevar(
    Price, SellingPrice, ManualPrice, SpecialPrice, Finalcost, SpecialPriceID,
    StoreSellingPrice, MinQuantity, QtyBreakPriceDiscount, QtyBreakPrice,
    PromotionPrice
) EXEC [dbo].[sp_PreSale_CalcPrice] @ModelID, @StoreID, @Qty,
    @PreInventMovID, @IDSpecialPrice, @ManualPrice

SELECT @OutPrice = Price, @OutCost = Finalcost FROM @tablevar

if (@FinalQty = 0)
begin
    delete from PreInventoryMov where IDPreInventoryMov = @PreInventMovID
end
else
begin
    UPDATE [PreInventoryMov]
       SET [CostPrice] = @OutCost 
          ,[SalePrice] = @OutPrice
          ,[Qty] = @FinalQty  
     WHERE [IDPreInventoryMov] = @PreInventMovID        
end


/*****************************************************************************************
	Inclusion of amounts for exchange
******************************************************************************************/
IF (@IDPreInvMovExchange IS NOT NULL)
BEGIN
	--Pre Inv Mov
	UPDATE
		PreInventoryMov
	SET 
		QtyExchanged = IsNull(QtyExchanged,0) + ABS(@Qty)
	WHERE 
		IDPreInventoryMov = @IDPreInvMovExchange
		AND 
		InventMovTypeID = 1
	
	SET @SysError = @@ERROR
	IF @SysError <> 0 
	BEGIN
		SET @ErrorLevel = -206
		GOTO ERRO
	END
	
	-- Inv Mov
	UPDATE
		InventoryMov
	SET 
		QtyExchanged = IsNull(QtyExchanged,0) + ABS(@Qty)
	WHERE 
		PreInventoryMovID = @IDPreInvMovExchange
		AND 
		InventMovTypeID = 1
	
	SET @SysError = @@ERROR
	IF @SysError <> 0 
	BEGIN
		SET @ErrorLevel = -207
		GOTO ERRO
	END
END


-- Return all records or just item based on input.
IF @PreInventMovID IS NOT NULL
BEGIN
 SELECT PIM.idpreinventorymov, M.IDModel, M.Model, M.Description, PIM.SalePrice,
 PIM.CostPrice, PIM.UnitDiscount, PIM.Discount, PIM.Promo, PIM.Qty,
 round((PIM.Qty * PIM.UnitDiscount), 2) as ExtDiscount, 
 round((PIM.Qty * PIM.SalePrice), 2) as ExtPrice, 
 (round((PIM.Qty * PIM.SalePrice), 2) - round((PIM.Qty * PIM.UnitDiscount), 2)) as LineSubTotal, 
 TC.Tax
  FROM preinventorymov PIM 
   join Model M on (PIM.modelid = M.idmodel) 
        join StoreToTabGroup STTG on (M.GroupID = STTG.IDGroup and PIM.StoreID = STTG.IDStore)
            join TaxCategory TC on (STTG.IDTaxCategory = TC.IDTaxCategory)
  WHERE PIM.InventMovTypeID = 1 and PIM.IDPreInventoryMov = @PreInventMovID
END
ELSE
BEGIN
 SELECT PIM.idpreinventorymov, M.IDModel, M.Model, M.Description, PIM.SalePrice,
 PIM.CostPrice, PIM.UnitDiscount, PIM.Discount, PIM.Promo, PIM.Qty,
 round((PIM.Qty * PIM.UnitDiscount), 2) as ExtDiscount, 
 round((PIM.Qty * PIM.SalePrice), 2) as ExtPrice, 
 (round((PIM.Qty * PIM.SalePrice), 2) - round((PIM.Qty * PIM.UnitDiscount), 2)) as LineSubTotal, 
 TC.Tax
  FROM preinventorymov PIM 
   join Model M on (PIM.modelid = M.idmodel) 
        join StoreToTabGroup STTG on (M.GroupID = STTG.IDGroup and PIM.StoreID = STTG.IDStore)
            join TaxCategory TC on (STTG.IDTaxCategory = TC.IDTaxCategory)
  WHERE PIM.InventMovTypeID = 1 and PIM.DocumentID = @PreSaleID
END

	
/*****************************************************************************************
	Inclusion of Commissions on the SaleItemCommission table
******************************************************************************************/
if @IsNewPIM = 1 begin
    print 'IsNewPIM = 1, so create saleItemcommission row with PreInventMovID = ' + cast(@PreInventMovID as varchar);
    
    
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
	     @PreInventMovID,
	     @IDComission,
	     100
	    )

    SET @SysError = @@ERROR
    IF @SysError <> 0 
    BEGIN
	    SET @ErrorLevel = -208
	    GOTO ERRO
    END
end

/*****************************************************************************************
	Inclusion of the Inv_MovPrice table
******************************************************************************************/
IF @IDDescriptionPrice <> 0
BEGIN
	EXEC sp_Sis_GetNextCode 'Inv_MovPrice.IDMovPrice', @IDMovPrice OUTPUT
	INSERT INTO Inv_MovPrice
		(
		IDMovPrice,
		IDPreInventoryMov,
		IDInventoryMov,
		IDDescriptionPrice,
		IDVendor,
		SuggPrice
		)
		VALUES
		(
		@IDMovPrice,
		@PreInventMovID,
		NULL,
		@IDDescriptionPrice,
		@IDVendorPrice,
		@SuggPrice
		)
	
	SET @SysError = @@ERROR
	IF @SysError <> 0 
	BEGIN
		SET @ErrorLevel = -210
		GOTO ERRO
	END
END

/*****************************************************************************************
	Inclusão na tabela de Inv_MovDocument
******************************************************************************************/
IF @DocumentNumber <> ''
BEGIN
	EXEC sp_Sis_GetNextCode 'Inv_MovDocument.IDMovDocument', @IDMovDocument OUTPUT
	INSERT INTO Inv_MovDocument
		(
		IDMovDocument,
		IDPreInventoryMov,
		IDInventoryMov,
		DocumentNumber,
		DocumentDate,
		DocumentStatus,
		IDDocumentType,
		OBS
		)
		VALUES
		(
		@IDMovDocument,
		@PreInventMovID,
		NULL,
		@DocumentNumber,
		@MovDate,
		1,
		@IDDocumentType,
		NULL
		)
	
	SET @SysError = @@ERROR
	IF @SysError <> 0 
	BEGIN
		SET @ErrorLevel = -211
		GOTO ERRO
	END
END


/*****************************************************************************************
	Inclusão dos Creditos para o modelo caso tenha
******************************************************************************************/
if @IsNewPIM = 1 begin
    EXEC sp_PreSale_AddModelCredit
			    @PreInventMovID,
			    @IDCliente,
			    @UserID,
			    @StoreID,
			    @MovDate;
end

SET @SysError = @@ERROR
IF @SysError <> 0 
BEGIN
	SET @ErrorLevel = -204
	GOTO ERRO
END
 

/*****************************************************************************************
	Inclusão de Models de PacketModel
******************************************************************************************/

--Declaração do Cursor de ModelChild

DECLARE ModelChild_Cursor CURSOR FOR

	SELECT
		M.IDModel,
		P.Qty
	FROM 
 		dbo.PackModel P (NOLOCK) 
		JOIN dbo.Model M (NOLOCK) ON (P.IDModel= M.IDModel)
 	WHERE
		P.IDPackModel = @ModelID


OPEN ModelChild_Cursor

--Inicialização de ModelChild_Cursor
FETCH NEXT FROM ModelChild_Cursor INTO
	@ModelIDChild,
	@QtyChild

--Enquanto tem registros
WHILE
@@FETCH_STATUS = 0
BEGIN
	EXEC sp_Sis_GetNextCode'PreInventoryMov.IDPreInventoryMov', @PreInvMovIDPack OUTPUT

	INSERT dbo.PreInventoryMov
	(
	IDPreInventoryMov,
	InventMovTypeID,
	IDPessoa,
	DocumentID,
	ModelID,
	StoreID,
	MovDate,
 	Qty,
	SalePrice,
	Discount,
	CostPrice,
	UserID,
	IDParentPack,
	IDDepartment
	)
	SELECT
		@PreInvMovIDPack,
		1,
		@IDCliente,
 		@PreSaleID,
		@ModelIDChild,
		@StoreID,
		@MovDate,
		@Qty * @QtyChild,--Qtde Comprada x Qtde do Kit
		0,
 		0,
		FinalCost,
		@UserID,
		@PreInventMovID,
		@IDDepartment
	FROM
 		dbo.Model (NOLOCK) 
 	WHERE
		dbo.Model.IDModel = @ModelIDChild


	SET @SysError = @@ERROR
	IF @SysError <> 0 
	BEGIN
		CLOSE ModelChild_Cursor
		DEALLOCATE ModelChild_Cursor
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
	 @PreInvMovIDPack,
	 @IDComission,
	 100
	)

        SET @SysError = @@ERROR
        IF @SysError <> 0 
        BEGIN
		SET @ErrorLevel = -209
		GOTO ERRO
        END

	/*****************************************************************************************
		Inclusão dos Creditos dos item do pack caso tenha
	******************************************************************************************/
	EXEC sp_PreSale_AddModelCredit
			@PreInvMovIDPack,
			@IDCliente,
			@UserID,
			@StoreID,

			@MovDate


	SET @SysError = @@ERROR
	IF @SysError <> 0 
	BEGIN
		SET @ErrorLevel = -205
		GOTO ERRO
	END

	--Leitura do Proximo 
	FETCH NEXT FROM ModelChild_Cursor INTO
		@ModelIDChild,
		@QtyChild

END
--fechamento do cursor
CLOSE ModelChild_Cursor

--Destruição do cursor
DEALLOCATE ModelChild_Cursor

SET @SysError = @@ERROR
IF @SysError <> 0 
BEGIN
	SET @ErrorLevel = -203
	GOTO ERRO
END


OK:
	--COMMIT TRAN
	RETURN 0
ERRO:
	PRINT CAST(@ErrorLevel AS VARCHAR)
	ROLLBACK TRAN

	DECLARE @ErrorLevelStr varchar(510)
	DECLARE @Params varchar(500)	
	SET @Params = ' [ @IDCliente = ' + CAST(@IDCliente AS VARCHAR) + ' @ModelID = ' + CAST(@ModelID AS VARCHAR) +  
			' @StoreID = ' + CAST(@StoreID AS VARCHAR) + ' @UserID = '  + CAST(@UserID AS VARCHAR) + 
			' @IDComission = '  + CAST(@IDComission AS VARCHAR) + ' @Qty = '  + CAST(@Qty AS VARCHAR) +
			' @IDPreInvMovExchange = '  + CAST(@IDPreInvMovExchange AS VARCHAR) + 
			' @PreInvMovParentID = '  + CAST(@PreInvMovParentID AS VARCHAR) + 
			' @IDDepartment = '  + CAST(@IDDepartment AS VARCHAR) +  ' ] '
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR) + @Params
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PreSale_SubAddItem', @ErrorLevelStr

	RETURN @ErrorLevel
