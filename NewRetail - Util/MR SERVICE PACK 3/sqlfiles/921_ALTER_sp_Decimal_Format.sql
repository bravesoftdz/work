if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_SubCalcTotal]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_SubCalcTotal]
GO

CREATE   PROCEDURE sp_PreSale_SubCalcTotal
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

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_SubCalcItemDiscount]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_SubCalcItemDiscount]
GO

CREATE  PROCEDURE sp_PreSale_SubCalcItemDiscount
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
			Invoice INV (NOLOCK) 
			JOIN
			PreInventoryMov PIM (NOLOCK) 
				ON (INV.IDPreSale = PIM.DocumentID)
			JOIN
			Model MO (NOLOCK) 
				ON (PIM.ModelID = MO.IDModel)
			JOIN
			TabGroup TG (NOLOCK) 
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
				Invoice INV (NOLOCK) 
				JOIN
				PreInventoryMov PIM (NOLOCK) 
					ON (INV.IDPreSale = PIM.DocumentID)
				JOIN
				Model MO (NOLOCK) 
					ON (PIM.ModelID = MO.IDModel)
				JOIN
				TabGroup TG (NOLOCK) 
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
			Invoice INV (NOLOCK) 
			JOIN
			InventoryMov IM (NOLOCK) 
				ON (INV.IDInvoice = IM.DocumentID)
			JOIN
			Model MO (NOLOCK) 
				ON (IM.ModelID = MO.IDModel)
			JOIN
			TabGroup TG (NOLOCK) 
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
				Invoice INV (NOLOCK) 
				JOIN
				InventoryMov IM (NOLOCK) 
					ON (INV.IDInvoice = IM.DocumentID)
				JOIN
				Model MO (NOLOCK) 
					ON (IM.ModelID = MO.IDModel)
				JOIN
				TabGroup TG (NOLOCK) 
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
	dbo.Invoice.ItemDiscount = Round(@TotalDiscount,4),
		--convert(money, convert(numeric(20, 0), @TotalDiscount * 100) / 100),

	dbo.Invoice.TaxIsemptItemDiscount = Round(@TotalDiscExemp,4)
		--convert(money, convert(numeric(20, 0), @TotalDiscExemp * 100) / 100)
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

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_SubCalcTax]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_SubCalcTax]
GO

CREATE    PROCEDURE sp_PreSale_SubCalcTax
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
	26 Fev	2007		Rodrigo Costa		Calcular imposto estabelecido no PreInvMov
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
	SELECT	ISNULL(
			SUM	(
				(Round(PIM.Qty * ISNULL(PIM.SalePrice, 0),4,1) - ISNULL(PIM.Discount, 0))  -- Subtotal da linha do inventario
			 	* (CASE WHEN (TC.SpecialDateStart <= @Date) AND (TC.SpecialDateEnd >= @Date) THEN (IsNull(TC.SpecialTax,0) + IsNull(TCI.Tax, 0)) ELSE (IsNull(TC.Tax,0) + IsNull(TCI.Tax,0)) END / 100.00)  -- Tax
				),0)
	FROM	
		Invoice INV (NOLOCK) 
		JOIN
		PreInventoryMov PIM (NOLOCK) ON (INV.IDPreSale = PIM.DocumentID)
		JOIN
		Model M (NOLOCK) ON (M.IDModel = PIM.ModelID)
		JOIN
		StoreToTabGroup STG (NOLOCK) ON (STG.IDGroup = M.GroupID AND STG.IDStore = I.IDStore)
		JOIN
		TaxCategory TC (NOLOCK) ON (STG.IDTaxCategory = TC.IDTaxCategory AND TC.IDTaxCategory = IsNull(PIM.IDTaxCategory, TC.IDTaxCategory))
		LEFT OUTER JOIN 
		TaxCategory TCI (NOLOCK) ON ( TCI.IDTaxCategory = STG.IDSaleTax )

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
	) + @TaxTotalExp, 4),
        		Tax =
	ROUND(
	(
	SELECT	ISNULL(
			SUM	(
				(Round(PIM.Qty * ISNULL(PIM.SalePrice, 0),4,1) - ISNULL(PIM.Discount, 0))  -- Subtotal da linha do inventario
			 	* (CASE WHEN (TC.SpecialDateStart <= @Date) AND (TC.SpecialDateEnd >= @Date) AND ( ISNULL((( ISNULL(PIM.SalePrice, 0) - ISNULL(PIM.Discount, 0)) / PIM.Qty), 0) < ISNULL(TC.MaxItemValue, 0))
					 THEN (IsNull(TC.SpecialTax,0) + IsNull(TCI.Tax, 0)) ELSE (IsNull(TC.Tax,0) + IsNull(TCI.Tax,0)) END / 100.00)  -- Tax
				),0)
	FROM	Invoice INV (NOLOCK) 
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
	) + @TaxTotal, 4)
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
