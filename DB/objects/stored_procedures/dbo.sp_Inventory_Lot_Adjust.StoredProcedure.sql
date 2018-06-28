SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_Inventory_Lot_Adjust]
	(
	@IDModel	int,
	@IDStore	int,
	@IDLot		int,
	@Qty		decimal(38, 4),
	@Type		int
	)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		@Type = 1 (Novo), 2 (Adicionar), 3 (Subtrair)
		- Movimentar quantidade de  lote

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em criar ModelStoreLot
		-202  Erro em atualizar ModelStoreLot
	
	LOG DE MODIFICACOES

	Data			Programador		Modifica??o
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	31 Mar		2009	Rodrigo Costa	Criacao
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

DECLARE @IDPO 			int
DECLARE @ErrorLevel 		int
DECLARE @SysError		int
DECLARE @QtyLot			decimal(38, 4)

IF NOT EXISTS(SELECT Qty FROM Inv_StoreModelLot WHERE IDModel = @IDModel AND IDStore = @IDStore AND IDLote = @IDLot)
BEGIN
	INSERT Inv_StoreModelLot (IDModel, IDStore, IDLote, Qty)
	VALUES (@IDModel, @IDStore, @IDLot, 0)
END

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END

SELECT 
	@QtyLot = Qty 
FROM
	Inv_StoreModelLot
WHERE 
	IDModel = @IDModel 
	AND 
	IDStore = @IDStore 
	AND 
	IDLote = @IDLot

--Type
IF @Type = 2
	SET @Qty = @QtyLot + @Qty
IF @Type = 3
	SET @Qty = @QtyLot - @Qty

UPDATE Inv_StoreModelLot
SET Qty = @Qty
WHERE IDModel = @IDModel AND IDStore = @IDStore AND IDLote = @IDLot

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -202
	GOTO ERRO
END

OK:
	RETURN 0

ERRO:
	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_Inventory_Lot_Adjust', @ErrorLevelStr

	RETURN @ErrorLevel
GO
