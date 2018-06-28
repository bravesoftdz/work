if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PO_Item_Remove]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PO_Item_Remove]
GO

CREATE PROCEDURE sp_PO_Item_Remove
		(
		@IDPO     		int,
		@IDPreInventoryMov	int
 		)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Removo todoas as relações entre PO e request
		- Removo os SubItens
		- Removo o Item
		- Atualizo o total do PO
		- Verifica condição de Fechamento e Atualiza

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Removo todoas as relações entre PO e request
		-202  Erro em Removo os subItems
		-203  Erro em Removo o Item
		-204  Erro em Atualizo o total do PO
		-205  Erro em Verifica condição de Fechamento e Atualiza


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	04 dezembro 2000	Eduardo Costa		Criação;
	26 June 2001		Davi Gouveia		Log de Return Values
	18 Aug 2004		Rodrigo Costa		Gravar error log
	30 Nov 2005		Carlos Lima		Verifica condição de Fechamento e Atualiza
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */


DECLARE @ErrorLevel	int
DECLARE @SysError	int
DECLARE @CountItem	int

SET @ErrorLevel = 0

BEGIN TRAN

------------------------------------------------------------------------------------------------------
-- Removo todoas as relações entre PO e request

DELETE
	POIR
FROM
	POItemRequest POIR
WHERE
	POIR.IDPreInventoryMov = @IDPreInventoryMov

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END


-------------------------------------------------------------------------------------------------------
-- Removo os subItems

DELETE
	PIM
FROM
	PreInventoryMov PIM
WHERE
	PIM.IDPreInventoryMovParent = @IDPreInventoryMov

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -202
	GOTO ERRO
END


--------------------------------------------------------------------------------------------------------
-- Removo o Item

DELETE
	PIM
FROM
	PreInventoryMov PIM
WHERE
	PIM.IDPreInventoryMov = @IDPreInventoryMov

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -203
	GOTO ERRO
END


------------------------------------------------------------------------------------------------------
-- Atualizo o total do PO


/*---------------------------------------------------------------------------------------------------------------------*/
/*                Testa se o numero de itens chegou a zero e deleta o PO	*/
/*---------------------------------------------------------------------------------------------------------------------*/

SELECT @CountItem = 	(
			SELECT 
				Count(*)
			FROM 
				dbo.vwPOItem 			WHERE 
				dbo.vwPOItem.IDPO = @IDPO
			)

IF @CountItem = 0
BEGIN
	EXEC sp_PO_Remove @IDPO

SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		SET @ErrorLevel = -204
		GOTO ERRO
	END
END

IF @CountItem > 0
BEGIN
	EXEC sp_PO_AtuPOTotal @IDPO
	
	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		SET @ErrorLevel = -204
		GOTO ERRO
	END
	
	EXEC sp_PO_CalcTotalQty @IDPO
	
	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		SET @ErrorLevel = -205
		GOTO ERRO
	END
END

OK:
	COMMIT TRAN
	RETURN 0
ERRO:
	ROLLBACK TRAN

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PO_Item_Remove', @ErrorLevelStr

	RETURN @ErrorLevel
GO
