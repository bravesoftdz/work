if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Inventory_UpdateABC]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Inventory_UpdateABC]
GO

CREATE PROCEDURE sp_Inventory_UpdateABC
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		Classifiçao ABC do Inventário

		- Crio uma tabela temporaria, ordenada descendentemente por Profit
		- Marco a Primeira fatia como A, a intermediaria como B e o resto como C
		- Uso a tabela temporaria para atualizar os modelos

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Marco as linhas conforme os cortes definidos nos parametros
		-202  Erro em Atualizo os Modelos


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	09 Sept 1999		Eduardo Costa		Criacao;
	25 June 2001		Davi Gouveia		Log de Return Values
	18 Aug 2004		Rodrigo Costa		Gravar error log
	16 Nov 2005		Leonardo Riego		Modificado Classificação ABC 
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */


DECLARE @ActualLine 	Int
DECLARE @TotalItems 	Int
DECLARE @ErrorLevel 	int
DECLARE @SysError	int

SET @ErrorLevel = 0

SELECT
	ModelID, -- Modelo ordenado DESC por profit
	' ' ABC  -- Para ser preenchido depois
INTO 
	#ABCTemp
FROM
	InventoryMov
WHERE	((
	(DatePart(Year, MovDate)-1) = (DatePart(Year, GetDate()) - 1)
	AND
	DatePart(Month, MovDate) >= DatePart(Month, GetDate())
	)
	OR
	(
	DatePart(Year, MovDate) = DatePart(Year, GetDate())
	AND
	DatePart(Month, MovDate) <= DatePart(Month, GetDate())
	))
	AND
	InventMovTypeID = 1
GROUP BY 
	ModelID
ORDER BY 
	SUM(Qty*CostPrice) DESC

-- Inicializo o contador da linha
SELECT  @ActualLine = 0


-- Guardo quantas linhas existem
SELECT 
	@TotalItems = COUNT(ModelID)
FROM 	
	#ABCTemp

 
-- Marco as linhas conforme os cortes definidos nos parametros
UPDATE 
	#ABCTemp
SET
	@ActualLine = @ActualLine + 1,
	ABC = 	CASE
			WHEN 	@ActualLine <= (@TotalItems * .20) THEN 'A'

			WHEN 	((@TotalItems * .20) < @ActualLine)
				AND
				(@ActualLine <= (@TotalItems * .50)) THEN 'B'

			ELSE  'C'
		END

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END


-- Atualizo os Modelos
UPDATE
	Model
SET
	Model.ClasseABC = ABCT.ABC
FROM
	#ABCTemp ABCT
WHERE
	Model.ClasseABC <> 'E'
	AND
	Model.ClasseABC <> ABCT.ABC
	AND
	Model.IDModel = ABCT.ModelID

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -202
	GOTO ERRO
END


-- Drop a tabela temporaria
DROP TABLE #ABCTemp


OK:
	RETURN 0

ERRO:
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_Inventory_UpdateABC', @ErrorLevelStr

	RETURN @ErrorLevel
GO
