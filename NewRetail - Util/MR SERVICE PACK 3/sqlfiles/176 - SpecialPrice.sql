if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_RemoveSpecialPrice]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_RemoveSpecialPrice]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_ApplySpecialPrice]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_ApplySpecialPrice]
GO

CREATE PROCEDURE sp_PreSale_RemoveSpecialPrice
		(
			@PreSaleID	int,
			@Date  	DateTime,
			@ExemptTax	bit
		)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Remove o SpecialPrice de um PreSale

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em UPDATE dbo.PreInventoryMov
		-202  Erro em UPDATE dbo.Invoice
		-203  Erro em exec sp_PreSale_SubCalcTotal


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
	26 June 2001		Davi Gouveia		Log de Return Values
	18 Aug 2004		Rodrigo Costa		Gravar error log
	20 Mar 2005		Rodrigo Costa		Novo parametro ExemptTax
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

DECLARE @ErrorLevel	int
DECLARE @SysError	int

SET @ErrorLevel = 0

BEGIN TRAN

UPDATE
	dbo.PreInventoryMov
SET
	dbo.PreInventoryMov.SalePrice =
		(
		SELECT
			MO.SellingPrice
		FROM
			dbo.PreInventoryMov 	PIM,
			dbo.Model 		MO
		WHERE
			PIM.IDPreInventoryMov = dbo.PreInventoryMov.IDPreInventoryMov
			AND
			PIM.ModelID    = MO.IDModel
		),
	dbo.PreInventoryMov.Discount = 0
WHERE
	dbo.PreInventoryMov.DocumentID = @PreSaleID
	AND
       	dbo.PreInventoryMov.InventMovTypeID = 1
	AND
	PreInventoryMov.IDParentPack IS Null

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END

UPDATE
	dbo.Invoice
SET
	dbo.Invoice.SpecialPriceID = NULL,
	dbo.Invoice.TaxIsent = @ExemptTax
WHERE
	dbo.Invoice.IDPreSale = @PreSaleID

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -202
	GOTO ERRO
END

exec sp_PreSale_SubCalcTotal @PreSaleID, @Date

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
	ROLLBACK TRAN
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PreSale_RemoveSpecialPrice', @ErrorLevelStr

	RETURN @ErrorLevel
GO

CREATE PROCEDURE sp_PreSale_ApplySpecialPrice
		(
		@PreSaleID 		int,
		@SpecialPriceID 	int,
		@Date 			datetime,
		@ExemptTax		bit
		)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Altera baseado no Special Price do Grupo
		- Altera baseado no Special Price do Model

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Altera baseado no Special Price do Grupo
		-202  Erro em Atualizo PreInventoryMov
		-203  Erro em Atualizo Invoice
		-204  Erro em exec sp_PreSale_SubCalcTotal @PreSaleID, @Date


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
	26 June 2001		Davi Gouveia		Log de Return Values
	25 May 2004		RodrigoCosta		Special price not for PackModel
	18 Aug 2004		Rodrigo Costa		Gravar error log
	10 Mar 2004		Rodrigo Costa		Novo parametro TaxExempt		
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

DECLARE @ErrorLevel	int
DECLARE @SysError	int

SET @ErrorLevel = 0

BEGIN TRAN

/* ----------------------------------------------- */
/*	Altera baseado no Special Price do Grupo   */
/* ----------------------------------------------- */
UPDATE
	PreInventoryMov
SET
	PreInventoryMov.Discount = 0,
	PreInventoryMov.SalePrice = 	ROUND(
						IsNull (
							(
							SELECT
								( (1+(IsNull( SP.SpecialMarkUp,0)/100)) * PreInventoryMov.CostPrice )
							FROM
								Model MO,
								SpecialPriceByGroup SP
							WHERE
								PreInventoryMov.ModelID = MO.IDModel
								AND
								MO.GroupID = SP.GroupID
								AND
								SP.SpecialPriceID = @SpecialPriceID
							), Model.SellingPrice)
						,2)
FROM
	Model Model
WHERE
	(PreInventoryMov.DocumentID = @PreSaleID
	AND
	PreInventoryMov.IDParentPack IS Null
	AND
	(PreInventoryMov.ModelID = Model.IDModel)
	AND
	PreInventoryMov.InventMovTypeID = 1)

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END


/* ----------------------------------------------- */
/*	Altera baseado no Special Price do Model   */
/* ----------------------------------------------- */
-- Atualizo PreInventoryMov
UPDATE
	PreInventoryMov
SET
	PreInventoryMov.SalePrice = ROUND(IsNull (( (1+(IsNull( MoToSP.MarkUp,0)/100)) * dbo.PreInventoryMov.CostPrice ), Model.SellingPrice),2)
FROM
	ModelToSpecialPrice MoToSP,
	model Model
WHERE
	PreInventoryMov.DocumentID = @PreSaleID
	AND
	PreInventoryMov.InventMovTypeID = 1
	AND
       	PreInventoryMov.ModelID = MoToSP.IDModel
	AND
      	MoToSp.IDModel = Model.IDModel
	AND
       	MoToSP.IDSpecialPrice = @SpecialPriceID
	AND
	PreInventoryMov.IDParentPack IS Null


SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -202
	GOTO ERRO
END


-- Atualizo Invoice
UPDATE
	Invoice
SET
	Invoice.SpecialPriceID = @SpecialPriceID,
	Invoice.TaxIsent = @ExemptTax
WHERE
	Invoice.IDPreSale = @PreSaleID

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -203
	GOTO ERRO
END

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

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PreSale_ApplySpecialPrice', @ErrorLevelStr

	RETURN @ErrorLevel
GO
