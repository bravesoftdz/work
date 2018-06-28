if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_quQtyOnStore]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_quQtyOnStore]
GO

CREATE PROCEDURE sp_PreSale_quQtyOnStore
		(
			@ModelID int
		)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Retorna Qtde do Model por Loja

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro no Select


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
	26 June 2001		Davi Gouveia		Log de Return Values
	18 Aug 2004		Rodrigo Costa		Gravar error log
	19 Nov 2004		Rodrigo Costa		Novo Campo Model.FloatPercent
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

DECLARE @ErrorLevel	int
DECLARE @SysError	int

SET @ErrorLevel = 0

SELECT
	Store.Name ,
	Inventory.QtyOnPreSale ,
	Inventory.QtyOnHand ,
	Inventory.QtyOnOrder ,
	Inventory.QtyOnRepair,
	Inventory.MinQty,
	Inventory.MaxQty,
	Inventory.StoreID ,
	(Model.VendorCost+Model.OtherCost+Model.FreightCost) as CurrentCost,
	Inventory.QtyOnPrePurchase,
	Model.FloatPercent
FROM
	dbo.Inventory Inventory ,
	dbo.Model Model ,
	dbo.Store Store
WHERE
	( Store.IDStore = Inventory.StoreID )
	AND
	( Inventory.ModelID = Model.IDModel )
	AND
	( ModelID = @ModelID )

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END


OK:
	RETURN 0
ERRO:
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PreSale_quQtyOnStore', @ErrorLevelStr

	RETURN @ErrorLevel
GO
