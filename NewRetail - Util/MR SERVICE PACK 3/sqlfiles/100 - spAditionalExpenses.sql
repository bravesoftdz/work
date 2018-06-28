if not exists (Select * From Sis_CodigoIncremental Where Tabela = 'InvoiceToCostType.IDInvoiceCost')
INSERT Sis_CodigoIncremental (Tabela,UltimoCodigo) VALUES ('InvoiceToCostType.IDInvoiceCost', 1)
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_SubCalcAdditionalExpenses]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_SubCalcAdditionalExpenses]
GO

CREATE PROCEDURE sp_PreSale_SubCalcAdditionalExpenses
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
            28 Sep 2004                 Carlos Lima                  Criação
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


if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_SubRemoveAdditionalExpenses]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_SubRemoveAdditionalExpenses]
GO


CREATE PROCEDURE sp_PreSale_SubRemoveAdditionalExpenses
                                   (
                                   @IDInvoiceCost 	int
                                   )
AS

/* --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
            SUMARIO

                        - Remove e recalcula Despesas Adicionais

            TABELA DE ERROS PARA RETURN_VALUE

                         000  Ok
                        -201  Erro em DELETE FROM InvoiceToCostType
                        -202  Erro em UPDATE Invoice SET AditionalExpenses

            LOG DE MODIFICAÇÕES
 

            Data                             Programador                 Modificação
            --------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
            28 Sep 2004                 Carlos Lima                  Criação
            ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- */


DECLARE @IDPreSale 	int
DECLARE @ErrorLevel  	int
DECLARE @SysError   	int
DECLARE @Amount	Money


SET @ErrorLevel = 0
 
--Grava o valor a ser retirado do invoice
SELECT 
	@IDPreSale = IDPreSale,
	@Amount = Amount
FROM
            InvoiceToCostType
WHERE           
            IDInvoiceCost = @IDInvoiceCost

-- Exclui a despesa Adicional
DELETE FROM 
            InvoiceToCostType
WHERE
            IDInvoiceCost = @IDInvoiceCost
 
SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END

 
-- É necessário a atualização de um campo: AditionalExpenses
UPDATE
            Invoice
SET 
            Invoice.AditionalExpenses =  Invoice.AditionalExpenses - @Amount
WHERE
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
            EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PreSale_SubRemoveAdditionalExpenses', @ErrorLevelStr
            RETURN @ErrorLevel
GO
