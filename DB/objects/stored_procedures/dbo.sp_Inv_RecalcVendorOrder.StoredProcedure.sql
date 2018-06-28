SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[sp_Inv_RecalcVendorOrder](
		@IDModel	int
)	
AS

DECLARE @Count		int
DECLARE @IDVendor	int
DECLARE @ErrorLevel 	int
DECLARE @SysError	int

SET @ErrorLevel = 0
SET @Count = 1

--Cursor
DECLARE RecalcVendorOrder_Cursor CURSOR FOR

SELECT
	MV.IDPessoa
FROM
	Inv_ModelVendor MV (NOLOCK)
WHERE
	MV.IDModel = @IDModel

OPEN RecalcVendorOrder_Cursor

--Inicializa??o de RecalcVendorOrder_Cursor
FETCH NEXT FROM RecalcVendorOrder_Cursor INTO
	@IDVendor
--Enquanto tem registros
WHILE
@@FETCH_STATUS = 0
BEGIN

	UPDATE 
		Inv_ModelVendor
	SET
		VendorOrder = @Count
	WHERE
		IDPessoa = @IDVendor
		AND
		IDModel = @IDModel

	SET @Count = @Count + 1

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		SET @ErrorLevel = -102
		GOTO ERRO
	END

	FETCH NEXT FROM RecalcVendorOrder_Cursor INTO
		@IDVendor

END
--fechamento do cursor
CLOSE RecalcVendorOrder_Cursor
--Destrui??o do cursor
DEALLOCATE RecalcVendorOrder_Cursor

OK:
	RETURN 0

ERRO:
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_Inv_RecalcVendorOrder', @ErrorLevelStr

	RETURN @ErrorLevel
GO
