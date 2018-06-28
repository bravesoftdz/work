if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_AddStoreAccount]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_AddStoreAccount]
GO

CREATE   PROCEDURE sp_PreSale_AddStoreAccount
	(
	@IDPessoa		int,
	@IDUser			int,
	@IDStore		int,
	@IDLancamento		int,
	@TransDate		datetime,
	@Amount			money,
	@IDStoreAccount		int out
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
	07 Apr 2008		Rodrigo Costa		Criacao;
	02 Dez 2009		Rodrigo Costa		Deletar Store Account Temporaria
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

DECLARE @ErrorLevel	int 
DECLARE @SysError	int

SET @ErrorLevel = 0 

BEGIN TRAN

SELECT * from Sal_StoreAccount

DELETE
	Sal_StoreAccount
WHERE
	IDUser = @IDUser
	AND
	IDPessoa = @IDPessoa
	AND
	Amount = @Amount
	AND
	IsUsed = 0
	AND
	IsReceiving = 0
	AND
	Verify = 1
	AND
	IDLancamento IS NULL

EXEC sp_Sis_GetNextCode 'Sal_StoreAccount.IDStoreAccount',  @IDStoreAccount output

INSERT Sal_StoreAccount
	(
	IDStoreAccount,
	IDPessoa,
	IDUser,
	IDStore,
	IDLancamento,
	TransactionDate,
	Amount,
	IsUsed,
	IsReceiving
	)
VALUES
	(
	@IDStoreAccount,
	@IDPessoa,
	@IDUser,
	@IDStore,
	@IDLancamento,
	@TransDate,
	ABS(ISNULL(@Amount, 0)),
	0,
	0
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


	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PreSale_AddStoreAccount', @ErrorLevelStr

	RETURN @ErrorLevel

GO
