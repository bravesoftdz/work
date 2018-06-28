if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_DeleteDelayPayment]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_DeleteDelayPayment]
GO

CREATE PROCEDURE sp_PreSale_DeleteDelayPayment
			(
			@PreSaleID	int
			)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Update Cash RegisterMovent
		- Desquita os lancamentos
		- Deleta os lancamentos

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Deleta os registros de ligacao
		-202  Erro em Deleta os registros de quitacao
		-203  Erro em Deleta os registros de lançamento
		-204  Erro em Update Cash RegisterMovent


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	22 Set 2004		Rodrigo Costa		Criação
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */



BEGIN TRAN

DECLARE @ErrorLevel		int
DECLARE @SysError		int

SET @ErrorLevel = 0

/*----------------------------------------------------------------*/
/*		Update Cash RegisterMovent do dia	     	  */
/*----------------------------------------------------------------*/ 
UPDATE
	CashRegMov	
SET
	CashRegMov.TotalSales = IsNull(CashRegMov.TotalSales, 0) - LM.TotalNominal
FROM
	(SELECT 
		IDCashRegMov,
		SUM(ISNULL(ValorNominal, 0)) AS TotalNominal
	 FROM
		Fin_Lancamento L 
		JOIN MeioPag MP ON (L.IDQuitacaoMeioPrevisto = MP.IDMeioPag 
			   AND (MP.Tipo IN (2,4)))
	 WHERE
		L.IDPreSale = @PreSaleID
	 GROUP BY
		IDCashRegMov) AS LM
WHERE
	CashRegMov.IDCashRegMov = LM.IDCashRegMov

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -204
	GOTO ERRO
END


/*----------------------------------------------------------------*/
/*	       Desquita os lancamentos         			  */
/*----------------------------------------------------------------*/

/*---------------- Deleta os registros de ligacao -------------------- */
DELETE
	LQ
FROM
	Fin_LancQuit LQ
	JOIN Fin_Lancamento L ON (L.IDLancamento = LQ.IDLancamento)
	JOIN MeioPag MP ON (L.IDQuitacaoMeioPrevisto = MP.IDMeioPag 
			   AND MP.Tipo IN (2,4))
WHERE
	L.IDPreSale = @PreSaleID

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END

/*--------------- Deleta os registros de quitacao -----------------*/
DELETE
	Q
FROM
	Fin_Quitacao Q
	JOIN Fin_Lancamento L ON (Q.SparrowInt = L.IDLancamento)
	JOIN MeioPag MP ON (L.IDQuitacaoMeioPrevisto = MP.IDMeioPag 
			   AND MP.Tipo IN (2,4))

WHERE
	L.IDPreSale = @PreSaleID

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -202
	GOTO ERRO
END

/*---------------- Deleta os registros de lançamento --------------------*/
DELETE
	L
FROM 
	Fin_Lancamento L
	JOIN MeioPag MP ON (L.IDQuitacaoMeioPrevisto = MP.IDMeioPag 
			   AND MP.Tipo IN (2,4))
WHERE
	L.IDPreSale = @PreSaleID



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
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PreSale_DelLancamento', @ErrorLevelStr

	RETURN @ErrorLevel
GO
