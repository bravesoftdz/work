if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_CancelHold]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_CancelHold]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_NewHistory]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_NewHistory]
GO


CREATE PROCEDURE sp_PreSale_CancelHold
                                   (
                                   @IDPreSale int
                                   )
AS


/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
            SUMARIO
 
                        - Deleta PreSerial Movement
                        - Update Cash RegisterMovent
                        - Desquita o lancamento
                        - Deleta o lancamento


            TABELA DE ERROS PARA RETURN_VALUE

                         000  Ok
                        -201  Erro em Inser no PreInventoryMov (Cancelamento)
                        -202  Erro em Delete no PreInventoryMov
                        -203  Erro em Delete nos registros de Lançamento e Quitação
                        -204  Erro em Update no Invoice
                        -205  Erro Delete PreSerial


            LOG DE MODIFICAÇÕES

            Data                             Programado		Modificação
            --------------------------------------- --------------------------------------- 	-----------------------------------------------------------------------------------------------------
            15 Oct 2004                  Carlos Lima		Criação
            21 Oct 2004                  Rodrigo Costa		Delecao dos PreSerial do item
            -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */


BEGIN TRAN

DECLARE @ErrorLevel	int
DECLARE @SysError	int
DECLARE @IDLancamento	int
 


-- Variaveis para o cursor PreInv_Cursor
DECLARE  @IDPreInventoryMov		int
DECLARE  @StoreID			int
DECLARE  @ModelID			int
DECLARE  @IDPessoa			int
DECLARE  @ComissionID		int
DECLARE  @UserID			int
DECLARE  @IDCotacao			int
DECLARE  @IDPreInventoryMovParent	int
DECLARE  @BarCodeID			TBarCode
DECLARE  @DocumentID		int
DECLARE  @MovDate			smalldatetime
DECLARE  @Qty			int
DECLARE  @CostPrice			money
DECLARE  @SalePrice			money
DECLARE  @Discount			money
DECLARE  @DateEstimatedMov		smalldatetime
DECLARE  @DateRealMov		smalldatetime
DECLARE  @QtyRealMov		int
DECLARE  @Marked			bit
DECLARE  @ExchangeInvoice		int
DECLARE  @SuggRetail			money
DECLARE  @IDParentPack		int
DECLARE  @IDModelService		int


SET @ErrorLevel = 0

/*--------------------------------------------------------------------------------------------------------*/
/*	       Deleta PreSerial Movement			*/
/*--------------------------------------------------------------------------------------------------------*/

DELETE 	
		PreSerialMov
FROM		
		PreInventoryMov PIM
WHERE 	
		PIM.DocumentID = @IDPreSale
		AND
		PIM.InventMovTypeID = 1

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -205
	GOTO ERRO
END


/*----------------------------------------------------------------------------------------------------------------------------------------------------------*/
/*          Insere movimentaçao de cancelamento com base na movimentação anterior                    */
/*----------------------------------------------------------------------------------------------------------------------------------------------------------*/ 

--Declaração do Cursor de PreInv_Cursor
DECLARE PreInv_Cursor CURSOR FOR 
            SELECT                       
                        StoreID,
                        ModelID,
                        IDPessoa,
                        ComissionID,
                        UserID,
                        IDCotacao,
                        IDPreInventoryMovParent,
                        BarCodeID,
                        DocumentID,
                        MovDate,
                        Qty,
                        CostPrice,
                        SalePrice,
                        Discount,
                        DateEstimatedMov,
                        DateRealMov,
                        QtyRealMov,
                        Marked,
                        ExchangeInvoice,
                        SuggRetail,
                        IDParentPack,
                        IDModelService
            FROM
                        PreInventoryMov
            WHERE
                        DocumentID = @IDPreSale
                        AND 
			InventMovTypeID = 1

OPEN PreInv_Cursor

--Inicialização de PreInv_Cursor
FETCH NEXT FROM PreInv_Cursor INTO
            @StoreID,
            @ModelID,
            @IDPessoa,
            @ComissionID,
            @UserID,
            @IDCotacao,
            @IDPreInventoryMovParent,
            @BarCodeID,
            @DocumentID,
            @MovDate,
            @Qty,
            @CostPrice,
            @SalePrice,
            @Discount,
            @DateEstimatedMov,
            @DateRealMov,
            @QtyRealMov,
            @Marked,
            @ExchangeInvoice,
            @SuggRetail,
            @IDParentPack,
            @IDModelService

--Enquanto tem registros
WHILE @@FETCH_STATUS = 0
BEGIN
            EXEC sp_Sis_GetNextCode 'Preinventorymov.IDPreInventoryMov', @IDPreInventoryMov OUTPUT

            INSERT PreInventoryMov
                        (
                        IDPreInventoryMov,
                        InventMovTypeID,
                        StoreID,
                        ModelID,
                        IDPessoa,
                        ComissionID,
                        UserID,
                        IDCotacao,
                        IDPreInventoryMovParent,
                        BarCodeID,
                        DocumentID,
                        MovDate,
                        Qty,
                        CostPrice,
                        SalePrice,
                        Discount,
                        DateEstimatedMov,
                        DateRealMov,
                        QtyRealMov,
                        Marked,
                        ExchangeInvoice,
                        SuggRetail,
                        IDParentPack,
                        IDModelService
                        )
                        VALUES
                        (
                        @IDPreInventoryMov,
                        25,
                        @StoreID,
                        @ModelID,
                        @IDPessoa,
                        @ComissionID,
                        @UserID,
                        @IDCotacao,
                        @IDPreInventoryMovParent,
                        @BarCodeID,
                        @DocumentID,
                        @MovDate,
                        @Qty,
                        @CostPrice,
                        @SalePrice,
                        @Discount,
                        @DateEstimatedMov,
                        @DateRealMov,
                        @QtyRealMov,
                        @Marked,
                        @ExchangeInvoice,
                        @SuggRetail,
                        @IDParentPack,
                        @IDModelService
                        )

            FETCH NEXT FROM PreInv_Cursor INTO
                        @StoreID,
                        @ModelID,
                        @IDPessoa,
                        @ComissionID,
                        @UserID,
                        @IDCotacao,
                        @IDPreInventoryMovParent,
                        @BarCodeID,
                        @DocumentID,
                        @MovDate,
                        @Qty,
                        @CostPrice,
                        @SalePrice,
                        @Discount,
                        @DateEstimatedMov,
                        @DateRealMov,
                        @QtyRealMov,
                        @Marked,
                        @ExchangeInvoice,
                        @SuggRetail,
                        @IDParentPack,
                        @IDModelService
END

--fechamento do cursor
CLOSE PreInv_Cursor
--Destruição do cursor
DEALLOCATE PreInv_Cursor

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
            SET @ErrorLevel = -201
            GOTO ERRO
END

/*----------------------------------------------------------------------------------------------------------------------------------------------------------*/
/*          Deleta a movimentação anterior em PreInventoryMov                                                      */
/*----------------------------------------------------------------------------------------------------------------------------------------------------------*/ 

DELETE FROM
            PreInventoryMov
WHERE
            DocumentID = @IDPreSale
            AND InventMovTypeID = 1

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
            SET @ErrorLevel = -202
            GOTO ERRO
END

/*----------------------------------------------------------------------------------------------------------------------------------------------------------*/
/*          Deleta todos os lançamentos e Quitações                                                                                */
/*----------------------------------------------------------------------------------------------------------------------------------------------------------*/ 

--Declaração do Cursor de Lancamento_Cursor
DECLARE Lancamento_Cursor CURSOR FOR
            SELECT 
                        IDLancamento
            FROM
                        Fin_Lancamento
            WHERE
                        IDPreSale = @IDPreSale

OPEN Lancamento_Cursor

--Inicialização de Lancamento_Cursor
FETCH NEXT FROM Lancamento_Cursor INTO @IDLancamento

--Enquanto tem registros
WHILE @@FETCH_STATUS = 0
BEGIN
            EXEC sp_PreSale_DeleteSingleDelayPayment @IDLancamento
            FETCH NEXT FROM Lancamento_Cursor INTO 
                        @IDLancamento
END

--fechamento do cursor
CLOSE Lancamento_Cursor
--Destruição do cursor
DEALLOCATE Lancamento_Cursor

 
SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
            SET @ErrorLevel = -203
            GOTO ERRO
END
 
/*----------------------------------------------------------------------------------------------------------------------------------------------------------*/
/*          Atualiza Status de Cancelado no invoice                                                                       */
/*----------------------------------------------------------------------------------------------------------------------------------------------------------*/ 

UPDATE 
            Invoice
SET
            Canceled = 1
WHERE
            IDPreSale = @IDPreSale

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
            EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PreSale_CancelHold', @ErrorLevelStr
            RETURN @ErrorLevel

GO

 

CREATE PROCEDURE sp_PreSale_NewHistory( @IDUser int, @MovDate DateTime, @OBS varchar(255), @IDHistoryType int, @IDPreSale int) AS
DECLARE @IDHistory int
 

EXEC sp_Sis_GetNextCode 'History.IDHistory', @IDHistory OUTPUT

INSERT INTO History
            (
            IDHistory,
            IDUser,
            MovDate,
            OBS,
            IDHistoryType,
            IDPreSale
            )
VALUES
            (
            @IDHistory,
            @IDUser,
            @MovDate,
            @OBS,
            @IDHistoryType,
            @IDPreSale
            )
GO

INSERT INTO InventoryMovType (IDInventMovType, Name, Entrando, System, Desativado, Hidden, UpdateOnHand, UpdateOnRepair, UpdateOnOrder, UpdateOnPreSale, UpdateOnPrePurchase, UpdatePreOnHand, UpdatePreOnRepair, UpdatePreOnOrder, UpdatePreOnPreSale, UpdatePreOnPrePurchase) 
VALUES (25, 'Canceled', 0, 1, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO

UPDATE Sis_CodigoIncremental SET UltimoCodigo = 25 Where Tabela = 'InventoryMovType.IDInventMovType'
GO
