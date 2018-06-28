SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[sp_Sys_ClearRemovedVendor]
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
