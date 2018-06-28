if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_DeleteSingleDelayPayment]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_DeleteSingleDelayPayment]
GO


CREATE PROCEDURE sp_PreSale_DeleteSingleDelayPayment
                                   (
                                   @IDLancamento int
                                   )
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
            SUMARIO

                        - Update Cash RegisterMovent
                        - Desquita o lancamento
                        - Deleta o lancamento

            TABELA DE ERROS PARA RETURN_VALUE
                         000  Ok
                        -201  Erro em Deleta os registros de ligacao
                        -202  Erro em Deleta os registros de quitacao
                        -203  Erro em Deleta os registros de lançamento
                        -204  Erro em Update Cash RegisterMovent
 

            LOG DE MODIFICAÇÕES

            Data                             Programador                 Modificação
            --------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
            05 Oct 2004                  Carlos Lima                  Criação
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

BEGIN TRAN

DECLARE @ErrorLevel             int
DECLARE @SysError               int

SET @ErrorLevel = 0
/*----------------------------------------------------------------*/
/*                     Update Cash RegisterMovent do dia                     */
/*----------------------------------------------------------------*/ 

UPDATE
            CashRegMov     
SET
            CashRegMov.TotalSales = IsNull(CashRegMov.TotalSales, 0) - Fin_Lancamento.ValorNominal
FROM
            Fin_Lancamento
WHERE
            CashRegMov.IDCashRegMov = Fin_Lancamento.IDCashRegMov
            AND Fin_Lancamento.IDLancamento = @IDLancamento

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
            SET @ErrorLevel = -204
            GOTO ERRO
END
 
/*----------------------------------------------------------------*/
/*                 Desquita o lancamento                                            */
/*----------------------------------------------------------------*/

/*---------------- Deleta o registro de ligacao -------------------- */
DELETE
            LQ
FROM
            Fin_LancQuit LQ
            JOIN Fin_Lancamento L ON (L.IDLancamento = LQ.IDLancamento)         
WHERE
            L.IDLancamento = @IDLancamento

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
            SET @ErrorLevel = -201
            GOTO ERRO
END
 

/*--------------- Deleta o registro de quitacao -----------------*/
DELETE
            Q
FROM
            Fin_Quitacao Q
            JOIN Fin_Lancamento L ON (Q.SparrowInt = L.IDLancamento)
WHERE
            L.IDLancamento = @IDLancamento


SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
            SET @ErrorLevel = -202
            GOTO ERRO
END

/*---------------- Deleta o registro de lançamento --------------------*/
DELETE
            L
FROM 
            Fin_Lancamento L
WHERE
            L.IDLancamento = @IDLancamento


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
            EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PreSale_DeleteSingleDelayPayment', @ErrorLevelStr
            RETURN @ErrorLevel

GO
