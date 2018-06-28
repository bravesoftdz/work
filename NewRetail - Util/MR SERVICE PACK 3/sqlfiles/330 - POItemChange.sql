if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PO_Item_Do]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PO_Item_Do]
GO

CREATE PROCEDURE sp_PO_Item_Do
		(
		@IDPreInventoryMov 	int,
		@IDPO			int
		)
AS
/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Deleto a POItemRequest
		- Atualiza SuggRetail no Model
		- Atualiza as informações nos Subs
		- Atualiza Total no PO
		- Incluo a POItemRequest
		- Atualizo a condição de fechamento do PO

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Deteto a POItemRequest
		-202  Erro em Atualiza o Model
		-203  Erro em Copio os dados do master para os subs
		-204  Erro em Atualiza o total do PO
		-205  Erro em Recrio  a POItemRequest
		-206  Erro em  Atualizo a condição de fechamento do PO



	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	04 dezembro 2000	Eduardo Costa		Criação;
	26 June 2001		Davi Gouveia		Log de Return Values
	18 Aug 2004		Rodrigo Costa		Gravar error log
	01 Dec 2005		Carlos Lima		Verificar a condição de fechamento do PO e atualizar
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

DECLARE @QtyAtual	int
DECLARE @ErrorLevel	int
DECLARE @SysError	int

SET @ErrorLevel = 0

BEGIN TRAN

------------------------------------------------------------------------------
-- Deteto a POItemRequest

DELETE
	POIR
FROM
	POItemRequest POIR
	JOIN 
	PreInventoryMov PIM ON (POIR.IDPreInventoryMov = PIM.IDPreInventoryMov)
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



------------------------------------------------------------------------------
-- Atualiza o Model

UPDATE
	M
SET
	M.SuggRetail = PIM.SuggRetail
FROM
	PreInventoryMov PIM
	JOIN 
	Model M ON (PIM.ModelID = M.IDModel)
WHERE
	PIM.IDPreInventoryMov = @IDPreInventoryMov
	AND
	IsNull(PIM.SuggRetail,0) <> 0

SET @SysError = @@ERROR 
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -202
	GOTO ERRO
END



------------------------------------------------------------------------------
-- Copio os dados do master para os subs

UPDATE
	PIMS
SET
	PIMS.CostPrice 			= PIMM.CostPrice,
	PIMS.SuggRetail		= PIMM.SuggRetail,
	PIMS.IDPessoa			= PIMM.IDPessoa,
	PIMS.DateEstimatedMov		= PIMM.DateEstimatedMov,
	PIMS.StoreID			= PIMM.StoreID,
	PIMS.SalePrice			= PIMM.SalePrice,
	PIMS.DocumentID		= PIMM.DocumentID,
	PIMS.MovDate			= PIMM.MovDate,
	PIMS.InventMovTypeID		= PIMM.InventMovTypeID,
	PIMS.UserID			= PIMM.UserID
FROM
	PreInventoryMov PIMM
	JOIN 
	PreInventoryMov PIMS ON (PIMM.IDPreInventoryMov = PIMS.IDPreInventoryMovParent)
WHERE
	PIMM.IDPreInventoryMov = @IDPreInventoryMov

SET @SysError = @@ERROR 
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -203
	GOTO ERRO
END


------------------------------------------------------------------------------
-- Atualiza o total do PO

EXEC sp_PO_AtuPOTotal @IDPO

SET @SysError = @@ERROR 
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -204
	GOTO ERRO
END



------------------------------------------------------------------------------
-- Recrio  a POItemRequest

INSERT
	POItemRequest
	(
	IDPreInventoryMov,
	IDRequest,
	Qty
	)
SELECT
	PIM.IDPreInventoryMov,
	R.IDRequest,
	CASE WHEN R.QtyReq <= PIM.Qty THEN R.QtyReq ELSE R.QtyReq - PIM.Qty END
FROM
	Request R
	JOIN 
	PreInventoryMov PIM ON (R.ModelID = PIM.ModelID)
WHERE
	IsNull(R.QtyReq, 0) > IsNull(R.QtyOrdered, 0)
	AND
	PIM.DocumentID = @IDPO
	AND
	PIM.InventMovTypeID = 2 -- Compra


SET @SysError = @@ERROR 
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -205
	GOTO ERRO
END


------------------------------------------------------------------------------
-- Atualizo a condição de fechamento do PO

EXEC sp_PO_CalcTotalQty @IDPO
	
SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -206
	GOTO ERRO
END


OK:
	COMMIT TRAN
	RETURN 0
ERRO:
	ROLLBACK TRAN

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PO_Item_Do', @ErrorLevelStr

	RETURN @ErrorLevel
GO
