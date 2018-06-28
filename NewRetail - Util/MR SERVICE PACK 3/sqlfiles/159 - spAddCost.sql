if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_AddAdditionalExpenses]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_AddAdditionalExpenses]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_SubCalcAdditionalExpenses]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_SubCalcAdditionalExpenses]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_SubCalcTotal]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_SubCalcTotal]
GO

CREATE PROCEDURE sp_PreSale_AddAdditionalExpenses
                                   (
                                   @IDPreSale int,
                                   @IDCostType int, 
                                   @Amount money
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

            Data                             Programador                 Modificação
            --------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
            28 Sep 2004                 Carlos Lima			Criação
            19 Jan 2005                 Rodrigo Costa			Modicação do SubCalcTotal
            ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- */
 

DECLARE @IDInvoiceCost 	int
DECLARE @ErrorLevel  	int
DECLARE @SysError   	int
 
SET @ErrorLevel = 0

EXEC sp_Sis_GetNextCode'InvoiceToCostType.IDInvoiceCost', @IDInvoiceCost OUTPUT
INSERT INTO InvoiceToCostType
            (IDInvoiceCost, IDPreSale, IDCostType, Amount)
VALUES
            (@IDInvoiceCost, @IDPreSale, @IDCostType, @Amount)
 
SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END

exec sp_PreSale_SubCalcAdditionalExpenses @IDPreSale

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
            EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PreSale_AddAdditionalExpenses', @ErrorLevelStr
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
            Invoice.IDPreSale = @IDPreSale

 

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
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */
DECLARE @ErrorLevel	int 
DECLARE @SysError	int
SET @ErrorLevel = 0 

BEGIN TRAN 

UPDATE
	dbo.Invoice
SET
	dbo.Invoice.SubTotal = convert(money, convert(numeric(20, 0),
					(
					SELECT
						SUM((IsNull(PIM.SalePrice, 0)*IsNull(PIM.Qty, 0)))
        					FROM
						dbo.Invoice INV
						LEFT JOIN dbo.PreInventoryMov PIM ON (INV.IDPreSale = PIM.DocumentID)
					WHERE
						(
						(
							INV.IDPreSale = @PreSaleID
							OR
							INV.IDPreSaleParent = @PreSaleID -- Calcula todos os invoices filhos deste PreSale
						)						
						AND
						PIM.InventMovTypeID = 1)
                                        )*100)/100)
WHERE 	dbo.Invoice.IDPreSale = @PreSaleID  IF @@ERROR <> 0 BEGIN
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

