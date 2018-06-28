SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_PreSale_AddCustomerCredit]
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
