SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[sp_CashRegister_Open]
		(
		@IDCashRegister 	int,
		@IDUser		int,
		@Bill100		int,
		@Bill50			int,
		@Bill20 			int,
		@Bill10 			int,
		@Bill5 			int,
		@Bill2 			int,
		@Bill1 			int,
		@Coin1 		int,
		@Coin050 		int,
		@Coin025 		int,
		@Coin010 		int,
		@Coin005 		int,
		@Coin001 		int,
		@OpenMoney		money,
		@TotalCash		money,
		@TotalCard		money,
		@TotalCardPre		money,
		@TotalCheck		money,
		@TotalOther 		money,
		@TotalDebit 		money,
 		@Date			Datetime,
		@FinalCount		money,
		@COO			int,
		@GNF			int,
		@IDCashRegLog	int output,
		@IDCashRegMov	int output
		)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Insere linha no cashregmov
		- Insere no CashRegLog

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Insere linha no cashregmov
		-202  Erro em Insere no CashRegLog
		-203  Erro em Insere no CashRegLogComplement

	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May 2000		Rodrigo Costa		Criacao;
        22 Jun 2001            	Davi Gouveia            Log de Return Values
  	21 Oct	2003		Rodrigo Costa		Chamada a sp_Sis_GetNextCode para @IDCashRegLog, @IDCashRegMov; 
							Removido SELECT @IDCashRegMov = @@IDENTITY;
							Removido SELECT @IDCashRegLog = @@IDENTITY;
	18 Aug	2004		Rodrigo Costa		Gravar error log
	28 Oct	2006		Rodrigo Costa		Criacao do parametro Debit
	24 Aug	2009		Rodrigo Costa		Inserir Campos COO e GNF no Complement
  -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */


DECLARE @ErrorLevel 	INT
DECLARE @SysError	INT

SET @ErrorLevel = 0


/*	Insere linha no cashregmov	*/

BEGIN TRANSACTION

EXEC sp_Sis_GetNextCode 'CashRegMov.IDCashRegMov', @IDCashRegMov OUTPUT
INSERT
	CashRegMov
	(
	IDCashRegMov,
	IDCashRegister,
	OpenTime,
	IDOpenUser,
	IDCashRegStatus,
 	OpenDeposit
	)
	VALUES
	(
	@IDCashRegMov,
	@IDCashRegister,
	@Date,
	@IDUser,
	1,
	@OpenMoney
	)

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
	TotalDebit
	)
	VALUES
	(
	@IDCashRegLog,
	@IDCashRegMov,
	1,
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
	@TotalDebit
	)

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -202
	GOTO ERRO
END

IF (@COO <> 0) OR (@GNF <> 0)
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
		0,
		'Abertura de caixa',
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
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_CashRegister_Open', @ErrorLevelStr

	RETURN @ErrorLevel
GO
