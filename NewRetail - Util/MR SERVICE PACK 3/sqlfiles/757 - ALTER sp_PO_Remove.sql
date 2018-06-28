if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PO_Remove]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PO_Remove]
GO

CREATE PROCEDURE sp_PO_Remove
		(
		@IDPO     		int
		)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Removo todoas as relações entre PO e request
		- Removo o Item
		- Removo o PO

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Removo todoas as relações entre PO e request
		-203  Erro em Removo o Item
		-204  Erro em Removo o PO
		-205  Erro em atualizar a Pur_Purchase


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	04 dezembro 2000	Eduardo Costa		Criação;
	05 fev 2001		Rodrigo Costa		Nao deleta fisicamente o PO - Set visible false
	26 June 2001		Davi Gouveia		Log de Return Values
	18 Aug 2004		Rodrigo Costa		Gravar error log
	12 Dez	2007		Rodrigo Costa		Atualizar a Put_Purchase
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

DECLARE @ErrorLevel	int
DECLARE @SysError	int

SET @ErrorLevel = 0

BEGIN TRAN

------------------------------------------------------------------------------------------------------
-- Removo todoas as relações entre PO e request

DELETE
	POIR
FROM
	POItemRequest POIR (NOLOCK) 
	JOIN 
	PreInventoryMov PIM (NOLOCK) ON (POIR.IDPreInventoryMov = PIM.IDPreInventoryMov)
WHERE
	PIM.DocumentID = @IDPO
	AND
	PIM.InventMovTypeID = 2 -- Compra

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END


--------------------------------------------------------------------------------------------------------
-- Removo o Item

DELETE
	PIM
FROM
	PreInventoryMov PIM (NOLOCK) 
WHERE
	PIM.DocumentID = @IDPO
	AND
	PIM.InventMovTypeID = 2 -- Compra

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -202
	GOTO ERRO
END

--------------------------------------------------------------------------------------------------------
-- Desmarco a importacao da compra

UPDATE 
	Pur_Purchase 
SET
	IDPO = NULL
WHERE
	IDPO = @IDPO

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -205
	GOTO ERRO
END

--------------------------------------------------------------------------------------------------------
-- Removo o PO

DELETE
	PO
WHERE
	PO.IDPO = @IDPO


SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -203
	GOTO ERRO
END

--------------------------------------------------------------------------------------------------------
-- Removo o PO - Rodrigo
/*
UPDATE
	PO
SET
	Aberto = 0
WHERE
	PO.IDPO = @IDPO

IF @@ERROR <> 0
BEGIN
	SET @ErrorLevel = -204
	GOTO ERRO
END
*/


OK:
	COMMIT TRAN
	RETURN 0

ERRO:
	ROLLBACK TRAN
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PO_Remove', @ErrorLevelStr

	RETURN @ErrorLevel
GO
