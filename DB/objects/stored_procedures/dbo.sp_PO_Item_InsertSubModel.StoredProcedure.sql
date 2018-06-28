SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_PO_Item_InsertSubModel]
	(
	@IDModel		int,
	@IDPreInventoryMov	int,
	@IDStore		int
	)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Deleto PreInventoryMov
		- Insiro em PreInventoryMov

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Deleto PreInventoryMov
		-202  Erro em Insiro em PreInventoryMov


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
	26 June 2001		Davi Gouveia		Log de Return Values
	12 July 2001		Rodrigo Costa		Novo Param @IDStore. O PreInvMov precisa de IDStore para o Trigger
	22 Jan	2002		Rodrigo Costa		Incluir o Inventory MovType nos subItems
	29 Oct	2003		Rodrigo Costa		Criado cursor PreInventoryMov_Cursor;
							Chama sp_GetNextCode;
	18 Aug 2004		Rodrigo Costa		Gravar error log
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

DECLARE @ErrorLevel		 	int
DECLARE @SysError			int
--Declaração de variáveis para o Cursor de PreInventoryMov
DECLARE @IDPreInventoryMovParent 	int 
DECLARE @DocumentID 		int 
DECLARE @InventMovTypeID 	 	int 
DECLARE @PreInventoryMovID	 	int

SET @ErrorLevel = 0

-- Deleto PreInventoryMov
DELETE
	PIM
FROM
	PreInventoryMov PIM (NOLOCK) 
WHERE
	PIM.IDPreInventoryMovParent = @IDPreInventoryMov

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END


-- Insiro em PreInventoryMov
--Declaração do Cursor de PreInventoryMov
DECLARE PreInventoryMov_Cursor CURSOR FOR

SELECT
	@IDPreInventoryMov,
	0,
	M.IDModel,
	2
FROM
	Model M (NOLOCK) 
WHERE
	M.IDModelParent = @IDModel

OPEN PreInventoryMov_Cursor

--Inicialização de PreInventoryMov_Cursor
FETCH NEXT FROM PreInventoryMov_Cursor INTO
	@IDPreInventoryMovParent,
	@DocumentID,
	@IDModel,
	@InventMovTypeID
--Enquanto tem registros
WHILE
@@FETCH_STATUS = 0
BEGIN
	EXEC sp_Sis_GetNextCode'PreInventoryMov.IDPreInventoryMov', @PreInventoryMovID OUTPUT
	INSERT PreInventoryMov
		(
		IDPreInventoryMov,
		IDPreInventoryMovParent,
		StoreID,
		DocumentID,
		ModelID,
		InventMovTypeID
		)
	VALUES
		(
		@PreInventoryMovID,
		@IDPreInventoryMovParent,
		@IDStore,
		@DocumentID,
		@IDModel,
		@InventMovTypeID
		)

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		CLOSE PreInventoryMov_Cursor
		DEALLOCATE PreInventoryMov_Cursor
		SET @ErrorLevel = -202
		GOTO ERRO
	END

	FETCH NEXT FROM PreInventoryMov_Cursor INTO
		@IDPreInventoryMovParent,
		@DocumentID,
		@IDModel,
		@InventMovTypeID
END
--fechamento do cursor
CLOSE PreInventoryMov_Cursor
--Destruição do cursor
DEALLOCATE PreInventoryMov_Cursor


SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -202
	GOTO ERRO
END

OK:
	RETURN 0
ERRO:
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PO_Item_InsertSubModel', @ErrorLevelStr

	RETURN @ErrorLevel
GO
