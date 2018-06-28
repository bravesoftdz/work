if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_Undo_Delivery]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_Undo_Delivery]
GO

CREATE PROCEDURE sp_PreSale_Undo_Delivery
			(
				@IDPreSaleNew	int,
				@IDPreSaleOld	int,
				@IDUser		int
			)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Atualizo com o novo PreInvMov
		- Remove o Invoice antigo

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Atualizar o novo PreInvMov
		-202  Erro em Remove o Invoice


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	23 Aug  2005		Rodrigo Costa		Criacao;
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */
 
DECLARE @IsLayaway		bit
DECLARE @ErrorLevel		int 
DECLARE @SysError		int
SET @ErrorLevel = 0 

BEGIN TRAN


/*--------------------------------------------------------------*/
/*	Atualizo o novo PreInvMov        */
/*--------------------------------------------------------------*/
UPDATE 
	PreInventoryMov 
SET 
	DocumentID = @IDPreSaleNew
WHERE
	DocumentID = @IDPreSaleOld
	AND
	InventMovTypeID = 1

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END


/*--------------------------------------------------------------*/
/*	Delecao do Antigo Invoice	        */
/*--------------------------------------------------------------*/
EXEC sp_PreSale_Remove @IDPreSaleOld, @IDUser

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -202
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
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_Undo_Delivery', @ErrorLevelStr
	RETURN @ErrorLevel

GO
