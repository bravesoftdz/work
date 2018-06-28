SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[sp_CashRegister_Widraw]
		(
		@IDCashRegMov		int,
		@IDUser			int,
		@Bill100		int,
		@Bill50			int,
		@Bill20	 		int,
		@Bill10			int,
		@Bill5 			int,
		@Bill2 			int,
		@Bill1 			int,
		@Coin1			int,
		@Coin050 		int,
		@Coin025 		int,
		@Coin010 		int,
		@Coin005 		int,
		@Coin001 		int,
		@TotalCash		money,
		@TotalCard		money,
		@TotalCardPre		money,
		@TotalCheck		money,
		@TotalOther		money,
		@TotalDebit		money,
		@LogDocument		varchar(20),
		@Date			DateTime,
		@OBS			varchar(255),
		@IDReason		int,
		@COO			int,
		@GNF			int,
		@IDCashRegLog   	int output
		)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Update Total Widraw no CashRegMov
		- Insere no CashRegLog
		- Inserir OBS

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Update Total Widraw no CashRegMov
		-202  Erro em Insere no CashRegLog
		-203  Erro em Inserir OBS


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Rodrigo Costa		Criacao;
	22 June 2001		Davi Gouveia		Log de Return Values
 	21 Oct	2003		Rodrigo Costa		Chamada a sp_Sis_GetNextCode para @IDCashRegLog; 
							Removido SELECT @IDCashRegLog = @@IDENTITY;
	18 Aug 	2004		Rodrigo Costa		Gravar error log
	26 Jun	2006		Carlos Lima		Inserir OBS
	28 Oct	2006		Rodrigo Costa		Novo parametro de Total Debito
	20 Jun	2008		Rodrigo	Costa 		Preenchimento do campo de motivo na tabela CashRegLogComplement
	24 Aug	2009		Rodrigo Costa		Inserir Campos COO e GNF no Complement
   -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

DECLARE @ErrorLevel 			int
DECLARE @SysError			int

SET @ErrorLevel = 0

/*	Update Total Widraw no CashRegMov    */

BEGIN TRANSACTION


UPDATE
	CashRegMov
SET
	TotalWidraw    = TotalWidraw + @TotalCash + @TotalOther + @TotalCheck + @TotalCard + @TotalDebit
WHERE
	IDCashRegMov = @IDCashRegMov

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END

/*	Insere no CashRegLog            */
EXEC sp_Sis_GetNextCode 'CashRegLog.IDCashRegLog', @IDCashRegLog OUTPUT
INSERT	
	CashRegLog
	(
	IDCashRegLog,
	IDCashRegMov,
	IDCashRegTipoLog,
	LogTime,
	IDUser,
	Bill100,
	Bill50,
	Bill20,
	Bill10,
	Bill5,
	Bill2,
	Bill1,
	Coin1,
	Coin050,
	Coin025,
	Coin010,
	Coin005,
	Coin001,
	TotalCash,
	TotalCard,
	TotalCardPre,
	TotalCheck,
	TotalOther,
	TotalDebit,
	LogDocument
	)
	VALUES
	(
	@IDCashRegLog,
	@IDCashRegMov,
	2,
	@Date,
	@IDUser,
 	@Bill100,
	@Bill50,
	@Bill20,
 	@Bill10,
	@Bill5,
	@Bill2,
	@Bill1,
	@Coin1,
	@Coin050,
	@Coin025,
	@Coin010,
	@Coin005,
	@Coin001,
	@TotalCash,
	@TotalCard,
	@TotalCardPre,
	@TotalCheck,
	@TotalOther,
	@TotalDebit,
	@LogDocument
	)

	

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -202
	GOTO ERRO
END

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
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_CashRegister_Widraw', @ErrorLevelStr

	RETURN @ErrorLevel
GO
