if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_CashRegister_AddCash]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_CashRegister_AddCash]
GO

CREATE  PROCEDURE sp_CashRegister_AddCash
		(
		@IDCashRegMov		int,
		@IDUser			int,
		@TotalCash		money,
		@Date			Datetime,
		@IDReason		int,
		@OBS			varchar(255),
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

IF (@OBS IS NOT NULL) OR (@IDReason <> 0)
BEGIN
	INSERT INTO
		CashRegLogComplement
	(
		IDCashRegLog,
		IDCashRegLogReason,
		OBS
	)
	VALUES
			(
		@IDCashRegLog,
		@IDReason,
		ISNULL(@OBS, '')
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
