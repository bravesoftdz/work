SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


if object_id('[dbo].[sp_PreSale_DelManualPrice]') is not null drop procedure [dbo].[sp_PreSale_DelManualPrice];
go
CREATE procedure [dbo].[sp_PreSale_DelManualPrice]
( @IDPreInventoryMov int
)
as

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMMARY

		- Checks to see confirm this is a presale and not invoiced yet
		- If this a presale, delete from sal_manualprice
		
	TABLE OF ERRORS WITH RETURN_VALUE
		 000  Ok
		-201  Could Not Delete From [dbo].[ManualPrice]

	MODIFICATION LOG

	Data			Programmer		Modification
	-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	2014-03-09      John Rogers		Created;
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

begin
 set nocount on;

--DECLARE @IDPreInventoryMov int
--SET @IDPreInventoryMov = 30769 

DECLARE @FoundIDPreInventoryMov int
DECLARE @ErrorLevel		int
DECLARE @SysError		int

SET @ErrorLevel = 0


SELECT @FoundIDPreInventoryMov = dbo.PreInventoryMov.IDPreInventoryMov
 FROM dbo.PreInventoryMov 
WHERE IDPreInventoryMov = @IDPreInventoryMov

IF (@FoundIDPreInventoryMov IS NOT NULL)
BEGIN
 BEGIN TRANSACTION
	 DELETE FROM [dbo].[ManualPrice] WHERE idpreinventorymov = @FoundIDPreInventoryMov;
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

	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PreSale_DelManualPrice', @ErrorLevelStr

	RETURN @ErrorLevel

END
GO


