if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_CalcCustomerDiscount]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_CalcCustomerDiscount]
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
		COMMIT TRAN
	RETURN @Result
ERRO:
	ROLLBACK TRAN
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PreSale_CalcCustomerDiscount', @ErrorLevelStr

	RETURN @ErrorLevel
GO
