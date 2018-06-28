/****** Object:  StoredProcedure [dbo].[sp_PreSale_AddItem]    Script Date: 04/27/2016 19:54:36 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[sp_PreSale_AddItem]
    (
    @PreSaleID          int,
    @IDCliente      int,
    @ModelID            int,
    @StoreID            int,
    @UserID             int,
    @IDComission        int,
    @Qty                float,
    @SalePrice          money,
    @CostPrice      money,
    @Discount           money,
    @MovDate            smalldatetime,
    @ResetDiscount      bit = 0,
    @Manager        bit = 0,
    @Date           DateTime,
    @IDPreInvMovExchange    int,
    @PreInvMovParentID  int,
    @IDDepartment       int,
    @Promo          bit = 0,
    @IDDescriptionPrice int,
    @IDVendorPrice      int,
    @SuggPrice      int,
    @DocumentNumber     varchar(20),
    @IDDocumentType     int,
    @SequencyNum        int = 0,
    @TotParcial     varchar(10) = NULL,
    @DiscountPromo      money = 0,
    @UnitDiscount money,
    @PreInventMovID     int = null Output,
    @ManualDiscount money = null,
    @IDSpecialPrice int = null,
    @ManualPrice money = null
    )
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------    SUMARIO

        - Tests if the total discount and still valid
        - Includes the movement

    ERROR TABLE FOR RETURN_VALUE

        @Result Ok
        -201  Erro in exec @Result = sp_PreSale_SubTestDiscount
        -202  Erro in exec sp_PreSale_SubResetDiscount
        -203  Erro in exec @Result = sp_PreSale_SubAddItem
        -204  Erro in exec sp_PreSale_SubCalcTotal

    LOG OF CHANGES

    Data            Programmer      Modification
    ----------------------- ----------------------- -----------------------------------------------------------------
    2000-05-15      Eduardo Costa       Creation;
    2001-06-26      Davi Gouveia        Log the Return Values;
    2004-08-18      Rodrigo Costa       Write error log;
    2005-02-01      Rodrigo Costa       New field @IDPreInvMovExchange
    2006-04-12      Leonardo Riego      New field @IDDepartment;
    2006-06-16      Rodrigo Costa       Added the parameters for ErrorHistory
    2007-07-20      Maximiliano Muniz   New parameters @IDDescriptionPrice, @IDVendorPrice and @SuggPrice;
    2007-08-08      Maximiliano Muniz   New parameters @DocumentNumber and @IDDocumentType;
    2009-08-24      Rodrigo Costa       Creation of the parameters for TotParcial and SeqNum PAF-ECF
    2010-01-18      Eliandro Souza      New parameter @DiscountPromo
    2012-12-11      Antonio M F Souza   New parameter @UnitDiscount
    2014-03-13      Nicholas Cook       New parameters @ManualDiscount, @IDSpecialPrice, and @ManualPrice along with
                                        rework of how pricing and discounts are calculated.
    ----------------------------------------------------------------------------------------------------------------- */

DECLARE @Result     int
DECLARE @ErrorLevel int
DECLARE @SysError   int

SET @ErrorLevel = 0

BEGIN TRAN

if (@ManualDiscount = 0)
BEGIN
  SET @ManualDiscount = NULL;
END

EXEC @Result = sp_PreSale_SubAddItem
                    @PreSaleID,
                    @IDCliente,
                    @ModelID,
                    @StoreID,
                    @UserID,
                    @IDComission,
                    @Qty,
                    @SalePrice,
                    @CostPrice,
                    @Discount,
                    @MovDate,
                    @IDPreInvMovExchange,
                    @PreInvMovParentID,
                    @IDDepartment,
                    @Promo,
                    @IDDescriptionPrice,
                    @IDVendorPrice,
                    @SuggPrice,
                    @DocumentNumber,
                    @IDDocumentType,
                    @SequencyNum,
                    @TotParcial,
                    @DiscountPromo,
                    @UnitDiscount,
                    @PreInventMovID Output,
                    @ManualDiscount,
                    @IDSpecialPrice,
                    @ManualPrice

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
    SET @ErrorLevel = -203
    GOTO ERRO
END

if @Result <> 0
    rollback tran
else
    exec sp_PreSale_SubCalcTotal @PreSaleID, @Date

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

    DECLARE @ErrorLevelStr varchar(510)
    DECLARE @Params varchar(500)
    SET @Params = ' [ @IDCliente = ' + CAST(@IDCliente AS VARCHAR) + ' @ModelID = ' + CAST(@ModelID AS VARCHAR) +
            ' @StoreID = ' + CAST(@StoreID AS VARCHAR) + ' @UserID = '  + CAST(@UserID AS VARCHAR) +
            ' @IDComission = '  + CAST(@IDComission AS VARCHAR) + ' @Qty = '  + CAST(@Qty AS VARCHAR) +
            ' @IDPreInvMovExchange = '  + CAST(@IDPreInvMovExchange AS VARCHAR) +
            ' @IDDepartment = '  + CAST(@IDDepartment AS VARCHAR) +  ' ] '
    SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR) + @Params
    EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PreSale_AddItem', @ErrorLevelStr

    RETURN @ErrorLevel

SET ANSI_NULLS ON

GO


/****** Object:  StoredProcedure [dbo].[sp_PreSale_ApplyCustomerItemDiscount]    Script Date: 04/27/2016 20:01:33 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER  PROCEDURE [dbo].[sp_PreSale_ApplyCustomerItemDiscount]
		(
		@IDPreSale		int,
		@IDCustomer		int,
		@IDPreInventoryMov	int,
		@Date			DateTime
		)
AS

/* ---------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Insere desconto em apenas um item espcifico, baseado no tipo de cliente

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro ao selecionar um item.
		-202  Erro ao atualizar o item.
		-203  Erro em exec sp_PreSale_SubCalcTotal @PreSaleID, @Date.

	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	------------------------------------------------------------------------------- -----------------------------------------------------------------------------------------------------------
	05 Jan 2007		Maic Nogueira		Criação;
	04 Mar 2009		Rodrigo Costa		Aplicar desconto nos produtos que nao estao com 0 no estoque e nao
							estao marcados para pedir preco
	June 10 2013    Antonio Marcos F. Souza added unitdiscount in PreInventoryMov						
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

DECLARE @Discount		money
DECLARE @OldDiscount		money
DECLARE @ErrorLevel		int 
DECLARE @SysError		int

SET @ErrorLevel = 0

/*--------------------------------------------------------------------------------------*/
/*				Calcula desconto do cliente				*/
/*--------------------------------------------------------------------------------------*/

	SELECT
		@Discount = ROUND((PIM.SalePrice * (CD.Discount / 100)),2) * PIM.Qty,
		@OldDiscount = PIM.Discount
	FROM
		Ent_CustomerDiscount CD (NOLOCK) 
		JOIN Model M (NOLOCK) ON (CD.IDGroup = M.GroupID)
		JOIN PreInventoryMov PIM (NOLOCK) ON (M.IDModel = PIM.ModelID)
		JOIN Pessoa P (NOLOCK) ON (CD.IDTipoPessoa = P.IDTipoPessoa)
	WHERE
		P.IDPessoa = @IDCustomer
		AND
		PIM.IDPreInventoryMov = @IDPreInventoryMov
		AND
		PIM.InventMovTypeID = 1
		AND
		M.CustomSalePrice = 0 
		AND 
		M.SellingPrice <> 0

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		SET @ErrorLevel = -201
		GOTO ERRO
	END

	IF (@Discount > 0) AND (@Discount > @OldDiscount)
	BEGIN	
		UPDATE
			PreInventoryMov
		SET
			Discount = @Discount,
			unitdiscount = @discount / ISNULL(qty,1) -- Antonio June 06, 2013
		WHERE
			IDPreInventoryMov = @IDPreInventoryMov
	
		SET @SysError = @@ERROR
		IF @SysError <> 0
		BEGIN
			SET @ErrorLevel = -202
			GOTO ERRO
		END
	
		exec sp_PreSale_SubCalcTotal @IDPreSale, @Date
	
		SET @SysError = @@ERROR
		IF @SysError <> 0
		BEGIN
			SET @ErrorLevel = -203
			GOTO ERRO
		END
	END

OK:
	RETURN 0
ERRO:
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PreSale_ApplyCustomerItemDiscount', @ErrorLevelStr

	RETURN @ErrorLevel
GO

/****** Object:  StoredProcedure [dbo].[sp_PreSale_ChangeItem]    Script Date: 04/27/2016 20:02:55 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO

ALTER  PROCEDURE [dbo].[sp_PreSale_ChangeItem]
	(
	@PreSaleID      	int,
	@ModelID     		int,
	@UserID      		int,
	@IDComission		int,
	@Qty         		float,
	@SalePrice      	money,
	@CostPrice      	money = Null,
	@Discount    		money,
	@MovDate     		smalldatetime,
	@Manager		bit = 0,
	@ResetDiscount		bit = 0,
	@Date			DateTime,
	@PreInvMovParentID	int,
	@IDDepartment		int,
	@Promo			bit,
	@IDDescriptionPrice	int,
	@IDVendorPrice		int,
	@SuggPrice		int,
	@DocumentNumber		varchar(20),
	@IDDocumentType		int,
	@DiscountPromo 		money=0,
	@UnitDiscount     money,    
	@PreInventMovID		int output 
	)
AS
	/* -------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Testa se o discount total ainda e valido
		- Efetivamente remove e inclui o inventory moviment
		- Passa os seriais do item antigo para o novo

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em exec @Result = sp_PreSale_SubTestDiscount
		-202  Erro em exec sp_PreSale_SubResetDiscount
		-209  Erro em exec sp_PreSale_SubCalcTotal

	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	-----------------------	-----------------------	----------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
	26 June 2001		Davi Gouveia		Log de Return Values;
	18 Aug 	2004		Rodrigo Costa		Gravar error log;
	01 Fev 	2005		Rodrigo Costa		Inclusao do IDPreInvMovExchange e qtyExchanged;
	12 Apr 	2006		Leonardo Riego		Novo campo @IDDepartment;
	16 Jun	2006		Rodrigo Costa		Adicionado os parametros para ErrorHistory;
	15 Aug 	2006		Leonardo Riego		Deleção da comissao do item novo e atualização de comissões do item novo;
	10 Aug	2007		Maximiliano Muniz	Novos parâmetros @IDDescriptionPrice, @IDVendorPrice e @SuggPrice;
							Novos parâmetros @DocumentNumber e @IDDocumentType;
	20 Aug	2007		Rodrigo Costa		Editar a tabela de PreInvMov sem deletar e incluir novamente
	19 Set	2008		Rodrigo Costa		Atualizar quantidades do Kit na venda
	18 Jan  2010		Eliandro Souza		inclusão do novo parâmetro @DiscountPromo
	16 Jul	2010		Rodrigo Costa		Loop para alterar a quantidade do KIT na venda
December 11 2012    Antonio M F Souza   added new parameter UnitDiscount 		
	---------------------------------------------------------------------------------------------------------------------------------- */

DECLARE @Result  		int
DECLARE @Value			money
DECLARE @StoreID		int
DECLARE @IDCliente		int
DECLARE @IDOldUser		int
DECLARE @OldPreInventoryMovID 	int 
DECLARE @ErrorLevel		int
DECLARE @SysError		int
DECLARE @IDPreInvMovExchange	int
DECLARE @QtyExchanged		float
DECLARE @IDChild		int
DECLARE @QtyChild		Decimal(38, 4)


SET @ErrorLevel = 0

/*------------------------------------------------------------------------------*/
/*                Testa se o discount total ainda e valido                      */
/*------------------------------------------------------------------------------*/
SELECT @Value = IsNull((@Qty * @SalePrice), 0)

IF @Manager = 0
BEGIN
	EXEC @Result = sp_PreSale_SubTestDiscount 	@PreSaleID,
							@ModelID,
							@UserID,
 							@Discount,
							@Value,
							'A', 
							@PreInventMovID

	SET @SysError = @@ERROR
	IF @SysError <> 0 	
	BEGIN
		SET @ErrorLevel = -201
		GOTO ERRO
	END

	IF @ResetDiscount = 1 and @Result <> 0
	BEGIN
		EXEC sp_PreSale_SubResetDiscount	@PreSaleID

		SET @SysError = @@ERROR
		IF @SysError <> 0 	
		BEGIN
			SET @ErrorLevel = -202
			GOTO ERRO
		END
	END
	ELSE
	BEGIN
		IF @Result <> 0
		BEGIN
			RETURN @Result
		END
	END
END

/*-------------------------------------------------------------*/
/*    Efetivamente remove e inclui o inventory moviment        */
/*-------------------------------------------------------------*/
BEGIN TRAN


UPDATE
	PreInventoryMov
SET
	QtyExchanged = @QtyExchanged,
	UserID = @UserID,
	Qty = @Qty,
	SalePrice = @SalePrice,
	CostPrice = @CostPrice,
	Discount = @Discount+@DiscountPromo,
	MovDate = @MovDate,
	IDDepartment = @IDDepartment,
	Promo = @Promo,
	SuggRetail = @SuggPrice,
	DiscountPromo = @DiscountPromo,
	UnitDiscount = @UnitDiscount
WHERE
	IDPreInventoryMov = @PreInventMovID

SET @SysError = @@ERROR
IF @SysError <> 0 	
BEGIN
	SET @ErrorLevel = -203
	GOTO ERRO
END

/*-------------------------------------------------------------*/
/*    Atualizar os itens do kit          */
/*-------------------------------------------------------------*/

DECLARE ModelChild_Cursor CURSOR FOR

	SELECT
		PIM.IDPreInventoryMov,
		MP.Qty
	FROM 
 		PreInventoryMov PIM (NOLOCK)
		JOIN (SELECT
				P.IDModel,
				P.Qty		
			FROM 
		 		PackModel P (NOLOCK)
		 	WHERE
				P.IDPackModel = @ModelID) MP ON (MP.IDModel = PIM.ModelID)
 	WHERE
		PIM.IDParentPack = @PreInventMovID


OPEN ModelChild_Cursor

--Inicialização de ModelChild_Cursor
FETCH NEXT FROM ModelChild_Cursor INTO
	@IDChild,
	@QtyChild

--Enquanto tem registros
WHILE
@@FETCH_STATUS = 0
BEGIN

	UPDATE
		PreInventoryMov
	SET
		Qty = @QtyChild * @Qty
	WHERE
		IDPreInventoryMov = @IDChild

	--Leitura do Proximo 
	FETCH NEXT FROM ModelChild_Cursor INTO
		@IDChild,
		@QtyChild

END
--fechamento do cursor
CLOSE ModelChild_Cursor

--Destruição do cursor
DEALLOCATE ModelChild_Cursor

SET @SysError = @@ERROR
IF @SysError <> 0 	
BEGIN
	SET @ErrorLevel = -204
	GOTO ERRO
END


/*-------------------------------------------------------------*/
/*    Calcula o SupTotal        */
/*-------------------------------------------------------------*/


exec sp_PreSale_SubCalcTotal @PreSaleID, @Date
SET @SysError = @@ERROR
IF @SysError <> 0 	
BEGIN
	SET @ErrorLevel = -209
	GOTO ERRO
END

OK:
	COMMIT TRAN
	RETURN 0
ERRO:
	ROLLBACK TRAN
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(510)
	DECLARE @Params varchar(500)	
	SET @Params = ' [ @ModelID = ' + CAST(@ModelID AS VARCHAR) + ' @UserID = '  + CAST(@UserID AS VARCHAR) + 
			' @IDComission = ' + CAST(@IDComission AS VARCHAR) + ' @Qty = '  + CAST(@Qty AS VARCHAR) +
			' @PreInvMovParentID = '  + CAST(@PreInvMovParentID AS VARCHAR) + 
			' @IDDepartment = ' + CAST(@IDDepartment AS VARCHAR) + ' ] '

	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR) + @Params
	EXEC sp_PreSale_ChangeItem 0, 0, @SysError, 'MainRetail', 'Error: sp_PreSale_ChangeItem', @ErrorLevelStr

	RETURN @ErrorLevel

GO

/****** Object:  StoredProcedure [dbo].[sp_PreSale_quPreSaleItem]    Script Date: 04/27/2016 20:08:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[sp_PreSale_quPreSaleItem]
	(
		@DocumentID	int,
		@IsPreSale	bit,
		@Date		DateTime
	)
AS

/* ---------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

	- Retorna itens de um determinado PreSale

	TABELA DE ERROS PARA RETURN_VALUE

		000  Ok
		-201  Erro no 1o select
		-202  Erro no 2o select

	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	-----------------------	-----------------------	----------------------------------------------------------------------------------
	15 May	2000		Eduardo Costa		Criacao;
	15 Aug	2000		Rodrigo Costa		Feito o Join com a Tbl TaxCategory para pegar a tax do Item;
	26 Jun	2001		Davi Gouveia		Log de Return Values;
	26 May	2004		Rodrigo Costa		Not display Item Packs;
	18 Aug	2004		Rodrigo Costa		Gravar error log;
	21 Oct	2004		Rodrigo Costa		Criado PIM.InventMovTypeID IN (1,25) para mostrar itens cancelados;
	07 Dez	2004		Rodrigo Costa		Novo calculo das taxas;
	01 Dez	2005		Leonardo Riego		Modificado para pegar o nome do Comissionado da função;
	17 Apr	2006		Leonardo Riego		Novo campo IDDepartment;
	26 Feb	2007		Rodrigo Costa		Selecionar imposto definido no PreInventoryMov;
	26 Mar	2007		Maic Nogueira		Adicionado o campo "CaseQty" da tabela "Model";
	10 Aug	2007		Maximiliano Muniz	Adicionado o campo "Department" da tabela "Inv_Department";
        05 Jan  2010		Eliandro Souza		Adicionando o campo "Discount" da tabela "Ent_CustomerDiscount"
December 10 2012        Antonio M F Souza  added UnitDiscount on SQL when in Presale                 
	---------------------------------------------------------------------------------------------------------------------------------- */

DECLARE @ErrorLevel int
DECLARE @SysError int

SET @ErrorLevel = 0

if @IsPreSale = 1
begin
	SELECT
		ModelID,
		M.CaseQty,
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
		PIM.Discount,
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
		PIM.IDPreInventoryMovParent as IDMovParent,
		D.Department
		,isnull(CD.Discount, 0) as DiscountLoyalt
		,isNull(PIM.UnitDiscount, 0) as UnitDiscount
	FROM
		PreInventoryMov PIM (NOLOCK) 
		JOIN Model M (NOLOCK) ON ( PIM.ModelID = M.IDModel )
		LEFT OUTER JOIN InvSize SZ (NOLOCK) ON (M.IDSize = SZ.IDSize)
		LEFT OUTER JOIN InvColor CL (NOLOCK) ON (M.IDColor = CL.IDColor)
		JOIN SystemUser SU (NOLOCK) ON ( SU.IDUser = PIM.UserID )
		JOIN TabGroup TG (NOLOCK) ON ( M.GroupID = TG.IDGroup )
		JOIN StoreToTabGroup STC (NOLOCK) ON ( STC.IDStore = PIM.StoreID AND STC.IDGroup = TG.IDGroup )
		LEFT OUTER JOIN TaxCategory TC (NOLOCK) ON ( TC.IDTaxCategory = STC.IDTaxCategory AND TC.IDTaxCategory = IsNull(PIM.IDTaxCategory, TC.IDTaxCategory))
		LEFT OUTER JOIN TaxCategory TCI (NOLOCK) ON ( TCI.IDTaxCategory = STC.IDSaleTax )
		LEFT OUTER JOIN Inv_Department D (NOLOCK) ON (PIM.IDDepartment = D.IDDepartment)
		LEFT OUTER JOIN Pessoa P (NOLOCK) ON PIM.IDPessoa = P.IDPessoa
		LEFT OUTER JOIN Ent_CustomerDiscount CD (NOLOCK) ON (CD.IDGroup = M.GroupID) AND (CD.IDTipoPessoa = P.IDTipoPessoa)
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
		M.CaseQty,
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
		IM.Discount,
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
		0 as IDMovParent,
		D.Department
		,isnull(CD.Discount, 0) as DiscountLoyalt
		,isnull(IM.UnitDiscount, 0) as UnitDiscount
	FROM
		InventoryMov IM (NOLOCK) 
		JOIN Model M (NOLOCK) ON ( IM.ModelID = M.IDModel )
		LEFT OUTER JOIN InvSize SZ (NOLOCK) ON (M.IDSize = SZ.IDSize)
		LEFT OUTER JOIN InvColor CL (NOLOCK) ON (M.IDColor = CL.IDColor)
		JOIN SystemUser SU (NOLOCK) ON ( SU.IDUser = IM.IDUser )
		JOIN TabGroup TG (NOLOCK) ON ( M.GroupID = TG.IDGroup )
		JOIN StoreToTabGroup STC (NOLOCK) ON ( STC.IDStore = IM.StoreID AND STC.IDGroup = TG.IDGroup )
		LEFT JOIN TaxCategory TC (NOLOCK) ON ( TC.IDTaxCategory = STC.IDTaxCategory )
		LEFT JOIN Inv_Department D (NOLOCK) ON (IM.IDDepartment = D.IDDepartment)
		LEFT OUTER JOIN Pessoa P (NOLOCK) ON IM.IDPessoa = P.IDPessoa
		LEFT OUTER JOIN Ent_CustomerDiscount CD (NOLOCK) ON (CD.IDGroup = M.GroupID) AND (CD.IDTipoPessoa = P.IDTipoPessoa)
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

/****** Object:  StoredProcedure [dbo].[sp_PreSale_RemoveItem]    Script Date: 04/27/2016 20:09:06 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[sp_PreSale_RemoveItem]
			( 
			@PreSaleID 		int,
			@ModelID		int,
			@UserID 		int,
			@PreInventMovID	int,
			@Discount		money,
			@SalePrice		money,
			@Qty			float,
			@Date			DateTime,
			@ResetDiscount	bit  	= 0,
			@Manager		bit	= 0,
			@SellBelowCost		bit	= 0
			)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Testa se o discount total ainda e valido
		- Efetivamente remove o inventory moviment

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em exec @Result = sp_PreSale_SubTestDiscount
		-202  Erro em exec sp_PreSale_SubResetDiscount
		-203  Erro em Delecao do PreSerialMov
		-204  Erro em exec @result = sp_PreSale_SubRemoveItem
		-205  Erro em exec sp_PreSale_RemoveDiscountItem
		-206  Erro em exec sp_PreSale_SubCalcTotal

	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
	26 June 2001		Davi Gouveia		Log de Return Values
	18 Aug  2004		Rodrigo Costa		Gravar error log
	06 Apr	2006		Leonardo Riego		Inclusão da chamada a sp_PreSale_RemoveDiscountItem
	16 Jun	2006		Rodrigo Costa		Adicionado os parametros para ErrorHistory
	18 Aug	2006		Rodrigo Costa		Novo parametro para aplicar desconto inferior ao custo
	22 Jan	2010		Eliandro Souza		Inclusão do Update para zerar os campos de descontos
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */


DECLARE @Result  	int 
DECLARE @Value	money
DECLARE @ErrorLevel	int
DECLARE @SysError	int

SET @ErrorLevel = 0

/*------------------------------------------------------------------------------*/
/*                Testa se o discount total ainda e valido                      */
/*------------------------------------------------------------------------------*/ 

SELECT @Value = IsNull((@Qty * @SalePrice), 0) 

if @Manager = 0
   begin
 
	exec @Result = sp_PreSale_SubTestDiscount
						@PreSaleID,
						@ModelID,
						@UserID,
						@Discount,
						@Value,
						'E'
 	
	SET @SysError = @@ERROR
	IF @SysError <> 0
 	BEGIN
 		PRINT '-201'
 		RETURN -201
 	END

 	if @ResetDiscount = 1 and @Result <> 0
	   begin
		exec sp_PreSale_SubResetDiscount	@PreSaleID
		SET @SysError = @@ERROR
		IF @SysError <> 0
		BEGIN
 			PRINT '-202'
 			RETURN -202
 		END
	   end
	else
	   begin
		if @Result <> 0
		   begin
 			Return @Result
		   end
	   end
   end

/*-------------------------------------------------------------*/
/*          Efetivamente remove o inventory moviment           */
/*-------------------------------------------------------------*/ 
begin tran
 
/*--------------------------------------------------------------*/
/*		Delecao do PreSerialMov	        */
/*--------------------------------------------------------------*/
DELETE
	PSM
FROM
	PreSerialMov PSM
WHERE
	PSM.PreInventoryMovID =  @PreInventMovID

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -203
	GOTO ERRO
END

exec @result = sp_PreSale_SubRemoveItem	@PreInventMovID

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -204
	GOTO ERRO
END

exec @result = sp_PreSale_RemoveDiscountItem @PreSaleID, @PreInventMovID, @Date 	

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -205
	GOTO ERRO
END  
 
if @Result <> 0
begin
	SET @ErrorLevel = @Result
	GOTO ERRO
end
else
begin
	exec sp_PreSale_SubCalcTotal @PreSaleID, @Date
	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		SET @ErrorLevel = -206
		GOTO ERRO
	END
end

exec @result = sp_PreSale_SetDiscount @PreSaleID
SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -207
	GOTO ERRO
END

OK:
	COMMIT TRAN
	RETURN @Result
ERRO:
	ROLLBACK TRAN
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(510)
	DECLARE @Params varchar(500)	
	SET @Params = ' [ @ModelID = ' + CAST(@ModelID AS VARCHAR) + ' @UserID = '  + CAST(@UserID AS VARCHAR) + 
			' @PreInventMovID = '  + CAST(@PreInventMovID AS VARCHAR) +  ' ] '
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR) + @Params

	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PreSale_RemoveItem', @ErrorLevelStr

	RETURN @ErrorLevel
GO

/****** Object:  StoredProcedure [dbo].[sp_PreSale_SubAddItem]    Script Date: 04/27/2016 20:10:25 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[sp_PreSale_SubAddItem]
    (
    @PreSaleID      int,
    @IDCliente      int,
    @ModelID        int,
    @StoreID        int,
    @UserID         int,
    @IDComission        int,
    @Qty            float,
    @SalePrice      money,
    @CostPrice      money = Null,
    @Discount       money,
    @MovDate        smalldatetime,
    @IDPreInvMovExchange    int,
    @PreInvMovParentID  int,
    @IDDepartment       int,
    @Promo          bit,
    @IDDescriptionPrice int,
    @IDVendorPrice      int,
    @SuggPrice      int,
    @DocumentNumber     varchar(20),
    @IDDocumentType     int,
    @SequencyNum        int,
    @TotParcial     varchar(10),
    @DiscountPromo      money = 0,
    @UnitDiscount       money =0,
    @PreInventMovID     int = NULL Output,
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

    Data            Programador     Modificação
    ----------------------- ----------------------- -----------------------------------------------------------------
    15 May  2000        Eduardo Costa       Criacao;
    26 Jun  2001        Davi Gouveia        Log de Return Values;
    29 Oct  2003        Rodrigo Costa       Criado sp_Sis_GetNextCod;
    24 May  2004        André Bogado        Criado Cursor para KitModel;
    18 Aug  2004        Rodrigo Costa       Gravar error log;
    01 Dec  2004        Rodrigo Costa       Gravar no Customer Credit;
    01 Feb  2005        Rodrigo Costa       Inclusao do campo @IDPreInvMovExchange;
    11 Apr  2005        Rodrigo Costa       Inclusao do campo DesiredMarkup no PreInvMov;
    28 Nov  2005        Leonardo Riego      Gravar na SaleItemCommission;
    12 Apr  2006        Leonardo Riego      Novo campo @IDDepartment;
    16 Jun  2006        Rodrigo Costa       Adicionado os parametros para ErrorHistory;
    20 Jul  2007        Maximiliano Muniz   Novos parâmetros @IDDescriptionPrice, @IDVendorPrice e @SuggPrice;
                            Inserção na tabeça Inv_MovPrice;
    08 Aug  2007        Maximiliano Muniz   Novos parâmetros @DocumentNumber e @IDDocumentType;
                            Inserção na tabeça Inv_MovDocument;
    24 Aug  2009        Rodrigo Costa       Inclusao dos campos TotParcial e SequencyNum para o PAF-ECF
    19 Jan  2010        Eliandro Souza      Inclusão do Parametro @DiscountPromo
    10 Dec  2012        Antonio M F Souza   added UnitDiscount parameter
    19 Nov 2015         Antonio M F Souza   added canCombine variable to test condition to combine lines in cash register
    09 Dec 2015         Antonio M F Souza   combine lines totally reimplemented
    17 Dec 2015         Antonio M F Souza   working around manual discounts and other discounts ( promo, etc )
    ----------------------------------------------------------------------------------------------------------------- */

DECLARE @ComissionID        int
DECLARE @IDMovPrice     int
DECLARE @IDMovDocument      int
DECLARE @ErrorLevel     int
DECLARE @SysError       int
DECLARE @IDSaleItemCommission   int
DECLARE @IsNewPIM             boolean
DECLARE @IsUpdate           boolean
declare @canCombine boolean
declare @PriceAux float
declare @discountAux float


--Declaration of variables for ModelChild cursor
DECLARE @ModelIDChild   int
DECLARE @QtyChild       float
DECLARE @PreInvMovIDPack    int



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
set @canCombine = 0

-- Check the passed-in ID exists in the table or not.
select @FoundIDPreInventoryMov = @PreInventMovID
from PreInventoryMov
where IDPreInventoryMov = @PreInventMovID

IF (@FoundIDPreInventoryMov is not null) begin
    --print 'Already have preinventorymov, add or remove to existing quantity.'
    --print 'FoundIDPreInventoryMov: ' + coalesce(cast(@FoundIDPreInventoryMov as varchar), 'null')
    --print 'PreInventMovID: ' + coalesce(cast(@PreInventMovID as varchar), 'null')
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

-- Antonio: combine lines reimplemented
end else begin --  - IdMov not found
         set @IsNewPIM = 1;
         
         declare @discountFound money
         declare @priceFound money
         declare @IdmodelFound int
         declare @movIDFound int
         declare @qtyFound decimal(38, 4)
         
         
         if ( @manualDiscount is null ) begin
            set @discountAux = 0
         end else begin
                 set @discountAux = @UnitDiscount
             end
             
         if (@ManualPrice is null) begin
             set @priceAux = 0
         end else begin
                  set @priceAux = @manualPrice
             end    
        
        -- price changed manually
        if ( @ManualPrice is not null ) begin        
			-- searching for an item that matches with discount
			select @movIDFound = dbo.PreInventoryMov.IDPreInventoryMov
				  ,@discountFound = isNull(dbo.PreinventoryMov.Discount, 0)
				  ,@priceFound = ISNULL(dbo.preinventoryMov.salePrice, 0)
				  ,@qtyFound = dbo.PreInventoryMov.Qty
				  ,@IdmodelFound = dbo.PreInventoryMov.ModelID
			FROM dbo.PreInventoryMov
			WHERE dbo.PreInventoryMov.ModelID = @ModelID
                  AND dbo.PreInventoryMov.UserID = @UserID
			      AND dbo.PreInventoryMov.DocumentID = @PreSaleID
			      AND dbo.PreInventoryMov.StoreID = @StoreID
                  AND dbo.PreInventoryMov.InventMovTypeID = 1
                  and dbo.PreinventoryMov.Discount = @discountAux -- also could have some discount
                  and dbo.PreInventoryMov.SalePrice = @priceAux
        
        
			if ( @idModelFound is not null ) begin
        
				  if ( @discountAux <> @discountFound ) begin
              
					  if ( @priceAux <> @priceFound ) begin
						  set @canCombine = 0
					  end
              
				  end else if ( @priceAux <> @priceFound ) begin
                       set @canCombine = 0
					  end else begin
                           set @canCombine = 1
                          end 
        
			 end else begin
					  set @canCombine = 0
				 end      
         
        -- manual price is null and is not a promo so, is a regular disccount
        end else if ( @manualDiscount is not null  ) begin
                     
     			 select @movidfound = dbo.preinventorymov.idpreinventorymov
						,@discountfound = isnull(dbo.preinventorymov.UnitDiscount, 0)
						,@pricefound = isnull(dbo.preinventorymov.saleprice, 0)
						,@qtyfound = dbo.preinventorymov.qty
						,@idmodelfound = dbo.preinventorymov.modelid
				  from dbo.preinventorymov
				  where dbo.preinventorymov.modelid = @modelid
					 and dbo.preinventorymov.userid = @userid
					 and dbo.preinventorymov.documentid = @presaleid
					 and dbo.preinventorymov.storeid = @storeid
					 and dbo.preinventorymov.inventmovtypeid = 1
					 and dbo.preinventorymov.UnitDiscount = @discountaux
					 
					 
					 if ( @idmodelfound is not null ) begin
					    if ( @discountfound <> @discountaux ) begin
					       set @cancombine = 0
					    end else begin
					          set @cancombine = 1  
					         end
                     end else begin
                         set @canCombine = 0
                     end
                     
						
				end else if ( @discountAux = 0 and @ManualPrice is null ) begin
        
									 -- to get original price to model
									declare @originalPrice money
		                        
									select @originalPrice = dbo.Model.SellingPrice from dbo.Model where IDModel = @ModelID
		                         
		                        
									select @movIDFound = dbo.PreInventoryMov.IDPreInventoryMov
										  ,@discountFound = isNull(dbo.PreinventoryMov.unitDiscount, 0)
										  ,@priceFound = ISNULL(dbo.preinventoryMov.salePrice, 0)
										  ,@qtyFound = dbo.PreInventoryMov.Qty
										  ,@IdmodelFound = dbo.PreInventoryMov.ModelID
									FROM dbo.PreInventoryMov
									WHERE dbo.PreInventoryMov.ModelID = @ModelID
											AND dbo.PreInventoryMov.UserID = @UserID
											AND dbo.PreInventoryMov.DocumentID = @PreSaleID
											AND dbo.PreInventoryMov.StoreID = @StoreID
											AND dbo.PreInventoryMov.InventMovTypeID = 1
											and dbo.PreinventoryMov.Discount = @discountAux
											and dbo.PreInventoryMov.SalePrice = @originalPrice
		                  
									if ( @IdmodelFound is not null ) begin
										if ( @discountFound  <> @discountAux ) begin
											set @canCombine = 0 
										end else begin
											   set @canCombine = 1
											end 
									end else begin
									        set @canCombine = 0
									    end
									 
	       -- promo				         
            end /*else if ( @SalePrice = 0 and @discountAux = 0 and @priceAux = 0) begin
                     
                    -- there is no manual price, neither manual discount but could have promotion
		            -- searching for an item that matches with discount calculations (i,e: promos )
					select @movIDFound = dbo.PreInventoryMov.IDPreInventoryMov
					       ,@discountFound = isNull(dbo.PreinventoryMov.UnitDiscount, 0)
					       ,@qtyFound = dbo.PreInventoryMov.Qty
					       ,@IdmodelFound = dbo.PreInventoryMov.ModelID
                    FROM dbo.PreInventoryMov
                    WHERE dbo.PreInventoryMov.ModelID = @ModelID
					     AND dbo.PreInventoryMov.UserID = @UserID
			             AND dbo.PreInventoryMov.DocumentID = @PreSaleID
			             AND dbo.PreInventoryMov.StoreID = @StoreID
                         AND dbo.PreInventoryMov.InventMovTypeID = 1
                  
                    if ( @discountAux = 0 ) begin
                        if ( @discountFound > 0 ) begin
					         set @discountAux = @discountFound       
	          		     end 
					end
					    
					    
					if ( @idModelFound is not null ) begin
					    if (@discountAux <> @discountFound) begin
					        set @canCombine = 0
					     end else begin
						          set  @canCombine = 1
						     end 
					     end else begin
					          set @canCombine = 0
						 end    
						   
		         end
		         */ 
                     
            
        -- combine lines if already exixts an ID in PreinventoryMov 
        IF ( @FoundIDPreInventoryMov is not null)  begin
			if ( @canCombine = 1 ) begin
               SET @PreInventMovID = @FoundIDPreInventoryMov;
               SELECT @FinalQty  = [Qty] + @Qty FROM [dbo].[PreInventoryMov] WHERE IDPreInventoryMov = @FoundIDPreInventoryMov;
               set @IsNewPIM = 0;
               print 'This has to be here to avoid a discount limit message.  No clue why.'
			end else if ( @canCombine = 0 ) begin
               SET @PreInventMovID = @FoundIDPreInventoryMov;
               SELECT @FinalQty  = @Qty
               set @IsNewPIM = 0;
			end
		-- combine lines if there is no a previous IdInventoryMov	
        end else begin
                 if ( @canCombine = 1 ) begin
                --print 'No preinventorymov yet, insert new row.'
                    -- this select get previous item that matches with discount conditions to line entered in cash register
                    
					SELECT @FinalQty  = @qtyFound + @Qty FROM [dbo].[PreInventoryMov] WHERE dbo.PreInventoryMov.IDPreInventoryMov = @movIDFound
					set @IsNewPIM = 1;
					EXEC sp_Sis_GetNextCode'PreInventoryMov.IDPreInventoryMov', @PreInventMovID OUTPUT;
					
					-- to clean up this record
					update PreInventoryMov set Qty = 0 where IDPreInventoryMov = @movIDFound
					
                 end else if ( @canCombine = 0 ) begin
					 --print 'No preinventorymov yet, insert new row.'
						  SET @FinalQty  = @Qty;
						  set @IsNewPIM = 1;
						  EXEC sp_Sis_GetNextCode'PreInventoryMov.IDPreInventoryMov', @PreInventMovID OUTPUT;
                     end      
            end
-- Antonio - combine lines reimplemented


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
 * Recalculate prices with the potentially-new quantity value.
 */
-- So that sp_PreSale_CalcPrice can work directly off the table and not the variable:
update PreInventoryMov
set Qty = @FinalQty
where IDPreInventoryMov = @PreInventMovID;

declare @OutPrice money;
declare @OutCost money;

/*
declare @tablevar table(Price money);
insert into @tablevar(Price)
    EXEC [dbo].[sp_PreSale_CalcPrice] @ModelID, @StoreID, @FinalQty,
    @PreInventMovID, @IDSpecialPrice, @ManualPrice;
SELECT @OutPrice = Price FROM @tablevar;
*/
if (@ManualPrice is not null)
begin
    merge ManualPrice as target
    using (select @PreInventMovID, @ManualPrice)
        as source (id_preinventorymov,  manual_price)
    on (target.IDPreInventoryMov = source.id_preinventorymov
        and target.IDPreInventoryMov = source.id_preinventorymov)
    when matched then
        update set ManualPrice = source.manual_price
    when not matched then
        insert (IDPreInventoryMov, ManualPrice)
        values (
            source.id_preinventorymov,
            source.manual_price
        );
end;

-- select @OutPrice = dbo.fn_CalcPrice(@PreInventMovID, @IDSpecialPrice);
-- select @OutCost = Finalcost from Model where IDModel = @ModelID;

if (@FinalQty = 0)
begin
    delete from PreInventoryMov where IDPreInventoryMov = @PreInventMovID
end
else
begin
    /*
     * Update prices on all items, since adding one may affect the others
     * due to quantity price breaks.
     */
    update PreInventoryMov
    set SalePrice = dbo.fn_CalcPrice(
            IDPreInventoryMov, (
                -- Only pass in the IDSpecialPrice for the one line item that is
                -- associated with this *_SubAddItem call, otherwise null.
                -- A better solution would be to store the IDSpecialPrice
                -- in an associated table, because otherwise an item will only
                -- have the specialprice until a different item is added (and
                -- it has its price recalculated without the specialprice).
                case when IDPreInventoryMov = @PreInventMovID then
                    @IDSpecialPrice
                else
                    null
                end
            )
        ),
        CostPrice = (select FinalCost from Model where IDModel = ModelID)
    where DocumentID = (
        select top 1 DocumentID
        from PreInventoryMov
        where IDPreInventoryMov = @PreInventMovID
    );

end

-- Call every time (i.e. temporarily disable IDParam 118.
-- exec sp_PreSale_SetDiscount @PreSaleID;

/*
 * IDParam 118 is "Calculate discounts on Finalization Only", which controls
 * whether discounts are calculated after each item addition, or just at order
 * finalization. The two valid values are 'Item' (default) or 'Sale'.
 */
declare @UpdateDiscounts char(4);
select @UpdateDiscounts = SrvValue from Param where IDParam = 118;
if @UpdateDiscounts <> 'Sale'
begin
    -- insert into ManualDiscount values (55137, 9.99)
    exec sp_PreSale_SetDiscount @PreSaleID
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


-- Create sprocs for Sal_Coupon

set xact_abort on;

GO

/****** Object:  StoredProcedure [dbo].[sp_PreSale_SubCalcItemDiscount]    Script Date: 04/27/2016 20:11:43 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO

ALTER  PROCEDURE [dbo].[sp_PreSale_SubCalcItemDiscount]
        (
            @PreSaleID Int
        )
AS
return 0;

GO

/****** Object:  StoredProcedure [dbo].[sp_PreSale_SubCalcTax]    Script Date: 04/27/2016 20:12:44 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO

ALTER    PROCEDURE [dbo].[sp_PreSale_SubCalcTax]
   (
   @PreSaleID  int,
   @Date  DateTime
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

 Data   Programador  Modificação
 --------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
 14 agosto 2000    Eduardo Costa  Suporte ao tax categories, agora é taxa é definda na tabela de
       TaxCategory. Cada conjunto de Store e TabGroup define uma
       TaxCategory;
 26 June 2001  Davi Gouveia  Log de Return Values
 18 Aug 2004  Rodrigo Costa  Gravar error log
 26 Oct  2004  Carlos Lima  Calcular Tax, incluindo os Invoices filhos
 07 Dez 2004  Rodrigo Costa  Novo calculo das taxas
 20 Jan 2005  Rodrigo Costa  Calculo das taxas do InventoryMov para somar com o total do invoice
 26 Fev 2007  Rodrigo Costa  Calcular imposto estabelecido no PreInvMov
 02 July 2013    Antonio Marcos      added InvoiceDiscount to fix tax when there is discount to all invoice ( sale                                              discount )
    02 Jul 2013     Daniel Browning and Nicholas Cook - Added ability to calculate tax including invoice discount.
 
    --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

DECLARE @LocalTax   money
DECLARE @ErrorLevel  int
DECLARE @SysError  int
DECLARE @TaxTotal  money
DECLARE @TaxTotalExp money

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
  Invoice INV (NOLOCK) 
  JOIN
  InventoryMov IM (NOLOCK) ON (INV.IDInvoice = IM.DocumentID)
  JOIN
  InventoryMovTax IMX (NOLOCK) ON (IM.IDInventoryMov = IMX.IDInventoryMov)
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
  Invoice INV (NOLOCK) 
  JOIN
  InventoryMov IM (NOLOCK) ON (INV.IDInvoice = IM.DocumentID)
  JOIN
  InventoryMovTax IMX (NOLOCK) ON (IM.IDInventoryMov = IMX.IDInventoryMov)
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
 SELECT ISNULL(
   SUM (
    (Round(PIM.Qty * ISNULL(PIM.SalePrice, 0),4,1) - ISNULL(PIM.Discount, 0))  -- Subtotal da linha do inventario
       -
        (
                        ( 
                            ((PIM.Qty * PIM.SalePrice) - PIM.Discount)  / nullif((INV.SubTotal - INV.ItemDiscount), 0)
                        )
                        * INV.InvoiceDiscount
                    )

               
     * (CASE WHEN (TC.SpecialDateStart <= @Date) AND (TC.SpecialDateEnd >= @Date) THEN (IsNull(TC.SpecialTax,0) + IsNull(TCI.Tax, 0)) ELSE (IsNull(TC.Tax,0) + IsNull(TCI.Tax,0)) END / 100.00)  -- Tax
    ),0)
 FROM 
  Invoice INV   
  JOIN
  PreInventoryMov PIM   ON (INV.IDPreSale = PIM.DocumentID)
  JOIN
  Model M   ON (M.IDModel = PIM.ModelID)
  JOIN
  StoreToTabGroup STG   ON (STG.IDGroup = M.GroupID AND STG.IDStore = I.IDStore)
  JOIN
  TaxCategory TC   ON (STG.IDTaxCategory = TC.IDTaxCategory AND TC.IDTaxCategory = IsNull(PIM.IDTaxCategory, TC.IDTaxCategory))
  LEFT OUTER JOIN 
  TaxCategory TCI   ON ( TCI.IDTaxCategory = STG.IDSaleTax )

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
 SELECT ISNULL(
   SUM (
           (
               (
                Round(
                    PIM.Qty * ISNULL(PIM.SalePrice, 0),
                    5,
                    1
                )
                - 
                ISNULL(PIM.Discount, 0)
            )  -- Subtotal da linha do inventario
            
             - ISNULL(
            round(
                (
                                ( 
                                    ((PIM.Qty * PIM.SalePrice) - PIM.Discount)  / nullif((INV.SubTotal - INV.ItemDiscount), 0)
                                    -- ((( 1 * 3.99+1.49) - 0.00) / (5.48 - 0.00)) * 5.48
                                )
                                * INV.InvoiceDiscount
                            ),
                            5, 0
                        )
                      ,0)  
                    )
                    
     * (CASE WHEN (TC.SpecialDateStart <= @Date) AND (TC.SpecialDateEnd >= @Date) AND ( ISNULL((( ISNULL(PIM.SalePrice, 0) - ISNULL(PIM.Discount, 0)) / PIM.Qty), 0) < ISNULL(TC.MaxItemValue, 0))
      THEN (IsNull(TC.SpecialTax,0) + IsNull(TCI.Tax, 0)) ELSE (IsNull(TC.Tax,0) + IsNull(TCI.Tax,0)) END / 100.00)  -- Tax
    ),
   0
   )
 FROM Invoice INV (NOLOCK) 
  JOIN PreInventoryMov PIM (NOLOCK) ON (INV.IDPreSale = PIM.DocumentID)
  JOIN Model M (NOLOCK) ON (M.IDModel = PIM.ModelID)
  JOIN StoreToTabGroup STG (NOLOCK) ON (STG.IDGroup = M.GroupID AND STG.IDStore = I.IDStore)
  JOIN TaxCategory TC (NOLOCK) ON (STG.IDTaxCategory = TC.IDTaxCategory AND TC.IDTaxCategory = IsNull(PIM.IDTaxCategory, TC.IDTaxCategory))
  LEFT OUTER JOIN TaxCategory TCI (NOLOCK) ON ( TCI.IDTaxCategory = STG.IDSaleTax )
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

/****** Object:  StoredProcedure [dbo].[sp_PreSale_SubCalcTotal]    Script Date: 04/27/2016 20:13:26 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO

ALTER   PROCEDURE [dbo].[sp_PreSale_SubCalcTotal]
		(
		@PreSaleID Int,
		@Date	DateTime
		)
AS
/* ----------------------------------------------------------------------------------------------------------------------------------------
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
	-----------------------	-----------------------	----------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
	26 June 2001		Davi Gouveia		Log de Return Values;
	18 Aug 	2004		Rodrigo Costa		Gravar error log;
	26 Oct 	2004		Carlos Lima		Calcular total, incluindo os Invoices filhos;
	19 Jan	2005		Rodrigo Costa		Calcular os totais das outras despesas;
	20 Jan	2005		Rodrigo Costa		Calcular os totais do InvMov para somar no total da nota;
	21 Dec	2006		Maximiliano Muniz	Aplicada uma nova forma de arredondamento;
	10 Jan	2007		Maximiliano Muniz	Alterado o tipo da variável @SubTotal de money para float, pois o tipo money já
							arredonda automaticamente, ignorando a nova forma de arredondamento;
	18 Apr	2007		Maic Nogueira		Removida a lógica de arredondamento anterior, e adicionado um Round
							para cada item da venda;
    11 Dec 2015         Nick, Antonio       change in where clause to fix invoice subtotal to kit models ( search for 11 Dec 2015 ) 							
							
	---------------------------------------------------------------------------------------------------------------------------------- */
DECLARE @ErrorLevel	int 
DECLARE @SysError	int
DECLARE @SubTotal	float
SET @ErrorLevel = 0 

BEGIN TRAN 

--Calculo do PreInventoryMov
SET @SubTotal = 
		IsNull((
		SELECT
			SUM(Round(IsNull(PIM.SalePrice, 0) * IsNull(PIM.Qty, 0), 4, 1))
		FROM
			dbo.Invoice INV (NOLOCK) 
			LEFT JOIN dbo.PreInventoryMov PIM (NOLOCK) ON (INV.IDPreSale = PIM.DocumentID)
		WHERE
			(
			INV.IDPreSale = @PreSaleID
			OR
			INV.IDPreSaleParent = @PreSaleID -- Calcula todos os invoices filhos deste PreSale
			)						
			AND
			PIM.InventMovTypeID = 1
			and pim.IDParentPack is null -- to fix subtotals to kit models - 11 Dec 2015
		),0)

--Calculo do InventoryMov
SET @SubTotal = @SubTotal + 
		IsNull((
		SELECT
			SUM(Round(IsNull(IM.SalePrice, 0) * IsNull(IM.Qty, 0), 4, 1))
		FROM
			dbo.Invoice INV (NOLOCK) 
			LEFT JOIN InventoryMov IM (NOLOCK) ON (INV.IDInvoice = IM.DocumentID)
		WHERE
			(
			INV.IDPreSale = @PreSaleID
			OR
			INV.IDPreSaleParent = @PreSaleID -- Calcula todos os invoices filhos deste Invoice
			)						
			AND
			IM.InventMovTypeID = 1
			and IM.IDParentPack is null -- to fix subtotals to kit models - 11 Dec 2015
		),0)

UPDATE
	dbo.Invoice
SET
	dbo.Invoice.SubTotal =  Round(@SubTotal,4)
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

/****** Object:  StoredProcedure [dbo].[sp_PreSale_SubRemoveItem]    Script Date: 04/27/2016 20:14:23 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


ALTER PROCEDURE [dbo].[sp_PreSale_SubRemoveItem]
	(
	@PreInventMovID int
	)
AS

/* ---------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Delete on Pre Inventory Movement Items Packages
		- Delete on Pre Inventory Movement

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro no Delete
		-202  Erro no Delete PackItems
		-203  Erro no Delete CustomerCredit
		-204  Erro no Delete CustomerCredit do PackModel
		-205  Erro em atulaizar qtyExchanged no Pre
		-206  Erro em atulaizar qtyExchanged no Inv
		-207  Erro no Delete SaleItemCommission
		-208  Erro ao deletar o comissionamento dos itens de Kit
		-209  Erro ao deletar Inv_MovPrice
		-210  Erro ao deletar Inv_MovPrice
		-211  Erro ao deleter Pet_PetSale/Pet_MicrochipSale
		-212  Erro ao voltar o Pet Para disponivel
		-213  Error on delete manual price

	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	-----------------------	-----------------------	----------------------------------------------------------------------------------
	15 May	2000		Eduardo Costa		Criacao;
	26 Jun	2001		Davi Gouveia		Log de Return Values;
	25 May	2004		Rodrigo Costa		Deletar os PackModels;
	18 Aug	2004		Rodrigo Costa		Gravar error log;
	01 Dec	2004		Rodrigo Costa		Deletar os Credits for Customer;
	28 Nov	2005		Leonardo Riego		Deletar as linhas da SaleItemCommission;
	16 Jun	2006		Rodrigo Costa		Deletar as linhas do SaleItemCommission do item de Kit;
	16 Jun	2006		Rodrigo Costa		Adicionado os parametros para ErrorHistory;
	20 Jul	2007		Maximiliano Muniz	Deletar a linha da Inv_MovPrice;
	08 Aug	2007		Maximiliano Muniz	Deletar a linha da Inv_MovDocument;
	16 Aug	2007		Rodrigo Costa		Deleter a linha da Pet_PetSale/Pet_MicrochipSale;
	04 Jul	2008		Rodrigo Costa		Voltar status do Pet para disponivel
	2014 03 10   		John Rogers		    Called SP to delete manual prioe
	---------------------------------------------------------------------------------------------------------------------------------- */

DECLARE @ErrorLevel			int
DECLARE @SysError			int
DECLARE @IDPreInvMovExchange	int
DECLARE @Qty			float

SET @ErrorLevel = 0

/*--------------------------------------------------------------*/
/*	Delete on os Customers Credit do PreInventoryMovPack	*/
/*--------------------------------------------------------------*/
UPDATE
	CustomerCredit
SET
	IsUsed = 1
FROM
	PreInventoryMov PIM (NOLOCK) 
WHERE
	PIM.IDParentPack = @PreInventMovID
	AND
	CustomerCredit.IDPreInventoryMov = PIM.IDPreInventoryMov

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -204
	GOTO ERRO
END

/*----------------------------------------------*/
/*	Deletar as quantidades para troca	*/
/*----------------------------------------------*/
SELECT
	@IDPreInvMovExchange = IDPreInvMovExchange,
	@Qty = Qty
FROM
	PreInventoryMov (NOLOCK) 
WHERE
	IDPreInventoryMov = @PreInventMovID

IF (@IDPreInvMovExchange IS NOT Null)
BEGIN
	--Pre Inv Mov
	UPDATE
		PreInventoryMov
	SET 
		QtyExchanged = IsNull(QtyExchanged,0) - ABS(@Qty)
	WHERE 
		IDPreInventoryMov = @IDPreInvMovExchange
		AND 
		InventMovTypeID = 1
	
	SET @SysError = @@ERROR
	IF @SysError <> 0 
	BEGIN
		SET @ErrorLevel = -205
		GOTO ERRO
	END
	
	-- Inv Mov
	UPDATE
		InventoryMov
	SET 
		QtyExchanged = IsNull(QtyExchanged,0) - ABS(@Qty)
	WHERE 
		PreInventoryMovID = @IDPreInvMovExchange
		AND 
		InventMovTypeID = 1
	
	SET @SysError = @@ERROR
	IF @SysError <> 0 
	BEGIN
		SET @ErrorLevel = -206
		GOTO ERRO
	END
END

/*----------------------------------------------*/
/*	Delete os Commissions dos itens de Kit	*/
/*----------------------------------------------*/
DELETE
	SaleItemCommission
FROM
	PreInventoryMov PIM (NOLOCK) 
	JOIN SaleItemCommission SIC (NOLOCK) ON (PIM.IDPreInventoryMov = SIC.IDPreInventoryMov)
WHERE
	PIM.IDParentPack = @PreInventMovID

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -208
	GOTO ERRO
END

/*------------------------------------------------------*/
/*	Delete os Commissions for SaleItemCommission	*/
/*------------------------------------------------------*/
DELETE
	SaleItemCommission
WHERE
	SaleItemCommission.IDPreInventoryMov = @PreInventMovID

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -207
	GOTO ERRO
END

/*----------------------------------------------*/
/*	Delete on Pre Inventory Movement Pack	*/
/*----------------------------------------------*/
DELETE
	PreInventoryMov
WHERE
	PreInventoryMov.IDParentPack = @PreInventMovID

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -202
	GOTO ERRO
END

/*------------------------------------------------------*/
/*	Delete os Customers Credit do PreInventoryMov	*/
/*------------------------------------------------------*/
UPDATE
	CustomerCredit
SET
	IsUsed = 1
WHERE
	IDPreInventoryMov = @PreInventMovID

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -203
	GOTO ERRO
END

/*----------------------------------------------*/
/*	Delete on Inv_MovPrice			*/
/*----------------------------------------------*/
DELETE
	Inv_MovPrice
WHERE
	IDPreInventoryMov = @PreInventMovID

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -209
	GOTO ERRO
END

/*----------------------------------------------*/
/*	Delete on Inv_MovDocument		*/
/*----------------------------------------------*/
DELETE
	Inv_MovDocument
WHERE
	IDPreInventoryMov = @PreInventMovID

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -210
	GOTO ERRO
END

/*----------------------------------------------*/
/*	Voltar status do Pet para disponivel */
/*----------------------------------------------*/
UPDATE
	Pet
SET
	IDStatus = 1
WHERE
	IDPet IN 
		(SELECT
			IDPet
		FROM
			Pet_PetSale (NOLOCK) 
		WHERE
			IDPreInventoryMov = @PreInventMovID)


/*----------------------------------------------*/
/*	Delete on Pet_PetSale/Pet_MicrochipSale */
/*----------------------------------------------*/
DELETE
	Pet_MicrochipSale
WHERE
	IDPetSale IN 
		(SELECT
			IDPetSale
		FROM
			Pet_PetSale (NOLOCK) 
		WHERE
			IDPreInventoryMov = @PreInventMovID)
	OR
	IDPreInventoryMov = @PreInventMovID


SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -211
	GOTO ERRO
END

DELETE
	Pet_PetSale
WHERE
	IDPreInventoryMov = @PreInventMovID

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -211
	GOTO ERRO
END

/*----------------------------------------------*/
/*	Delete From ManualPrice                 */
/*----------------------------------------------*/
EXEC [dbo].[sp_PreSale_DelManualPrice] @PreInventMovID

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -213
	GOTO ERRO
END

/*----------------------------------------------*/
/*	Delete From ManualDiscount                */
/*----------------------------------------------*/
EXEC [dbo].[sp_PreSale_DelManualDiscount] @PreInventMovID

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -213
	GOTO ERRO
END

/*----------------------------------------------*/
/*	Delete on Pre Inventory Movement	*/
/*----------------------------------------------*/
DELETE
	PreInventoryMov
WHERE
	PreInventoryMov.IDPreInventoryMov = @PreInventMovID

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

	DECLARE @ErrorLevelStr varchar(110)
	DECLARE @Params varchar(100)
	SET @Params = ' [ @PreInventMovID = ' + CAST(@PreInventMovID AS VARCHAR) + ' ] '
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR) + @Params

	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PreSale_SubRemoveItem', @ErrorLevelStr
	RETURN @ErrorLevel

GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_CashRegister]    Script Date: 04/27/2016 20:16:02 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[sp_rpl_insupd_CashRegister]
(
	@IDCashRegister int,@Name varchar(15),@IsAssociated bit,@Desativado bit,@Hidden bit,@System bit,@IsOpen bit,@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	CashRegister
      (IDCashRegister,Name,IsAssociated,Desativado,Hidden,System,IsOpen,ReplLastChange)
      VALUES
      (@IDCashRegister,@Name,@IsAssociated,@Desativado,@Hidden,@System,@IsOpen,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE CashRegister SET
    			-- No key fields
    			Name = @Name,
IsAssociated = @IsAssociated,
Desativado = @Desativado,
Hidden = @Hidden,
System = @System,
IsOpen = @IsOpen,
ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			IDCashRegister = @IDCashRegister
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Inv_ModelVendor]    Script Date: 04/27/2016 20:17:09 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[sp_rpl_insupd_Inv_ModelVendor]
(
	@IDPessoa int,@IDModel int,@VendorOrder int,@MinQtyPO float,@CaseQty decimal,@VendorCost money,@CostLastChange datetime,@DoNotOrder bit,@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	Inv_ModelVendor
      (IDPessoa,IDModel,VendorOrder,MinQtyPO,CaseQty,VendorCost,CostLastChange,DoNotOrder,ReplLastChange)
      VALUES
      (@IDPessoa,@IDModel,@VendorOrder,@MinQtyPO,@CaseQty,@VendorCost,@CostLastChange,@DoNotOrder,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE Inv_ModelVendor SET
    			-- No key fields
    			VendorOrder = @VendorOrder,
MinQtyPO = @MinQtyPO,
CaseQty = @CaseQty,
VendorCost = @VendorCost,
CostLastChange = @CostLastChange,
DoNotOrder = @DoNotOrder,
ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			IDPessoa = @IDPessoa AND
IDModel = @IDModel
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_InventoryMov]    Script Date: 04/27/2016 20:18:41 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[sp_rpl_insupd_InventoryMov]
(
	@IDInventoryMov int,@IDRepair int,@StoreID int,@ModelID int,@InventMovTypeID int,@IDPessoa int,@IDAgrupaPag int,@IDTemp int,@IDLancPagCom int,@DocumentID int,@IDUser int,@BarCodeID char(20),@PreInventoryMovID int,@MovDate smalldatetime,@CostPrice money,@SalePrice money,@Discount money,@Freight money,@OtherCost money,@ExchangeInvoice int,@SalesTax money,@IDParentPack int,@IDModelService int,@IDPreInvMovExchange int,@AvgCost money,@DesiredMarkup money,@SequencyNum int,@Promo bit,@IDDepartment int,@QTY decimal,@QtyExchanged decimal,@UnitDiscount money,@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	InventoryMov
      (IDInventoryMov,IDRepair,StoreID,ModelID,InventMovTypeID,IDPessoa,IDAgrupaPag,IDTemp,IDLancPagCom,DocumentID,IDUser,BarCodeID,PreInventoryMovID,MovDate,CostPrice,SalePrice,Discount,Freight,OtherCost,ExchangeInvoice,SalesTax,IDParentPack,IDModelService,IDPreInvMovExchange,AvgCost,DesiredMarkup,SequencyNum,Promo,IDDepartment,QTY,QtyExchanged,UnitDiscount,ReplLastChange)
      VALUES
      (@IDInventoryMov,@IDRepair,@StoreID,@ModelID,@InventMovTypeID,@IDPessoa,@IDAgrupaPag,@IDTemp,@IDLancPagCom,@DocumentID,@IDUser,@BarCodeID,@PreInventoryMovID,@MovDate,@CostPrice,@SalePrice,@Discount,@Freight,@OtherCost,@ExchangeInvoice,@SalesTax,@IDParentPack,@IDModelService,@IDPreInvMovExchange,@AvgCost,@DesiredMarkup,@SequencyNum,@Promo,@IDDepartment,@QTY,@QtyExchanged,@UnitDiscount,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE InventoryMov SET
    			-- No key fields
    			IDRepair = @IDRepair,
StoreID = @StoreID,
ModelID = @ModelID,
InventMovTypeID = @InventMovTypeID,
IDPessoa = @IDPessoa,
IDAgrupaPag = @IDAgrupaPag,
IDTemp = @IDTemp,
IDLancPagCom = @IDLancPagCom,
DocumentID = @DocumentID,
IDUser = @IDUser,
BarCodeID = @BarCodeID,
PreInventoryMovID = @PreInventoryMovID,
MovDate = @MovDate,
CostPrice = @CostPrice,
SalePrice = @SalePrice,
Discount = @Discount,
Freight = @Freight,
OtherCost = @OtherCost,
ExchangeInvoice = @ExchangeInvoice,
SalesTax = @SalesTax,
IDParentPack = @IDParentPack,
IDModelService = @IDModelService,
IDPreInvMovExchange = @IDPreInvMovExchange,
AvgCost = @AvgCost,
DesiredMarkup = @DesiredMarkup,
SequencyNum = @SequencyNum,
Promo = @Promo,
IDDepartment = @IDDepartment,
QTY = @QTY,
QtyExchanged = @QtyExchanged,
UnitDiscount = @UnitDiscount,
ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			IDInventoryMov = @IDInventoryMov
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_Model]    Script Date: 04/27/2016 20:20:21 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[sp_rpl_insupd_Model]
(
	@IDModel int,@GroupID int,@IDUnidade int,@IDFabricante int,@IDSize int,@IDColor int,@IDModelParent int,@Model varchar(30),@Description varchar(50),@VendorCost money,@FreightCost money,@OtherCost money,@MarkUp money,@SellingPrice money,@LastCost money,@DateLastCost smalldatetime,@DateLastSellingPrice smalldatetime,@LastMovDate datetime,@Peso money,@Avaiable money,@SuggRetail money,@PVD money,@DP money,@ES money,@PP money,@InicioPontoPedido datetime,@ClasseABC char(1),@AutomaticRequest bit,@TR int,@ModelType char(1),@CustomSalePrice bit,@CustomCostPrice bit,@CustomSpecialPrice bit,@CustomPromotion bit,@AvgCost money,@System bit,@Hidden int,@Desativado int,@LargeImage varchar(255),@FloatPercent int,@LargeImage2 varchar(255),@ReplacementCost money,@NotVerifyQty bit,@PromotionPrice money,@DiscountPerc float,@IDModelGroup int,@IDModelSubGroup int,@VD float,@VP float,@SX float,@SX2 float,@Verify bit,@AvgCostTotal money,@SendToTrash bit,@IDUserLastSellingPrice int,@AskUserOnSale bit,@TotQtyOnHand decimal,@TotQtyOnRepair decimal,@TotQtyOnPreSale decimal,@TotQtyOnPrePurchase decimal,@TotQtyOnOrder decimal,@CaseQty decimal,@UpdatePrice bit,@UseScale bit,@ScaleValidDay int,@UseLot bit,@IndicadorProducao char(1),@IndicadorAT char(1),@IDNCM int,@WebDescription varchar(255),@Portion varchar(100),@IDCFOP int,@ServiceMap varchar(30),@RequireOnSale bit,@ReplLastChange datetime,@NoUpdateCatalogs bit
) AS
BEGIN TRY
      INSERT INTO	Model
      (IDModel,GroupID,IDUnidade,IDFabricante,IDSize,IDColor,IDModelParent,Model,Description,VendorCost,FreightCost,OtherCost,MarkUp,SellingPrice,LastCost,DateLastCost,DateLastSellingPrice,LastMovDate,Peso,Avaiable,SuggRetail,PVD,DP,ES,PP,InicioPontoPedido,ClasseABC,AutomaticRequest,TR,ModelType,CustomSalePrice,CustomCostPrice,CustomSpecialPrice,CustomPromotion,AvgCost,System,Hidden,Desativado,LargeImage,FloatPercent,LargeImage2,ReplacementCost,NotVerifyQty,PromotionPrice,DiscountPerc,IDModelGroup,IDModelSubGroup,VD,VP,SX,SX2,Verify,AvgCostTotal,SendToTrash,IDUserLastSellingPrice,AskUserOnSale,TotQtyOnHand,TotQtyOnRepair,TotQtyOnPreSale,TotQtyOnPrePurchase,TotQtyOnOrder,CaseQty,UpdatePrice,UseScale,ScaleValidDay,UseLot,IndicadorProducao,IndicadorAT,IDNCM,WebDescription,Portion,IDCFOP,ServiceMap,RequireOnSale,ReplLastChange,NoUpdateCatalogs)
      VALUES
      (@IDModel,@GroupID,@IDUnidade,@IDFabricante,@IDSize,@IDColor,@IDModelParent,@Model,@Description,@VendorCost,@FreightCost,@OtherCost,@MarkUp,@SellingPrice,@LastCost,@DateLastCost,@DateLastSellingPrice,@LastMovDate,@Peso,@Avaiable,@SuggRetail,@PVD,@DP,@ES,@PP,@InicioPontoPedido,@ClasseABC,@AutomaticRequest,@TR,@ModelType,@CustomSalePrice,@CustomCostPrice,@CustomSpecialPrice,@CustomPromotion,@AvgCost,@System,@Hidden,@Desativado,@LargeImage,@FloatPercent,@LargeImage2,@ReplacementCost,@NotVerifyQty,@PromotionPrice,@DiscountPerc,@IDModelGroup,@IDModelSubGroup,@VD,@VP,@SX,@SX2,@Verify,@AvgCostTotal,@SendToTrash,@IDUserLastSellingPrice,@AskUserOnSale,@TotQtyOnHand,@TotQtyOnRepair,@TotQtyOnPreSale,@TotQtyOnPrePurchase,@TotQtyOnOrder,@CaseQty,@UpdatePrice,@UseScale,@ScaleValidDay,@UseLot,@IndicadorProducao,@IndicadorAT,@IDNCM,@WebDescription,@Portion,@IDCFOP,@ServiceMap,@RequireOnSale,@ReplLastChange,@NoUpdateCatalogs)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE Model SET
    			-- No key fields
    			GroupID = @GroupID,
IDUnidade = @IDUnidade,
IDFabricante = @IDFabricante,
IDSize = @IDSize,
IDColor = @IDColor,
IDModelParent = @IDModelParent,
Model = @Model,
Description = @Description,
VendorCost = @VendorCost,
FreightCost = @FreightCost,
OtherCost = @OtherCost,
MarkUp = @MarkUp,
SellingPrice = @SellingPrice,
LastCost = @LastCost,
DateLastCost = @DateLastCost,
DateLastSellingPrice = @DateLastSellingPrice,
LastMovDate = @LastMovDate,
Peso = @Peso,
Avaiable = @Avaiable,
SuggRetail = @SuggRetail,
PVD = @PVD,
DP = @DP,
ES = @ES,
PP = @PP,
InicioPontoPedido = @InicioPontoPedido,
ClasseABC = @ClasseABC,
AutomaticRequest = @AutomaticRequest,
TR = @TR,
ModelType = @ModelType,
CustomSalePrice = @CustomSalePrice,
CustomCostPrice = @CustomCostPrice,
CustomSpecialPrice = @CustomSpecialPrice,
CustomPromotion = @CustomPromotion,
AvgCost = @AvgCost,
System = @System,
Hidden = @Hidden,
Desativado = @Desativado,
LargeImage = @LargeImage,
FloatPercent = @FloatPercent,
LargeImage2 = @LargeImage2,
ReplacementCost = @ReplacementCost,
NotVerifyQty = @NotVerifyQty,
PromotionPrice = @PromotionPrice,
DiscountPerc = @DiscountPerc,
IDModelGroup = @IDModelGroup,
IDModelSubGroup = @IDModelSubGroup,
VD = @VD,
VP = @VP,
SX = @SX,
SX2 = @SX2,
Verify = @Verify,
AvgCostTotal = @AvgCostTotal,
SendToTrash = @SendToTrash,
IDUserLastSellingPrice = @IDUserLastSellingPrice,
AskUserOnSale = @AskUserOnSale,
TotQtyOnHand = @TotQtyOnHand,
TotQtyOnRepair = @TotQtyOnRepair,
TotQtyOnPreSale = @TotQtyOnPreSale,
TotQtyOnPrePurchase = @TotQtyOnPrePurchase,
TotQtyOnOrder = @TotQtyOnOrder,
CaseQty = @CaseQty,
UpdatePrice = @UpdatePrice,
UseScale = @UseScale,
ScaleValidDay = @ScaleValidDay,
UseLot = @UseLot,
IndicadorProducao = @IndicadorProducao,
IndicadorAT = @IndicadorAT,
IDNCM = @IDNCM,
WebDescription = @WebDescription,
Portion = @Portion,
IDCFOP = @IDCFOP,
ServiceMap = @ServiceMap,
RequireOnSale = @RequireOnSale,
ReplLastChange = @ReplLastChange,
NoUpdateCatalogs = @NoUpdateCatalogs
		    WHERE
         -- Key Fields
    			IDModel = @IDModel
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_PreInventoryMov]    Script Date: 04/27/2016 20:21:43 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[sp_rpl_insupd_PreInventoryMov]
(
	@IDPreInventoryMov int,@InventMovTypeID int,@StoreID int,@ModelID int,@IDPessoa int,@UserID int,@IDCotacao int,@IDPreInventoryMovParent int,@BarCodeID char(20),@DocumentID int,@MovDate smalldatetime,@CostPrice money,@SalePrice money,@Discount money,@DateEstimatedMov smalldatetime,@DateRealMov smalldatetime,@Marked bit,@ExchangeInvoice int,@SuggRetail money,@IDParentPack int,@IDModelService int,@IDPreInvMovExchange int,@DesiredMarkup money,@CaseCost money,@Promo bit,@IDDepartment int,@IDTaxCategory int,@Qty decimal,@QtyRealMov decimal,@QtyExceeded decimal,@QtyExchanged decimal,@CaseQty decimal,@SequencyNum int,@TotParcial varchar(10),@DiscountPromo money,@UnitDiscount money,@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	PreInventoryMov
      (IDPreInventoryMov,InventMovTypeID,StoreID,ModelID,IDPessoa,UserID,IDCotacao,IDPreInventoryMovParent,BarCodeID,DocumentID,MovDate,CostPrice,SalePrice,Discount,DateEstimatedMov,DateRealMov,Marked,ExchangeInvoice,SuggRetail,IDParentPack,IDModelService,IDPreInvMovExchange,DesiredMarkup,CaseCost,Promo,IDDepartment,IDTaxCategory,Qty,QtyRealMov,QtyExceeded,QtyExchanged,CaseQty,SequencyNum,TotParcial,DiscountPromo,UnitDiscount,ReplLastChange)
      VALUES
      (@IDPreInventoryMov,@InventMovTypeID,@StoreID,@ModelID,@IDPessoa,@UserID,@IDCotacao,@IDPreInventoryMovParent,@BarCodeID,@DocumentID,@MovDate,@CostPrice,@SalePrice,@Discount,@DateEstimatedMov,@DateRealMov,@Marked,@ExchangeInvoice,@SuggRetail,@IDParentPack,@IDModelService,@IDPreInvMovExchange,@DesiredMarkup,@CaseCost,@Promo,@IDDepartment,@IDTaxCategory,@Qty,@QtyRealMov,@QtyExceeded,@QtyExchanged,@CaseQty,@SequencyNum,@TotParcial,@DiscountPromo,@UnitDiscount,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE PreInventoryMov SET
    			-- No key fields
    			InventMovTypeID = @InventMovTypeID,
StoreID = @StoreID,
ModelID = @ModelID,
IDPessoa = @IDPessoa,
UserID = @UserID,
IDCotacao = @IDCotacao,
IDPreInventoryMovParent = @IDPreInventoryMovParent,
BarCodeID = @BarCodeID,
DocumentID = @DocumentID,
MovDate = @MovDate,
CostPrice = @CostPrice,
SalePrice = @SalePrice,
Discount = @Discount,
DateEstimatedMov = @DateEstimatedMov,
DateRealMov = @DateRealMov,
Marked = @Marked,
ExchangeInvoice = @ExchangeInvoice,
SuggRetail = @SuggRetail,
IDParentPack = @IDParentPack,
IDModelService = @IDModelService,
IDPreInvMovExchange = @IDPreInvMovExchange,
DesiredMarkup = @DesiredMarkup,
CaseCost = @CaseCost,
Promo = @Promo,
IDDepartment = @IDDepartment,
IDTaxCategory = @IDTaxCategory,
Qty = @Qty,
QtyRealMov = @QtyRealMov,
QtyExceeded = @QtyExceeded,
QtyExchanged = @QtyExchanged,
CaseQty = @CaseQty,
SequencyNum = @SequencyNum,
TotParcial = @TotParcial,
DiscountPromo = @DiscountPromo,
UnitDiscount = @UnitDiscount,
ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			IDPreInventoryMov = @IDPreInventoryMov
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO

/****** Object:  StoredProcedure [dbo].[sp_rpl_insupd_SerialMov]    Script Date: 04/27/2016 20:23:40 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[sp_rpl_insupd_SerialMov]
(
	@InventoryMovID int,@SerialNumber char(30),@IdentificationNumber varchar(30),@processor char(1),@ReplLastChange datetime
) AS
BEGIN TRY
      INSERT INTO	SerialMov
      (InventoryMovID,SerialNumber,IdentificationNumber,processor,ReplLastChange)
      VALUES
      (@InventoryMovID,@SerialNumber,@IdentificationNumber,@processor,@ReplLastChange)
END TRY
BEGIN CATCH
    DECLARE @_rpl_pk_violation_err_num int,
            @_rpl_number int,
            @_rpl_message nvarchar(2048),
            @_rpl_severity tinyint,
            @_rpl_state tinyint
    SELECT @_rpl_pk_violation_err_num = 2627,
           @_rpl_number = error_number(),
           @_rpl_message = error_message(),
           @_rpl_severity = error_severity(),
           @_rpl_state = error_state()
    IF @_rpl_number = @_rpl_pk_violation_err_num
    		UPDATE SerialMov SET
    			-- No key fields
    			IdentificationNumber = @IdentificationNumber,
processor = @processor,
ReplLastChange = @ReplLastChange
		    WHERE
         -- Key Fields
    			InventoryMovID = @InventoryMovID AND
SerialNumber = @SerialNumber
    			-- Replication Field
    			AND ReplLastChange < @ReplLastChange
        ELSE
            -- Re-raise error since it isn't one we can handle here.
            RAISERROR(@_rpl_number, @_rpl_message, @_rpl_severity, @_rpl_state)
    END CATCH

GO

/****** Object:  StoredProcedure [dbo].[sp_Sis_GetNextCode]    Script Date: 04/27/2016 20:26:16 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


ALTER PROCEDURE [dbo].[sp_Sis_GetNextCode]
		(
		@Tabela		varchar(100),
		@NovoCodigo	int = 0 output	
		)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Incrementa a tabela de controle de Codigos e retorna o valor 

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Campo nao existe


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	04 November 	2003	Rodrigo Costa		Criação;
	22 Octuber 	2004	Rodrigo Costa		Incliuir Tabelas automaticas
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */


DECLARE @ErrorLevel		int
SET @ErrorLevel = 0

if (@Tabela = 'InventoryMov.IDInventoryMov') BEGIN
	EXEC @NovoCodigo = sp_GetNextKey_IDInventoryMov
END ELSE IF (@Tabela = 'PreInventoryMov.IDPreInventoryMov') BEGIN
	EXEC @NovoCodigo = sp_GetNextKey_IDPreInventoryMov
END ELSE IF (@Tabela = 'Invoice.IDPreSale') BEGIN
	EXEC @NovoCodigo = sp_GetNextKey_IDPreSale
END ELSE IF (@Tabela = 'SaleItemCommission.IDSaleItemCommission') BEGIN
	EXEC @NovoCodigo = sp_GetNextKey_IDSaleItemCommission
END ELSE IF (@Tabela = 'Fin_Lancamento.IDLancamento') BEGIN
	EXEC @NovoCodigo = sp_GetNextKey_IDLancamento
END ELSE IF (@Tabela = 'InvoiceGen.IDInvoice') BEGIN
	EXEC @NovoCodigo = sp_GetNextKey_IDInvoice
END
ELSE
BEGIN
	UPDATE	
		CI
	SET	
		UltimoCodigo = UltimoCodigo + 1,
		@NovoCodigo = UltimoCodigo + 1
	FROM
		Sis_CodigoIncremental CI
	
	WHERE  	
		Tabela = @Tabela
	
	IF (@@ROWCOUNT = 0)
	BEGIN
		DECLARE @LastKey int
		SET @LastKey = (SELECT UltimoCodigo FROM Sis_CodigoIncremental WHERE Tabela = 'LastKey')
		
		SET @NovoCodigo = IsNull(@LastKey,1)
		INSERT Sis_CodigoIncremental (Tabela,  UltimoCodigo) 
		VALUES (@Tabela, @NovoCodigo)
		
		SET @ErrorLevel = -101
		GOTO ERRO
	END
END

OK:
	RETURN 0
ERRO:
	RETURN @ErrorLevel

GO

/****** Object:  StoredProcedure [dbo].[sp_UpdateSystemQty]    Script Date: 04/27/2016 20:27:10 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER  PROCEDURE [dbo].[sp_UpdateSystemQty]
AS

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--  Recalculo dos saldos do sistema.
--  Não faz parte da operação normal do sistema.
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--     CLEAR DOS SALDOS
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

UPDATE
    I
SET
    I.QtyOnHand = 0,
    I.QtyOnOrder = 0,
    I.QtyOnPreSale = 0,
    I.QtyOnPrePurchase =0 ,
    I.QtyOnRepair = 0
FROM
    Inventory I (NOLOCK)

UPDATE
    IMT
SET
    IMT.TotQty = 0,
    IMT.TotCost = 0,
    IMT.TotSale = 0
FROM
    InventoryMovTotal IMT (NOLOCK)


UPDATE
    M
SET
    M.TotQtyOnHand = 0,
    M.TotQtyOnOrder = 0,
    M.TotQtyOnPreSale = 0,
    M.TotQtyOnPrePurchase =0,
    M.TotQtyOnRepair = 0
FROM
    Model M



---###################################################################################################
-- ###### PreInventoryMov atualiza as Qty
---###################################################################################################

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--     INVENTORY
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
UPDATE
    I
SET
    I.QtyOnHand         = IsNull(I.QtyOnHand, 0) + Total.OnHand,
    I.QtyOnOrder        = IsNull(I.QtyOnOrder, 0) + Total.OnOrder,
    I.QtyOnRepair       = IsNull(I.QtyOnRepair, 0) + Total.OnRepair,
    I.QtyOnPrePurchase  = IsNull(I.QtyOnPrePurchase, 0) + Total.OnPrePurchase,
    I.QtyOnPreSale      = IsNull(I.QtyOnPreSale, 0) + Total.OnPreSale

FROM
    (
    SELECT
        ModelID,
        StoreID,
        SUM( IsNull(PIM.Qty * (2*IMT.UpdatePreOnHand-1), 0) ) as OnHand,
        SUM( IsNull((PIM.Qty - IsNull(PIM.QtyRealMov,0)) * (2*IMT.UpdatePreOnOrder-1), 0) ) as OnOrder,
        SUM( IsNull(PIM.Qty * (2*IMT.UpdatePreOnRepair-1), 0) ) as OnRepair,
        SUM( IsNull(PIM.Qty * (2*IMT.UpdatePreOnPrePurchase-1), 0) ) as OnPrePurchase,
        SUM( IsNull(PIM.Qty * (2*IMT.UpdatePreOnPreSale-1), 0) ) as OnPreSale
    FROM
        PreInventoryMov PIM (NOLOCK)
        JOIN InventoryMovType IMT (NOLOCK) ON (PIM.InventMovTypeID = IMT.IDInventMovType)
        JOIN Model M on (PIM.ModelID = M.IDModel)
    WHERE
        --PIM.InventMovTypeID = 1       AND
        PIM.ModelID IS NOT NULL     AND
        PIM.StoreID IS NOT NULL     AND
        M.Desativado = 0
    GROUP BY
        ModelID,
        StoreID
    ) Total
    JOIN Inventory I ON (Total.ModelID = I.ModelID AND Total.StoreID = I.StoreID)


----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--     INVENTORY MASTER
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

UPDATE
    I
SET
    I.QtyOnHand         = IsNull(I.QtyOnHand, 0) + Total.OnHand,
    I.QtyOnOrder        = IsNull(I.QtyOnOrder, 0) + Total.OnOrder,
    I.QtyOnRepair       = IsNull(I.QtyOnRepair, 0) + Total.OnRepair,
    I.QtyOnPrePurchase  = IsNull(I.QtyOnPrePurchase, 0) + Total.OnPrePurchase,
    I.QtyOnPreSale      = IsNull(I.QtyOnPreSale, 0) + Total.OnPreSale
FROM
    (
    SELECT
        M.IDModelParent as ModelID,
        PIM.StoreID,

        SUM( IsNull(PIM.Qty * (2*IMT.UpdatePreOnHand-1), 0) ) as OnHand,
        SUM( IsNull((PIM.Qty - IsNull(PIM.QtyRealMov,0)) * (2*IMT.UpdatePreOnOrder-1), 0) ) as OnOrder,
        SUM( IsNull(PIM.Qty * (2*IMT.UpdatePreOnRepair-1), 0) ) as OnRepair,
        SUM( IsNull(PIM.Qty * (2*IMT.UpdatePreOnPrePurchase-1), 0) ) as OnPrePurchase,
        SUM( IsNull(PIM.Qty * (2*IMT.UpdatePreOnPreSale-1), 0) ) as OnPreSale
    FROM
        PreInventoryMov PIM (NOLOCK)
        JOIN Model M (NOLOCK) ON (PIM.ModelID = M.IDModel)
        JOIN InventoryMovType IMT (NOLOCK) ON (PIM.InventMovTypeID = IMT.IDInventMovType)
    WHERE
        M.IDModelParent IS NOT NULL
        AND M.Desativado = 0
    GROUP BY
        M.IDModelParent,
        PIM.StoreID
    ) Total
    JOIN Inventory I ON (Total.ModelID = I.ModelID AND Total.StoreID = I.StoreID)



----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--  MODEL TOTAL
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------


UPDATE
    M
SET
    M.TotQtyOnHand      = IsNull(M.TotQtyOnHand, 0) + Total.OnHand,
    M.TotQtyOnOrder     = IsNull(M.TotQtyOnOrder, 0) + Total.OnOrder,
    M.TotQtyOnRepair    = IsNull(M.TotQtyOnRepair, 0) + Total.OnRepair,
    M.TotQtyOnPrePurchase   = IsNull(M.TotQtyOnPrePurchase, 0) + Total.OnPrePurchase,
    M.TotQtyOnPreSale   = IsNull(M.TotQtyOnPreSale, 0) + Total.OnPreSale
FROM
    (
    SELECT
        ModelID,
        SUM( IsNull(PIM.Qty * (2*IMT.UpdatePreOnHand-1), 0) ) as OnHand,
        SUM( IsNull((PIM.Qty - IsNull(PIM.QtyRealMov,0)) * (2*IMT.UpdatePreOnOrder-1), 0) ) as OnOrder,
        SUM( IsNull(PIM.Qty * (2*IMT.UpdatePreOnRepair-1), 0) ) as OnRepair,
        SUM( IsNull(PIM.Qty * (2*IMT.UpdatePreOnPrePurchase-1), 0) ) as OnPrePurchase,
        SUM( IsNull(PIM.Qty * (2*IMT.UpdatePreOnPreSale-1), 0) ) as OnPreSale
    FROM
        PreInventoryMov PIM (NOLOCK)
        JOIN InventoryMovType IMT (NOLOCK) ON (PIM.InventMovTypeID = IMT.IDInventMovType)
        JOIN Model M (NOLOCK) ON (PIM.ModelID = M.IDModel)
    WHERE
        M.Desativado = 0
    GROUP BY
        ModelID
    ) Total
    JOIN Model M ON (Total.ModelID = M.IDModel)

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--  MODEL MASTER TOTAL
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

UPDATE  M
SET
    M.TotQtyOnHand      = IsNull(M.TotQtyOnHand, 0) + Total.OnHand,
    M.TotQtyOnOrder     = IsNull(M.TotQtyOnOrder, 0) + Total.OnOrder,
    M.TotQtyOnRepair        = IsNull(M.TotQtyOnRepair, 0) + Total.OnRepair,
    M.TotQtyOnPrePurchase       = IsNull(M.TotQtyOnPrePurchase, 0) + Total.OnPrePurchase,
    M.TotQtyOnPreSale       = IsNull(M.TotQtyOnPreSale, 0) + Total.OnPreSale
FROM
    (
    SELECT
        IDModelParent,
        SUM( IsNull(PIM.Qty * (2*IMT.UpdatePreOnHand-1), 0) ) as OnHand,
        SUM( IsNull((PIM.Qty - IsNull(PIM.QtyRealMov,0)) * (2*IMT.UpdatePreOnOrder-1), 0) ) as OnOrder,
        SUM( IsNull(PIM.Qty * (2*IMT.UpdatePreOnRepair-1), 0) ) as OnRepair,
        SUM( IsNull(PIM.Qty * (2*IMT.UpdatePreOnPrePurchase-1), 0) ) as OnPrePurchase,
        SUM( IsNull(PIM.Qty * (2*IMT.UpdatePreOnPreSale-1), 0) ) as OnPreSale
    FROM
        PreInventoryMov PIM (NOLOCK)
        JOIN Model M (NOLOCK) ON (PIM.ModelID = M.IDModel)
        JOIN InventoryMovType IMT (NOLOCK) ON (PIM.InventMovTypeID = IMT.IDInventMovType)
    WHERE
        M.IDModelParent IS NOT NULL AND
        M.Desativado = 0
    GROUP BY
        IDModelParent
    ) Total
    JOIN Model M ON (Total.IDModelParent = M.IDModel)


---###################################################################################################
-- ###### Inventory atualiza as Qty
---###################################################################################################


----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--     INVENTORY
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

UPDATE
    I
SET
    I.QtyOnHand         = IsNull(I.QtyOnHand, 0) + Total.OnHand,
    I.QtyOnOrder        = IsNull(I.QtyOnOrder, 0) + Total.OnOrder,
    I.QtyOnRepair       = IsNull(I.QtyOnRepair, 0) + Total.OnRepair,
    I.QtyOnPrePurchase  = IsNull(I.QtyOnPrePurchase, 0) + Total.OnPrePurchase,
    I.QtyOnPreSale      = IsNull(I.QtyOnPreSale, 0) + Total.OnPreSale
FROM
    (
    SELECT
        ModelID,
        StoreID,
        SUM( IsNull(IM.Qty * (2*IMT.UpdateOnHand-1), 0) ) as OnHand,
        SUM( IsNull(IM.Qty * (2*IMT.UpdateOnOrder-1), 0) ) as OnOrder,
        SUM( IsNull(IM.Qty * (2*IMT.UpdateOnRepair-1), 0) ) as OnRepair,
        SUM( IsNull(IM.Qty * (2*IMT.UpdateOnPrePurchase-1), 0) ) + IsNull(PPI.Qty,0) as OnPrePurchase,
        SUM( IsNull(IM.Qty * (2*IMT.UpdateOnPreSale-1), 0) ) as OnPreSale
    FROM
        InventoryMov IM (NOLOCK)
        JOIN InventoryMovType IMT (NOLOCK) ON (IM.InventMovTypeID = IMT.IDInventMovType)
        JOIN Model M on (IM.ModelID = M.IDModel)
        LEFT JOIN (
                SELECT
                    PPI.IDModel,
                    PU.IDStore,
                    SUM(Qty - IsNull(QtyRet,0)) as Qty
                FROM
                    Pur_PurchaseItem PPI (NOLOCK)
                    JOIN Pur_Purchase PU (NOLOCK) ON (PU.IDPurchase = PPI.IDPurchase)
                WHERE
                    DateFinalReceiving IS NULL
                GROUP BY
                    PPI.IDModel,
                    PU.IDStore
            ) PPI ON (PPI.IDModel = IM.ModelID AND PPI.IDStore = IM.StoreID)
        WHERE M.Desativado = 0
    GROUP BY
        ModelID,
        StoreID,
        PPI.Qty
    ) Total
    JOIN Inventory I ON (Total.ModelID = I.ModelID AND Total.StoreID = I.StoreID)


----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--     INVENTORY MASTER
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

UPDATE
    I
SET
    I.QtyOnHand         = IsNull(I.QtyOnHand, 0) + Total.OnHand,
    I.QtyOnOrder        = IsNull(I.QtyOnOrder, 0) + Total.OnOrder,
    I.QtyOnRepair       = IsNull(I.QtyOnRepair, 0) + Total.OnRepair,
    I.QtyOnPrePurchase  = IsNull(I.QtyOnPrePurchase, 0) + Total.OnPrePurchase,
    I.QtyOnPreSale      = IsNull(I.QtyOnPreSale, 0) + Total.OnPreSale
FROM
    (
    SELECT
        M.IDModelParent as ModelID,
        StoreID,
        SUM( IsNull(IM.Qty * (2*IMT.UpdateOnHand-1), 0) ) as OnHand,
        SUM( IsNull(IM.Qty * (2*IMT.UpdateOnOrder-1), 0) ) as OnOrder,
        SUM( IsNull(IM.Qty * (2*IMT.UpdateOnRepair-1), 0) ) as OnRepair,
        (SUM( IsNull(IM.Qty * (2*IMT.UpdateOnPrePurchase-1), 0) ) + IsNull(PPI.Qty,0)) as OnPrePurchase,
        SUM( IsNull(IM.Qty * (2*IMT.UpdateOnPreSale-1), 0) ) as OnPreSale
    FROM
        InventoryMov IM (NOLOCK)
        JOIN Model M (NOLOCK) ON (IM.ModelID = M.IDModel)
        JOIN InventoryMovType IMT (NOLOCK) ON (IM.InventMovTypeID = IMT.IDInventMovType)
        LEFT JOIN (
                SELECT
                    PPI.IDModel,
                    PU.IDStore,
                    SUM(Qty - IsNull(QtyRet,0)) as Qty
                FROM
                    Pur_PurchaseItem PPI (NOLOCK)
                    JOIN Pur_Purchase PU (NOLOCK) ON (PU.IDPurchase = PPI.IDPurchase)
                WHERE
                    DateFinalReceiving IS NULL
                GROUP BY
                    PPI.IDModel,
                    PU.IDStore
            ) PPI ON (PPI.IDModel = IM.ModelID AND PPI.IDStore = IM.StoreID)
    WHERE
        M.IDModelParent IS NOT NULL
        AND M.Desativado = 0
    GROUP BY
        M.IDModelParent,
        StoreID,
        PPI.Qty
    ) Total
    JOIN Inventory I ON (Total.ModelID = I.ModelID AND Total.StoreID = I.StoreID)



----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--  MODEL TOTAL
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------


UPDATE
    M
SET
    M.TotQtyOnHand      = IsNull(M.TotQtyOnHand, 0) + Total.OnHand,
    M.TotQtyOnOrder     = IsNull(M.TotQtyOnOrder, 0) + Total.OnOrder,
    M.TotQtyOnRepair    = IsNull(M.TotQtyOnRepair, 0) + Total.OnRepair,
    M.TotQtyOnPrePurchase   = IsNull(M.TotQtyOnPrePurchase, 0) + Total.OnPrePurchase,
    M.TotQtyOnPreSale   = IsNull(M.TotQtyOnPreSale, 0) + Total.OnPreSale
FROM
    (
    SELECT
        ModelID,
        SUM( IsNull(IM.Qty * (2*IMT.UpdateOnHand-1), 0) ) as OnHand,
        SUM( IsNull(IM.Qty * (2*IMT.UpdateOnOrder-1), 0) ) as OnOrder,
        SUM( IsNull(IM.Qty * (2*IMT.UpdateOnRepair-1), 0) ) as OnRepair,
        SUM( IsNull(IM.Qty * (2*IMT.UpdateOnPrePurchase-1), 0) ) + IsNull(PPI.Qty, 0) as OnPrePurchase,
        SUM( IsNull(IM.Qty * (2*IMT.UpdateOnPreSale-1), 0) ) as OnPreSale
    FROM
        InventoryMov IM (NOLOCK)
        JOIN InventoryMovType IMT (NOLOCK)  ON (IM.InventMovTypeID = IMT.IDInventMovType)
        JOIN Model M on (IM.ModelID = M.IDModel)
        LEFT JOIN (
                SELECT
                    PPI.IDModel,
                    SUM(Qty - IsNull(QtyRet,0)) as Qty
                FROM
                    Pur_PurchaseItem PPI (NOLOCK)
                    JOIN Pur_Purchase PU (NOLOCK) ON (PU.IDPurchase = PPI.IDPurchase)
                WHERE
                    DateFinalReceiving IS NULL
                GROUP BY
                    PPI.IDModel,
                    PU.IDStore
            ) PPI ON (PPI.IDModel = IM.ModelID)
        WHERE M.Desativado = 0
    GROUP BY
        ModelID,
        PPI.Qty
    ) Total
    JOIN Model M ON (Total.ModelID = M.IDModel)



----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--  MODEL MASTER TOTAL
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
UPDATE
    M
SET
    M.TotQtyOnHand      = IsNull(M.TotQtyOnHand, 0) + Total.OnHand,
    M.TotQtyOnOrder     = IsNull(M.TotQtyOnOrder, 0) + Total.OnOrder,
    M.TotQtyOnRepair    = IsNull(M.TotQtyOnRepair, 0) + Total.OnRepair,
    M.TotQtyOnPrePurchase   = IsNull(M.TotQtyOnPrePurchase, 0) + Total.OnPrePurchase,
    M.TotQtyOnPreSale   = IsNull(M.TotQtyOnPreSale, 0) + Total.OnPreSale
FROM
    (
    SELECT
        IDModelParent,
        SUM( IsNull(IM.Qty * (2*IMT.UpdateOnHand-1), 0) ) as OnHand,
        SUM( IsNull(IM.Qty * (2*IMT.UpdateOnOrder-1), 0) ) as OnOrder,
        SUM( IsNull(IM.Qty * (2*IMT.UpdateOnRepair-1), 0) ) as OnRepair,
        SUM( IsNull(IM.Qty * (2*IMT.UpdateOnPrePurchase-1), 0) ) as OnPrePurchase,
        SUM( IsNull(IM.Qty * (2*IMT.UpdateOnPreSale-1), 0) ) as OnPreSale
    FROM
        InventoryMov IM (NOLOCK)
        JOIN Model M (NOLOCK) ON (IM.ModelID = M.IDModel)
        JOIN InventoryMovType IMT (NOLOCK) ON (IM.InventMovTypeID = IMT.IDInventMovType)

    WHERE
        M.IDModelParent IS NOT NULL AND
        M.Desativado = 0

    GROUP BY
        IDModelParent
    ) Total
    JOIN Model M ON (Total.IDModelParent = M.IDModel)

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--  MODEL: Atualiza o InventoryMovTotals
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
UPDATE
    IMT
SET
    IMT.TotQty = IsNull(IMT.TotQty, 0) + Total.Qty,
    IMT.TotSale = IsNull(IMT.TotSale, 0) + Total.Sale,
    IMT.TotCost = IsNull(IMT.TotCost, 0) + Total.Cost
FROM
    (
    SELECT
        IM.StoreID,
        IM.ModelID,
        IM.InventMovTypeID,
        DatePart(yy, IM.MovDate) as [Year],
        DatePart(mm, IM.MovDate) as [Month],
        SUM( IsNull( IM.Qty, 0 ) ) as Qty,
        SUM( IsNull( IM.Qty * IM.SalePrice, 0 )  - IsNull(IM.Discount , 0) ) as Sale,
        SUM( IsNull( IM.Qty * IM.CostPrice, 0) ) as Cost
    FROM
        InventoryMov IM (NOLOCK)
    GROUP BY
        IM.StoreID,
        IM.ModelID,
        IM.InventMovTypeID,
        DatePart(yy, IM.MovDate),
        DatePart(mm, IM.MovDate)
    ) as Total
    JOIN InventoryMovTotal IMT  (NOLOCK)
        ON (    Total.StoreID = IMT.StoreID
            AND
            Total.ModelID = IMT.ModelID
            AND
            Total.InventMovTypeID = IMT.InventMovTypeID
            AND
            Total.[Year] = IMT.[Year]
            AND
            Total.[Month] = IMT.[Month] )

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--  MASTER: Atualiza o InventoryMovTotals
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
UPDATE
    IMT
SET
    IMT.TotQty = IsNull(IMT.TotQty, 0) + Total.Qty,
    IMT.TotSale = IsNull(IMT.TotSale, 0) + Total.Sale,
    IMT.TotCost = IsNull(IMT.TotCost, 0) + Total.Cost
FROM
    (
    SELECT
        IM.StoreID,
        M.IDModelParent as ModelID,
        IM.InventMovTypeID,
        DatePart(yy, IM.MovDate) as [Year],
        DatePart(mm, IM.MovDate) as [Month],
        SUM( IsNull( IM.Qty, 0 ) ) as Qty,
        SUM( IsNull( IM.Qty * IM.SalePrice, 0 )  - IsNull(IM.Discount , 0) ) as Sale,
        SUM( IsNull( IM.Qty * IM.CostPrice, 0) ) as Cost
    FROM
        InventoryMov IM (NOLOCK)
        JOIN Model M (NOLOCK) ON (IM.ModelID = M.IDModel)
    WHERE
        M.IDModelParent IS NOT NULL
    GROUP BY
        IM.StoreID,
        M.IDModelParent,
        IM.InventMovTypeID,
        DatePart(yy, IM.MovDate),
        DatePart(mm, IM.MovDate)
    ) as Total
    JOIN InventoryMovTotal IMT
        ON (    Total.StoreID = IMT.StoreID
            AND
            Total.ModelID = IMT.ModelID
            AND
            Total.InventMovTypeID = IMT.InventMovTypeID
            AND
            Total.[Year] = IMT.[Year]
            AND
            Total.[Month] = IMT.[Month] )

GO


