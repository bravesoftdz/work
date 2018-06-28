if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_ServiceOrder_ApplyDiscount]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_ServiceOrder_ApplyDiscount]
GO

CREATE PROCEDURE sp_ServiceOrder_ApplyDiscount
		(
			@IDServiceOrder int,
			@PercDiscount 	Float
		)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Atualizo PreInventoryMov
		- Atualizo Invoice

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em UPDATE Ser_SOItemProduct	
		-202  Erro em Update InventoryMov


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	22 Oct  2008		Rodrigo Costa		Criacao;
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

DECLARE @ErrorLevel	int 
DECLARE @SysError	int

SET @ErrorLevel = 0 
BEGIN TRAN

	UPDATE
		SOI
	SET
		SOI.Discount =
	        		ROUND(
					IsNull (
							(
							SELECT  ( SOI.SalePrice * @PercDiscount / 100) * SOI.Qty
		                        		FROM 	Model M (NOLOCK) 
                                        		WHERE   SOI.IDModel = M.IDModel), 
							0),
				2)
	FROM
		Ser_SOItemProduct SOI
		JOIN Ser_SOItem SOT (NOLOCK) ON (SOT.IDSOItem = SOI.IDSOItem)
	WHERE
		SOT.IDServiceOrder = @IDServiceOrder
	

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END

UPDATE
	IMV
SET
	IMV.Discount = SOI.Discount
FROM
	InventoryMov IMV
	JOIN Ser_SOItemProduct SOI (NOLOCK) ON (IMV.DocumentID = SOI.IDSOItemProduct AND IMV.InventMovTypeID = 50)
	JOIN Ser_SOItem SOT (NOLOCK) ON (SOT.IDSOItem = SOI.IDSOItem)
WHERE
	SOT.IDServiceOrder = @IDServiceOrder

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
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_ServiceOrder_ApplyDiscount', @ErrorLevelStr

	RETURN @ErrorLevel

GO
