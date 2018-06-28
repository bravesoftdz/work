if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Fin_Transferencia_Do]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Fin_Transferencia_Do]
GO

CREATE  PROCEDURE sp_Fin_Transferencia_Do
	(
	@IDTransferencia	int
	)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Deleto todas as quitacoes
		- Incluo de novo o debito
		- Incluo de novo o credito

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Deleto todas as quitacoes
		-202  Erro em Incluo de novo o debito
		-203  Erro em Incluo de novo o credito


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
	25 June 2001		Davi Gouveia		Log de Return Values
	19 Oct 2001		Rodrigo Costa		Colocado o IDTransferencia no insert da Fin_Quitacao
	27 Oct	2003		André Bogado		Chamada a sp_Sis_GetNextCode
							Declaraçao do cursor Fin_Quitacao_Cursor
	18 Aug 2004		Rodrigo Costa		Gravar error log
	24 Jun 2010		Rodrigo Costa		Gravar Observacao
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */


DECLARE @ErrorLevel 	int
DECLARE @SysError	int

SET @ErrorLevel = 0

-- Primeiro deleto todas as quitacoes
DELETE
	Q
FROM
	Fin_Quitacao Q
WHERE
	Q.IDTransferencia = @IDTransferencia

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END

--Declaração de variáveis para o Cursor de Fin_Quitacao
DECLARE @IDQuitacao		int 
DECLARE @IDQuitacaoMeio 	int 
DECLARE @DataQuitacao 	smalldatetime 
DECLARE @IDContaCorrenteDebito 	int 
DECLARE @IDContaCorrenteCredito	int
DECLARE @IDUsuarioQuitacao 	int 
DECLARE @ValorQuitacao 	money 
DECLARE @ValorJuros 		money 
DECLARE @NumeroMeioQuit 	varchar(20)
DECLARE @OBS			varchar(100)

--Declaração do Cursor de Fin_Quitacao

DECLARE Fin_Quitacao_Cursor CURSOR FOR

SELECT
		-1, -- Meio de pag de transferencia
		T.Data,
		T.IDContaCorrenteDebito,
		T.IDContaCorrenteCredito,
		T.IDUsuario,
		T.Valor,
		0,
		CONVERT(Varchar(20), T.IDTransferencia),
		T.IDTransferencia,
		SUBSTRING(OBS, 1, 100)
	FROM
		Fin_Transferencia T (NOLOCK)
	WHERE
		T.IDTransferencia = @IDTransferencia
OPEN Fin_Quitacao_Cursor

--Inicialização de Fin_Quitacao_Cursor
FETCH NEXT FROM Fin_Quitacao_Cursor INTO
	@IDQuitacaoMeio,
	@DataQuitacao,
	@IDContaCorrenteDebito,
	@IDContaCorrenteCredito,
	@IDUsuarioQuitacao,
	@ValorQuitacao,
	@ValorJuros,
	@NumeroMeioQuit,
	@IDTransferencia,
	@OBS
--Enquanto tem registros
WHILE @@FETCH_STATUS = 0
BEGIN
-- Agora Incluo de novo o debito
	EXEC sp_Sis_GetNextCode 'Fin_Quitacao.IDQuitacao', @IDQuitacao OUTPUT
	INSERT Fin_Quitacao
		(
		IDQuitacao,
		IDQuitacaoMeio,
		DataQuitacao,
		IDContaCorrente,
		IDUsuarioQuitacao,
		Pagando,
		ValorQuitacao,
		ValorJuros,
		NumeroMeioQuit,
		IDTransferencia,
		String
		)
	VALUES 
		(
		@IDQuitacao,
		@IDQuitacaoMeio,
		@DataQuitacao,
		@IDContaCorrenteDebito,
		@IDUsuarioQuitacao,
		1, --@Pagando 
		@ValorQuitacao,
		@ValorJuros,
		@NumeroMeioQuit,
		@IDTransferencia,
		@OBS
		)

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		CLOSE Fin_Quitacao_Cursor
		DEALLOCATE Fin_Quitacao_Cursor
		SET @ErrorLevel = -202
		GOTO ERRO
	END

-- Agora Incluo de novo o credito
	EXEC sp_Sis_GetNextCode 'Fin_Quitacao.IDQuitacao', @IDQuitacao OUTPUT
	INSERT Fin_Quitacao
		(
		IDQuitacao,
		IDQuitacaoMeio,
		DataQuitacao,
		IDContaCorrente,
		IDUsuarioQuitacao,
		Pagando,
		ValorQuitacao,
		ValorJuros,
		NumeroMeioQuit,
		IDTransferencia,
		String
		)
	VALUES 
		(
		@IDQuitacao,
		@IDQuitacaoMeio,
		@DataQuitacao,
		@IDContaCorrenteCredito,
		@IDUsuarioQuitacao,
		0, --@Pagando 
		@ValorQuitacao,
		@ValorJuros,
		@NumeroMeioQuit,
		@IDTransferencia,
		@OBS
		)

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		CLOSE Fin_Quitacao_Cursor
		DEALLOCATE Fin_Quitacao_Cursor
		SET @ErrorLevel = -203
		GOTO ERRO
	END

	FETCH NEXT FROM Fin_Quitacao_Cursor INTO
		@IDQuitacaoMeio,
		@DataQuitacao,
		@IDContaCorrenteDebito,
		@IDContaCorrenteCredito,
		@IDUsuarioQuitacao,
		@ValorQuitacao,
		@ValorJuros,
		@NumeroMeioQuit,
		@IDTransferencia,
		@OBS
END
--fechamento do cursor
CLOSE Fin_Quitacao_Cursor
--Destruição do cursor
DEALLOCATE Fin_Quitacao_Cursor

OK:
	RETURN 0

ERRO:
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'OfficeManager', 'Error: sp_Fin_Transferencia_Do', @ErrorLevelStr

	RETURN @ErrorLevel
GO
