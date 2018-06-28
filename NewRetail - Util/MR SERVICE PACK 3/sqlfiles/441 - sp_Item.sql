if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_SubAddItem]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_SubAddItem]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_AddItem]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_AddItem]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_ChangeItem]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_ChangeItem]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_quPreSaleItem]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_quPreSaleItem]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_Pay]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_Pay]
GO

CREATE PROCEDURE sp_PreSale_SubAddItem
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
		@PreInventMovID		int Output
 		)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Insert on Inventory Movement
		- Inserir no Customer Credit
		- Inserir as quantidades para troca

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Insert on Inventory Movement
		-203  Erro em Inclusão de Models de PacketModel
		-204  Erro em Inserir no Customer Credit
		-205  Erro em Inserir no Customer Credit do PackModel
		-206  Erro em Inserir as quantidades para troca do PreInvMov
		-207  Erro em Inserir as quantidades para troca InvMov
		-208  Erro em Inserir na SaleItemCommission	
		-209  Erro em Inserir na SaleItemCommission referente ao item de Kit	


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	-----------------------	-----------------------	-----------------------------------------------------------------
	15 May	2000		Eduardo Costa		Criacao;
	26 Jun	2001		Davi Gouveia		Log de Return Values
	29 Oct	2003		Rodrigo Costa		Criado sp_Sis_GetNextCod;
	24 May	2004		André Bogado		Criado Cursor para KitModel 
	18 Aug	2004		Rodrigo Costa		Gravar error log
	01 Dec	2004		Rodrigo Costa		Gravar no Customer Credit
	01 Feb	2005		Rodrigo Costa		Inclusao do campo @IDPreInvMovExchange
	11 Apr	2005		Rodrigo Costa		Inclusao do campo DesiredMarkup no PreInvMov
	28 Nov	2005		Leonardo Riego		Gravar na SaleItemCommission
	12 Apr  2006		Leonardo Riego		Novo campo @IDDepartment
	----------------------------------------------------------------------------------------------------------------- */

DECLARE @ComissionID 	int
DECLARE @ErrorLevel		int
DECLARE @SysError		int
DECLARE @IDSaleItemCommission   int

--Declaração de variáveis para o Cursor de ModelChild
DECLARE @ModelIDChild  	int 
DECLARE @QtyChild  		float
DECLARE @PreInvMovIDPack	int

SET @ErrorLevel = 0

BEGIN TRAN

/*-------------------------------------------------------------*/
/*                  Insert on PreInventory Movement               */
/*-------------------------------------------------------------*/

EXEC sp_Sis_GetNextCode'PreInventoryMov.IDPreInventoryMov', @PreInventMovID OUTPUT
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
	IDPreInvMovExchange,
	IDPreInventoryMovParent,
	IDDepartment,
	Promo,
	DesiredMarkup
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
 		@Discount,
		IsNull(@CostPrice, (M.VendorCost+M.OtherCost+M.FreightCost)),
		@UserID,
		@IDPreInvMovExchange,
		@PreInvMovParentID,
		@IDDepartment,
		@Promo,
		TG.DesiredMarkup
	FROM
 		dbo.Model M
		JOIN TabGroup TG ON (TG.IDGroup = M.GroupID)
 	WHERE
		M.IDModel = @ModelID

SET @SysError = @@ERROR
IF @SysError <> 0 
BEGIN
	SET @ErrorLevel = -201
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

/*****************************************************************************************
	Inclusão das quantidades para troca
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

/*****************************************************************************************
	Inclusão dos Creditos para o modelo caso tenha
******************************************************************************************/
EXEC sp_PreSale_AddModelCredit
			@PreInventMovID,
			@IDCliente,
			@UserID,
			@StoreID,
			@MovDate


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
 		dbo.PackModel P
		JOIN dbo.Model M ON (P.IDModel= M.IDModel)
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
 		dbo.Model
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
	COMMIT TRAN
	RETURN 0
ERRO:
	PRINT CAST(@ErrorLevel AS VARCHAR)
	ROLLBACK TRAN

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PreSale_SubAddItem', @ErrorLevelStr

	RETURN @ErrorLevel
GO

CREATE PROCEDURE sp_PreSale_AddItem
		(
		@PreSaleID     			int,
		@IDCliente			int,
		@ModelID     			int,
		@StoreID     			int,
		@UserID      			int,
		@IDComission			int,
		@Qty         			float,
		@SalePrice      		money,
		@CostPrice			money,
		@Discount    			money,
		@MovDate     			smalldatetime,
		@ResetDiscount  		bit = 0,
		@Manager			bit = 0,
		@Date				DateTime,
		@IDPreInvMovExchange		int,
		@PreInvMovParentID		int,
		@IDDepartment			int,
		@Promo				bit = 0,
		@PreInventMovID  		int	Output
		)
AS

/* ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 	SUMARIO

		- Testa se o discount total ainda e valido
		- Inclui a movimentaçao

	TABELA DE ERROS PARA RETURN_VALUE

		 @Result  Ok
		-201      Erro em exec @Result = sp_PreSale_SubTestDiscount
		-202      Erro em exec sp_PreSale_SubResetDiscount
		-203      Erro em exec @Result = sp_PreSale_SubAddItem
		-204      Erro em exec sp_PreSale_SubCalcTotal


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	-----------------------	-----------------------	-----------------------------------------------------------------
	15 May	2000		Eduardo Costa		Criacao;
	26 Jun	2001		Davi Gouveia		Log de Return Values
	18 Aug	2004		Rodrigo Costa		Gravar error log
	01 Fev	2005		Rodrigo Costa		Novo campo @IDPreInvMovExchange
	12 Apr  2006		Leonardo Riego		Novo campo @IDDepartment 
	----------------------------------------------------------------------------------------------------------------- */
 
DECLARE @Result		int
DECLARE @Value		money
DECLARE @ErrorLevel	int 
DECLARE @SysError	int

SET @ErrorLevel = 0 

/*------------------------------------------------------------------------------*/
/*                Testa se o discount total ainda e valido                      */
/*------------------------------------------------------------------------------*/ 

SELECT @Value = IsNUll((@SalePrice * @Qty),0)

IF @Manager = 0 BEGIN
	EXEC @Result = sp_PreSale_SubTestDiscount 	@PreSaleID,
							@ModelID,
							@UserID,
							@Discount,
							@Value,
							'I',
							1

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		SET @ErrorLevel = -201
		GOTO ERRO
	END

	IF @ResetDiscount = 1 and @Result <> 0
	BEGIN
		EXEC sp_PreSale_SubResetDiscount	@PreSaleID
	END
	ELSE
	BEGIN
		IF @Result <> 0
		BEGIN
			RETURN @Result
		END
	END

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		SET @ErrorLevel = -202
		GOTO ERRO
	END
END

/*------------------------------------------------------------------------------*/
/*	        	         Inclui a movimentaçao                          */
/*------------------------------------------------------------------------------*/

BEGIN TRAN

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
					@PreInventMovID		Output

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
	IF @Result = 0
		COMMIT TRAN
	RETURN @Result
ERRO:
	ROLLBACK TRAN
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PreSale_AddItem', @ErrorLevelStr

	RETURN @ErrorLevel
GO

CREATE  PROCEDURE sp_PreSale_ChangeItem
		(
		@PreSaleID      		int,
		@ModelID     			int,
		@UserID      			int,
		@IDComission			int,
		@Qty         			float,
		@SalePrice      		money,
		@CostPrice      		money = Null,
		@Discount    			money,
		@MovDate     			smalldatetime,
		@Manager			bit 	= 0,
		@ResetDiscount			bit	= 0,
		@Date				DateTime,
		@PreInvMovParentID		int,
		@IDDepartment			int,
		@Promo				bit,
		@PreInventMovID			int	output 
		)
AS
 /* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Testa se o discount total ainda e valido
		- Efetivamente remove e inclui o inventory moviment
		- Passa os seriais do item antigo para o novo

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em exec @Result = sp_PreSale_SubTestDiscount
		-202  Erro em exec sp_PreSale_SubResetDiscount
		-203  Erro em exec @result = sp_PreSale_SubRemoveItem
		-204  Erro em exec @result = sp_PreSale_SubAddItem
		-205  Erro em Passa os seriais do item antigo para o novo
		-206  Erro em exec sp_PreSale_SubCalcTotal
		-207  Erro em atualizar quantidades trocadas


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
	26 June 2001		Davi Gouveia		Log de Return Values
	18 Aug 2004		Rodrigo Costa		Gravar error log
	01 Fev 2005		Rodrigo Costa		Inclusao do IDPreInvMovExchange e qtyExchanged
	12 Apr 2006		Leonardo Riego		Novo campo @IDDepartment
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

 DECLARE @Result  			int
DECLARE @Value				money
DECLARE @StoreID			int
DECLARE @IDCliente			int
DECLARE @IDOldUser			int
DECLARE @OldPreInventoryMovID 		int 
DECLARE @ErrorLevel			int
DECLARE @SysError			int
DECLARE @IDPreInvMovExchange		int
DECLARE @QtyExchanged			float

SET @ErrorLevel = 0


SET @OldPreInventoryMovID = @PreInventMovID

/*------------------------------------------------------------------------------*/
/*                Testa se o discount total ainda e valido                      */
/*------------------------------------------------------------------------------*/
 SELECT @Value = IsNull((@Qty * @SalePrice), 0)

if @Manager = 0
   begin 

	exec @Result = sp_PreSale_SubTestDiscount 	@PreSaleID,
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
 
	if @ResetDiscount = 1 and @Result <> 0
	   begin
		exec sp_PreSale_SubResetDiscount	@PreSaleID

		SET @SysError = @@ERROR
		IF @SysError <> 0 	
		BEGIN
			SET @ErrorLevel = -202
			GOTO ERRO
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

/*------------------------------------------------------------------------------*/
/*                            Descobre o Store                                  */
/*------------------------------------------------------------------------------*/

SELECT
	@StoreID = StoreID,
	@IDCliente = IDPessoa,
	@IDPreInvMovExchange = IDPreInvMovExchange,
	@QtyExchanged = QtyExchanged
FROM 
	PreInventoryMov
WHERE 
	PreInventoryMov.IDPreInventoryMov = @PreInventMovID

/*-------------------------------------------------------------*/
/*    Efetivamente remove e inclui o inventory moviment        */
/*-------------------------------------------------------------*/
begin tran

exec @result = sp_PreSale_SubRemoveItem	@PreInventMovID

SET @SysError = @@ERROR
IF @SysError <> 0 	
BEGIN
	SET @ErrorLevel = -203
	GOTO ERRO
END

exec @result = sp_PreSale_SubAddItem	@PreSaleID,
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
					@PreInventMovID 	output

SET @SysError = @@ERROR
IF @SysError <> 0 	
BEGIN
	SET @ErrorLevel = -204
	GOTO ERRO
END

/*-------------------------------------------------------------*/
/*    Atualiza as quantidades trocadas      */
/*-------------------------------------------------------------*/

UPDATE
	PreInventoryMov
SET
	QtyExchanged = @QtyExchanged
WHERE
	IDPreInventoryMov = @PreInventMovID


SET @SysError = @@ERROR
IF @SysError <> 0 	
BEGIN
	SET @ErrorLevel = -207
	GOTO ERRO
END

/*-------------------------------------------------------------*/
/*    Passa os seriais do item antigo para o novo      */
/*-------------------------------------------------------------*/
UPDATE
	PSM
SET
	PSM.PreInventoryMovID = @PreInventMovID
FROM
	PreSerialMov PSM
WHERE
	PSM.PreInventoryMovID = @OldPreInventoryMovID

SET @SysError = @@ERROR
IF @SysError <> 0 	
BEGIN
	SET @ErrorLevel = -205
	GOTO ERRO
END


if @Result <> 0 	rollback tran
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

OK:
	IF @Result = 0
		COMMIT TRAN
	RETURN @Result
ERRO:
	ROLLBACK TRAN
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PreSale_ChangeItem', @ErrorLevelStr

	RETURN @ErrorLevel
GO

CREATE   PROCEDURE sp_PreSale_quPreSaleItem
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
		-201  Erro no 1o select
		-202  Erro no 2o select


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
	15 Aug  2000		Rodrigo Costa		Feito o Join com a Tbl TaxCategory para pegar a tax do Item
	26 June 2001		Davi Gouveia		Log de Return Values
	26 May 2004		Rodrigo Costa		Not display Item Packs
	18 Aug 2004		Rodrigo Costa		Gravar error log
	21 Oct 2004		Rodrigo Costa		Criado PIM.InventMovTypeID IN (1,25) para mostrar itens cancelados
	07 Dez 2004		Rodrigo Costa		Novo calculo das taxas
	01 Dez 2005		Leonardo Riego		Modificado para pegar o nome do Comissionado da função.
	17 Apr 2006		Leonardo Riego		Novo campo IDDepartment.
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

DECLARE @ErrorLevel	int
DECLARE @SysError	int

SET @ErrorLevel = 0

if @IsPreSale = 1
begin
	SELECT
		ModelID ,
		M.Model,
		Description ,
		(SELECT dbo.SalesPersonPreInvMov(IDPreInventoryMov)) AS SalesPerson ,
		M.SuggRetail ,
		SU.IDUser ,
		0 as IDComission,
		Qty ,
		ExchangeInvoice,
		SalePrice ,
		CostPrice,
		Discount ,
		PIM.IDPreInventoryMov IDInventoryMov,
		TG.SerialNumber,
	 	 (CASE WHEN (TC.SpecialDateStart <=  @Date) AND (TC.SpecialDateEnd >= @Date) AND ( ISNULL((( ISNULL(PIM.SalePrice, 0) - ISNULL(PIM.Discount, 0)) / PIM.Qty), 0) < ISNULL(TC.MaxItemValue, 0))
			 THEN (IsNull(TC.SpecialTax,0) + IsNull(TCI.Tax, 0)) ELSE (IsNull(TC.Tax,0) + IsNull(TCI.Tax,0)) END) as Tax, -- Tax
		SZ.CodSize,
		SZ.SizeName,
		CL.CodColor,
		CL.Color,
		M.NotVerifyQty,
		PIM.IDDepartment
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
		AND
		PIM.InventMovTypeID IN (1,25) --Sale and Canceled
		AND
		PIM.IDParentPack Is Null

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
		ModelID ,
		M.Model,
		Description ,
		(SELECT dbo.SalesPersonInvMov(IM.IDInventoryMov)) AS SalesPerson ,
		M.SuggRetail ,
		SU.IDUser ,
		0 AS IDComission,
		Qty ,
		ExchangeInvoice,
		SalePrice ,
		CostPrice,
		Discount ,
		IM.IDInventoryMov IDInventoryMov,
		TG.SerialNumber,
	 	IM.SalesTax as Tax, -- Tax
		SZ.CodSize,
		SZ.SizeName,
		CL.CodColor,
		CL.Color,
		M.NotVerifyQty,
		IM.IDDepartment
	FROM
		InventoryMov IM
		JOIN Model M ON ( IM.ModelID = M.IDModel )
		LEFT OUTER JOIN InvSize SZ ON (M.IDSize = SZ.IDSize)
		LEFT OUTER JOIN InvColor CL ON (M.IDColor = CL.IDColor)
		JOIN SystemUser SU ON ( SU.IDUser = IM.IDUser )
		JOIN TabGroup TG ON ( M.GroupID = TG.IDGroup )
		JOIN StoreToTabGroup STC ON ( STC.IDStore = IM.StoreID AND STC.IDGroup = TG.IDGroup )
		JOIN TaxCategory TC ON ( TC.IDTaxCategory = STC.IDTaxCategory )
	WHERE
		IM.DocumentID  = @DocumentID
		AND
		IM.InventMovTypeID = 1
		AND
		IM.IDParentPack Is Null

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
			@IDInvoice 		int output
			)
AS


/* --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
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
	-209  Erro as inserir as linhas de ligação entre lancamento e quitacao
	-210  Erro ao atualizar o NumDocumento nas parcelas do Invoice
	-212  Erro ao Atualizar as comissões
	-213  Erro ao mover Model Pack de PreInvMov para InvMov
	-214  Erro ao Impostos
	-216  Erro ao Colocar PreInventMovParent para Null
	-217  Erro ao atualizar SaleItemCommission
	-218  Erro ao inserir em Sal_AccountCard
	-219  Erro ao Inserir em Repair

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
	07 Dez 2004		Rodrigo Costa		Novo calculo das taxas
	01 Fev 2005		Rodrigo Costa		Mover as QtyExchanged de Pre para Inv
	25 Fev 2005		Rodrigo Costa		Quando finalizar o Invoice nao pode atualizar o IDStore
	29 Mar 	2005		Rodrigo Costa		Atualiza o custo medio dos modelos; gravar o custo medio na venda
	11 Apr	2005		Rodrigo Costa		Inclusao do campo DesiredMarkup no PreInv e InventoryMov
	17 May	2005		Rodrigo Costa		Cursor para alterar PreInvMovParent
	01 July	2005		Rodrigo Costa		Gerar numero sequencial para Items de Servico
	28 Nov	2005		Leonardo Riego		Atualiza SaleItemCommission
	11 Jan	2006		Rodrigo Costa		Remover zerar o custo medio
	23 Mar	2006		Carlos Lima		Suporte ao Gift Card ( Chamada para a procedure que inclui em Sal_AccountCard )
	03 Apr	2006		Rodrigo Costa		Inserir em Repair

    --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

DECLARE @DataPagamento  	smalldatetime
DECLARE @ComissionPayed 	money
DECLARE @IDCentroCusto	int
DECLARE @ErrorLevel		int
DECLARE @SysError		int
DECLARE @InvoiceCode	varchar(20)
DECLARE @ServiceField	varchar(30)
--Declaração de variáveis para o Cursor de InventoryMov
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
declare @GiftValue		money
declare @IDDepartment		int

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
			PIM.IDPreInventoryMov,
			PIM.UserID,
			(CASE WHEN (TC.SpecialDateStart <= @Date) AND (TC.SpecialDateEnd >= @Date) AND ( ISNULL((( ISNULL(PIM.SalePrice, 0) - ISNULL(PIM.Discount, 0)) / PIM.Qty), 0) < ISNULL(TC.MaxItemValue, 0))
				 THEN TC.SpecialTax ELSE TC.Tax END / 100.00)  as Tax,-- Tax
			PIM.IDParentPack,
			PIM.QtyExchanged,
			PIM.IDPreInvMovExchange,
			M.AvgCost,
			TG.DesiredMarkup,
			TG.ServiceAutoNumber,
			TG.Service,
			TG.IDGroup,
			PIM.IDDepartment
	FROM		
			dbo.PreInventoryMov PIM
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
	@IDDepartment
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
		IDDepartment
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
		@IDDepartment
		)

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		CLOSE InventoryMov_Cursor
		DEALLOCATE InventoryMov_Cursor
		SET @ErrorLevel = -203
		GOTO ERRO
	END

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
		@IDDepartment
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
/*	     Insere a movimentação de crédito na tabela de AccountCard                	*/
/*--------------------------------------------------------------------------------------------------------*/

EXEC sp_PreSale_ItemRepair @PreSaleID
SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -219
	GOTO ERRO
END


/*--------------------------------------------------------------------------------------------------------*/
/*	     Insere a movimentação de crédito na tabela de AccountCard                	*/
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

--Inicialização de PreInventoryMov_Cursor
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

--Declaração do Cursor de PreInventoryMov
DECLARE PreInventoryMovDelParent_Cursor CURSOR FOR

	SELECT
		IDPreInventoryMov
	FROM
		PreInventoryMov
	WHERE
		DocumentID = @PreSaleID

OPEN PreInventoryMovDelParent_Cursor

--Inicialização de PreInventoryMov_Cursor
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
--Destruição do cursor
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
