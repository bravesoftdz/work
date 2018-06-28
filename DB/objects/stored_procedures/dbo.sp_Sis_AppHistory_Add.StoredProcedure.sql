SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_Sis_AppHistory_Add]
		(
		@IDUsuario	int,
		@ErrorLevel 	int,
		@SystemError	int,
		@Software	varchar(20),
		@FormSource	varchar(255),
		@ErrorMessage	varchar(8000)
		)
AS 
/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Insere no AppHistory

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Inserir Sis_AppHistory


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	18 August 2004		Rodrigo Costa		Criação;
	26 Dec 	  2008		Rodrigo Costa		Remover Transacao;
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

DECLARE @IDHistory 		int
DECLARE @HistoryDate		DateTime
DECLARE @SysTextError 	varchar(255)

SET @HistoryDate = GetDate()

------------------------------------------------------------------------------
-- Insere no AppHistory

IF @SystemError <> 0
BEGIN
	SELECT  
		@SysTextError = description 
	FROM 
		Master..SysMessages
	WHERE 
		Error = @SystemError

	SET @ErrorMessage = @ErrorMessage + CHAR(13) + ' --------------- ' + CHAR(13) + @SysTextError
END

EXEC sp_Sis_GetNextCode'Sis_AppHistory.IDHistory', @IDHistory OUTPUT

INSERT Sis_AppHistory (IDHistory, ErrorLevel, FormSource, ErrorMessage, IDUsuario, Software, HistoryDate)
VALUES (@IDHistory, @ErrorLevel, @FormSource, @ErrorMessage, @IDUsuario, @Software, @HistoryDate)

IF @@ERROR <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END


OK:
	RETURN 0
ERRO:
	RETURN @ErrorLevel
GO
