if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_ApplyCustomerDiscount]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_ApplyCustomerDiscount]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_CalcCustomerDiscount]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_CalcCustomerDiscount]
GO

CREATE PROCEDURE sp_PreSale_ApplyCustomerDiscount
		(
		@IDPreSale		int,
		@IDCustomer		int,
		@Date			DateTime
		)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Altera desconto baseado no tipo de cliente

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro na atualização dos itens
		-202  Erro no Cursor
		-203  Erro em exec sp_PreSale_SubCalcTotal @PreSaleID, @Date

	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	------------------------------------------------------------------------------- -----------------------------------------------------------------------------------------------------------
	17 Feb 2006		Maximiliano Muniz	Criacao;
   -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

DECLARE @IDPreInventoryMov	int
DECLARE @IDModel		int
DECLARE @Qty			float
DECLARE @SalePrice		money
DECLARE @Discount		money
DECLARE @ErrorLevel		int 
DECLARE @SysError		int

SET @ErrorLevel = 0

BEGIN TRAN

/*--------------------------------------*/
/*	Calcula desconto do cliente	*/
/*--------------------------------------*/

--Declaração do Cursor de PreInventoryMov
DECLARE ApplyDiscount_Cursor CURSOR FOR

	SELECT
		IDPreInventoryMov,
		ModelID,
	 	Qty,
		SalePrice,
		Discount
	FROM
		PreInventoryMov
	WHERE
		DocumentID = @IDPreSale

OPEN ApplyDiscount_Cursor

--Inicialização de ApplyDiscount_Cursor
FETCH NEXT FROM ApplyDiscount_Cursor INTO
	@IDPreInventoryMov,
	@IDModel,
	@Qty,
	@SalePrice,
	@Discount

--Enquanto tem registros
WHILE
@@FETCH_STATUS = 0
BEGIN

	SELECT
		@Discount = (@SalePrice * (CD.Discount / 100)) * @Qty
	FROM
		Ent_CustomerDiscount CD
		JOIN Model M ON (CD.IDGroup = M.GroupID)
		JOIN Pessoa P ON (CD.IDTipoPessoa = P.IDTipoPessoa)
	WHERE
		M.IDModel = @IDModel
		AND
		P.IDPessoa = @IDCustomer

	UPDATE
		PreInventoryMov
	SET
		Discount = @Discount
	WHERE
		IDPreInventoryMov = @IDPreInventoryMov

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		CLOSE ApplyDiscount_Cursor
		DEALLOCATE CalcABC_Cursor
		SET @ErrorLevel = -201
		GOTO ERRO
	END

	FETCH NEXT FROM ApplyDiscount_Cursor INTO
		@IDPreInventoryMov,
		@IDModel,
		@Qty,
		@SalePrice,
		@Discount
END

--fechamento do cursor
CLOSE ApplyDiscount_Cursor

--Destruição do cursor
DEALLOCATE ApplyDiscount_Cursor

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -202
	GOTO ERRO
END

exec sp_PreSale_SubCalcTotal @IDPreSale, @Date

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
	ROLLBACK TRAN
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PreSale_ApplyCustomerDiscount', @ErrorLevelStr

	RETURN @ErrorLevel

GO

CREATE PROCEDURE sp_PreSale_CalcCustomerDiscount
		(
		@IDCustomer		int,
		@IDModel		int,
		@Qty			float,
		@SalePrice		money,
		@Discount		money out
		)
AS

/* ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 	SUMARIO

		- Calcula o desconto por tipo de cliente

	TABELA DE ERROS PARA RETURN_VALUE

		 000	Ok
		-201	Erro no cálculo do desconto por tipo de cliente

	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	----------------------- ----------------------- ---------------------------------------------------------------------------------------------------------------------------------------------
	21 Feb 2006		Maximiliano		Criacao;
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */
 
DECLARE @Result		int
DECLARE @ErrorLevel	int 
DECLARE @SysError	int

SET @ErrorLevel = 0

/*--------------------------------------*/
/*	Calcula desconto do cliente	*/
/*--------------------------------------*/

IF @Discount = 0
BEGIN
	SELECT
		@Discount = (@SalePrice * (CD.Discount / 100)) * @Qty
	FROM
		Ent_CustomerDiscount CD
		JOIN Model M ON (CD.IDGroup = M.GroupID)
		JOIN Pessoa P ON (CD.IDTipoPessoa = P.IDTipoPessoa)
	WHERE
		M.IDModel = @IDModel
		AND
		P.IDPessoa = @IDCustomer
END

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END

OK:
	IF @Result = 0
	RETURN @Result
ERRO:
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PreSale_CalcCustomerDiscount', @ErrorLevelStr

	RETURN @ErrorLevel
GO
