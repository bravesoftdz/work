if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_AddCustomerCredit]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_AddCustomerCredit]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_AddItem]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_AddItem]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_AddParcela]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_AddParcela]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_ChangeItem]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_ChangeItem]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_CreateHold]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_CreateHold]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_RemoveItem]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_RemoveItem]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_SubAddItem]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_SubAddItem]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_SubRemoveItem]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_SubRemoveItem]
GO

CREATE PROCEDURE sp_PreSale_AddCustomerCredit
	(
	@IDPessoa		int,
	@IDUser		int,
	@IDStore		int,
	@CreditDate		datetime,
	@ExpirationDate	datetime,	
	@Amount		money,
	@IDLancamento	int,
	@IDCustomerCredit	int out
	)
AS

/* ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 	
	SUMARIO

		- Inserir novo crédito para o cliente

	TABELA DE ERROS PARA RETURN_VALUE
		 000	Ok
		-201	Erro em - Inserir novo crédito para o cliente


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	09 Nov 2004		Carlos Lima		Criacao;
	10 Nov 2004		Carlos Lima		Adicionado parâmetro @IDLancamento
	16 Jun	2006		Rodrigo Costa		Adicionado os parametros para ErrorHistory
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

DECLARE @ErrorLevel	int 
DECLARE @SysError	int

SET @ErrorLevel = 0 

BEGIN TRAN

EXEC sp_Sis_GetNextCode 'CustomerCredit.IDCustomerCredit',  @IDCustomerCredit output

INSERT CustomerCredit
	(
	IDCustomerCredit,
	IDPessoa,
	IDUser,
	IDStore,
	CreditDate,
	ExpirationDate,
	IsUsed,
	Amount,
	IDLancamento
	)
VALUES
	(
	@IDCustomerCredit,
	@IDPessoa,
	@IDUser,
	@IDStore,
	@CreditDate,
	@ExpirationDate,
	0,
	ABS(ISNULL(@Amount, 0)),
	@IDLancamento
	)


SET @SysError = @@ERROR

IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
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
	SET @Params = ' [ @IDPessoa = ' + CAST(@IDPessoa AS VARCHAR) + 
			' @IDUser = ' + CAST(@IDUser AS VARCHAR) +  
			' @IDStore = ' + CAST(@IDStore AS VARCHAR) + 
			' @IDLancamento = '  + CAST(@IDLancamento AS VARCHAR) +  ' ] '
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR) + @Params


	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PreSale_AddCustomerCredit', @ErrorLevelStr

	RETURN @ErrorLevel
GO

CREATE PROCEDURE sp_PreSale_AddItem
		(
		@PreSaleID     			int,
		@IDCliente			int,
		@ModelID     			int,
		@StoreID     			int,
		@UserID      			int,
		@IDComission			int,
		@Qty         			float,
		@SalePrice      		money,
		@CostPrice			money,
		@Discount    			money,
		@MovDate     			smalldatetime,
		@ResetDiscount  		bit = 0,
		@Manager			bit = 0,
		@Date				DateTime,
		@IDPreInvMovExchange		int,
		@PreInvMovParentID		int,
		@IDDepartment			int,
		@Promo				bit = 0,
		@PreInventMovID  		int	Output
		)
AS

/* ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 	SUMARIO

		- Testa se o discount total ainda e valido
		- Inclui a movimentaçao

	TABELA DE ERROS PARA RETURN_VALUE

		 @Result  Ok
		-201      Erro em exec @Result = sp_PreSale_SubTestDiscount
		-202      Erro em exec sp_PreSale_SubResetDiscount
		-203      Erro em exec @Result = sp_PreSale_SubAddItem
		-204      Erro em exec sp_PreSale_SubCalcTotal


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	-----------------------	-----------------------	-----------------------------------------------------------------
	15 May	2000		Eduardo Costa		Criacao;
	26 Jun	2001		Davi Gouveia		Log de Return Values
	18 Aug	2004		Rodrigo Costa		Gravar error log
	01 Fev	2005		Rodrigo Costa		Novo campo @IDPreInvMovExchange
	12 Apr  2006		Leonardo Riego		Novo campo @IDDepartment 
	16 Jun	2006		Rodrigo Costa		Adicionado os parametros para ErrorHistory
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
					@PreInventMovID		Output

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
	IF @Result = 0
		COMMIT TRAN
	RETURN @Result
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

CREATE PROCEDURE sp_PreSale_AddParcela
	(
	@IDStore		int,
	@IDUser			int,
	@IDCliente		int,
	@PreSaleID		int,
	@PreSaleDate		smalldatetime,
	@ExpirationDate		smalldatetime,
	@IDMeioPag		int,
	@Value			money,
	@Authorization		varchar(50),
	@IDCashRegMov		int,
	@Parcela		varchar(20),
	@IDBankCheck		int,
	@CheckNumber		varchar(20),
	@CustomerDocument	varchar(20),
	@CustomerName		varchar(80),
	@CustomerPhone		varchar(20),
	@OBS			varchar(255),
	@PaymentPlace		int,
	@IsPreDatado		bit
	) AS

/* ----------------------------------------------------------------------------------------------------------------------
	SUMARIO
		- Pega as constantes
		- Insere o lancamento
		- Update CashReg TotalSales
		- Incluir crédito para o Cliente

	TABELA DE ERROS PARA RETURN_VALUE
		 000 Ok
		-201 Erro em Pega as constantes
		-202 Erro em Insere o lancamento
		-203  Erro em Update CashReg TotalSales
		-204  Erro em Incluir crédito para o Cliente
		-205 Erro em Incluir em Sal_AccountCard

	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	----------------------- ----------------------- -----------------------------------------------------------------
	26 May	2000		Eduardo Costa		Suporte ao novo financeiro;
	27 Jun	2001		Davi Gouveia		Log de Return Values;
	28 Jul	2001		Rodrigo Costa		Atualizar o CashReg TotalSales;
	21 Oct	2003		Rodrigo Costa		Chamada a sp_Sis_GetNextCode para @IDLancamento; 
							Criado @IDLancamento;
	15 Oct	2004		Carlos Lima		Incluídos novos campos no Fin_Lancamento;
	27 Sep	2004		Carlos Lima		Incluídos novo campo no no Fin_Lancamento (PaymentPlace);
	09 Nov	2004		Carlos Lima		Inclusão de Crédito;
	10 Nov	2004		Carlos Lima		Inclusão do campo IDLancamento quando inclui Crédito;
	07 Jan	2005		Carlos Lima		Inclusão do parâmetro IsPredatado;
	23 Mar	2006		Carlos Lima		Suporte ao Gift Card ( Chamada para a procedure que inclui em Sal_AccountCard );
	16 May	2006		Maximiliano Muniz	Calcula da data de vencimento do Lancamento, com base no MeioPag.
	16 Jun	2006		Rodrigo Costa		Adicionado os parametros para ErrorHistory
	--------------------------------------------------------------------------------------------------------------- */

DECLARE @IDCentroCusto	int
DECLARE @IDContaCorrente	int
DECLARE @IDEmpresa		int
DECLARE @ErrorLevel		int
DECLARE @IDLancamento	int
DECLARE @Tipo		int
DECLARE @IDCustomerCredit	int
DECLARE @DueDate		smalldatetime
DECLARE @SysError		int

SET @ErrorLevel = 0

-- Pega as constantes
SELECT
	@IDCentroCusto = S.IDCentroCusto,
	@IDContaCorrente = MPS.IDContaCorrente,
	@IDEmpresa = S.IDEmpresa
FROM
	Store S
	JOIN MeioPagToStore MPS ON (S.IDStore = MPS.IDStore)
WHERE
	S.IDStore = @IDStore
	AND
	MPS.IDMeioPag = @IDMeioPag

SELECT
	@Tipo = Tipo,
	@DueDate = (CASE WHEN @PreSaleDate = @ExpirationDate THEN DateAdd(Day, PrazoRecebimento, @ExpirationDate) ELSE @ExpirationDate END)
FROM
	MeioPag
WHERE
	IDMeioPag = @IDMeioPag

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
            SET @ErrorLevel = -201
            GOTO ERRO
END
 
-- Insere o lancamento
EXEC sp_Sis_GetNextCode 'Fin_Lancamento.IDLancamento', @IDLancamento OUTPUT
INSERT            Fin_Lancamento
                        (
                        IDLancamento,
                        IDLancamentoTipo,
                        Pagando,
                        Situacao,
                        IDCentroCusto,
                        IDContaCorrentePrevista,
                        IDDocumentoTipo,
                        NumDocumento,
                        IDEmpresa,
                        IDPreSale,
                        IDPessoaTipo,
                        IDPessoa,
                        IDMoeda,
                        IDMoedaCotacao,
                        DataLancamento,
                        DataVencimento,
                        ValorNominal,
                        IDQuitacaoMeioPrevisto,
                        IDUsuarioLancamento,
                        NumMeioQuitPrevisto,
                        IDCashRegMov,
                        NumDesdobramento,
                        IDDesdobramentoTipo,
                        IDBankCheck,
                        CheckNumber,
                        CustomerDocument,
                        CustomerName,
                        CustomerPhone,
                        Historico,
                        PaymentPlace,
                        IsPreDatado
                        )
                        VALUES
                        (
                        @IDLancamento,
                        2, -- \\Receitas\Vendas
                        0,
                        1,
                        @IDCentroCusto,
                        @IDContaCorrente,
                        1001, -- Sales Invoice
                        Convert(varchar(50), @PreSaleID),
                        @IDEmpresa,
                        @PreSaleID,
                        1, -- Sales Customer
                        @IDCliente,
                        4, -- Dollares
                        6, -- CotacaoPadrao do Dollar
                        @PreSaleDate,
                        @DueDate,
                        @Value,
                        @IDMeioPag,
                        @IDUser, --Usuario do financeiro
                        @Authorization,
                        @IDCashRegMov,
                        @Parcela,
                        1001,
                        @IDBankCheck,
                        @CheckNumber,
                        @CustomerDocument,
                        @CustomerName,
                        @CustomerPhone,
                        @OBS,
                        @PaymentPlace,
                        @IsPreDatado
                        )

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
            SET @ErrorLevel = -202
            GOTO ERRO
END

/*--------------------------------------------------------------------------------------------------------*/
/*                     Update Cash RegisterMovent                             */
/*--------------------------------------------------------------------------------------------------------*/
UPDATE
            CashRegMov
SET
            CashRegMov.TotalSales = IsNull(dbo.CashRegMov.TotalSales, 0) + ROUND(IsNull(@Value,0),2)
WHERE
            CashRegMov.IDCashRegMov = @IDCashRegMov 

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
            SET @ErrorLevel = -203
            GOTO ERRO
END

/*----------------------------------------------------------------*/
/*		Customer Credit		*/
/*----------------------------------------------------------------*/
IF (@Tipo = 5)  AND (@Value < 0)
BEGIN
	EXEC sp_PreSale_AddCustomerCredit @IDCliente, @IDUser, @IDStore, @PreSaleDate, NULL, @Value, @IDLancamento, @IDCustomerCredit OUTPUT

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
	            SET @ErrorLevel = -204
	            GOTO ERRO
	END
END

/*----------------------------------------------------------------*/
/*		Gift Card		*/
/*----------------------------------------------------------------*/
IF (@Tipo = 6)
BEGIN

	EXEC sp_Sal_AccountCard_AddAmount @CustomerDocument, @Value, @PreSaleID, @IDLancamento, @IDUser, 0, ''

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
	            SET @ErrorLevel = -205
	            GOTO ERRO
	END
END

OK:
            RETURN 0
ERRO:
            PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(510)
	DECLARE @Params varchar(500)	

	SET @Params = ' [ @IDStore = ' + CAST(@IDStore AS VARCHAR) + 
			' @IDUser = ' + CAST(@IDUser AS VARCHAR) +  
			' @IDCliente = ' + CAST(@IDCliente AS VARCHAR) + 
			' @PreSaleID = '  + CAST(@PreSaleID AS VARCHAR) + 
			' @IDMeioPag = '  + CAST(@IDMeioPag AS VARCHAR) + 
			' @IDCashRegMov = '  + CAST(@IDCashRegMov AS VARCHAR) +
			' @IDBankCheck = '  + CAST(@IDBankCheck AS VARCHAR) + 
			' @Value = '  + CAST(@Value AS VARCHAR) +  ' ] '

	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR) + @Params
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PreSale_AddParcela', @ErrorLevelStr


            RETURN @ErrorLevel
GO

CREATE  PROCEDURE sp_PreSale_ChangeItem
		(
		@PreSaleID      		int,
		@ModelID     			int,
		@UserID      			int,
		@IDComission			int,
		@Qty         			float,
		@SalePrice      		money,
		@CostPrice      		money = Null,
		@Discount    			money,
		@MovDate     			smalldatetime,
		@Manager			bit 	= 0,
		@ResetDiscount			bit	= 0,
		@Date				DateTime,
		@PreInvMovParentID		int,
		@IDDepartment			int,
		@Promo				bit,
		@PreInventMovID			int	output 
		)
AS
 /* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Testa se o discount total ainda e valido
		- Efetivamente remove e inclui o inventory moviment
		- Passa os seriais do item antigo para o novo

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em exec @Result = sp_PreSale_SubTestDiscount
		-202  Erro em exec sp_PreSale_SubResetDiscount
		-203  Erro em exec @result = sp_PreSale_SubRemoveItem
		-204  Erro em exec @result = sp_PreSale_SubAddItem
		-205  Erro em Passa os seriais do item antigo para o novo
		-206  Erro em exec sp_PreSale_SubCalcTotal
		-207  Erro em atualizar quantidades trocadas


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
	26 June 2001		Davi Gouveia		Log de Return Values
	18 Aug 2004		Rodrigo Costa		Gravar error log
	01 Fev 2005		Rodrigo Costa		Inclusao do IDPreInvMovExchange e qtyExchanged
	12 Apr 2006		Leonardo Riego		Novo campo @IDDepartment
	16 Jun	2006		Rodrigo Costa		Adicionado os parametros para ErrorHistory
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

 DECLARE @Result  			int
DECLARE @Value				money
DECLARE @StoreID			int
DECLARE @IDCliente			int
DECLARE @IDOldUser			int
DECLARE @OldPreInventoryMovID 		int 
DECLARE @ErrorLevel			int
DECLARE @SysError			int
DECLARE @IDPreInvMovExchange		int
DECLARE @QtyExchanged			float

SET @ErrorLevel = 0


SET @OldPreInventoryMovID = @PreInventMovID

/*------------------------------------------------------------------------------*/
/*                Testa se o discount total ainda e valido                      */
/*------------------------------------------------------------------------------*/
 SELECT @Value = IsNull((@Qty * @SalePrice), 0)

if @Manager = 0
   begin 

	exec @Result = sp_PreSale_SubTestDiscount 	@PreSaleID,
							@ModelID,
							@UserID,
 							@Discount,
							@Value,
							'A', 
							@PreInventMovID
  	
	SET @SysError = @@ERROR
	IF @SysError <> 0 	
	BEGIN
		SET @ErrorLevel = -201
		GOTO ERRO
	END
 
	if @ResetDiscount = 1 and @Result <> 0
	   begin
		exec sp_PreSale_SubResetDiscount	@PreSaleID

		SET @SysError = @@ERROR
		IF @SysError <> 0 	
		BEGIN
			SET @ErrorLevel = -202
			GOTO ERRO
		END
	   end
	else
	   begin
		if @Result <> 0
		   begin
			Return @Result
		   end 
	   end
   end

/*------------------------------------------------------------------------------*/
/*                            Descobre o Store                                  */
/*------------------------------------------------------------------------------*/

SELECT
	@StoreID = StoreID,
	@IDCliente = IDPessoa,
	@IDPreInvMovExchange = IDPreInvMovExchange,
	@QtyExchanged = QtyExchanged
FROM 
	PreInventoryMov
WHERE 
	PreInventoryMov.IDPreInventoryMov = @PreInventMovID

/*-------------------------------------------------------------*/
/*    Efetivamente remove e inclui o inventory moviment        */
/*-------------------------------------------------------------*/
begin tran

exec @result = sp_PreSale_SubRemoveItem	@PreInventMovID

SET @SysError = @@ERROR
IF @SysError <> 0 	
BEGIN
	SET @ErrorLevel = -203
	GOTO ERRO
END

exec @result = sp_PreSale_SubAddItem	@PreSaleID,
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
					@PreInventMovID 	output

SET @SysError = @@ERROR
IF @SysError <> 0 	
BEGIN
	SET @ErrorLevel = -204
	GOTO ERRO
END

/*-------------------------------------------------------------*/
/*    Atualiza as quantidades trocadas      */
/*-------------------------------------------------------------*/

UPDATE
	PreInventoryMov
SET
	QtyExchanged = @QtyExchanged
WHERE
	IDPreInventoryMov = @PreInventMovID


SET @SysError = @@ERROR
IF @SysError <> 0 	
BEGIN
	SET @ErrorLevel = -207
	GOTO ERRO
END

/*-------------------------------------------------------------*/
/*    Passa os seriais do item antigo para o novo      */
/*-------------------------------------------------------------*/
UPDATE
	PSM
SET
	PSM.PreInventoryMovID = @PreInventMovID
FROM
	PreSerialMov PSM
WHERE
	PSM.PreInventoryMovID = @OldPreInventoryMovID

SET @SysError = @@ERROR
IF @SysError <> 0 	
BEGIN
	SET @ErrorLevel = -205
	GOTO ERRO
END


if @Result <> 0 	rollback tran
else
begin
	exec sp_PreSale_SubCalcTotal @PreSaleID, @Date
	SET @SysError = @@ERROR
	IF @SysError <> 0 	
	BEGIN
		SET @ErrorLevel = -206
		GOTO ERRO
	END
end

OK:
	IF @Result = 0
		COMMIT TRAN
	RETURN @Result
ERRO:
	ROLLBACK TRAN
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(510)
	DECLARE @Params varchar(500)	
	SET @Params = ' [ @ModelID = ' + CAST(@ModelID AS VARCHAR) + ' @UserID = '  + CAST(@UserID AS VARCHAR) + 
			' @IDComission = ' + CAST(@IDComission AS VARCHAR) + ' @Qty = '  + CAST(@Qty AS VARCHAR) +
			' @PreInvMovParentID = '  + CAST(@PreInvMovParentID AS VARCHAR) + 
			' @IDDepartment = ' + CAST(@IDDepartment AS VARCHAR) + ' ] '

	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR) + @Params
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PreSale_ChangeItem', @ErrorLevelStr

	RETURN @ErrorLevel
GO

CREATE PROCEDURE sp_PreSale_CreateHold
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
	PrintNotes
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
	@PrintNotes
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

CREATE PROCEDURE sp_PreSale_RemoveItem
			( 
			@PreSaleID 		int,
			@ModelID		int,
			@UserID 		int,
			@PreInventMovID	int,
			@Discount		money,
			@SalePrice		money,
			@Qty			float,
			@Date			DateTime,
			@ResetDiscount	bit  	= 0,
			@Manager		bit	= 0
			)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Testa se o discount total ainda e valido
		- Efetivamente remove o inventory moviment

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em exec @Result = sp_PreSale_SubTestDiscount
		-202  Erro em exec sp_PreSale_SubResetDiscount
		-203  Erro em Delecao do PreSerialMov
		-204  Erro em exec @result = sp_PreSale_SubRemoveItem
		-205  Erro em exec sp_PreSale_RemoveDiscountItem
		-206  Erro em exec sp_PreSale_SubCalcTotal


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
	26 June 2001		Davi Gouveia		Log de Return Values
	18 Aug  2004		Rodrigo Costa		Gravar error log
	06 Apr	2006		Leonardo Riego		Inclusão da chamada a sp_PreSale_RemoveDiscountItem
	16 Jun	2006		Rodrigo Costa		Adicionado os parametros para ErrorHistory
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */


DECLARE @Result  	int 
DECLARE @Value	money
DECLARE @ErrorLevel	int
DECLARE @SysError	int

SET @ErrorLevel = 0

/*------------------------------------------------------------------------------*/
/*                Testa se o discount total ainda e valido                      */
/*------------------------------------------------------------------------------*/ 

SELECT @Value = IsNull((@Qty * @SalePrice), 0) 

if @Manager = 0
   begin
 
	exec @Result = sp_PreSale_SubTestDiscount
						@PreSaleID,
						@ModelID,
						@UserID,
						@Discount,
						@Value,
						'E'
 	
	SET @SysError = @@ERROR
	IF @SysError <> 0
 	BEGIN
 		PRINT '-201'
 		RETURN -201
 	END

 	if @ResetDiscount = 1 and @Result <> 0
	   begin
		exec sp_PreSale_SubResetDiscount	@PreSaleID
		SET @SysError = @@ERROR
		IF @SysError <> 0
		BEGIN
 			PRINT '-202'
 			RETURN -202
 		END
	   end
	else
	   begin
		if @Result <> 0
		   begin
 			Return @Result
		   end
	   end
   end

/*-------------------------------------------------------------*/
/*          Efetivamente remove o inventory moviment           */
/*-------------------------------------------------------------*/ 
begin tran
 
/*--------------------------------------------------------------*/
/*		Delecao do PreSerialMov	        */
/*--------------------------------------------------------------*/
DELETE
	PSM
FROM
	PreSerialMov PSM
WHERE
	PSM.PreInventoryMovID =  @PreInventMovID

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -203
	GOTO ERRO
END

exec @result = sp_PreSale_SubRemoveItem	@PreInventMovID

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -204
	GOTO ERRO
END

exec @result = sp_PreSale_RemoveDiscountItem @PreSaleID, @PreInventMovID, @Date 	

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -205
	GOTO ERRO
END  
 
if @Result <> 0
begin
	SET @ErrorLevel = @Result
	GOTO ERRO
end
else
begin
	exec sp_PreSale_SubCalcTotal @PreSaleID, @Date
	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		SET @ErrorLevel = -206
		GOTO ERRO
	END
end

OK:
	COMMIT TRAN
	RETURN @Result
ERRO:
	ROLLBACK TRAN
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(510)
	DECLARE @Params varchar(500)	
	SET @Params = ' [ @ModelID = ' + CAST(@ModelID AS VARCHAR) + ' @UserID = '  + CAST(@UserID AS VARCHAR) + 
			' @PreInventMovID = '  + CAST(@PreInventMovID AS VARCHAR) +  ' ] '
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR) + @Params

	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PreSale_RemoveItem', @ErrorLevelStr

	RETURN @ErrorLevel
GO

CREATE PROCEDURE sp_PreSale_SubAddItem
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


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	-----------------------	-----------------------	-----------------------------------------------------------------
	15 May	2000		Eduardo Costa		Criacao;
	26 Jun	2001		Davi Gouveia		Log de Return Values
	29 Oct	2003		Rodrigo Costa		Criado sp_Sis_GetNextCod;
	24 May	2004		André Bogado		Criado Cursor para KitModel 
	18 Aug	2004		Rodrigo Costa		Gravar error log
	01 Dec	2004		Rodrigo Costa		Gravar no Customer Credit
	01 Feb	2005		Rodrigo Costa		Inclusao do campo @IDPreInvMovExchange
	11 Apr	2005		Rodrigo Costa		Inclusao do campo DesiredMarkup no PreInvMov
	28 Nov	2005		Leonardo Riego		Gravar na SaleItemCommission
	12 Apr  2006		Leonardo Riego		Novo campo @IDDepartment
	16 Jun	2006		Rodrigo Costa		Adicionado os parametros para ErrorHistory
	----------------------------------------------------------------------------------------------------------------- */

DECLARE @ComissionID 	int
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
	DesiredMarkup
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
		TG.DesiredMarkup
	FROM
 		dbo.Model M
		JOIN TabGroup TG ON (TG.IDGroup = M.GroupID)
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
 		dbo.PackModel P
		JOIN dbo.Model M ON (P.IDModel= M.IDModel)
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
 		dbo.Model
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

CREATE PROCEDURE sp_PreSale_SubRemoveItem
			(
			@PreInventMovID int
			)
AS 
/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Delete on Pre Inventory Movement Items Packages
		- Delete on Pre Inventory Movement

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro no Delete
		-202  Erro no Delete PackItems
		-203  Erro no Delete CustomerCredit
		-204  Erro no Delete CustomerCredit do PackModel
		-205  Erro em atulaizar qtyExchanged no Pre
		-206  Erro em atulaizar qtyExchanged no Inv
		-207  Erro no Delete SaleItemCommission	
		-208  Erro ao deletar o comissionamento dos itens de Kit


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
	26 June 2001		Davi Gouveia		Log de Return Values
	25 May 2004		Rodrigo Costa		Deletar os PackModels
	18 Aug 2004		Rodrigo Costa		Gravar error log
	01 Dec 2004		Rodrigo Costa		Deletar os Credits for Customer
	28 Nov 2005		Leonardo Riego		Deletar as linhas da SaleItemCommission
	16 Jun	2006		Rodrigo Costa		Deletar as linhas do SaleItemCommission do item de Kit
	16 Jun	2006		Rodrigo Costa		Adicionado os parametros para ErrorHistory
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

DECLARE @ErrorLevel			int
DECLARE @SysError			int
DECLARE @IDPreInvMovExchange	int
DECLARE @Qty			float

SET @ErrorLevel = 0


/*-------------------------------------------------------------*/
/* Delete on os Customers Credit  do  PreInventoryMovPack        */
/*-------------------------------------------------------------*/
UPDATE
	CustomerCredit
SET
	IsUsed = 1
FROM
	PreInventoryMov PIM 
WHERE
	PIM.IDParentPack = @PreInventMovID
	AND
	CustomerCredit.IDPreInventoryMov = PIM.IDPreInventoryMov


SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -204
	GOTO ERRO
END

/*****************************************************************************************
	Deletar as quantidades para troca
******************************************************************************************/
SELECT
	@IDPreInvMovExchange = IDPreInvMovExchange,
	@Qty = Qty
FROM
	PreInventoryMov
WHERE
	IDPreInventoryMov = @PreInventMovID

IF (@IDPreInvMovExchange IS NOT Null)
BEGIN
	--Pre Inv Mov
	UPDATE
		PreInventoryMov
	SET 
		QtyExchanged = IsNull(QtyExchanged,0) - ABS(@Qty)
	WHERE 
		IDPreInventoryMov = @IDPreInvMovExchange
		AND 
		InventMovTypeID = 1
	
	SET @SysError = @@ERROR
	IF @SysError <> 0 
	BEGIN
		SET @ErrorLevel = -205
		GOTO ERRO
	END
	
	-- Inv Mov
	UPDATE
		InventoryMov
	SET 
		QtyExchanged = IsNull(QtyExchanged,0) - ABS(@Qty)
	WHERE 
		PreInventoryMovID = @IDPreInvMovExchange
		AND 
		InventMovTypeID = 1
	
	SET @SysError = @@ERROR
	IF @SysError <> 0 
	BEGIN
		SET @ErrorLevel = -206
		GOTO ERRO
	END
END

/*-------------------------------------------------------------*/
/*                Delete os Commissions dos itens de Kit  */
/*-------------------------------------------------------------*/

DELETE
	SaleItemCommission
FROM
	PreInventoryMov PIM 
WHERE
	PIM.IDParentPack = @PreInventMovID

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -208
	GOTO ERRO
END


/*-------------------------------------------------------------*/
/*                Delete os Commissions for SaleItemCommission   */
/*-------------------------------------------------------------*/

DELETE
	dbo.SaleItemCommission
WHERE
	dbo.SaleItemCommission.IDPreInventoryMov = @PreInventMovID

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -207
	GOTO ERRO
END


/*-------------------------------------------------------------*/
/*                  Delete on Pre Inventory Movement Pack           */
/*-------------------------------------------------------------*/

DELETE
	dbo.PreInventoryMov
WHERE
	dbo.PreInventoryMov.IDParentPack = @PreInventMovID

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -202
	GOTO ERRO
END


/*-------------------------------------------------------------*/
/*                  Delete os Customers Credit  do  PreInventoryMov        */
/*-------------------------------------------------------------*/
UPDATE
	CustomerCredit
SET
	IsUsed = 1
WHERE
	IDPreInventoryMov = @PreInventMovID

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -203
	GOTO ERRO
END


/*-------------------------------------------------------------*/
/*                  Delete on Pre Inventory Movement           */
/*-------------------------------------------------------------*/

DELETE
	dbo.PreInventoryMov
WHERE
	dbo.PreInventoryMov.IDPreInventoryMov = @PreInventMovID

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END

OK:
	RETURN 0
ERRO:
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(110)
	DECLARE @Params varchar(100)	
	SET @Params = ' [ @PreInventMovID = ' + CAST(@PreInventMovID AS VARCHAR) + ' ] '
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR) + @Params

	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PreSale_SubRemoveItem', @ErrorLevelStr
	RETURN @ErrorLevel
GO
