if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Inventory_Count]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Inventory_Count]
GO

CREATE PROCEDURE sp_Inventory_Count
		(
		@IDModel	int,
		@IDStore	int,
		@CountType	int,
		@CountedQty	float,
		@CountDate	smalldatetime,
		@IDUser		int
		)
AS

	/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		Calcula o total de quantidade movimentada ate a contagem

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Ajuste por entrada de estoque
		-202  Erro em Ajuste por saida de estoque


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	-----------------------	-----------------------	----------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
	25 June 2001		Davi Gouveia		Log de Return Values
 	21 Oct	2003		Rodrigo Costa		Chamada a sp_Sis_GetNextCode para @IDInventoryMov; 
							Criado @IDInventoryMov;
	18 Aug 2004		Rodrigo Costa		Gravar error log
	02 Jun 2006		Rodrigo Costa		Removido Notes do InventoryMov
	19 Oct 2006		Max e Maic		Alterado parâmetro "@Difference" por "@CountedQty";
							Removidos parâmetros "@Date e @Notes";
							Inserido parâmetro "@CountType";
	----------------------------------------------------------------------------------------------------------- */

DECLARE @ErrorLevel 		int
DECLARE @SysError		int
DECLARE @IDInventoryMov		int
DECLARE @QtyOnHand		float
DECLARE @QtyDifference		float

SET @ErrorLevel = 0
SET @QtyOnHand = 0

-------------------------------------------------------------------------------------------------------
-- Pego a quantidade atual em estoque do produto
SELECT
	@QtyOnHand = IsNull(SUM(IM.Qty * (2*IMT.UpdateOnHand-1)), 0)
FROM
	InventoryMov IM
	JOIN InventoryMovType IMT ON (IM.InventMovTypeID = IMT.IDInventMovType)
WHERE
	IM.StoreID = @IDStore     
	AND IM.ModelID = @IDModel     	
	AND IM.MovDate <= @CountDate


-------------------------------------------------------------------------------------------------------
-- Descubro qual a diferença entre meu estoque e a quantidade contada.
-- Caso seja igual a zero, saio da SP sem inserir a movimentação
IF @CountType = 1
	SET @QtyDifference = @CountedQty
ELSE
	SET @QtyDifference = @CountedQty - @QtyOnHand

IF @QtyDifference = 0
	GOTO OK

-------------------------------------------------------------------------------------------------------
-- Pego um novo ID para inserir na InventoryMov
EXEC sp_Sis_GetNextCode 'InventoryMov.IDInventoryMov', @IDInventoryMov OUTPUT

-------------------------------------------------------------------------------------------------------
-- Insiro na InventoryMov a movimentação de ajuste do estoque
if @QtyDifference > 0
begin
	/*	Ajuste por entrada de estoque	*/
	INSERT InventoryMov 	(
				IDInventoryMov,
				InventMovTypeID,
				DocumentID,
				StoreID,
				ModelID,
				MovDate,
				Qty,
				IDUser
				)
				VALUES
				(
				@IDInventoryMov,
				21,
				0,
				@IDStore,
				@IDModel,
				GetDate(),
				Abs(@QtyDifference),
				@IDUser
				)

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		SET @ErrorLevel = -201
		GOTO ERRO
	END
END
ELSE
BEGIN
	/*	Ajuste por saida de estoque	*/
	INSERT InventoryMov 	(
				IDInventoryMov,
				InventMovTypeID,
				DocumentID,
				StoreID,
				ModelID,
				MovDate,
				Qty,
				IDUser
				)
				VALUES
				(
				@IDInventoryMov,
				22,
				0,
				@IDStore,
 				@IDModel,
				GetDate(),
				Abs(@QtyDifference),
				@IDUser
				)

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		SET @ErrorLevel = -202
		GOTO ERRO
	END
END

OK:
	RETURN 0
ERRO:
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_Inventory_Count', @ErrorLevelStr

	RETURN @ErrorLevel
GO
