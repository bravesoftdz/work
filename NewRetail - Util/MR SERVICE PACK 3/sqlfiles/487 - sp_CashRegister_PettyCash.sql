if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_CashRegister_PettyCash]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_CashRegister_PettyCash]
GO

CREATE PROCEDURE sp_CashRegister_PettyCash
		(
		@IDCashRegMov		int,
		@IDUser			int,
		@TotalCash		money,
		@Date			Datetime,
		@OBS			varchar(255),
		@IDCashRegLog   	int output
		)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Update Total Cash no CashRegMov
		- Insere no CashRegLog

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Update Total Cash no CashRegMov
		-202  Erro em Insere no CashRegLog


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Rodrigo Costa		Criacao;
	22 June 2001            Davi Gouveia           	Log de Return Values
	21 Oct	2003		Rodrigo Costa		Chamada a sp_Sis_GetNextCode para @IDCashRegLog; 
							Removido SELECT @IDCashRegLog = @@IDENTITY;
	18 Aug 2004		Rodrigo Costa		Gravar error log
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */


DECLARE @ErrorLevel 	INT
DECLARE @SysError	INT

SET @ErrorLevel = 0

/*	Update Total Cash no CashRegMov    */

BEGIN TRANSACTION

UPDATE
	CashRegMov 
SET 
	TotalPetty    = TotalPetty + @TotalCash
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
	6,
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

IF @OBS IS NOT NULL
BEGIN
	INSERT INTO
		CashRegLogComplement
	(
		IDCashRegLog,
		OBS
	)
	VALUES
			(
		@IDCashRegLog,
		@OBS
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
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_CashRegister_PettyCash', @ErrorLevelStr

	RETURN @ErrorLevel

GO
