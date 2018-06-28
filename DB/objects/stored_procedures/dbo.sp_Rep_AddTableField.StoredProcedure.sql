SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_Rep_AddTableField]
		(
		@TableName varchar(60)
		)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 	SUMARIO

		- Inclui a tabela no Rep_Table
		- Inclui os campos ta tabela no Rep_Item

	TABELA DE ERROS PARA RETURN_VALUE

		 @Result  Ok
		-201      Erro em incluir no Rep_Table
		-202      Erro em incluir no Rep_Item


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	06 Dez  2004		Rodigo Costa		Criacao;
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

DECLARE @ErrorLevel		int 
DECLARE @SysError		int

SET @ErrorLevel = 0

BEGIN TRAN 

/*------------------------------------------------------------------------------*/
/*                Testa se o discount total ainda e valido                      */
/*------------------------------------------------------------------------------*/ 

INSERT INTO Rep_table (TableName, TableAlias) VALUES (@TableName,@TableName)
SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END

INSERT INTO Rep_Field (
        tablename,
        fieldname,
        fieldalias,
        datatype,
        selectable,
        searchable,
        sortable,
        autosearch,
        mandatory)
SELECT
        TABLE_NAME,
        COLUMN_NAME AS fieldname,
        COLUMN_NAME AS fieldalias,
        CASE data_type
                WHEN 'INT' THEN 'dtInteger'
                WHEN 'DateTime' THEN 'dtDateTime'
                WHEN 'smalldatetime' THEN 'dtDateTime'
                WHEN 'TBit' THEN 'dtBoolean'
                WHEN 'TControlField' THEN 'dtBoolean'
                WHEN 'Bit' THEN 'dtBoolean'
                WHEN 'Money' THEN 'dtCurrency'
                WHEN 'TValor' THEN 'dtCurrency'
                WHEN 'TValorNull' THEN 'dtCurrency'
                ELSE  'dtString' END AS data_type,
        'T' AS selectable,
        'T' AS searchable,
        'T' AS sortable,
        'T' AS autosearch,
        'T' AS mandatory
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = @TableName

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -202
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
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'System', 'Error: sp_Rep_AddTableField', @ErrorLevelStr

	RETURN @ErrorLevel
GO
