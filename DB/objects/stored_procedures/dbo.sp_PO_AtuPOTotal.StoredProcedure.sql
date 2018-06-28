SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_PO_AtuPOTotal]
		(
		@IDPO     		int
		)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Cancelando

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro no Update


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	04 dezembro 2000	Eduardo Costa		Criação;
	26 June 2001		Davi Gouveia		Log de Return Values
	18 Aug 2004		Rodrigo Costa		Gravar error log
	22 Nov 2005		Carlos Lima		Atualizar o custo corretamente  para recebimento maior que o esperado
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

DECLARE @ErrorLevel	int
DECLARE @SysError	int

SET @ErrorLevel = 0

UPDATE
	PO
SET
	PO.SubTotal = IsNull(
		(
		SELECT
			SUM
			(
				CASE 
					WHEN PIM.Qty >= 0 THEN
						CASE 
							WHEN PIM.Qty >= PIM.QtyRealMov THEN
								(PIM.Qty - PIM.QtyRealMov) * PIM.CostPrice
							ELSE
								(PIM.Qty) * PIM.CostPrice
					END

					ELSE
						(PIM.Qty - PIM.QtyRealMov) * PIM.CostPrice
				END
			)
		FROM
			PreInventoryMov PIM (NOLOCK) 
			JOIN Model M (NOLOCK) ON (PIM.ModelID = M.IDModel) 
		WHERE
			PIM.InventMovTypeID = 2      -- Compra
			AND
			PIM.DocumentID = @IDPO
			AND
			M.ModelType IN ('R', 'S')
		),0)
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
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PO_AtuPOTotal', @ErrorLevelStr

	RETURN @ErrorLevel
GO
