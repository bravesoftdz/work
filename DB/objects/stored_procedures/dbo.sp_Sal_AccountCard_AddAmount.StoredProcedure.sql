SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_Sal_AccountCard_AddAmount]
			(
				@CardNumber		varchar(20),
				@Amount		money,
				@IDPreSale		int,
				@IDLancamento	int,
				@IDUser		int,
				@Credit			bit,
				@OBS			varchar(100)
			)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Inseriro a linha de credito
		- Atualizo o total

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Inserir o credito
		-202  Erro em Atualizar o total


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	23 Mar  2006		Rodrigo Costa		Criacao;
	29 Jun	2006		Rodrigo Costa		Retirado a transacao, tem que ser feita no Delphi
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */
 
DECLARE @ErrorLevel		int 
DECLARE @SysError		int
DECLARE @IDAccountCardMov	int
DECLARE @IDAccountCard	int
DECLARE @ExpDateMonth	int

SET @ErrorLevel = 0 

SET @ExpDateMonth = (SELECT Convert(int, SrvValue) FROM Param Where IDParam = 86)

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -203
	GOTO ERRO
END


/*--------------------------------------------------------------*/
/*	Ler o ID do account        */
/*--------------------------------------------------------------*/
SELECT
	@IDAccountCard = A.IDAccountCard
FROM
	Sal_AccountCard A (NOLOCK) 
WHERE
	A.CardNumber = @CardNumber


/*--------------------------------------------------------------*/
/*	Insere o credito        */
/*--------------------------------------------------------------*/

EXEC sp_Sis_GetNextCode 'Sal_AccountCardMov.IDAccountCardMov', @IDAccountCardMov OUTPUT

INSERT
	Sal_AccountCardMov
	(
	IDAccountCardMov,
	DateMov,
	Value,
	Credit,
	IDPreSale,
	IDLancamento,
	IDUser,
	IDAccountCard,
	Obs
	)
VALUES
	(
	@IDAccountCardMov,
	GetDate(),
	@Amount,
	@Credit,
	@IDPreSale,
	@IDLancamento,
	@IDUser,
	@IDAccountCard,
	@OBS
	)

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END

/*--------------------------------------------------------------*/
/*		Atualiza o total	        */
/*--------------------------------------------------------------*/
IF @Credit = 0
	SET @Amount = @Amount * -1

UPDATE
	Sal_AccountCard
SET
	Amount = Amount + @Amount
WHERE
	IDAccountCard = @IDAccountCard


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
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_Sal_AccountCard_AddAmount', @ErrorLevelStr
	RETURN @ErrorLevel
GO
