if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_UpHold]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_UpHold]
GO

CREATE PROCEDURE sp_PreSale_UpHold
			(
			@IDPreSaleOrigem 	int,
			@IDPreSaleDestino	int,
			@Date			DateTime,
			@IDUser		int
			)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Atualizo PreInventoryMov

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Atualizo PreInventoryMov
		-202  Erro em exec sp_PreSale_SubCalcTotal
		-203  Erro em exec sp_PreSale_Remove
		-204  Erro em mover os outros costos
		-205  Erro em mover os lancamentos


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
	26 June 2001		Davi Gouveia		Log de Return Values
	18 Aug	2004		Rodrigo Costa		Gravar error log
	19 Jan	2005		Rodrigo Costa		Mover os outros Custos & Pagamentos
	23 May	2005		Rodrigo Costa		Criado parametro @IDUser
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

DECLARE @ErrorLevel	int
DECLARE @SysError	int

SET @ErrorLevel = 0

BEGIN TRAN
 -- Atualizo PreInventoryMov
UPDATE
	PreInventoryMov
SET
	DocumentID = @IDPreSaleDestino
WHERE
	DocumentID = @IDPreSaleOrigem
	AND
	InventMovTypeID = 1

SET @SysError = @@ERROR
IF @SysError <> 0 
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END 


--Copiar os outros custos para o novo PreSale
UPDATE
	InvoiceToCostType
SET
	IDPreSale = @IDPreSaleDestino
WHERE
	IDPreSale = @IDPreSaleOrigem

SET @SysError = @@ERROR
IF @SysError <> 0 
BEGIN
	SET @ErrorLevel = -204
	GOTO ERRO
END 

--Copiar os lancamestos para o novo PreSale
UPDATE
	Fin_Lancamento
SET
	IDPreSale = @IDPreSaleDestino
WHERE
	IDPreSale = @IDPreSaleOrigem

SET @SysError = @@ERROR
IF @SysError <> 0 
BEGIN
	SET @ErrorLevel = -205
	GOTO ERRO
END 

exec sp_PreSale_SubCalcTotal @IDPreSaleDestino, @Date

SET @SysError = @@ERROR
IF @SysError <> 0 
BEGIN
	SET @ErrorLevel = -202
	GOTO ERRO
END

exec sp_PreSale_Remove @IDPreSaleOrigem, @IDUser

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
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PreSale_UpHold', @ErrorLevelStr

	RETURN @ErrorLevel
GO
