if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Sys_ClearRemovedVendor]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Sys_ClearRemovedVendor]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Inv_RecalcVendorOrder]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Inv_RecalcVendorOrder]
GO

CREATE  PROCEDURE sp_Inv_RecalcVendorOrder(
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

CREATE  PROCEDURE sp_Sys_ClearRemovedVendor
AS

DECLARE @IDVendor 	int
DECLARE @IDModel 	int
DECLARE @ErrorLevel 	int
DECLARE @SysError	int

SET @ErrorLevel = 0

BEGIN TRANSACTION

CREATE TABLE #Temp (IDPessoa int, IDModel int)

INSERT 
	#Temp (
		IDPessoa, 
		IDModel
	) 
	SELECT
		P.IDPessoa,
		IMV.IDModel
	FROM
		Pessoa P (NOLOCK)
		JOIN TipoPessoa TP (NOLOCK) ON (TP.IDTipoPessoa = P.IDTipoPessoa)
		JOIN Inv_ModelVendor IMV (NOLOCK) ON (IMV.IDPessoa = P.IDPessoa)
	WHERE
		TP.Path LIKE '.002%'
		AND
		P.Desativado = 1


--Cursor
DECLARE ClearDeletedVendor_Cursor CURSOR FOR
SELECT
	IDPessoa,
	IDModel
FROM
	#Temp

OPEN ClearDeletedVendor_Cursor

--Inicializa??o de ClearDeletedVendor_Cursor
FETCH NEXT FROM ClearDeletedVendor_Cursor INTO
	@IDVendor,
	@IDModel
--Enquanto tem registros
WHILE
@@FETCH_STATUS = 0
BEGIN

	DELETE VendorModelCode
	WHERE IDPessoa = @IDVendor

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		SET @ErrorLevel = -201
		GOTO ERRO
	END

	DELETE Inv_ModelVendor
	WHERE IDPessoa = @IDVendor

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		SET @ErrorLevel = -202
		GOTO ERRO
	END

	EXEC sp_Inv_RecalcVendorOrder @IDModel

	FETCH NEXT FROM ClearDeletedVendor_Cursor INTO
		@IDVendor,
		@IDModel

END
--fechamento do cursor
CLOSE ClearDeletedVendor_Cursor
--Destrui??o do cursor
DEALLOCATE ClearDeletedVendor_Cursor

DROP TABLE #Temp

OK:
	COMMIT TRANSACTION
	RETURN 0

ERRO:
	ROLLBACK
	DROP TABLE #Temp
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_Sys_ClearRemovedVendor', @ErrorLevelStr

	RETURN @ErrorLevel

GO

