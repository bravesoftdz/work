SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_PreSale_SubRemoveAdditionalExpenses]
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
            InvoiceToCostType (NOLOCK) 
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
