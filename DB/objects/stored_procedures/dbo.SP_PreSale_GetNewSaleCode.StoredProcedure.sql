SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[SP_PreSale_GetNewSaleCode]
	(
	@IDPreSaleParent 	int, 
	@IDStore 		int, 
	@SaleCode 		varchar(20) output
	) 
AS

DECLARE @ParentSaleCode 	varchar(20)
DECLARE @MiddleSaleCode 	varchar(50)
DECLARE @PartitionCount 	varchar
DECLARE @ConcatStr 		varchar(50)

DECLARE @ErrorLevel  		int
DECLARE @SysError  		int


/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Crio um novo SaleCode
		- Busco o SaleCode do pai

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Crio um novo SaleCode
		-202  Busco o SaleCode do pai


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	01 Nov  2000		Carlos Lima		Criacao;
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

SET @ErrorLevel = 0
 
BEGIN TRAN



IF @IDPreSaleParent IS NULL
	BEGIN
		SET @ConcatStr = 'Invoice.SaleCode' + CONVERT(varchar, @IDStore)
		EXEC sp_Sis_GetNextCode @ConcatStr, @MiddleSaleCode OUTPUT

		SET @SysError = @@ERROR
		IF @SysError <> 0
		BEGIN
			SET @ErrorLevel = -201
			GOTO ERRO 
		END
	END
ELSE
	BEGIN
		SELECT
			@ParentSaleCode = SaleCode
		FROM
			Invoice (NOLOCK) 
		WHERE
			IDPreSale = @IDPreSaleParent


		SELECT
			@PartitionCount = (COUNT(*) + 1)
		FROM
			Invoice (NOLOCK) 
		WHERE
			IDPreSaleParent = @IDPreSaleParent


		SET @MiddleSaleCode = @ParentSaleCode + '-' + CONVERT(varchar, @PartitionCount)

		SET @SysError = @@ERROR
		IF @SysError <> 0
		BEGIN
			SET @ErrorLevel = -202
			GOTO ERRO 
		END
	END

SET @SaleCode = CONVERT(varchar(20), @MiddleSaleCode)

 
OK:
	COMMIT TRAN
	RETURN 0
ERRO:
	ROLLBACK TRAN
	PRINT CAST(@ErrorLevel AS VARCHAR)
 
	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: SP_PreSale_GetNewSaleCode', @ErrorLevelStr
 
	RETURN @ErrorLevel
GO
