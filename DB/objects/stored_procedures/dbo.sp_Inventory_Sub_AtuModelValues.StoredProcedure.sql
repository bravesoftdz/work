SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_Inventory_Sub_AtuModelValues]
	(
	@IDModelMaster	int
	)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		Atualiza todos os sub models de uma grade a partir da seguinte formula

		Model = Model + ColorCode + SizeCode
		Description = Description + Color + Size


	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro no Update

	LOG DE MODIFICAÇÕES

		Data			Programador		Modificação
		--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
		15 Agosto 2005		Rodrigo Costa		Criação;
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

DECLARE @ColorSeparator  	VarChar(10)
DECLARE @SizeSeparator  	VarChar(10)
DECLARE @Trailing  		VarChar(10)
DECLARE @ErrorLevel 		int
DECLARE @SysError		int

SET @ColorSeparator = '-'
SET @SizeSeparator = '-'
SET @Trailing = '...'


UPDATE
	M
SET
	M.LastCost = MM.LastCost,
	M.DateLastCost = MM.DateLastCost,
	M.VendorCost = MM.VendorCost,
	M.OtherCost = MM.OtherCost,
	M.FreightCost = MM.FreightCost,
	M.MarkUp = MM.MarkUp,
	M.DateLastSellingPrice = MM.DateLastSellingPrice,
	M.SellingPrice = MM.SellingPrice,
	M.SuggRetail = M.SuggRetail
FROM
	Model MM (NOLOCK)
	JOIN 
	Model M (NOLOCK) ON (M.IDModelParent = MM.IDModel)
	LEFT OUTER JOIN 
	InvColor C (NOLOCK) ON (M.IDColor = C.IDColor)
	LEFT OUTER JOIN 
	InvSize S (NOLOCK) ON (M.IDSize = S.IDSize)
WHERE
	MM.IDModel = @IDModelMaster

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
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_Inventory_Sub_AtuModelValues', @ErrorLevelStr

	RETURN @ErrorLevel
GO
