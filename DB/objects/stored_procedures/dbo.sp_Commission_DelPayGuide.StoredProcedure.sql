SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
ALTER PROCEDURE [dbo].[sp_Commission_DelPayGuide]
		(
		@IDGuide		int,
		@IDLancamento	int
		)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Deleto Lancamento/Quitacao
		- Deleto Quitacao
		- Deleto Lancamento
		- Deleta o Lancamento no Cost do Grupo
		- Deleta o pagamento nos grupos

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Deleto Lancamento/Quitacao
		-202  Erro em Deleto Quitacao
		-203  Erro em Deleto Lancamento
		-204  Erro em Deleta o Lancamento no Cost do Grupo
		-205  Erro em Deleta o pagamento nos grupos


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
	22 June 2001		Davi Gouveia		Log de Return Values
	18 Aug 2004		Rodrigo Costa		Gravar error log
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */



DECLARE @IDQuitacao 	int
DECLARE @ErrorLevel 		int
DECLARE @SysError		int

SET @ErrorLevel = 0

if not (@IDGuide > 0)
   return

BEGIN TRAN

/*----------------------------------------------------------------*/
/*		Deleta o registro do pagamento			  */
/*----------------------------------------------------------------*/

SELECT
	LQ.IDQuitacao
INTO
	#QuitacaoToDelete
FROM
	Fin_LancQuit LQ
WHERE
	LQ.IDLancamento = @IDLancamento

-- Deleto Lancamento/Quitacao
DELETE
	Fin_LancQuit
WHERE
	IDLancamento = @IDLancamento

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END

-- Deleto Quitacao
DELETE 
	Q
FROM
	Fin_Quitacao Q
	JOIN
	#QuitacaoToDelete QTD ON (Q.IDQuitacao = QTD.IDQuitacao)

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -202
	GOTO ERRO
END

-- Deleto Lancamento
DELETE 	Fin_Lancamento
WHERE	IDLancamento=@IDLancamento

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -203
	GOTO ERRO
END

DROP TABLE 	#QuitacaoToDelete



/*----------------------------------------------------------------*/
/*	      Deleta o Lancamento no Cost do Grupo	          */
/*----------------------------------------------------------------*/

DELETE GroupCost 

WHERE IDCostType = 3 and
      IDTouristGroup in
  (SELECT 	IDTouristGroup
   FROM 	dbo.TouristGroup	 TG
   WHERE	TG.IDLancPagGuia = @IDLancamento )

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -204
	GOTO ERRO
END

/*----------------------------------------------------------------*/
/*		Deleta o pagamento nos grupos			  */
/*----------------------------------------------------------------*/
UPDATE	TouristGroup
SET	IDLancPagGuia = NULL
WHERE	IDGuide = @IDGuide 		AND
	IDLancPagGuia = @IDLancamento

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -205
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
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_Commission_DelPayGuide', @ErrorLevelStr

	RETURN @ErrorLevel
GO
