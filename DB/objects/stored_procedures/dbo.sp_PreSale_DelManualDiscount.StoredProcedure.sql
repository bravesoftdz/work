SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
alter procedure [dbo].[sp_PreSale_DelManualDiscount] (
    @IDPreInventoryMov int 
    ,@Result        VARCHAR(1010) output 
)
as

/* --------------------------------------------------------------------------
SUMMARY
    - Checks to see confirm this is a presale and not invoiced yet
    - If this a presale, delete the manualdiscount value
    
TABLE OF ERRORS WITH RETURN_VALUE
     000  Ok
    -201  Could Not set the manualdiscount to null

MODIFICATION LOG
    Date           Programmer         Modification
    -----------    ---------------    ---------------------------------------
    27 Mar 2014    Daniel Browning    See git log for modifications.

    -------------------------------------------------------------------------*/

begin
 set nocount on;

DECLARE @FoundIDPreInventoryMov int
DECLARE @ErrorLevel        int
DECLARE @SysError        int

SET @ErrorLevel = 0


SELECT @FoundIDPreInventoryMov = dbo.PreInventoryMov.IDPreInventoryMov
 FROM dbo.PreInventoryMov 
WHERE IDPreInventoryMov = @IDPreInventoryMov

IF (@FoundIDPreInventoryMov IS NOT NULL)
BEGIN
 BEGIN TRANSACTION
     update Sal_DiscPIMExtra set ManualDiscount = null, ManualDiscountType = null
     WHERE idpreinventorymov = @FoundIDPreInventoryMov;
OK:
    COMMIT TRAN
    RETURN 'Success'
END
ELSE
BEGIN
    SET @SysError = @@ERROR
    IF @SysError <> 0
    BEGIN
        SET @ErrorLevel = -201
        GOTO ERRO 
    END
END
ERRO:
    PRINT CAST(@ErrorLevel AS VARCHAR)
    DECLARE @ErrorLevelStr varchar(510)
    DECLARE @Params varchar(500)    
    SET @Params = ' [ (IDPreInventoryMov) = ' + CAST(@FoundIDPreInventoryMov AS VARCHAR) + ') ]'
    SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR) + @Params
    EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_CashRegister_DelManualDiscount', @ErrorLevelStr
    RETURN @ErrorLevel
END
GO


