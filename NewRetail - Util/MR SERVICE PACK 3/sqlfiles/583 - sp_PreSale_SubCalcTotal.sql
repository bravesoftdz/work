IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[sp_PreSale_SubCalcTotal]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[sp_PreSale_SubCalcTotal]
GO

CREATE PROCEDURE sp_PreSale_SubCalcTotal
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
	-----------------------	-----------------------	-----------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
	26 June 2001		Davi Gouveia		Log de Return Values
	18 Aug 	2004		Rodrigo Costa		Gravar error log
	26 Oct 	2004		Carlos Lima		Calcular total, incluindo os Invoices filhos
	19 Jan	2005		Rodrigo Costa		Calcular os totais das outras despesas
	20 Jan	2005		Rodrigo Costa		Calcular os totais do InvMov para somar no total da nota
	----------------------------------------------------------------------------------------------------------------------------------- */
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
	dbo.Invoice.SubTotal =
		CASE
			WHEN CAST(SUBSTRING(SUBSTRING(cast(@SubTotal as varchar), LEN(cast(cast(@SubTotal as int) as varchar))+2, LEN(cast(@SubTotal as varchar))), 3, 1) as int) > 5 THEN Round(@SubTotal, 2)
			ELSE Round(@SubTotal, 2, 1)
		END
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
