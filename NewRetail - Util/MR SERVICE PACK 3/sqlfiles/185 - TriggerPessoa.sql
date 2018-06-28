if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tr_Pessoa_All]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[tr_Pessoa_All]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Pessoa_GetPessoaRoot]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Pessoa_GetPessoaRoot]
GO

CREATE PROCEDURE sp_Pessoa_GetPessoaRoot
		(
			@IDTipoPessoa 	int,
			@IDPessoa		int,
			@Code			int output,
			@IDTipoPessoaRoot 	int output
		)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Atualiza os proximo TipoPessoaRoot

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro no UpdateTipo Pessoa
		-202  Erro no Select


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	22 Mac  2005		Rodrigo Costa		Criacao;
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

DECLARE @ErrorLevel	int
DECLARE @SysError	int

SET @ErrorLevel = 0

SELECT
	@Code = (IsNull(TP.LastCode, 0) + 1),
	@IDTipoPessoaRoot = Tp.IDTipoPessoa
FROM
	TipoPessoa TP1
	JOIN
	TipoPessoa TP ON ( CASE SUBSTRING(TP1.Path, 1, 4)
		WHEN '.003' THEN SUBSTRING(TP1.Path, 1, 8)
		ELSE SUBSTRING(TP1.Path, 1, 4)
		END = TP.Path )
WHERE
	TP1.IDTipoPessoa = @IDTipoPessoa

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END

UPDATE
	TipoPessoa
SET
	LastCode = IsNull(LastCode, 0) + 1
FROM	(
	SELECT	CASE SUBSTRING(TP.Path, 1, 4)
		WHEN '.003' THEN SUBSTRING(TP.Path, 1, 8)
		ELSE SUBSTRING(TP.Path, 1, 4)
		END Path
	FROM
		Pessoa I JOIN TipoPessoa TP ON (I.IDTipoPessoa = TP.IDTipoPessoa)
	WHERE
		I.IDPessoa = @IDPessoa
	) A
WHERE
	A.Path = TipoPessoa.Path

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
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_Pessoa_GetPessoaRoot', @ErrorLevelStr

	RETURN @ErrorLevel
GO
