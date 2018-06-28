SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_CashRegister_SubClose]
		(
		@IDCashRegMov   	int,
		@IDUser		int,
		@IDUsuario		int,
		@TotalCash		money,
		@TotalCard		money,
		@TotalCardPre		money,
		@TotalCheck		money,
		@TotalOther 		money,
		@TotalDebit 		money,
		@FinalCount		money,
		@LogDocument		varchar(20),
		@Date			Datetime,
		@IDCashRegLog	int  output
		)
AS


/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO
		
		- Testa se o final deposit ja foi feito
		- Update Final Deposit no CashRegMov
		- Insere no CashRegLog
		- Executa sp_CashRegister_Quita_Lancamento


	TABELA DE ERROS PARA RETURN_VALUE
	
		 000  Ok
		-001  Se deposito final ja foi feito
		-201  Erro em Update Final Deposit no CashRegMov
		-202  Erro em Insere no CashRegLog
		-203  Erro em Executa sp_CashRegister_Quita_Lancamento


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	21 Oct 2000		Carlos Lima		Criacao;
	28 Oct 2006		Rodrigo Costa		Novo parametro TotalDebit
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */


DECLARE @ErrorLevel 	int
DECLARE @SysError 	INT

SET @ErrorLevel = 0

/* Testa se o final deposit ja foi feito */
if EXISTS (SELECT IDCashRegLog FROM CashRegLog (NOLOCK) WHERE IDCashRegMov = @IDCashRegMov AND IDCashRegTipoLog = 4) 
   RETURN -1


/*	Update Final Deposit no CashRegMov    */
BEGIN TRANSACTION 

UPDATE
	CashRegMov 
SET	
	FinalWidraw      		= @TotalCash + @TotalCard + @TotalCardPre + @TotalCheck + @TotalOther + @TotalDebit,
	FinalCount     		= @FinalCount,   	
	IDCashRegStatus  	= 2 
WHERE 
	IDCashRegMov = @IDCashRegMov

PRINT 'Update Final Deposit no CashRegMov'

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END

/*	Insere no CashRegLog            */
/******************************************************************************
	Obtenho o @IDCashRegLog
*******************************************************************************/

EXEC sp_Sis_GetNextCode 'CashRegLog.IDCashRegLog', @IDCashRegLog OUTPUT
INSERT CashRegLog
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
	4,
	@Date,
	@IDUser,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
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

EXEC sp_CashRegister_Quita_Lancamento @IDUser, @Date, @IDCashRegMov

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -203
	GOTO ERRO
END

OK:	
	COMMIT TRANSACTION 
	RETURN 0


ERRO:
	ROLLBACK
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_CashRegister_SubClose', @ErrorLevelStr

	RETURN @ErrorLevel
GO
