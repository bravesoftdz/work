SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
ALTER PROCEDURE [dbo].[sp_Fin_ContaCorrenteAjusta]
	(
	@IDContaCorrente	int,
	@Valor			TValor,
	@Data			DateTime,
	@IDUsuario		int
	)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Inclui um ajuste de conta corrente
                fazendo uma quitacao de ajuste

		- Ajusta a data do ajuste, para que fique na ultima hora do dia
		Para isto somo um dia e subtraio um minuto


	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Inclui a Quitacao
		-202  Erro em sp_Sis_GetNextCode 'Fin_Quitacao.IDQuitacao', @IDQuitacao


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Rodrigo Costa		Criacao;
	25 June 2001		Davi Gouveia		Log de Return Values
 	21 Oct	2003		Rodrigo Costa		Chamada a sp_Sis_GetNextCode para @IDQuitacao; 
							Removido SELECT @IDQuitacao = @@Identity;
	18 Aug 2004		Rodrigo Costa		Gravar error log
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

BEGIN TRAN


SELECT @Data = DateAdd(minute, -1, DateAdd(day, 1, @Data))
DECLARE @IDLancamento	int
DECLARE @IDQuitacao		int
DECLARE @ErrorLevel 		int
DECLARE @SysError		int

SET @ErrorLevel = 0

-- Inclui a Quitacao
EXEC sp_Sis_GetNextCode 'Fin_Quitacao.IDQuitacao', @IDQuitacao OUTPUT

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -202
	GOTO ERRO
END

IF @Valor > 0
BEGIN
	INSERT Fin_Quitacao
		(
		IDQuitacao,
		Pagando,
		IDContaCorrente,
		IDUsuarioQuitacao,
		ValorQuitacao,
		ValorJuros,
		DataQuitacao,
		IDQuitacaoMeio
		)
	VALUES
		(
		@IDQuitacao,
		0,
		@IDContaCorrente,
		@IDUsuario,
		@Valor,
		0,
		@Data,
		12
		)
END
ELSE
BEGIN
	INSERT Fin_Quitacao
		(
		IDQuitacao,
		Pagando,
		IDContaCorrente,
		IDUsuarioQuitacao,
		ValorQuitacao,
		ValorJuros,
		DataQuitacao,
		IDQuitacaoMeio
		)
	VALUES
		(
		@IDQuitacao,
		1,
		@IDContaCorrente,
		@IDUsuario,
		@Valor * -1,
		0,
		@Data,
		12 -- Ajuste de Saldo de Conta Corrente
		)
END

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END


OK:
	COMMIT TRAN
	RETURN 0
ERRO:
	ROLLBACK TRAN

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'OfficeManager', 'Error: sp_Fin_ContaCorrenteAjusta', @ErrorLevelStr

	RETURN @ErrorLevel
GO
