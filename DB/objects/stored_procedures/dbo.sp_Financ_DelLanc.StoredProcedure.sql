SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_Financ_DelLanc]
		(
		@IDLancamento	int
		)

AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Deleto Lancamento/Quitacao
		- Deleto Quitacao
		- Deleto Lancamento

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Delete from InventoryMov
		-202  Erro em Insert InventoryMov Send to Vendor
		-203  Erro em Insert InvMov Back From Vendor


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	16 Nov  1999		Eduardo Costa		Criacao;
	26 May  2000		Eduardo Costa		suporte ao novo financeiro
	25 June 2001		Davi Gouveia		Log de Return Values
	18 Aug 2004		Rodrigo Costa		Gravar error log
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */


DECLARE @ErrorLevel 	int
DECLARE @SysError	int

SET @ErrorLevel = 0

BEGIN TRAN


SELECT
	LQ.IDQuitacao
INTO
	#QuitacaoToDelete
FROM
	Fin_LancQuit LQ (NOLOCK)
WHERE
	LQ.IDLancamento = @IDLancamento

-- Deleto Lancamento/Quitacao
DELETE
	Fin_LancQuit
WHERE
	IDLancamento = @IDLancamento

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END

-- Deleto Quitacao
DELETE
	Q
FROM
	Fin_Quitacao (NOLOCK)
	JOIN
	#QuitacaoToDelete QTD ON (Q.IDQuitacao = QTD.IDQuitacao)

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -202
	GOTO ERRO
END

-- Deleto Lancamento
DELETE
	Fin_Lancamento
WHERE
	IDLancamento=@IDLancamento

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -203
	GOTO ERRO
END

DROP TABLE 	#QuitacaoToDelete


OK:
	COMMIT TRAN
	RETURN 0
ERRO:
	ROLLBACK TRAN
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'OfficeManager', 'Error: sp_Financ_DelLanc', @ErrorLevelStr

	RETURN @ErrorLevel
GO
