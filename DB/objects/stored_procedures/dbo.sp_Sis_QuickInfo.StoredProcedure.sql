SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_Sis_QuickInfo]

AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		-

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Total Invoices Today
		-202  Erro em ItemOnPO
		-203  Erro em ItemOnHand
		-204  Erro em SELECT FROM Fin_Lancamento (NOLOCK)
		-205  Erro em PastDuePayments
		-206  Erro em Expenses
		-207  Erro em Profit
		-207  Erro em Item Request
		-207  Erro em Item Hold


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May 2000		Eduardo Costa		Criacao;
	27 June 2001		Davi Gouveia		Log de Return Values
	15 October 2001	Rodrigo Costa		Exepenses was updated with 'L.IDLancamentoTipo <> 7' - Cost of Good
	28 Nov 2001		Rodrigo Costa		Novos Quick Info - Request & Items onHold
 	18 Aug 2004		Rodrigo Costa		Gravar error log
   -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */


DECLARE @TotalSale 				money
DECLARE @ItemOnHand 			int
DECLARE @ItemOnPO 				int
DECLARE @AccountReceivableToAprove 	int
DECLARE @AccountPayableToAprove 		int
DECLARE @PastDuePayments 			int
DECLARE @Profit 				money
DECLARE @Expenses 				money
DECLARE @ErrorLevel 				int
DECLARE @SysError				int
DECLARE @ItemOnRequest 			int
DECLARE @ItemOnHold 			int 

SET @ErrorLevel = 0


/*-----------------------------------  Total Invoices Today ---------------------------------*/

SELECT
	@TotalSale =  SUM(I.SubTotal - I.ItemDiscount)
FROM
	Invoice I (NOLOCK) 
WHERE
	DatePart( Year, I.InvoiceDate ) = DatePart( Year, GetDate() )
	AND
	DatePart( Month, I.InvoiceDate ) = DatePart( Month, GetDate() )
	AND
	DatePart( Day, I.InvoiceDate ) = DatePart( Day, GetDate() )
	AND
	I.IDInvoice IS NOT NULL

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END


/*-----------------------------------  ItemOnPO ---------------------------------*/

SELECT
	@ItemOnPO = SUM(POI.Qty )
FROM
	vwPOItem POI (NOLOCK) 

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -202
	GOTO ERRO
END


/*-----------------------------------  ItemOnHand ---------------------------------*/

SELECT
	@ItemOnHand = count(IDInventory)
FROM
	inventory (NOLOCK) 
WHERE
	QtyOnHand < 0

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -203
	GOTO ERRO
END


/*-----------------------------------   ---------------------------------*/

SELECT
	@AccountReceivableToAprove = SUM(CASE Pagando WHEN 0 THEN 1 ELSE 0 END),
	@AccountPayableToAprove = SUM(CASE Pagando WHEN 1 THEN 1 ELSE 0 END)
FROM
	Fin_Lancamento (NOLOCK)
WHERE
	DatePart(Year, DataVencimento) = DatePart(Year, GetDate())
	AND
	DatePart(Month, DataVencimento) = DatePart(Month, GetDate())
	AND
	Previsao = 1
	AND
	Situacao in (1,5)

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -204
	GOTO ERRO
END

/*-----------------------------------  PastDuePayments ---------------------------------*/

SELECT
	@PastDuePayments = COUNT(IDLancamento)
FROM
	Fin_Lancamento (NOLOCK)
WHERE
	DataVencimento < GetDate()
	AND
	Situacao in (1,5)
	AND
	Pagando = 1
	AND
	Desativado = 0

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -205
	GOTO ERRO
END

/*-----------------------------------  BreakEven ---------------------------------*/

--Expenses
Select
	@Expenses = Sum(L.ValorNominal)
From
	Fin_Lancamento L (NOLOCK) 
Where
	L.Pagando = 1
	AND
	DatePart(Month, L.DataVencimento) = DatePart(Month, GetDate())
	AND
	DatePart(Year, L.DataVencimento) = DatePart(Year, GetDate())
	AND
	L.Desativado = 0
	AND
	L.IDLancamentoTipo <> 7 --Cust of Good

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -206
	GOTO ERRO
END

--Profit
SELECT
	@Profit = ( sum(  ( InvMov.SalePrice - InvMov.CostPrice )  * InvMov.Qty - InvMov.Discount ) )
FROM
	InventoryMov InvMov (NOLOCK)
WHERE
	( InventMovTypeID = 1 )
	AND
	DatePart(Month, InvMov.MovDate) = DatePart(Month, GetDate())
	AND
	DatePart(Year, InvMov.MovDate) = DatePart(Year, GetDate())

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -207
	GOTO ERRO
END


/*-----------------------------------  Request ---------------------------------*/
SELECT
	@ItemOnRequest = SUM(QtyReq)
FROM
	Request (NOLOCK) 

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -208
	GOTO ERRO
END


/*-----------------------------------  Item on Hold ---------------------------------*/

SELECT 
	@ItemOnHold = SUM(Qty)
FROM
	PreInventoryMov (NOLOCK) 
WHERE
	InventMovTypeID = 1
	AND
	Qty > 0

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -209
	GOTO ERRO
END


--Rodrigo Select the var to show in Delphi

SELECT
	IsNull ( @TotalSale, 0 ) as TotalSale,
	IsNull ( @ItemOnPO, 0 )  as ItemOnPO,
	IsNull ( @ItemOnHand, 0 ) as ItemOnHand,
	IsNull ( @AccountReceivableToAprove, 0 ) as AccountReceivableToAprove,
	IsNull ( @AccountPayableToAprove, 0 ) as AccountPayableToAprove,
	IsNull ( @PastDuePayments, 0 ) as PastDuePayments,
	IsNull ( @Profit - @Expenses, 0 ) as BreakEven,
	IsNull ( @ItemOnRequest, 0 ) as ItemOnRequest,
	IsNull ( @ItemOnHold, 0 )  as ItemOnHold



OK:
	RETURN 0
ERRO:
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'OfficeManager', 'Error: sp_Sis_QuickInfo', @ErrorLevelStr

	RETURN @ErrorLevel
GO
