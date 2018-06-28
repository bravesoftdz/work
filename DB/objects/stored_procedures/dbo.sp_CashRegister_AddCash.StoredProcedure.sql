SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[sp_CashRegister_AddCash]
		(
		@IDCashRegMov		int,
		@IDUser			int,
		@TotalCash		money,
		@Date			Datetime,
		@IDReason		int,
		@OBS			varchar(255),
		@COO			int,
		@GNF			int,
		@IDCashRegLog   	int output
		)
AS

/* ---------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Update Total Cash no CashRegMov
		- Insere no CashRegLog

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Update Total Cash no CashRegMov
		-202  Erro em Insere no CashRegLog


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	-----------------------	-----------------------	----------------------------------------------------------------------------------
	23 Mar	2007		Rodrigo Costa		Criacao;
	24 Aug	2009		Rodrigo Costa		Inserir Campos COO e GNF no Complement
	---------------------------------------------------------------------------------------------------------------------------------- */


DECLARE @ErrorLevel 	INT
DECLARE @SysError	INT

SET @ErrorLevel = 0

/*	Update Total Cash no CashRegMov    */

BEGIN TRANSACTION

UPDATE
	CashRegMov 
SET 
	TotalDeposit = TotalDeposit + @TotalCash
WHERE
	IDCashRegMov = @IDCashRegMov

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
        SET @ErrorLevel = -201
        GOTO ERRO
END;

/*	Insere no CashRegLog            */

exec sp_Sis_GetNextCode 'CashRegLog.IDCashRegLog', @IDCashRegLog OUTPUT
INSERT CashRegLog
	(
	IDCashRegLog,
	IDCashRegMov,
	IDCashRegTipoLog,
	LogTime,
	IDUser,
	TotalCash
	)
	VALUES
	(
	@IDCashRegLog,
	@IDCashRegMov,
	3,
	@Date,
	@IDUser, 
	@TotalCash
	)

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
        SET @ErrorLevel = -202
        GOTO ERRO
END;

IF (@OBS IS NOT NULL) OR (@IDReason <> 0) OR (@COO <> 0) OR (@GNF <> 0)
BEGIN
	INSERT INTO
		CashRegLogComplement
	(
		IDCashRegLog,
		IDCashRegLogReason,
		OBS,
		COO,
		GNF
	)
	VALUES
			(
		@IDCashRegLog,
		@IDReason,
		ISNULL(@OBS, ''),
		@COO,
		@GNF
	)

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		SET @ErrorLevel = -203
		GOTO ERRO
	END
END


OK:
        COMMIT TRANSACTION
        RETURN 0

ERRO:
	ROLLBACK
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_CashRegister_AddCash', @ErrorLevelStr

	RETURN @ErrorLevel
GO
