SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

if object_id('[dbo].[sp_PreSale_DelManualDiscount]') is not null drop procedure [dbo].[sp_PreSale_DelManualDiscount];
go
CREATE procedure [dbo].[sp_PreSale_DelManualDiscount] (
    @IDPreInventoryMov int
)
as

/* --------------------------------------------------------------------------
SUMMARY
    - Checks to see confirm this is a presale and not invoiced yet
    - If this a presale, delete the manualdiscount value
    
TABLE OF ERRORS WITH RETURN_VALUE
     000  Ok
    -201  Could Not delete the manualprice

MODIFICATION LOG
    Date           Programmer         Modification
    -----------    ---------------    ---------------------------------------
    27 Mar 2014    Daniel Browning    First created. See git log.

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
     DELETE FROM [dbo].[ManualDiscount] WHERE idpreinventorymov = @FoundIDPreInventoryMov;
OK:
    COMMIT TRAN
    RETURN 0
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
    EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PreSale_DelManualDiscount', @ErrorLevelStr
    RETURN @ErrorLevel
END
GO


