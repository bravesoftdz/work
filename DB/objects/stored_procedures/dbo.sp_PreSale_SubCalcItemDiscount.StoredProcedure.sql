SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE  PROCEDURE [dbo].[sp_PreSale_SubCalcItemDiscount]
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
