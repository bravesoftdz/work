SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_PreSale_ApplyCustomerDiscount]
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
	04 Mar 2009		Rodrigo Costa		Aplicar desconto nos produtos que nao estao com 0 no estoque e nao
							estao marcados para pedir preco
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
		PIM.IDPreInventoryMov,
		PIM.ModelID,
	 	PIM.Qty,
		PIM.SalePrice,
		PIM.Discount
	FROM
		PreInventoryMov PIM (NOLOCK)
		JOIN Model M (NOLOCK) ON (M.IDModel = PIM.ModelID)
	WHERE
		PIM.DocumentID = @IDPreSale
		AND
		PIM.InventMovTypeID = 1
		AND
		M.CustomSalePrice = 0 
		AND 
		M.SellingPrice <> 0

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
		@Discount = ROUND((@SalePrice * (CD.Discount / 100)),2) * @Qty
	FROM
		Ent_CustomerDiscount CD (NOLOCK) 
		JOIN Model M (NOLOCK) ON (CD.IDGroup = M.GroupID)
		JOIN Pessoa P (NOLOCK) ON (CD.IDTipoPessoa = P.IDTipoPessoa)
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
