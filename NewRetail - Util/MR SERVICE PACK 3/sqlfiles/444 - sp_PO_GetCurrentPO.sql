if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PO_GetCurrentPO]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PO_GetCurrentPO]
GO

CREATE PROCEDURE sp_PO_GetCurrentPO
	(
	@IDStore	int,
	@IDPessoa	int,
	@Date		Datetime,
	@IDPO		int output,
	@NewOne	bit output
	)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Retorna qual o PO aberto para a Store e Pessoa selecionados
		- Caso nao exista inclui um novo

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em INSERT PO


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	04 dezembro 2000	Eduardo Costa		Criação;
	26 June 2001		Davi Gouveia		Log de Return Values
 	21 Oct	2003		Rodrigo Costa		Chamada a sp_Sis_GetNextCode para @IDPO; 
							Removido SET @IDPO = @@IDENTITY;
	18 Aug 2004		Rodrigo Costa		Gravar error log
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

DECLARE @ErrorLevel	int
DECLARE @SysError	int

SET @ErrorLevel = 0

BEGIN TRAN

SET @IDPO 	= Null
SET @NewOne = 0

------------------------------------------------------------------------------
-- Pesquisa por um PO aberto

SELECT
	@IDPO=IDPO
FROM
	PO
WHERE
	PO.IDFornecedor = @IDPessoa
	AND
	PO.Aberto   = 1
	AND
	PO.IDStore  = @IDStore
	AND
	convert(SmallDateTime, convert(varchar, PO.DataPedido, 103), 103) = convert(SmallDateTime, convert(varchar, @Date, 103), 103)


------------------------------------------------------------------------------
-- Verifico se achou algum

IF @IDPO IS NULL
BEGIN
	------------------------------------------------------------------------------
	-- Nao existe, inclui um novo
	EXEC sp_Sis_GetNextCode 'PO.IDPO ', @IDPO OUTPUT
	INSERT
		PO (IDPO, IDFornecedor, DataPedido, Aberto, IDStore)
	VALUES
		(@IDPO, @IDPessoa, @Date, 1, @IDStore)

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		SET @ErrorLevel = -201
		GOTO ERRO
	END

	SET @NewOne = 1
END


OK:
	COMMIT TRAN
	RETURN 0
ERRO:
	ROLLBACK TRAN

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PO_GetCurrentPO', @ErrorLevelStr

	RETURN @ErrorLevel
GO
