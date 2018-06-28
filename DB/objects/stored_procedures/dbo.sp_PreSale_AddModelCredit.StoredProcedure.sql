SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_PreSale_AddModelCredit]
		(
		@IDPreInventMov	int,
		@IDCliente		int,
		@IDUser		int,
		@IDStore		int,
		@MovDate		smalldatetime
 		)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Inserir no Customer Credit

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Inserir no Customer Credit


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	01 Dec 2004		Rodrigo Costa		Criacao;
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */


DECLARE @ErrorLevel		int
DECLARE @SysError		int
DECLARE @TotalCredit		Money
DECLARE @TotalCreditModel	Money
DECLARE @IDCustomerCredit	int

SET @ErrorLevel = 0


/*****************************************************************************************
	Inclusão dos Creditos para o modelo caso tenha
******************************************************************************************/
SELECT
	@TotalCredit = ((P.Qty * P.SalePrice)-P.Discount),
	@TotalCreditModel = (P.Qty * M.SellingPrice)
FROM
	PreInventoryMov P (NOLOCK) 
	JOIN Model M (NOLOCK) ON (M.IDModel = P.ModelID)
	JOIN TabGroup TB (NOLOCK) ON (TB.IDGroup = M.GroupID)
WHERE
	TB.Credit = 1
	AND
	P.IDPreInventoryMov = @IDPreInventMov
	AND
	P.InventMovTypeID = 1

/*****************************************************************************************
	Testar o valor do PackModel
******************************************************************************************/
SELECT
	@TotalCredit = (CASE WHEN IDParentPack Is Null THEN @TotalCredit ELSE @TotalCreditModel END)
FROM
	PreInventoryMov (NOLOCK) 
WHERE
	IDPreInventoryMov = @IDPreInventMov
	AND
	InventMovTypeID = 1

IF @TotalCredit > 0
BEGIN
	EXEC sp_Sis_GetNextCode 'CustomerCredit.IDCustomerCredit',  @IDCustomerCredit output

	INSERT CustomerCredit
	(
	IDCustomerCredit,
	IDPessoa,
	IDUser,
	IDStore,
	CreditDate,
	IsUsed,
	Amount,
	IDPreInventoryMov
	)
	VALUES
	(
	@IDCustomerCredit,
	@IDCliente,
	@IDUser,
	@IDStore,
	@MovDate,
	0,
	ABS(ISNULL(@TotalCredit, 0)),
	@IDPreInventMov
	)

END

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

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PreSale_AddModelCredit', @ErrorLevelStr

	RETURN @ErrorLevel
GO
