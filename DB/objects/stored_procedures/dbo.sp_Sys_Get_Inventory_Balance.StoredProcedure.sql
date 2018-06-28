SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[sp_Sys_Get_Inventory_Balance] (
	@IDModel	int,
	@IDStore	int,
	@MovDate	DateTime,
	@Balance	float output
) AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO
		
		- Calculo o balance

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em calcular o balance

	LOG DE MODIFICAÇÕES

	Data		Programador				Modificação
	--------------- --------------------------------------- ------------------------------------------------------------------------------
	19 May 2008	Rodrigo Costa				Criação
	--------------------------------------------------------------------------------------------------------------------------------------*/

DECLARE @ErrorLevel	int
DECLARE @SysError	int

SELECT
	@Balance = SUM( IsNull(IM.Qty * (2*IMT.UpdateOnHand-1), 0) )
FROM
	InventoryMov IM (NOLOCK) 
	INNER JOIN InventoryMovType IMT (NOLOCK) ON (IM.InventMovTypeID = IMT.IDInventMovType)
WHERE
	IM.ModelID = @IDModel
	AND
	IM.StoreID = @IDStore
	AND
	IM.MovDate < @MovDate

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END

OK:
	RETURN 0

ERRO:

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_Sys_Get_Inventory_Balance', @ErrorLevelStr

	RETURN @ErrorLevel
GO
