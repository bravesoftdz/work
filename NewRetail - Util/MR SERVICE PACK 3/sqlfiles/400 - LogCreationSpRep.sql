ALTER TABLE Sys_Module
	ADD MRLogo image NULL
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_Import_Estimated]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_Import_Estimated]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_quPreSaleItemSplited]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_quPreSaleItemSplited]
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
	-----------------------	-----------------------	-----------------------------------------------------------------
	19 Aug  2005		Rodrigo Costa		Criacao;
	09 Dec	2005		Rodrigo Costa		Inclusao da comissao
	24 Feb	2006		Maximiliano Muniz	Ordenação dos itens por código
	----------------------------------------------------------------------------------------------------------------- */

DECLARE @ErrorLevel		int
DECLARE @SysError		int
--Declaração de variáveis para o Cursor de PreInventoryMov
DECLARE @InventMovTypeID 	int 
DECLARE @StoreID		int
DECLARE @DocumentID 		int 
DECLARE @ModelID 		int 
DECLARE @MovDate 		smalldatetime 
DECLARE @Qty 			float
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
		ORDER BY
			EI.Code

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

CREATE  PROCEDURE sp_PreSale_quPreSaleItemSplited
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

	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	-----------------------	-----------------------	-----------------------------------------------------------------
	27 Oct	2004		Rodrigo Costa		Criacao;
	07 Dez	2004		Rodrigo Costa		Novo calculo das taxas
	01 Jul	2005		Rodrigo Costa		Exibir campo auto incremental do item servico
	01 Dez	2005		Leonardo Riego		Modificado para pegar o nome do Comissionado da função.
	24 Feb	2006		Maximiliano Muniz	Ordenação dos selects por IDInvMov
	----------------------------------------------------------------------------------------------------------------- */

DECLARE @ErrorLevel	int
DECLARE @SysError	int

SET @ErrorLevel = 0

-- Criação e carca da Tabela Temporária e inclusao dos Items
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
	SalesPerson		varchar(50)
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
	SalesPerson
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
	(SELECT dbo.SalesPersonPreInvMov(PIM.IDPreInventoryMov)) AS SalesPerson
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
	SalesPerson
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
	(SELECT dbo.SalesPersonPreInvMov(PIM.IDPreInventoryMov)) AS SalesPerson
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
	SalesPerson
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
	(SELECT dbo.SalesPersonInvMov(IM.IDInventoryMov)) AS SalesPerson
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
	SalesPerson
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
	(SELECT dbo.SalesPersonInvMov(IM.IDInventoryMov)) AS SalesPerson
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
	IM.AutoServiceNum
FROM
	#InventoryItems IM
	JOIN Model M ON ( IM.IDModel = M.IDModel )
	LEFT OUTER JOIN InvSize SZ ON (M.IDSize = SZ.IDSize)
	LEFT OUTER JOIN InvColor CL ON (M.IDColor = CL.IDColor)
	JOIN SystemUser SU ON ( SU.IDUser = IM.IDUser )
	JOIN TabGroup TG ON ( M.GroupID = TG.IDGroup )
	JOIN StoreToTabGroup STC ON ( STC.IDStore = IM.IDStore AND STC.IDGroup = TG.IDGroup )
	JOIN TaxCategory TC ON ( TC.IDTaxCategory = STC.IDTaxCategory )
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
