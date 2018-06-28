SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
ALTER PROCEDURE [dbo].[sp_TourGroup_DelGift]
		(
		@IDModel    	int,
		@MovDate	smallDateTime
		)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Deleto InventoryMov

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Deleto InventoryMov


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
	27 June 2001		Davi Gouveia		Log de Return Values
	04 July   2001		Davi Gouveia		Tirado o Update na QtyOnHand que era rodado em Inventory
	18 Aug 2004		Rodrigo Costa		Gravar error log
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

DECLARE @ErrorLevel 	int
DECLARE @SysError	int

SET @ErrorLevel = 0

-- Deleto InventoryMov
DELETE
	InventoryMov
WHERE
	InventMovTypeID = 13 /* Saida por Gift */
	AND 
	MovDate = @MovDate
	AND
	ModelID = @IDModel

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END


OK:
	RETURN 0
ERRO:
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_TourGroup_DelGift', @ErrorLevelStr

	RETURN @ErrorLevel
GO
