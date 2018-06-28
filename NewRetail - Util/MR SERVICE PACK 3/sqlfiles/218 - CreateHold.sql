if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_CreateHold]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_CreateHold]
GO

CREATE PROCEDURE sp_PreSale_CreateHold
	(
	@IDCustomer 		int, 
	@IDTouristGroup 	int, 
	@PreSaleDate 		smalldatetime, 
	@MediaID		int, 
	@DeliverTypeID 		int, 
	@IDOtherCommission 	int, 
	@FirstName		varchar(20), 
	@LastName		varchar(20), 
	@Layaway		bit, 
	@IDStore		int, 
	@Zip			varchar(20),
	@Note			varchar(150), 
	@PrintNotes		bit,
	@IDPreSale		int output
	) 
AS

DECLARE @SaleCode	varchar(20)

DECLARE @ErrorLevel  	int
DECLARE @SysError  	int


/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO
		- Gero um novo número de Pedido
		- Crio um novo Invoice

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Gero um novo número de Pedido
		-202  Erro em Crio um novo Invoice


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	03 Nov  2000		Carlos Lima		Criacao;
	09 May	2005		Rodrigo Costa		Retirado o criar SaleCode
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

SET @ErrorLevel = 0
 
BEGIN TRAN

EXEC sp_Sis_GetNextCode 'Invoice.IDPresale', @IDPreSale output

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO 
END

INSERT Invoice 
	(
	IDPreSale, 
	IDCustomer, 
	IDTouristGroup, 
	PreSaleDate, 
	MediaID, 
	DeliverTypeID, 
	OtherComissionID, 
	FirstName, 
	LastName, 
	Layaway, 
	IDStore, 
	Zip, 
	Note, 
	PrintNotes
	) 
VALUES 
	(
	@IDPreSale, 
	@IDCustomer, 
	@IDTouristGroup, 
	@PreSaleDate, 
	@MediaID, 
	@DeliverTypeID, 
	@IDOtherCommission, 
	@FirstName, 
	@LastName, 
	@Layaway, 
	@IDStore, 
	@Zip, 
	@Note, 
	@PrintNotes
	)

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
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PreSale_CreateHold', @ErrorLevelStr
 
	RETURN @ErrorLevel
GO
