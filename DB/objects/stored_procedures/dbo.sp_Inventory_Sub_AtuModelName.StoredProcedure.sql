SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_Inventory_Sub_AtuModelName]
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
		29 novembro 2000	Eduardo Costa		Criação;
		25 June 2001		Davi Gouveia		Log de Return Values
		18 Aug 2004		Rodrigo Costa		Gravar error log
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
	M.Model =
		CASE WHEN Len(MM.[Model] + IsNull(@ColorSeparator + C.CodColor, '') + IsNull(@SizeSeparator + S.CodSize, '')) <= 30 THEN
			MM.Model + IsNull(@ColorSeparator + C.CodColor, '') + IsNull(@SizeSeparator + S.CodSize, '')
		ELSE
			Left(M.Model, 30 - Len(@Trailing + IsNull(@ColorSeparator + C.CodColor, '') + IsNull(@SizeSeparator + S.CodSize, '')))  + @Trailing + IsNull(@ColorSeparator + C.CodColor, '') + IsNull(@SizeSeparator + S.CodSize, '')
		END,
	M.[Description] =
		CASE WHEN Len(MM.[Description] + IsNull(@ColorSeparator + C.Color, '') + IsNull(@SizeSeparator + S.SizeName, '')) <= 50 THEN
			MM.[Description] + IsNull(@ColorSeparator + C.Color, '') + IsNull(@SizeSeparator + S.SizeName, '')
		ELSE
			Left(MM.[Description], 50 - Len(@Trailing + IsNull(@ColorSeparator + C.Color, '') + IsNull(@SizeSeparator + S.SizeName, '')))  + @Trailing + IsNull(@ColorSeparator + C.Color, '') + IsNull(@SizeSeparator + S.SizeName, '')
		END,
	M.GroupID = MM.GroupID,
	M.IDFabricante = MM.IDFabricante,
	M.IDModelGroup = MM.IDModelGroup,
	M.IDModelSubGroup = MM.IDModelSubGroup,
	M.IDUnidade = MM.IDUnidade
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
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_Inventory_Sub_AtuModelName', @ErrorLevelStr

	RETURN @ErrorLevel
GO
