SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
ALTER PROCEDURE [dbo].[sp_Commission_ChangeGuide]
	(
	@IDGuiaOrigem  int,
	@IDGuiaDestino int
	)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Movo os recebimentos
		- Movo os touristgroups

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-202  Erro em Movo os touristgroups


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	26 May  2000		Eduardo Costa		suporte ao novo financeiro
	22 June 2001		Davi Gouveia		Log de Return Values
	06 July  2001		Rodrigo Costa		Nao transfere os recebimentos da Agencia - Fin_Lancamento
	18 Aug 2004		Rodrigo Costa		Gravar error log
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */


DECLARE @ErrorLevel 	INT
DECLARE @SysError	INT

SET @ErrorLevel = 0

-- Movo os touristgroups
UPDATE
	Touristgroup
SET
	IDGuide = @IDGuiaDestino
WHERE
	IDGuide = @IDGuiaOrigem
	AND
	IDLancPagGuia IS NULL

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
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_Commission_ChangeGuide', @ErrorLevelStr

	RETURN @ErrorLevel
GO
