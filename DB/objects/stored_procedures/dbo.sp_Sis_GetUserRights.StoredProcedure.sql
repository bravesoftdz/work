SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_Sis_GetUserRights]
	(
	@IDUsuario 	int,
	@IDMenuItem 	int,
	@Rights	varchar(255)	output
	)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Le os direitos que o usuario tem sobre o menuitem
		e os retorna em uma string separada por ponto e virgula

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro na Criacao do CURSOR
		-202  Erro no FETCH dado para o CURSOR


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
	26 June 2001		Davi Gouveia		Log de Return Values
	18 Aug 2004		Rodrigo Costa		Gravar error log
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */


DECLARE @IDOperacao	int
DECLARE @ErrorLevel		int
DECLARE @SysError		int

SET @ErrorLevel = 0

DECLARE Operacoes CURSOR FOR
	(
	SELECT 	IDOperacao
	FROM	((
		Sis_Grupo G (NOLOCK) 
		JOIN Sis_GrupoMainMenuOperacao GMMO (NOLOCK) ON (G.IDGrupo = GMMO.IDGrupo))
		JOIN Sis_UsuarioGrupo GU (NOLOCK) ON (GU.IDGrupo = G.IDGrupo))
	WHERE   IDMenuItem = @IDMenuItem
		AND
		IDUsuario = @IDUsuario
	GROUP BY IDOperacao
	HAVING  SUM(Convert(int, GMMO.Permissao)) > 0
	)  

	SET @SysError = @@ERROR
	IF @SysError <> 0 
	BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
	END 

SELECT @Rights = ''

OPEN Operacoes
FETCH NEXT FROM Operacoes INTO @IDOperacao
WHILE (@@FETCH_STATUS = 0)
BEGIN
	-- Inclui a operacao
	SELECT @Rights = @Rights + RTrim(Convert(char(20), @IDOperacao)) + ';'
	-- Proximo Operacao
	FETCH NEXT FROM Operacoes INTO @IDOperacao
END

CLOSE Operacoes
DEALLOCATE Operacoes

SET @SysError = @@ERROR
IF @SysError <> 0 
BEGIN
	SET @ErrorLevel = -202
	GOTO ERRO
END


OK:
	RETURN 0
ERRO:
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_Sis_GetUserRights', @ErrorLevelStr

	RETURN @ErrorLevel
GO
