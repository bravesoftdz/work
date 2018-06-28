SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_PreSale_SubCalcAdditionalExpenses]
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
                        InvoiceToCostType (NOLOCK) 
            GROUP BY
                        IDPreSale) ICT
WHERE
	ICT.IDPreSale = Invoice.IDPreSale 
	AND
	(
	Invoice.IDPreSale = @IDPreSale
	OR
	Invoice.IDPreSaleParent = @IDPreSale
	)
 

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
