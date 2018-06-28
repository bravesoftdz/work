if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_CashRegister_AddCash]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_CashRegister_AddCash]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_CashRegister_Open]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_CashRegister_Open]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_CashRegister_PettyCash]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_CashRegister_PettyCash]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_CashRegister_Widraw]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_CashRegister_Widraw]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_AddItem]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_AddItem]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_CreateHold]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_CreateHold]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_Pay]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_Pay]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_Remove]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_Remove]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_SubAddItem]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_SubAddItem]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_CancelInvoice]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_CancelInvoice]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_UnPay]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_UnPay]
GO


CREATE   PROCEDURE sp_CashRegister_AddCash
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

CREATE   PROCEDURE sp_CashRegister_Open
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

CREATE  PROCEDURE sp_CashRegister_PettyCash
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
	15 May	2000		Rodrigo Costa		Criacao;
	22 Jun	2001            Davi Gouveia           	Log de Return Values
	21 Oct	2003		Rodrigo Costa		Chamada a sp_Sis_GetNextCode para @IDCashRegLog; 
							Removido SELECT @IDCashRegLog = @@IDENTITY;
	18 Aug	2004		Rodrigo Costa		Gravar error log;
	29 Jan	2007		Maximiliano Muniz	Preenchimento do campo de motivo na tabela CashRegLogComplement
	12 Fev	2007		Rodrigo Costa		Alterado IsNULL no OBS para nao dar error the constraint
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
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_CashRegister_PettyCash', @ErrorLevelStr

	RETURN @ErrorLevel

GO

CREATE   PROCEDURE sp_CashRegister_Widraw
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

CREATE  PROCEDURE sp_PreSale_AddItem
	(
	@PreSaleID     		int,
	@IDCliente		int,
	@ModelID     		int,
	@StoreID     		int,
	@UserID      		int,
	@IDComission		int,
	@Qty         		float,
	@SalePrice      	money,
	@CostPrice		money,
	@Discount    		money,
	@MovDate     		smalldatetime,
	@ResetDiscount  	bit = 0,
	@Manager		bit = 0,
	@Date			DateTime,
	@IDPreInvMovExchange	int,
	@PreInvMovParentID	int,
	@IDDepartment		int,
	@Promo			bit = 0,
	@IDDescriptionPrice	int,
	@IDVendorPrice		int,
	@SuggPrice		int,
	@DocumentNumber		varchar(20),
	@IDDocumentType		int,
	@SequencyNum		int = 0,
	@TotParcial		varchar(10) = NULL,
	@PreInventMovID  	int Output
	)
AS

/* ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 	SUMARIO

		- Testa se o discount total ainda e valido
		- Inclui a movimentaçao

	TABELA DE ERROS PARA RETURN_VALUE

		@Result Ok
		-201  Erro em exec @Result = sp_PreSale_SubTestDiscount
		-202  Erro em exec sp_PreSale_SubResetDiscount
		-203  Erro em exec @Result = sp_PreSale_SubAddItem
		-204  Erro em exec sp_PreSale_SubCalcTotal

	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	-----------------------	-----------------------	-----------------------------------------------------------------
	15 May	2000		Eduardo Costa		Criacao;
	26 Jun	2001		Davi Gouveia		Log de Return Values;
	18 Aug	2004		Rodrigo Costa		Gravar error log;
	01 Fev	2005		Rodrigo Costa		Novo campo @IDPreInvMovExchange;
	12 Apr  2006		Leonardo Riego		Novo campo @IDDepartment;
	16 Jun	2006		Rodrigo Costa		Adicionado os parametros para ErrorHistory;
	20 Jul	2007		Maximiliano Muniz	Novos parâmetros @IDDescriptionPrice, @IDVendorPrice e @SuggPrice;
	08 Aug	2007		Maximiliano Muniz	Novos parâmetros @DocumentNumber e @IDDocumentType;
	24 Aug	2009		Rodrigo Costa		Criacao dos parametros SeqNum e TotParcial para o PAF-ECF
	----------------------------------------------------------------------------------------------------------------- */
 
DECLARE @Result		int
DECLARE @Value		money
DECLARE @ErrorLevel	int 
DECLARE @SysError	int

SET @ErrorLevel = 0 

/*------------------------------------------------------------------------------*/
/*                Testa se o discount total ainda e valido                      */
/*------------------------------------------------------------------------------*/ 

SELECT @Value = IsNUll((@SalePrice * @Qty),0)

IF @Manager = 0 BEGIN
	EXEC @Result = sp_PreSale_SubTestDiscount 	@PreSaleID,
							@ModelID,
							@UserID,
							@Discount,
							@Value,
							'I',
							1

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		SET @ErrorLevel = -201
		GOTO ERRO
	END

	IF @ResetDiscount = 1 and @Result <> 0
	BEGIN
		EXEC sp_PreSale_SubResetDiscount	@PreSaleID
	END
	ELSE
	BEGIN
		IF @Result <> 0
		BEGIN
			RETURN @Result
		END
	END

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		SET @ErrorLevel = -202
		GOTO ERRO
	END
END

/*------------------------------------------------------------------------------*/
/*	        	         Inclui a movimentaçao                          */
/*------------------------------------------------------------------------------*/

BEGIN TRAN

EXEC @Result = sp_PreSale_SubAddItem
					@PreSaleID,
					@IDCliente,
					@ModelID,
					@StoreID,
					@UserID,
					@IDComission,
					@Qty,
					@SalePrice,
					@CostPrice,
					@Discount,
					@MovDate,
					@IDPreInvMovExchange,
					@PreInvMovParentID,
					@IDDepartment,
					@Promo,
					@IDDescriptionPrice,
					@IDVendorPrice,
					@SuggPrice,
					@DocumentNumber,
					@IDDocumentType,
					@SequencyNum,
					@TotParcial,
					@PreInventMovID	Output

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -203
	GOTO ERRO
END

if @Result <> 0
	rollback tran
else
	exec sp_PreSale_SubCalcTotal @PreSaleID, @Date

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -204
	GOTO ERRO
END


OK:
	COMMIT TRAN
	RETURN 0
ERRO:
	ROLLBACK TRAN
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(510)
	DECLARE @Params varchar(500)	
	SET @Params = ' [ @IDCliente = ' + CAST(@IDCliente AS VARCHAR) + ' @ModelID = ' + CAST(@ModelID AS VARCHAR) +  
			' @StoreID = ' + CAST(@StoreID AS VARCHAR) + ' @UserID = '  + CAST(@UserID AS VARCHAR) + 
			' @IDComission = '  + CAST(@IDComission AS VARCHAR) + ' @Qty = '  + CAST(@Qty AS VARCHAR) +
			' @IDPreInvMovExchange = '  + CAST(@IDPreInvMovExchange AS VARCHAR) + 
			' @IDDepartment = '  + CAST(@IDDepartment AS VARCHAR) +  ' ] '
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR) + @Params
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PreSale_AddItem', @ErrorLevelStr

	RETURN @ErrorLevel

GO

CREATE  PROCEDURE sp_PreSale_CreateHold
	(
	@IDCustomer 		int, 
	@IDTouristGroup 	int, 
	@PreSaleDate 		smalldatetime, 
	@MediaID		int, 
	@DeliverTypeID 		int, 
	@IDOtherCommission 	int, 
	@FirstName		varchar(20), 
	@LastName		varchar(20), 
	@Layaway		bit, 
	@IDStore		int, 
	@Zip			varchar(20),
	@Note			varchar(150), 
	@PrintNotes		bit,
	@CustomerDOC		varchar(20) = null,
	@IDPreSale		int output
	) 
AS

DECLARE @SaleCode	varchar(20)

DECLARE @ErrorLevel  	int
DECLARE @SysError  	int


/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO
		- Gero um novo número de Pedido
		- Crio um novo Invoice

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Gero um novo número de Pedido
		-202  Erro em Crio um novo Invoice


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	03 Nov  2000		Carlos Lima		Criacao;
	09 May	2005		Rodrigo Costa		Retirado o criar SaleCode
	16 Jun	2006		Rodrigo Costa		Adicionado os parametros para ErrorHistory
	19 Aug	2009		Rodrigo Costa		Adiconar o CPF/CGC do cliente ns nota
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

SET @ErrorLevel = 0
 
BEGIN TRAN

EXEC sp_Sis_GetNextCode 'Invoice.IDPresale', @IDPreSale output

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO 
END

INSERT Invoice 
	(
	IDPreSale, 
	IDCustomer, 
	IDTouristGroup, 
	PreSaleDate, 
	MediaID, 
	DeliverTypeID, 
	OtherComissionID, 
	FirstName, 
	LastName, 
	Layaway, 
	IDStore, 
	Zip, 
	Note, 
	PrintNotes,
	CompanyCGC
	) 
VALUES 
	(
	@IDPreSale, 
	@IDCustomer, 
	@IDTouristGroup, 
	@PreSaleDate, 
	@MediaID, 
	@DeliverTypeID, 
	@IDOtherCommission, 
	@FirstName, 
	@LastName, 
	@Layaway, 
	@IDStore, 
	@Zip, 
	@Note, 
	@PrintNotes,
	@CustomerDOC
	)

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -202
	GOTO ERRO 
END



OK:
	COMMIT TRAN
	RETURN 0
ERRO:
	ROLLBACK TRAN
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(510)
	DECLARE @Params varchar(500)	
	SET @Params = ' [ @IDCustomer = ' + CAST(@IDCustomer AS VARCHAR) + 
			' @IDTouristGroup = ' + CAST(@IDTouristGroup AS VARCHAR) +  
			' @MediaID = ' + CAST(@MediaID AS VARCHAR) + 
			' @DeliverTypeID = '  + CAST(@DeliverTypeID AS VARCHAR) + 
			' @IDOtherCommission = '  + CAST(@IDOtherCommission AS VARCHAR) + 
			' @IDStore = '  + CAST(@IDStore AS VARCHAR) + ' ] '
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR) + @Params


	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PreSale_CreateHold', @ErrorLevelStr
 
	RETURN @ErrorLevel

GO

CREATE   PROCEDURE sp_PreSale_Pay
			(
			@PreSaleID		int,
			@IDCashRegMov		int,
			@PayDate 		smalldatetime,
			@IDStore		int,
			@IDTouristGroup 	int,
			@OtherComID 		int,
			@CashReceived   	money,
			@Date			Datetime,
			@BonusBucks		money,
			@InvoiceCode		varchar(20) = null,
			@IDInvoice 		int output
			)
AS

/* ---------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO
	- Transforma a PreSale em Sale
	- Move os PreInventMov para o InventMov
	- Insert Encargos de Venda na tabela de Taxas InventoryMovTax
	- Insert Impostos de Venda na tabela de Taxas InventoryMovTax
	- Move os PreSerialMov para o SerialMov
	- Deleta os seriais do Inventario
	- Deleta Pre Inventory Movement
	- Marca os lancamentos como confimados, e troca o documento
	- Update Cash RegisterMovent
	- Atualiza o custo medio dos modelos
	- Calc commissions for report performace

	TABELA DE ERROS PARA RETURN_VALUE

	 000  Ok
	-201  Erro ao gerar novo IDInvoice
	-202  Erro ao transformar Hold em Invoice
	-203  Erro movendo os PreInventMov para o InventMov
	-204  Erro movendo os PreSerialMov para o SerialMov
	-205  Erro ao deletar/inserir os Seriais do Inventario
	-206  Erro ao deletar o PreSerialMov
	-207  Erro ao deletar o PreInventoryMov
	-208  Erro ao inserir as linhas de quitacao
	-209  Erro as inserir as linhas de ligação entre lancamento e quitacao
	-210  Erro ao atualizar o NumDocumento nas parcelas do Invoice
	-212  Erro ao Atualizar as comissões
	-213  Erro ao mover Model Pack de PreInvMov para InvMov
	-214  Erro ao Impostos
	-216  Erro ao Colocar PreInventMovParent para Null
	-217  Erro ao atualizar SaleItemCommission
	-218  Erro ao inserir em Sal_AccountCard
	-219  Erro ao Inserir em Repair
	-220  Erro ao Inserir em Sal_RebateDiscount
	-221  Erro nos totais de Invoice com os Lacamentos
	-222  Erro ao atualizar Inv_MovPrice
	-223  Erro ao inserir Price
	-224  Erro ao atualizar Inv_MovDocument
	-225  Erro ao inserir Inv_MovComplement

	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	-----------------------	-----------------------	----------------------------------------------------------------------------------
	26 May	2000		Eduardo Costa		Alteração para suporte as novas tabelas do financeiro;
	27 May	2000   		Eduardo Costa		Criação da rotina de tratamento e retorno de erros;
	14 Aug	2000   		Eduardo Costa		A quitação dos lancamentos do invoice foi transferida
							para o close da caixa registradora;
	15 Aug	2000		Rodrigo Costa		Novo campo SalesTax para calcular a tax;
	26 Jun	2001		Davi Gouveia		Log de Return Values;
	29 Jun	2001		Rodrigo Costa		Alteracao no delete Serial do Inventory, criado um join com a tbl PreSerialMov;
	29 Oct	2003		Rodrigo Costa		Criado sp_Sis_GetNextCode para Invoice; Cursor InventoryMov;
							Deletado INSERT InvoiceGen (BitGen) VALUES (1), SELECT @IDInvoice = @@IDENTITY; 
							Criado Cursor para InvMov;
	18 Dec	2003		Andre Bogado		Alteração no cursor de InvMov para atualizar InventoryMovTax;
	22 Dec	2003		Rodrigo Costa		Incluir os Serias no Inventory se for Refound;
	25 May	2004		Rodrigo Costa		Mover PackModels do PreInvMov para o InvMov;
	18 Aug	2004		Rodrigo Costa		Gravar error log;
	20 Set	2004		Rodrigo Costa		Correcao do Calculo de InventoryMovTax (IM.SalePrice-IM.Discount);
	07 Dez	2004		Rodrigo Costa		Novo calculo das taxas;
	01 Fev	2005		Rodrigo Costa		Mover as QtyExchanged de Pre para Inv;
	25 Fev	2005		Rodrigo Costa		Quando finalizar o Invoice nao pode atualizar o IDStore;
	29 Mar	2005		Rodrigo Costa		Atualiza o custo medio dos modelos; gravar o custo medio na venda;
	11 Apr	2005		Rodrigo Costa		Inclusao do campo DesiredMarkup no PreInv e InventoryMov;
	17 May	2005		Rodrigo Costa		Cursor para alterar PreInvMovParent;
	01 Jul	2005		Rodrigo Costa		Gerar numero sequencial para Items de Servico;
	28 Nov	2005		Leonardo Riego		Atualiza SaleItemCommission;
	11 Jan	2006		Rodrigo Costa		Remover zerar o custo medio;
	23 Mar	2006		Carlos Lima		Suporte ao Gift Card ( Chamada para a procedure que inclui em Sal_AccountCard );
	03 Apr	2006		Rodrigo Costa		Inserir em Repair;
	29 Jun	2006		Rodrigo Costa		Retirado a transacao, tem que ser feita no Delphi;
	09 Aug	2006		Leonardo Riego		Adicionado a coluna de promo na PreInventory para InventoryMov;
	07 Nov	2006		Maximiliano Muniz	Inserção na tabela Sal_RebateDiscount;
	16 Nov	2006		Maximiliano Muniz	Mudança do campo IDPreSale para IDPreSaleCreated e inclusão do campo
							IDPreSaleUsed, na tabela Sal_RebateDiscount;
	23 Nov	2006		Maximiliano Muniz	Mudança na inserção da tabela Sal_RebateDiscount, para gravar os novos
							campos (ValidFromDate, ExpirationDate)
	28 Nov	2006		Rodrigo Costa		Verificacao do total do invoice com os totais do pagamento;
	11 Jan	2007		Maximiliano Muniz	Retirada a gravação em Sis_AppHistory;
	26 Fev	2007		Rodrigo Costa		Calcular imposto estabelecido no PreInvMov
	03 Apr	2007		Maximiliano Muniz	Alterado o join da query que insere os impostos;
	11 Apr	2007		Maximiliano Muniz	Adicionado ao cálculo do total da nota, o novo campo de desconto;
	19 Jul	2007		Maximiliano Muniz	Atualização do campo IDInventoryMov na tabela Inv_MovPrice;
							Inserção de um novo registro na Fin_Lancamento com o valor nominal igual a diferênça
							entre o valor vendido e o valor sugerido pelo fornecedor, na tabela Inv_MovPrice;
	09 Aug	2007		Maximiliano Muniz	Atualização do campo IDInventoryMov na tabela Inv_MovDocument;
							Preenchimento do campo "IdentificationNumber" na tabela "SerialMov";
	19 Aug	2009		Rodrigo Costa		Passar o InvoiceCode como parametro 
	24 Aug	2009		Rodrigo Costa		Gravar o SeqNum e TotParcial na inventoryMovComplement
	---------------------------------------------------------------------------------------------------------------------------------- */

DECLARE @DataPagamento  	smalldatetime
DECLARE @ComissionPayed 	money
DECLARE @IDCentroCusto		int
DECLARE @ErrorLevel		int
DECLARE @SysError		int
DECLARE @ServiceField		varchar(30)
DECLARE @BonusMinSaleValue	money
DECLARE @DaysToUseBonusBucks	int
DECLARE @ExpireDaysBonusBucks	int
--Declaração de variáveis para o Cursor de InventoryMov
DECLARE @InventMovTypeID	int
DECLARE @DocumentID		int
DECLARE @IDPessoa		int
DECLARE @ModelID		int
DECLARE @BarCodeID		char(20)
DECLARE @MovDate		smalldatetime
DECLARE @Qty 			float
DECLARE @CostPrice		money
DECLARE @SalePrice		money
DECLARE @Discount		money
DECLARE @PreInventoryMovID	int
DECLARE @IDUser			int
DECLARE @SalesTax		money
DECLARE @StoreID		int
DECLARE @IDInventoryMov		int
DECLARE @IDParentPack		int
DECLARE @QtyExchanged		float
DECLARE @IDPreInvMovExchange	int
DECLARE @AvgCost		money
DECLARE @DesiredMarkup		money
DECLARE @IsService		bit
DECLARE @AutoCreateSrvNum	bit
DECLARE @IDGroup		int
DECLARE @CardNumber		varchar(20)
DECLARE @GiftValue		money
DECLARE @IDDepartment		int
DECLARE @Promo			bit
DECLARE @TotalPaid		money
DECLARE @TotalInvoice		money
DECLARE @IDTaxCategory		int
DECLARE @SequencyNum		int
DECLARE @TotParcial		varchar(10)

--Declaração de variáveis para Price
DECLARE @GeneratePrice		int
DECLARE @IDEmpresa		int
DECLARE @IDContaCorrente	int
DECLARE @IDLancamento		int
DECLARE @IDLancamentoTipo	int
DECLARE @IDDocumentoTipo	int
DECLARE @IDPagamentoTipo	int
DECLARE @DiasVencimento		int
DECLARE @IDVendorPrice		int
DECLARE @IDVendorType		int
DECLARE @SuggPrice		money

SET @ErrorLevel = 0

SET @SysError = @@ERROR
IF @SysError <> 0 GOTO ERRO


-- Pego o parâmetro de PRICE
SELECT @GeneratePrice = CASE WHEN UPPER(SrvValue) = 'TRUE' THEN 1 ELSE 0 END FROM Param (NOLOCK) WHERE IDParam = 97

/*--------------------------------------------------------------------------------------------------------*/
/*		Valida as formas de pagamento								*/
/*--------------------------------------------------------------------------------------------------------*/

SELECT
	@TotalPaid = SUM(IsNull(ValorNominal, 0))
FROM
	Fin_Lancamento (NOLOCK)
WHERE
	IDPreSale =  @PreSaleID

SELECT
	@TotalInvoice = ((((IsNull(SubTotal,0) - IsNull(InvoiceDiscount, 0) - IsNull(TaxIsemptItemDiscount,0)) - IsNull(ItemDiscount,0)) + IsNull(Tax,0)) + IsNull(AditionalExpenses,0))
FROM
	Invoice (NOLOCK)
WHERE
	IDPreSale =  @PreSaleID

PRINT 'TotalPaid = ' + cast(@TotalPaid as varchar)
PRINT 'TotalInvoice = ' + cast(@TotalInvoice as varchar)

SET @SysError = @@ERROR
IF (@SysError <> 0) OR (@TotalPaid <> @TotalInvoice)
BEGIN
	SET @ErrorLevel = -221
	GOTO ERRO
END


/*--------------------------------------------------------------------------------------------------------*/
/*		Transforma a PreSale em Sale    		  	*/
/*--------------------------------------------------------------------------------------------------------*/

-- Calcula o proximo IDInvoice
EXEC sp_Sis_GetNextCode 'InvoiceGen.IDInvoice', @IDInvoice OUTPUT

IF (@InvoiceCode IS Null)
	EXEC SP_PreSale_GetNewInvoiceCode @IDStore, @InvoiceCode OUTPUT

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END

 -- Transforma o hold em invoice
UPDATE Invoice
SET		Invoice.IDInvoice    	= @IDInvoice,
		Invoice.InvoiceDate  	= @PayDate,
		Invoice.CashReceived 	= @CashReceived,
		Invoice.CashRegMovID 	= @IDCashRegMov,
		Invoice.InvoiceCode	= @InvoiceCode

WHERE 	Invoice.IDPreSale = @PreSaleID

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -202
	GOTO ERRO
END


/*--------------------------------------------------------------------------------------------------------*/
/*	     Move os PreInventMov para o InventMov                      */
/*------------------------------------------------------------------------------------------------------*/
--Declaração do Cursor de InventoryMov

DECLARE InventoryMov_Cursor CURSOR FOR

	SELECT	PIM.InventMovTypeID,
			@IDInvoice,
			PIM.IDPessoa,
			PIM.StoreID,
			PIM.ModelID,
			PIM.BarCodeID,
			@PayDate,
			PIM.Qty,
			PIM.CostPrice,
			PIM.SalePrice,
			PIM.Discount,
			PIM.IDPreInventoryMov,
			PIM.UserID,
			IsNull((CASE WHEN (TC.SpecialDateStart <= @Date) AND (TC.SpecialDateEnd >= @Date) AND ( ISNULL((( ISNULL(PIM.SalePrice, 0) - ISNULL(PIM.Discount, 0)) / PIM.Qty), 0) < ISNULL(TC.MaxItemValue, 0))
				 THEN TC.SpecialTax ELSE TC.Tax END / 100.00),0)  as Tax,-- Tax
			PIM.IDParentPack,
			PIM.QtyExchanged,
			PIM.IDPreInvMovExchange,
			M.AvgCost,
			TG.DesiredMarkup,
			TG.ServiceAutoNumber,
			TG.Service,
			TG.IDGroup,
			PIM.IDDepartment,
			PIM.Promo,
			PIM.IDTaxCategory,
			SequencyNum,
			TotParcial
	FROM		
			dbo.PreInventoryMov PIM (NOLOCK)
			JOIN Model M (NOLOCK) ON ( PIM.ModelID = M.IDModel )
			JOIN TabGroup TG (NOLOCK) ON ( M.GroupID = TG.IDGroup )
			JOIN StoreToTabGroup STC (NOLOCK) ON ( STC.IDStore = PIM.StoreID AND STC.IDGroup = TG.IDGroup )
			LEFT JOIN TaxCategory TC (NOLOCK) ON ( TC.IDTaxCategory = STC.IDTaxCategory AND TC.IDTaxCategory = IsNull(PIM.IDTaxCategory, STC.IDTaxCategory))

	WHERE   	PIM.DocumentID = @PreSaleID
			AND
			PIM.InventMovTypeID = 1

OPEN InventoryMov_Cursor

--Inicialização de InventoryMov_Cursor
FETCH NEXT FROM InventoryMov_Cursor INTO
	@InventMovTypeID,
	@DocumentID,
	@IDPessoa,
	@StoreID,
	@ModelID,
	@BarCodeID,
	@MovDate,
	@Qty,
	@CostPrice,
	@SalePrice,
	@Discount,
	@PreInventoryMovID,
	@IDUser,
	@SalesTax,
	@IDParentPack,
	@QtyExchanged,
	@IDPreInvMovExchange,
	@AvgCost,
	@DesiredMarkup,
	@AutoCreateSrvNum,
	@IsService,
	@IDGroup,
	@IDDepartment,
	@Promo,
	@IDTaxCategory,
	@SequencyNum,
	@TotParcial
--Enquanto tem registros
WHILE
@@FETCH_STATUS = 0
BEGIN

	IF @SequencyNum IS NULL
	BEGIN
		IF (@AutoCreateSrvNum = 1 AND @IsService = 1  )
		BEGIN
			SET @ServiceField = 'TabGroup.Service'+CAST(@IDGroup as Varchar(10))
			EXEC sp_Sis_GetNextCode @ServiceField, @SequencyNum OUTPUT
		END
	END

	EXEC sp_Sis_GetNextCode 'InventoryMov.IDInventoryMov', @IDInventoryMov OUTPUT


	INSERT InventoryMov
		(
		IDInventoryMov,
		InventMovTypeID,
		DocumentID,
		IDPessoa,
		StoreID,
		ModelID,
		BarCodeID,
		MovDate,
		Qty,
		CostPrice,
		SalePrice,
		Discount,
		PreInventoryMovID,
		IDUser,
		SalesTax,
		IDParentPack,
		QtyExchanged,
		IDPreInvMovExchange,
		AvgCost,
		DesiredMarkup,
		SequencyNum,
		IDDepartment,
		Promo
		)
	VALUES
		(
		@IDInventoryMov,
		@InventMovTypeID,
		@DocumentID,
		@IDPessoa,
		@StoreID,
		@ModelID,
		@BarCodeID,
		@MovDate,
		@Qty,
		@CostPrice,
		@SalePrice,
		@Discount,
		@PreInventoryMovID,
		@IDUser,
		@SalesTax,
		@IDParentPack,
		@QtyExchanged,
		@IDPreInvMovExchange,
		@AvgCost,
		@DesiredMarkup,
		@SequencyNum,
		@IDDepartment,
		@Promo
		)

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		CLOSE InventoryMov_Cursor
		DEALLOCATE InventoryMov_Cursor
		SET @ErrorLevel = -203
		GOTO ERRO
	END

	-- Atualiza SaleItemCommission
	UPDATE SaleItemCommission
	SET
	 	IDPreInventoryMov = NULL,
		IDInventoryMov = @IDInventoryMov
	WHERE
		IDPreInventoryMov = @PreInventoryMovID
	
	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		CLOSE InventoryMov_Cursor
		DEALLOCATE InventoryMov_Cursor
		SET @ErrorLevel = -217
		GOTO ERRO
	END

	-- Insert Encargos de Venda na tabela de Taxas InventoryMovTax
	INSERT INTO InventoryMovTax 
		(
		IDInventoryMov, 
		IDTaxCategory, 
		Tax, 
		TaxValue 
		)
	SELECT 
		IM.IDInventoryMov,
		ISNULL (TCC.IDTaxCategory,0) AS IDTaxCategory,
		ISNULL (TCC.Tax,0)/100 AS Tax,
		ISNULL (((IM.SalePrice * IM.Qty) - IM.Discount) * TCC.Tax,0)/100 AS TaxValue

	FROM 	InventoryMov IM (NOLOCK)
		JOIN Model Mo (NOLOCK) ON (IM.ModelID = Mo.IDModel)
		JOIN StoreToTabGroup SG (NOLOCK) ON (SG.IDStore = IM.StoreID AND SG.IDGroup = Mo.GroupID )
		JOIN TaxCategory TCP (NOLOCK) ON (TCP.IDTaxCategory = IsNull(@IDTaxCategory, SG.IDTaxCategory))
		JOIN TaxCategory TCC (NOLOCK) ON (SG.IDTaxCategory = TCC.IDTaxCategoryParent)
	WHERE
	 	IM.IDInventoryMov = @IDInventoryMov

	-- Insert Impostos de Venda na tabela de Taxas InventoryMovTax
	INSERT INTO InventoryMovTax 
		(
		IDInventoryMov, 
		IDTaxCategory, 
		Tax, 
		TaxValue 
		)
	SELECT 
		IM.IDInventoryMov,
		ISNULL (TC.IDTaxCategory,0) AS IDTaxCategory,
		ISNULL (TC.Tax,0)/100 AS Tax,
		ISNULL (((IM.SalePrice * IM.Qty) - IM.Discount) * TC.Tax,0)/100 AS TaxValue

	FROM 	InventoryMov IM (NOLOCK)
		JOIN Model Mo (NOLOCK) ON (IM.ModelID = Mo.IDModel)
		JOIN StoreToTabGroup SG (NOLOCK) ON (SG.IDStore = IM.StoreID AND SG.IDGroup = Mo.GroupID )
		JOIN TaxCategory TC (NOLOCK) ON (SG.IDSaleTax = TC.IDTaxCategory)

	WHERE
	 	IM.IDInventoryMov = @IDInventoryMov

	-- Insert na Inventory Mov Complement os valores para o PAF-ECF
	IF @TotParcial IS NOT NULL
	BEGIN
	INSERT INTO Inv_MovComplement
		(
		IDInventoryMov,
		IDMovReason,
		TotalizadorParcial
		)
		VALUES
		(
		@IDInventoryMov,
		1,
		@TotParcial
		)

	END

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		CLOSE InventoryMov_Cursor
		DEALLOCATE InventoryMov_Cursor
		SET @ErrorLevel = -225
		GOTO ERRO
	END

	-- Atualiza Inv_MovPrice
	UPDATE Inv_MovPrice
	SET
	 	IDPreInventoryMov = NULL,
		IDInventoryMov = @IDInventoryMov
	WHERE
		IDPreInventoryMov = @PreInventoryMovID
	
	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		CLOSE InventoryMov_Cursor
		DEALLOCATE InventoryMov_Cursor
		SET @ErrorLevel = -222
		GOTO ERRO
	END

	IF @GeneratePrice = 1
	BEGIN
		-- Pego as informações de price
		SET @SuggPrice = @SalePrice

		SELECT
			@IDVendorPrice = IDVendor,
			@SuggPrice = SuggPrice
		FROM
			Inv_MovPrice (NOLOCK)
		WHERE
			IDInventoryMov = @IDInventoryMov
		
		-- Se o preço vendido foi inferior ao preço sugerido pelo fornecedor, insere o Price
		IF @SalePrice < @SuggPrice
		BEGIN
			-- Pega as constantes
			SELECT @IDLancamentoTipo = CAST(PropertyValue AS INT) FROM Sis_PropertyDomain (NOLOCK) WHERE Property = 'PriceRecordType'
			SELECT @IDDocumentoTipo = CAST(PropertyValue AS INT) FROM Sis_PropertyDomain (NOLOCK) WHERE Property = 'PriceDocumentType'
			SELECT @IDPagamentoTipo = CAST(PropertyValue AS INT) FROM Sis_PropertyDomain (NOLOCK) WHERE Property = 'PricePaymentType'
			SELECT @DiasVencimento = CAST(PropertyValue AS INT) FROM Sis_PropertyDomain (NOLOCK) WHERE Property = 'PriceDueDateDays'
			SELECT @IDVendorType = IDTipoPessoaRoot FROM Pessoa (NOLOCK) WHERE IDPessoa = @IDVendorPrice


			SELECT
				@IDCentroCusto = S.IDCentroCusto,
				@IDContaCorrente = MPS.IDContaCorrente,
				@IDEmpresa = S.IDEmpresa
			FROM
				Store S (NOLOCK)
				JOIN MeioPagToStore MPS (NOLOCK) ON (S.IDStore = MPS.IDStore)
			WHERE
				S.IDStore = @IDStore
				AND MPS.IDMeioPag = @IDPagamentoTipo

			EXEC sp_Sis_GetNextCode 'Fin_Lancamento.IDLancamento', @IDLancamento output

			INSERT INTO Fin_Lancamento (IDLancamento, IDPessoa, IDPessoaTipo, IDUsuarioLancamento, IDEmpresa, DataLancamento, DataVencimento,
			ValorNominal, Pagando, NumDocumento, IDCentroCusto, IDContaCorrentePrevista, IDQuitacaoMeioPrevisto, IDLancamentoTipo,
			IDDocumentoTipo, Situacao)
			VALUES (@IDLancamento, @IDVendorPrice, @IDVendorType, @IDUser, @IDEmpresa, @MovDate, DATEADD(DAY, @DiasVencimento, @MovDate),
			@SuggPrice - @SalePrice, 0, @InvoiceCode, @IDCentroCusto, @IDContaCorrente, @IDPagamentoTipo, @IDLancamentoTipo,
			@IDDocumentoTipo, 1)
		END

		SET @SysError = @@ERROR
		IF @SysError <> 0
		BEGIN
			CLOSE InventoryMov_Cursor
			DEALLOCATE InventoryMov_Cursor
			SET @ErrorLevel = -223
			GOTO ERRO
		END
	END

	-- Atualiza Inv_MovDocument
	UPDATE Inv_MovDocument
	SET
	 	IDPreInventoryMov = NULL,
		IDInventoryMov = @IDInventoryMov
	WHERE
		IDPreInventoryMov = @PreInventoryMovID
	
	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		CLOSE InventoryMov_Cursor
		DEALLOCATE InventoryMov_Cursor
		SET @ErrorLevel = -223
		GOTO ERRO
	END

	FETCH NEXT FROM InventoryMov_Cursor INTO
		@InventMovTypeID,
		@DocumentID,
		@IDPessoa,
		@StoreID,
		@ModelID,
		@BarCodeID,
		@MovDate,
		@Qty,
		@CostPrice,
		@SalePrice,
		@Discount,
		@PreInventoryMovID,
		@IDUser,
		@SalesTax,
		@IDParentPack,
		@QtyExchanged,
		@IDPreInvMovExchange,
		@AvgCost,
		@DesiredMarkup,
		@AutoCreateSrvNum,
		@IsService,
		@IDGroup,
		@IDDepartment,
		@Promo,
		@IDTaxCategory,
		@SequencyNum,
		@TotParcial
END
--fechamento do cursor
CLOSE InventoryMov_Cursor
--Destruição do cursor
DEALLOCATE InventoryMov_Cursor


SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -203
	GOTO ERRO
END


/*--------------------------------------------------------------------------------------------------------*/
/*	     Insere a movimentação de crédito na tabela de AccountCard                	*/
/*--------------------------------------------------------------------------------------------------------*/

EXEC sp_PreSale_ItemRepair @PreSaleID
SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -219
	GOTO ERRO
END


/*--------------------------------------------------------------------------------------------------------*/
/*	     Insere a movimentação de crédito na tabela de AccountCard                	*/
/*--------------------------------------------------------------------------------------------------------*/


DECLARE AccountMov_Cursor CURSOR FOR
	SELECT			
		PSM.SerialNumber,
		PIM.SalePrice - (PIM.Discount / PIM.Qty),
		PIM.UserID
	FROM		
		PreSerialMov PSM (NOLOCK)
		JOIN PreInventoryMov PIM (NOLOCK) ON (PSM.PreInventoryMovID = PIM.IDPreInventoryMov)
		JOIN Model M (NOLOCK) ON (PIM.ModelID = M.IDModel)
	WHERE 	
		PIM.DocumentID = @PreSaleID
		AND
		PIM.InventMovTypeID = 1
		AND
		M.ModelType = 'G'

OPEN AccountMov_Cursor

--Inicialização de PreInventoryMov_Cursor
FETCH NEXT FROM AccountMov_Cursor INTO @CardNumber, @GiftValue, @IDUser

WHILE @@FETCH_STATUS = 0
BEGIN

	EXEC sp_Sal_AccountCard_AddAmount @CardNumber, @GiftValue, @PreSaleID, NULL, @IDUser, 1, ''


	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		CLOSE AccountMov_Cursor
		DEALLOCATE AccountMov_Cursor
		SET @ErrorLevel = -218
		GOTO ERRO
	END

	FETCH NEXT FROM AccountMov_Cursor INTO @CardNumber, @GiftValue, @IDUser
END

CLOSE AccountMov_Cursor
DEALLOCATE AccountMov_Cursor


/*--------------------------------------------------------------------------------------------------------*/
/*	     Move os PreSerialMov para o SerialMov                	*/
/*--------------------------------------------------------------------------------------------------------*/
INSERT SerialMov (InventoryMovID, SerialNumber, IdentificationNumber)
	SELECT
		IM.IDInventoryMov,
		PSM.SerialNumber,
		PSM.IdentificationNumber
	FROM
		PreSerialMov PSM (NOLOCK)
		JOIN InventoryMov IM (NOLOCK) ON (PSM.PreInventoryMovID = IM.PreInventoryMovID)
	WHERE
		IM.DocumentID = @IDInvoice
		AND IM.InventMovTypeID = 1

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -204
	GOTO ERRO
END

/*--------------------------------------------------------------------------------------------------------*/
/*	       Deleta/Insert os seriais do Inventario			*/
/*--------------------------------------------------------------------------------------------------------*/

DELETE
	InventorySerial
FROM
	PreInventoryMov PIM (NOLOCK),
	PreSerialMov PSV (NOLOCK)
WHERE
	PIM.DocumentID = @PreSaleID
	AND PIM.InventMovTypeID = 1
	AND InventorySerial.ModelID = PIM.ModelID
	AND InventorySerial.StoreID = @IDStore
	AND InventorySerial.Serial = PSV.SerialNumber
	AND PIM.Qty > 0

--Refound
INSERT
	InventorySerial (StoreID, ModelID, Serial)
SELECT
	@IDStore,
	PIM.ModelID,	
	PSV.SerialNumber
FROM
	PreInventoryMov PIM (NOLOCK)
	JOIN PreSerialMov PSV (NOLOCK) ON (PIM. IDPreInventoryMov = PSV.PreInventoryMovID)
WHERE
	PIM.DocumentID = @PreSaleID
	AND PIM.InventMovTypeID = 1
	AND PIM.Qty < 0


SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -205
	GOTO ERRO
END

/*--------------------------------------------------------------------------------------------------------*/
/*	       Deleta PreSerial Movement			*/
/*--------------------------------------------------------------------------------------------------------*/

DELETE
	PreSerialMov
FROM
	PreInventoryMov PIM (NOLOCK)
WHERE
	PIM.DocumentID = @PreSaleID
	AND PIM.InventMovTypeID = 1

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -206
	GOTO ERRO
END

/*--------------------------------------------------------------------------------------------------------*/
/*	       Atualiza  os ModelsPack de InvMov			*/
/*--------------------------------------------------------------------------------------------------------*/

UPDATE 
	IMC 
SET 
	IMC.IDParentPack = IMP.IDInventoryMov
FROM 
	InventoryMov IMC (NOLOCK)
	JOIN InventoryMov IMP (NOLOCK) ON ( IMP.PreInventoryMovID = IMC.IDParentPack)
WHERE 
	IMC.DocumentID = @DocumentID
	AND IMC.InventMovTypeID = 1

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -213
	GOTO ERRO
END

/*--------------------------------------------------------------------------------------------------------*/
/*	       Deleta PreInventory Movement			*/
/*--------------------------------------------------------------------------------------------------------*/

UPDATE
	PreInventoryMov
SET
	IDPreInventoryMovParent = NULL
WHERE
	InventMovTypeID = 1
	AND IDPreInventoryMovParent IN (SELECT IDPreInventoryMov FROM PreInventoryMov WHERE InventMovTypeID = 1 AND DocumentID = @PreSaleID)

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	CLOSE PreInventoryMovDelParent_Cursor
	DEALLOCATE PreInventoryMovDelParent_Cursor
	SET @ErrorLevel = -216
	GOTO ERRO
END


/*--------------------------------------------------------------------------------------------------------*/
/*	       Deleta PreInventory Movement			*/
/*--------------------------------------------------------------------------------------------------------*/
DELETE 	
		PreInventoryMov
WHERE 	
		PreInventoryMov.DocumentID = @PreSaleID
		AND
		PreInventoryMov.InventMovTypeID = 1

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -207
	GOTO ERRO
END

/*----------------------------------------------------------------------------------------------*/
/*	Marca os lancamentos como confimados, e troca o documento				*/
/*----------------------------------------------------------------------------------------------*/

UPDATE
	Fin_Lancamento
SET
	NumDocumento = @InvoiceCode,
	DataEmissao = @PayDate,
	Previsao = 0
WHERE
	IDPreSale =  @PreSaleID

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -210
	GOTO ERRO
END

/*----------------------------------------------------------------------------------------------*/
/*		Insere o bonus bucks								*/
/*----------------------------------------------------------------------------------------------*/

IF (@BonusBucks > 0)
BEGIN
	SELECT @BonusMinSaleValue = CAST(PropertyValue as money)
	FROM Sis_PropertyDomain (NOLOCK)
	WHERE Property = 'BonusBuckMinSaleValue'
	
	IF (@TotalInvoice > @BonusMinSaleValue)
	BEGIN
		SELECT @DaysToUseBonusBucks = CAST(PropertyValue as int)
		FROM Sis_PropertyDomain (NOLOCK)
		WHERE Property = 'DaysToUseBonusBucks'
	
		SELECT @ExpireDaysBonusBucks = CAST(PropertyValue as int)
		FROM Sis_PropertyDomain (NOLOCK)
		WHERE Property = 'ExpireDaysBonusBucks'
	
		INSERT INTO Sal_RebateDiscount (IDPreSaleCreated, DiscountValue, ValidFromDate, ExpirationDate, IDPreSaleUsed)
		VALUES (@PreSaleID, @BonusBucks, dbo.fn_Sys_RemoveTime(DateAdd(Day, @DaysToUseBonusBucks, @PayDate)), DateAdd(Day, @DaysToUseBonusBucks + @ExpireDaysBonusBucks, @PayDate), NULL)
		
		SET @SysError = @@ERROR
		IF @SysError <> 0
		BEGIN
			SET @ErrorLevel = -220
			GOTO ERRO
		END
	END
END

OK:
	RETURN 0
ERRO:
	RETURN @ErrorLevel


GO

CREATE   PROCEDURE sp_PreSale_Remove
			(
				@PreSaleID	int,
				@IDUser		int
			)
AS

/* ---------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Deleto PreSerialMov
		- Remove InventoryMov
		- Deleta os pagamentos
		- Remove o Invoice

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Delecao do PreSerialMov
		-202  Erro em Remove the Inventory Mov
		-203  Erro em Remover os lancamentos
		-207  Erro em Remove the Invoice
		-208  Erro em Remove historico
		-208  Erro em Remove outros custos
		-209  Erro em Deletar Account Number
		-210  Erro em Deletar Item repair
		-211  Erro em Remove the Shipping
		-212  Erro no Update Sal_RebateDiscount
		-213  Erro em Remove Sal_AccountCardMov
		-214  Erro em Update Estimated
		-215  Erro em Remove InvoiceOBS
		-216  Erro em Remover Sal_PaymentCondition
		-217  Erro em Remover Sal_RemovedItem

	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	-----------------------	-----------------------	----------------------------------------------------------------------------------
	15 May	2000		Eduardo Costa		Criacao;
	26 Jun	2001		Davi Gouveia		Log de Return Values;
	19 Jul	2001		Davi Gouveia		Exclusao de testes se Hold está sendo usado, visto q o teste ja é feito no Delphi;
	18 Aug	2004		Rodrigo Costa		Gravar error log;
	25 Oct	2004		Rodrigo Costa		Deleta os Historicos dos pedidos;
	19 Jan	2005		Rodrigo Costa		Deleta os outros custos do pedido;
	22 Mar	2006		Rodrigo Costa		Deletar Account Number;
	03 Apr	2006		Rodrigo Costa		Deletar o Item Repair;
	14 Feb	2007		Maximiliano Muniz	Deletar da tabela Sal_InvoiceShipping;
	21 Mar	2007		Maic Nogueira		Update na tabela Sal_RebateDiscount para remover o vínculo com a tabela Invoice;
	23 Jul	2007		Maximiliano Muniz	Deleção nas tabelas Sal_AccountCardMov e InvoiceOBS, e update na Estimated;
	16 Jul	2008		Rodrigo Costa		Deleção na tabela de Sal_PaymentCondition;
	16 Aug	2009		Rodrigo Costa		Delecao da tabela Sal_RemovedItem
	---------------------------------------------------------------------------------------------------------------------------------- */

DECLARE @IsLayaway	bit
DECLARE @ErrorLevel	int 
DECLARE @SysError	int
DECLARE @IDPreInvMovOld	int
SET @ErrorLevel = 0

BEGIN TRAN

/*----------------------------------------------*/
/*	Deleta os Historicos dos pedidos	*/
/*----------------------------------------------*/
DELETE
	H
FROM
	History H (NOLOCK) 
WHERE
	H.IDPreSale = @PreSaleID

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -208
	GOTO ERRO
END

/*--------------------------------------*/
/*	Delecao do Account Number	*/
/*--------------------------------------*/
DELETE
	AC
FROM
	PreInventoryMov PIM (NOLOCK) 
	JOIN Sal_AccountCard AC (NOLOCK) ON (PIM.IDPreInventoryMov = AC.IDPreInventoryMov)
WHERE
	PIM.DocumentID = @PreSaleID
	AND
	PIM.InventMovTypeID = 1

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -209
	GOTO ERRO
END


/*--------------------------------------------------------------*/
/*		Delecao do Sal_ItemRepair	        */
/*--------------------------------------------------------------*/
DELETE
	IR
FROM
	PreInventoryMov PIM (NOLOCK) 
	JOIN Sal_ItemRepair IR (NOLOCK) ON (PIM.IDPreInventoryMov = IR.IDPreInventoryMov)
WHERE
	PIM.DocumentID = @PreSaleID
	AND
	PIM.InventMovTypeID = 1

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -210
	GOTO ERRO
END


/*--------------------------------------------------------------*/
/*	Delecao do PreSerialMov	        */
/*--------------------------------------------------------------*/
DELETE
	PSM
FROM
	PreInventoryMov PIM (NOLOCK) 
	JOIN PreSerialMov PSM (NOLOCK) ON (PSM.PreInventoryMovID = PIM.IDPreInventoryMov)
WHERE
	PIM.DocumentID = @PreSaleID
	AND
	PIM.InventMovTypeID = 1

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END

/*----------------------------------------------------------------*/
/*	Remove the PreInventoryMov		  */
/*----------------------------------------------------------------*/
--Declaração do Cursor de PreInvDel_Cursor
DECLARE PreInvDel_Cursor CURSOR STATIC FOR 
	SELECT
		IDPreInventoryMov
	FROM
		PreInventoryMov (NOLOCK) 
	WHERE
		DocumentID = @PreSaleID
		AND 
		InventMovTypeID = 1

OPEN PreInvDel_Cursor

--Inicialização de PreInv_Cursor
FETCH NEXT FROM PreInvDel_Cursor INTO
            @IDPreInvMovOld

--Enquanto tem registros
WHILE @@FETCH_STATUS = 0
BEGIN
	--Deletar os items
	EXEC sp_PreSale_SubRemoveItem @IDPreInvMovOld

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
	            SET @ErrorLevel = -202
	            GOTO ERRO
	END

            FETCH NEXT FROM PreInvDel_Cursor INTO
                        @IDPreInvMovOld
END

--fechamento do cursor
CLOSE PreInvDel_Cursor
--Destruição do cursor
DEALLOCATE PreInvDel_Cursor

/*--------------------------------------*/
/*	Deleta os pagamentos		*/
/*--------------------------------------*/

EXEC sp_PreSale_DeletePayments @PreSaleID, @IDUser

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
            SET @ErrorLevel = -203
            GOTO ERRO
END

-- Remove os outros custos
DELETE
	C
FROM
	InvoiceToCostType C (NOLOCK) 
WHERE
	C.IDPreSale = @PreSaleID

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -209
	GOTO ERRO
END

/*------------------------------*/
/*	Remove the Shipping	*/
/*------------------------------*/
DELETE
	Sal_InvoiceShipping
WHERE
	IDPreSale = @PreSaleID

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -211
	GOTO ERRO
END

/*--------------------------------------*/
/*	Update Sal_RebateDiscount	*/
/*--------------------------------------*/
UPDATE
	Sal_RebateDiscount
SET
	IDPreSaleUsed = NULL
WHERE
	IDPreSaleUsed = @PreSaleID

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -212
	GOTO ERRO
END

/*--------------------------------------*/
/*	Remove the Sal_AccountCardMov	*/
/*--------------------------------------*/

DELETE
	Sal_AccountCardMov
WHERE
	IDPreSale = @PreSaleID

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -213
	GOTO ERRO
END

/*--------------------------------------*/
/*	Update Estimated		*/
/*--------------------------------------*/

UPDATE
	Estimated
SET
	IDPreSale = NULL
WHERE
	IDPreSale = @PreSaleID

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -214
	GOTO ERRO
END

/*------------------------------*/
/*	Remove the InvoiceOBS	*/
/*------------------------------*/

DELETE
	InvoiceOBS
WHERE
	IDPreSale = @PreSaleID

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -215
	GOTO ERRO
END

/*------------------------------*/
/*	Remove Sal_PaymentCondition */
/*------------------------------*/
DELETE
	P
FROM
	Sal_PaymentCondition P
WHERE
	P.IDPreSale = @PreSaleID

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -216
	GOTO ERRO
END

/*------------------------------*/
/*	Remove Sal_RemovedItem */
/*------------------------------*/
DELETE
	P
FROM
	Sal_RemovedItem P
WHERE
	P.IDPreSale = @PreSaleID

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -217
	GOTO ERRO
END


/*------------------------------*/
/*	Remove the Invoice	*/
/*------------------------------*/
DELETE
	I
FROM
	Invoice I (NOLOCK) 
WHERE
	I.IDPreSale = @PreSaleID
	AND
	I.IDInvoice IS  NULL 

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -207
	GOTO ERRO
END


OK:
	COMMIT TRAN
	RETURN 0
ERRO:
	ROLLBACK TRAN
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PreSale_Remove', @ErrorLevelStr
	RETURN @ErrorLevel


GO

CREATE  PROCEDURE sp_PreSale_SubAddItem
	(
	@PreSaleID		int,
	@IDCliente		int,
	@ModelID		int,
	@StoreID		int,
	@UserID			int,
	@IDComission		int,
	@Qty			float,
	@SalePrice		money,
	@CostPrice		money = Null,
	@Discount		money,
	@MovDate		smalldatetime,
	@IDPreInvMovExchange	int,
	@PreInvMovParentID	int,
	@IDDepartment		int,
	@Promo			bit,
	@IDDescriptionPrice	int,
	@IDVendorPrice		int,
	@SuggPrice		int,
	@DocumentNumber		varchar(20),
	@IDDocumentType		int,
	@SequencyNum		int,
	@TotParcial		varchar(10),
	@PreInventMovID		int Output
	)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Insert on Inventory Movement
		- Inserir no Customer Credit
		- Inserir as quantidades para troca

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Insert on Inventory Movement
		-203  Erro em Inclusão de Models de PacketModel
		-204  Erro em Inserir no Customer Credit
		-205  Erro em Inserir no Customer Credit do PackModel
		-206  Erro em Inserir as quantidades para troca do PreInvMov
		-207  Erro em Inserir as quantidades para troca InvMov
		-208  Erro em Inserir na SaleItemCommission
		-209  Erro em Inserir na SaleItemCommission referente ao item de Kit
		-210  Erro em Inserir na Inv_MovPrice
		-211  Erro em Inserir na Inv_MovDocument

	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	-----------------------	-----------------------	-----------------------------------------------------------------
	15 May	2000		Eduardo Costa		Criacao;
	26 Jun	2001		Davi Gouveia		Log de Return Values;
	29 Oct	2003		Rodrigo Costa		Criado sp_Sis_GetNextCod;
	24 May	2004		André Bogado		Criado Cursor para KitModel;
	18 Aug	2004		Rodrigo Costa		Gravar error log;
	01 Dec	2004		Rodrigo Costa		Gravar no Customer Credit;
	01 Feb	2005		Rodrigo Costa		Inclusao do campo @IDPreInvMovExchange;
	11 Apr	2005		Rodrigo Costa		Inclusao do campo DesiredMarkup no PreInvMov;
	28 Nov	2005		Leonardo Riego		Gravar na SaleItemCommission;
	12 Apr  2006		Leonardo Riego		Novo campo @IDDepartment;
	16 Jun	2006		Rodrigo Costa		Adicionado os parametros para ErrorHistory;
	20 Jul	2007		Maximiliano Muniz	Novos parâmetros @IDDescriptionPrice, @IDVendorPrice e @SuggPrice;
							Inserção na tabeça Inv_MovPrice;
	08 Aug	2007		Maximiliano Muniz	Novos parâmetros @DocumentNumber e @IDDocumentType;
							Inserção na tabeça Inv_MovDocument;
	24 Aug	2009		Rodrigo Costa		Inclusao dos campos TotParcial e SequencyNum para o PAF-ECF
	----------------------------------------------------------------------------------------------------------------- */

DECLARE @ComissionID		int
DECLARE @IDMovPrice		int
DECLARE @IDMovDocument		int
DECLARE @ErrorLevel		int
DECLARE @SysError		int
DECLARE @IDSaleItemCommission   int

--Declaração de variáveis para o Cursor de ModelChild
DECLARE @ModelIDChild  	int 
DECLARE @QtyChild  		float
DECLARE @PreInvMovIDPack	int

SET @ErrorLevel = 0

BEGIN TRAN

/*-------------------------------------------------------------*/
/*                  Insert on PreInventory Movement               */
/*-------------------------------------------------------------*/

EXEC sp_Sis_GetNextCode'PreInventoryMov.IDPreInventoryMov', @PreInventMovID OUTPUT
INSERT dbo.PreInventoryMov
	(
	IDPreInventoryMov,
	InventMovTypeID,
	IDPessoa,
	DocumentID,
	ModelID,
	StoreID,
	MovDate,
 	Qty,
	SalePrice,
	Discount,
	CostPrice,
	UserID,
	IDPreInvMovExchange,
	IDPreInventoryMovParent,
	IDDepartment,
	Promo,
	DesiredMarkup,
	SequencyNum,
	TotParcial
	)
	SELECT
		@PreInventMovID,
		1,
		@IDCliente,
 		@PreSaleID,
		@ModelID,
		@StoreID,
		@MovDate,
		@Qty,
		@SalePrice,
 		@Discount,
		IsNull(@CostPrice, (M.VendorCost+M.OtherCost+M.FreightCost)),
		@UserID,
		@IDPreInvMovExchange,
		@PreInvMovParentID,
		@IDDepartment,
		@Promo,
		TG.DesiredMarkup,
		@SequencyNum,
		@TotParcial
	FROM
 		dbo.Model M (NOLOCK) 
		JOIN TabGroup TG (NOLOCK) ON (TG.IDGroup = M.GroupID)
 	WHERE
		M.IDModel = @ModelID

SET @SysError = @@ERROR
IF @SysError <> 0 
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END

/*****************************************************************************************
	Inclusão do Comissionado na tabela de SaleItemCommission
******************************************************************************************/
EXEC sp_Sis_GetNextCode'SaleItemCommission.IDSaleItemCommission', @IDSaleItemCommission OUTPUT
INSERT INTO dbo.SaleItemCommission
	(
	 IDSaleItemCommission,
	 IDPreInventoryMov,
	 IDCommission,
	 CommissionPercent
	)
	VALUES
	(
	 @IDSaleItemCommission,
	 @PreInventMovID,
	 @IDComission,
	 100
	)

SET @SysError = @@ERROR
IF @SysError <> 0 
BEGIN
	SET @ErrorLevel = -208
	GOTO ERRO
END

/*****************************************************************************************
	Inclusão na tabela de Inv_MovPrice
******************************************************************************************/
IF @IDDescriptionPrice <> 0
BEGIN
	EXEC sp_Sis_GetNextCode 'Inv_MovPrice.IDMovPrice', @IDMovPrice OUTPUT
	INSERT INTO Inv_MovPrice
		(
		IDMovPrice,
		IDPreInventoryMov,
		IDInventoryMov,
		IDDescriptionPrice,
		IDVendor,
		SuggPrice
		)
		VALUES
		(
		@IDMovPrice,
		@PreInventMovID,
		NULL,
		@IDDescriptionPrice,
		@IDVendorPrice,
		@SuggPrice
		)
	
	SET @SysError = @@ERROR
	IF @SysError <> 0 
	BEGIN
		SET @ErrorLevel = -210
		GOTO ERRO
	END
END

/*****************************************************************************************
	Inclusão na tabela de Inv_MovDocument
******************************************************************************************/
IF @DocumentNumber <> ''
BEGIN
	EXEC sp_Sis_GetNextCode 'Inv_MovDocument.IDMovDocument', @IDMovDocument OUTPUT
	INSERT INTO Inv_MovDocument
		(
		IDMovDocument,
		IDPreInventoryMov,
		IDInventoryMov,
		DocumentNumber,
		DocumentDate,
		DocumentStatus,
		IDDocumentType,
		OBS
		)
		VALUES
		(
		@IDMovDocument,
		@PreInventMovID,
		NULL,
		@DocumentNumber,
		@MovDate,
		1,
		@IDDocumentType,
		NULL
		)
	
	SET @SysError = @@ERROR
	IF @SysError <> 0 
	BEGIN
		SET @ErrorLevel = -211
		GOTO ERRO
	END
END

/*****************************************************************************************
	Inclusão das quantidades para troca
******************************************************************************************/
IF (@IDPreInvMovExchange IS NOT NULL)
BEGIN
	--Pre Inv Mov
	UPDATE
		PreInventoryMov
	SET 
		QtyExchanged = IsNull(QtyExchanged,0) + ABS(@Qty)
	WHERE 
		IDPreInventoryMov = @IDPreInvMovExchange
		AND 
		InventMovTypeID = 1
	
	SET @SysError = @@ERROR
	IF @SysError <> 0 
	BEGIN
		SET @ErrorLevel = -206
		GOTO ERRO
	END
	
	-- Inv Mov
	UPDATE
		InventoryMov
	SET 
		QtyExchanged = IsNull(QtyExchanged,0) + ABS(@Qty)
	WHERE 
		PreInventoryMovID = @IDPreInvMovExchange
		AND 
		InventMovTypeID = 1
	
	SET @SysError = @@ERROR
	IF @SysError <> 0 
	BEGIN
		SET @ErrorLevel = -207
		GOTO ERRO
	END
END

/*****************************************************************************************
	Inclusão dos Creditos para o modelo caso tenha
******************************************************************************************/
EXEC sp_PreSale_AddModelCredit
			@PreInventMovID,
			@IDCliente,
			@UserID,
			@StoreID,
			@MovDate


SET @SysError = @@ERROR
IF @SysError <> 0 
BEGIN
	SET @ErrorLevel = -204
	GOTO ERRO
END
 

/*****************************************************************************************
	Inclusão de Models de PacketModel
******************************************************************************************/

--Declaração do Cursor de ModelChild

DECLARE ModelChild_Cursor CURSOR FOR

	SELECT
		M.IDModel,
		P.Qty
	FROM 
 		dbo.PackModel P (NOLOCK) 
		JOIN dbo.Model M (NOLOCK) ON (P.IDModel= M.IDModel)
 	WHERE
		P.IDPackModel = @ModelID


OPEN ModelChild_Cursor

--Inicialização de ModelChild_Cursor
FETCH NEXT FROM ModelChild_Cursor INTO
	@ModelIDChild,
	@QtyChild

--Enquanto tem registros
WHILE
@@FETCH_STATUS = 0
BEGIN
	EXEC sp_Sis_GetNextCode'PreInventoryMov.IDPreInventoryMov', @PreInvMovIDPack OUTPUT

	INSERT dbo.PreInventoryMov
	(
	IDPreInventoryMov,
	InventMovTypeID,
	IDPessoa,
	DocumentID,
	ModelID,
	StoreID,
	MovDate,
 	Qty,
	SalePrice,
	Discount,
	CostPrice,
	UserID,
	IDParentPack,
	IDDepartment
	)
	SELECT
		@PreInvMovIDPack,
		1,
		@IDCliente,
 		@PreSaleID,
		@ModelIDChild,
		@StoreID,
		@MovDate,
		@Qty * @QtyChild,--Qtde Comprada x Qtde do Kit
		0,
 		0,
		FinalCost,
		@UserID,
		@PreInventMovID,
		@IDDepartment
	FROM
 		dbo.Model (NOLOCK) 
 	WHERE
		dbo.Model.IDModel = @ModelIDChild


	SET @SysError = @@ERROR
	IF @SysError <> 0 
	BEGIN
		CLOSE ModelChild_Cursor
		DEALLOCATE ModelChild_Cursor
		SET @ErrorLevel = -203
		GOTO ERRO
	END

	/*****************************************************************************************
	               Inclusão do Comissionado na tabela de SaleItemCommission
        ******************************************************************************************/
        EXEC sp_Sis_GetNextCode'SaleItemCommission.IDSaleItemCommission', @IDSaleItemCommission OUTPUT
        INSERT INTO dbo.SaleItemCommission
	(
	 IDSaleItemCommission,
	 IDPreInventoryMov,
	 IDCommission,
	 CommissionPercent
	)
	VALUES
	(
	 @IDSaleItemCommission,
	 @PreInvMovIDPack,
	 @IDComission,
	 100
	)

        SET @SysError = @@ERROR
        IF @SysError <> 0 
        BEGIN
		SET @ErrorLevel = -209
		GOTO ERRO
        END

	/*****************************************************************************************
		Inclusão dos Creditos dos item do pack caso tenha
	******************************************************************************************/
	EXEC sp_PreSale_AddModelCredit
			@PreInvMovIDPack,
			@IDCliente,
			@UserID,
			@StoreID,

			@MovDate


	SET @SysError = @@ERROR
	IF @SysError <> 0 
	BEGIN
		SET @ErrorLevel = -205
		GOTO ERRO
	END

	--Leitura do Proximo 
	FETCH NEXT FROM ModelChild_Cursor INTO
		@ModelIDChild,
		@QtyChild

END
--fechamento do cursor
CLOSE ModelChild_Cursor

--Destruição do cursor
DEALLOCATE ModelChild_Cursor

SET @SysError = @@ERROR
IF @SysError <> 0 
BEGIN
	SET @ErrorLevel = -203
	GOTO ERRO
END


OK:
	COMMIT TRAN
	RETURN 0
ERRO:
	PRINT CAST(@ErrorLevel AS VARCHAR)
	ROLLBACK TRAN

	DECLARE @ErrorLevelStr varchar(510)
	DECLARE @Params varchar(500)	
	SET @Params = ' [ @IDCliente = ' + CAST(@IDCliente AS VARCHAR) + ' @ModelID = ' + CAST(@ModelID AS VARCHAR) +  
			' @StoreID = ' + CAST(@StoreID AS VARCHAR) + ' @UserID = '  + CAST(@UserID AS VARCHAR) + 
			' @IDComission = '  + CAST(@IDComission AS VARCHAR) + ' @Qty = '  + CAST(@Qty AS VARCHAR) +
			' @IDPreInvMovExchange = '  + CAST(@IDPreInvMovExchange AS VARCHAR) + 
			' @PreInvMovParentID = '  + CAST(@PreInvMovParentID AS VARCHAR) + 
			' @IDDepartment = '  + CAST(@IDDepartment AS VARCHAR) +  ' ] '
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR) + @Params
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PreSale_SubAddItem', @ErrorLevelStr

	RETURN @ErrorLevel

GO

CREATE  PROCEDURE sp_PreSale_CancelInvoice
	(
	@IDPreSale int,
	@IDUser int
	)
AS
/* ---------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Transforma Invoice em Hold (Quando necessario)
		- Cancela o Hold

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Transforma Invoice em Hold
		-202  Erro em Cancela o Hold

	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	-----------------------	-----------------------	----------------------------------------------------------------------------------
	24 Mar  2005		Carlos Lima		Criacao;
	04 Jan	2007		Maximiliano Muniz	Retirada a transação
							Alterado o "IF" antes da sp_PreSale_UnPay. Testa agora com "IS" e não com "<>";
	28 Aug	2009		Rodrigo Costa		Salvar o CashRegMov original do cancelamento
	---------------------------------------------------------------------------------------------------------------------------------- */

DECLARE @ErrorLevel	int
DECLARE @SysError	int

DECLARE @IDInvoice	int
DECLARE @IDCashRegMov	int

SELECT
	@IDInvoice = IDInvoice,
	@IDCashRegMov = CashRegMovID
FROM
	Invoice (NOLOCK) 
WHERE
	IDPreSale = @IDPreSale

/* Transforma Invoice em Hold */

IF @IDInvoice IS NOT NULL
	EXEC sp_PreSale_Unpay @IDPreSale

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
            SET @ErrorLevel = -201
            GOTO ERRO
END

EXEC sp_PreSale_CancelHold @IDPreSale, @IDUser

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
            SET @ErrorLevel = -202
            GOTO ERRO
END

--Atualiza o caixa principal do cancelamento
UPDATE
	Invoice
SET
	CashRegMovID = @IDCashRegMov
WHERE
	IDPreSale = @IDPreSale


OK:
            RETURN 0
ERRO:
            RETURN @ErrorLevel

GO

CREATE  PROCEDURE sp_PreSale_UnPay
			(
			@PreSaleID	int
			)
AS

/* ---------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Unmove os PreInventMov para o InventMov
		- Deleta os InventoryMovTax
		- Deleta os preInventory Movement
		- Desquita os lancamentos
		- Update Cash RegisterMovent
		- Transforma a PreSale em Sale

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Unmove os PreInventMov para o InventMov
		-202  Erro em Deleta os preInventory Movement
		-203  Erro em Deleta os registros de ligacao
		-204  Erro em Deleta os registros de quitacao
		-205  Erro em Troca o documento dos lancamentos
		-206  Erro em Deleta todos os lançamentos e Quitações
		-207  Erro em Transforma a PreSale em Sale
		-208  Erro em Deleta os InventoryMovTax
		-209  Erro em Alterar comissao
		-210  Erro em Deletar InventMovComplement


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	-----------------------	----------------------------------------------------------------------------------------------------------
	26 May	2000		Eduardo Costa		suporte ao novo financeiro e suporte a tratamento de erro
	26 June 2001		Davi Gouveia		Log de Return Values
	28 Oct	2003		Rodrigo Costa		Created Cursor for PreInvMov;
							Call sp_GetNextCode;
	18 Aug	2004		Rodrigo Costa		Gravar error log
	24 Mar	2005		Carlos Lima		Deleta os InventoryMovTax
	30 Mar  2005		Rodrigo Costa		Criar table temp para as quitacoes
	09 Dec	2005		Rodrigo Costa		Alterar comissao
	04 Jan	2007		Maximiliano Muniz	Retirada a transação;
	28 Aug	2009		Rodrigo Costa		Deleta InventMovComplement
	---------------------------------------------------------------------------------------------------------------------------------- */

DECLARE @IDInvoice 		int
DECLARE @ErrorLevel		int
DECLARE @SysError		int

--Declaração de variáveis para o Cursor de PreInventoryMov
DECLARE @InventMovTypeID 	int 
DECLARE @DocumentID 		int 
DECLARE @IDPessoa 		int 
DECLARE @StoreID 		int 
DECLARE @ModelID 		int 
DECLARE @BarCodeID 		char(20)
DECLARE @MovDate 		smalldatetime 
DECLARE @Qty 			float
DECLARE @CostPrice 		money 
DECLARE @SalePrice 		money 
DECLARE @Discount 		money 
DECLARE @ComissionID 		int 
DECLARE @UserID 		int 
DECLARE @IDPreInventoryMov	int
DECLARE @IDInventoryMov		int

SET @ErrorLevel = 0

SELECT 	@IDInvoice = IDInvoice
FROM		Invoice
WHERE 	IDPreSale = @PreSaleID

/* -------------------------------------------------------------*/
/*	Unmove os PreInventMov para o InventMov			*/
/* -------------------------------------------------------------*/
--Declaração do Cursor de PreInventoryMov

DECLARE PreInventoryMov_Cursor CURSOR FOR

	SELECT
		IM.IDInventoryMov,
		IM.InventMovTypeID,
		@PreSaleID,
		IM.IDPessoa,
		IM.StoreID,
		IM.ModelID,
		IM.BarCodeID,
		IM.MovDate,
		IM.Qty,
		IM.CostPrice,
		IM.SalePrice,
		IM.Discount,
		IM.IDUser

	FROM	
		InventoryMov IM (NOLOCK) 
	WHERE   
		IM.DocumentID = @IDInvoice 
		AND
		IM.InventMovTypeID = 1

OPEN PreInventoryMov_Cursor

--Inicialização de PreInventoryMov_Cursor
FETCH NEXT FROM PreInventoryMov_Cursor INTO
	@IDInventoryMov,
	@InventMovTypeID,
	@DocumentID,
	@IDPessoa,
	@StoreID,
	@ModelID,
	@BarCodeID,
	@MovDate,
	@Qty,
	@CostPrice,
	@SalePrice,
	@Discount,
	@UserID
--Enquanto tem registros
WHILE @@FETCH_STATUS = 0
BEGIN
	EXEC sp_Sis_GetNextCode 'PreInventoryMov.IDPreInventoryMov', @IDPreInventoryMov OUTPUT

	INSERT PreInventoryMov
		(
		IDPreInventoryMov,
		InventMovTypeID,
		DocumentID,
		IDPessoa,
		StoreID,
		ModelID,
		BarCodeID,
		MovDate,
		Qty,
		CostPrice,
		SalePrice,
		Discount,
		UserID
		)
	VALUES 
		(
		@IDPreInventoryMov,
		@InventMovTypeID,
		@DocumentID,
		@IDPessoa,
		@StoreID,
		@ModelID,
		@BarCodeID,
		@MovDate,
		@Qty,
		@CostPrice,
		@SalePrice,
		@Discount,
		@UserID	
		)

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		CLOSE PreInventoryMov_Cursor
		DEALLOCATE PreInventoryMov_Cursor
		SET @ErrorLevel = -201
		GOTO ERRO
	END

	--Atualizar os SaleItemCommisison
	UPDATE
		SaleItemCommission
	SET
		IDPreInventoryMov = @IDPreInventoryMov,	
		IDInventoryMov = Null
	WHERE
		IDInventoryMov = @IDInventoryMov

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		CLOSE PreInventoryMov_Cursor
		DEALLOCATE PreInventoryMov_Cursor
		SET @ErrorLevel = -209
		GOTO ERRO
	END


	FETCH NEXT FROM PreInventoryMov_Cursor INTO	
		@IDInventoryMov,
		@InventMovTypeID,
		@DocumentID,
		@IDPessoa,
		@StoreID,
		@ModelID,
		@BarCodeID,
		@MovDate,
		@Qty,
		@CostPrice,
		@SalePrice,
		@Discount,
		@UserID
END
--fechamento do cursor
CLOSE PreInventoryMov_Cursor
--Destruição do cursor
DEALLOCATE PreInventoryMov_Cursor

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END

/*----------------------------------------------------------------*/
/*	       Deleta os InventoryMovTax			  */
/*----------------------------------------------------------------*/


DELETE
	InventoryMovTax
FROM
	InventoryMov (NOLOCK) 
WHERE
	InventoryMov.IDInventoryMov = InventoryMovTax.IDInventoryMov 
	AND
 	InventoryMov.DocumentID = @IDInvoice
	AND
	InventoryMov.InventMovTypeID = 1 

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -208
	GOTO ERRO
END

/*----------------------------------------------------------------*/
/*	       Deleta os Inventory Movement Complement  	  */
/*----------------------------------------------------------------*/

DELETE
	Inv_MovComplement
FROM
	InventoryMov (NOLOCK) 
WHERE
	InventoryMov.IDInventoryMov = Inv_MovComplement.IDInventoryMov 
	AND
 	InventoryMov.DocumentID = @IDInvoice
	AND
	InventoryMov.InventMovTypeID = 1 

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -210
	GOTO ERRO
END


/*----------------------------------------------------------------*/
/*	       Deleta os preInventory Movement			  */
/*----------------------------------------------------------------*/

DELETE 
	InventoryMov
WHERE
 	InventoryMov.DocumentID = @IDInvoice
	AND
	InventoryMov.InventMovTypeID = 1 

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -202
	GOTO ERRO
END

/*----------------------------------------------------------------*/
/*	       Desquita os lancamentos         			  */
/*----------------------------------------------------------------*/

/*----------- Cria tabela com as quitacoes a serem deletadas ------------ */
SELECT
	Q.IDQuitacao
INTO
	#sp_PreSale_Remove_QuitToDelete
FROM
	Fin_Quitacao Q (NOLOCK) 
	JOIN Fin_LancQuit LQ (NOLOCK) ON (LQ.IDQuitacao = Q.IDQuitacao)
	JOIN Fin_Lancamento L (NOLOCK) ON (LQ.IDLancamento = L.IDLancamento)
WHERE
	L.IDPreSale = @PreSaleID


/*---------------- Deleta os registros de ligacao -------------------- */
DELETE
	LQ
FROM
	Fin_LancQuit LQ (NOLOCK) 
	JOIN
	Fin_Lancamento L (NOLOCK) ON (L.IDLancamento = LQ.IDLancamento)
WHERE
	L.IDPreSale = @PreSaleID

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -203
	GOTO ERRO
END

/*--------------- Deleta os registros de quitacao -----------------*/
DELETE
	Q
FROM
	Fin_Quitacao Q (NOLOCK) 
	JOIN #sp_PreSale_Remove_QuitToDelete QTD ON (QTD.IDQuitacao = Q.IDQuitacao)

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -204
	GOTO ERRO
END

/*---------------- Troca o documento dos lancamentos --------------------*/
UPDATE
	Fin_Lancamento
SET
	NumDocumento = Convert(varchar(50), @PreSaleID)
WHERE
	IDPreSale = @PreSaleID

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -205
	GOTO ERRO
END

/*----------------------------------------------------------------------------------------------------------------------------------------------------------*/
/*          Deleta todos os lançamentos e Quitações                                                                                */
/*----------------------------------------------------------------------------------------------------------------------------------------------------------*/ 

EXEC sp_PreSale_DeletePayments @PreSaleID, 0

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
            SET @ErrorLevel = -206
            GOTO ERRO
END



/*----------------------------------------------------------------*/
/*		Transforma a PreSale em Sale    		  */
/*----------------------------------------------------------------*/
UPDATE dbo.Invoice
	SET	dbo.Invoice.IDInvoice    = null,
		dbo.Invoice.InvoiceDate  = null,
		dbo.Invoice.CashReceived = null,
		dbo.Invoice.IDStore	 = null,
		dbo.Invoice.CashRegMovID = null
	WHERE
	 	dbo.Invoice.IDPreSale 	= @PreSaleID

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -207
	GOTO ERRO
END

OK:
	RETURN 0
ERRO:
	RETURN @ErrorLevel

GO

