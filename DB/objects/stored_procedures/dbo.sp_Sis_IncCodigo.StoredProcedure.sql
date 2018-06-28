SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
ALTER PROCEDURE [dbo].[sp_Sis_IncCodigo]
		(
		@Tabela			varchar(35),
		@TabelaParticao 	varchar(35)=Null,
		@PrefixoParticao	varchar(35)=Null,
		@Coluna			varchar(35),
		@IDUsuario		int,
		@NovoCodigo		int = 0 output
		)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Incrementa a tabela de controle de Codigos
		e retorna o valor

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em UPDATE	Sis_CodigoIncremental
		-202  Erro em INSERT Sis_CodigoIncremental


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
	27 June 2001		Davi Gouveia		Log de Return Values
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */


DECLARE @ValorColuna	varchar(200)
DECLARE @TabelaNome  	varchar(200)
DECLARE @ErrorLevel	int

SET @ErrorLevel = 0

UPDATE
	Sis_CodigoIncremental
SET
	UltimoCodigo = UltimoCodigo + 1,
	@NovoCodigo = UltimoCodigo
WHERE
	Tabela = @Tabela

IF @@ERROR <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END

IF NOT EXISTS(SELECT UltimoCodigo FROM Sis_CodigoIncremental WHERE Tabela = @Tabela)
BEGIN
	SELECT @NovoCodigo = 1

	INSERT
		Sis_CodigoIncremental
			(
			Tabela,
			IDUsuario,
			Data,
			UltimoCodigo
			)
		VALUES	(
			@Tabela,
			@IDUsuario,
			GetDate(),
			@NovoCodigo
			)

	IF @@ERROR <> 0
	BEGIN
		SET @ErrorLevel = -202
		GOTO ERRO
	END
END


OK:
	RETURN 0
ERRO:
	PRINT CAST(@ErrorLevel AS VARCHAR)
	RETURN @ErrorLevel
GO
