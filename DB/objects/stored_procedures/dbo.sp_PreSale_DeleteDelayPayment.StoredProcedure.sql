SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_PreSale_DeleteDelayPayment]
			(
			@PreSaleID	int,
			@IDUser	int
			)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Deleta os lancamentos

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Deletar o simgle payment


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	22 Set  2004		Rodrigo Costa		Criação
	12 Nov 2004		Carlos Lima		Suporte a Crédito do Cliente
	07 Jan 2005		Carlos Lima		Alteração para que somente os campos marcados com
							IsPreDatado = 1 sejam filtrados
	30 Mar	2005		Rodrigo Costa		Nova chamada para DelSinglePayment
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */



BEGIN TRAN

DECLARE @ErrorLevel		int
DECLARE @SysError		int


-- Variáveis para o cursor Cursor_Lanc
DECLARE @IDLancamento		int

SET @ErrorLevel = 0

DECLARE Cursor_Lanc CURSOR FOR
	SELECT
		L.IDLancamento
	FROM
		Fin_Lancamento L (NOLOCK) 
		JOIN MeioPag MP (NOLOCK) ON (L.IDQuitacaoMeioPrevisto = MP.IDMeioPag 
				   AND (MP.Tipo IN (2,4)) AND L.IsPreDatado = 1)
	WHERE
		L.IDPreSale = @PreSaleID
		

OPEN Cursor_Lanc

FETCH NEXT FROM Cursor_Lanc INTO
	@IDLancamento

WHILE @@FETCH_STATUS = 0
BEGIN
	/*----------------------------------------------------------------*/
	/*	Deleta os Lancamentos	*/
	/*---------------------------------------------------------------*/
	EXEC sp_PreSale_DeleteSingleDelayPayment @IDLancamento, @IDUser

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		CLOSE Cursor_Lanc
		DEALLOCATE Cursor_Lanc
		SET @ErrorLevel = -201
		GOTO ERRO
	END

	FETCH NEXT FROM Cursor_Lanc INTO
		@IDLancamento
END

CLOSE Cursor_Lanc
DEALLOCATE Cursor_Lanc

OK:
	COMMIT TRAN
	RETURN 0
ERRO:
	ROLLBACK TRAN
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PreSale_DelLancamento', @ErrorLevelStr

	RETURN @ErrorLevel
GO
