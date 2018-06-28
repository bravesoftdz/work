if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PO_CalcTotalQty]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PO_CalcTotalQty]
GO

CREATE PROCEDURE sp_PO_CalcTotalQty
		(
		@IDPO     		int
		)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Atualizacao do PO

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro no Update


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	11 Mar 2005		Rodrigo Costa		Criação;
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

DECLARE @ErrorLevel	int
DECLARE @SysError	int
DECLARE @Counted	int
DECLARE @Records	int
DECLARE @Aberto	bit

SET @ErrorLevel = 0

--Retorno as quantidades
SELECT
	@Counted = COUNT(IDPreInventoryMov)
FROM
	PreInventoryMov PIM
WHERE
	PIM.InventMovTypeID = 2
	AND
	PIM.DocumentID = @IDPO
	AND
	PIM.Qty > PIM.QtyRealMov

--Contar as linhas de itens do PO
SELECT
	@Records = COUNT(IDPreInventoryMov)
FROM
	PreInventoryMov PIM
WHERE
	PIM.InventMovTypeID = 2
	AND
	PIM.DocumentID = @IDPO

--
IF ((@Records>0) AND (@Counted=0))
	SET @Aberto = 0
ELSE
	SET @Aberto = 1

--Atualizo PO
UPDATE
	PO
SET
	PO.Aberto = @Aberto
FROM
	PO
WHERE
	PO.IDPO = @IDPO

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
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PO_CalcTotalQty', @ErrorLevelStr

	RETURN @ErrorLevel
GO
