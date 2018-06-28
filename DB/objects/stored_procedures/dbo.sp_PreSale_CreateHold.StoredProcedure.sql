SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[sp_PreSale_CreateHold]
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
	@CustomerDOC		varchar(20) = null,
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
	16 Jun	2006		Rodrigo Costa		Adicionado os parametros para ErrorHistory
	19 Aug	2009		Rodrigo Costa		Adiconar o CPF/CGC do cliente ns nota
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
	PrintNotes,
	CompanyCGC
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
	@PrintNotes,
	@CustomerDOC
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

	DECLARE @ErrorLevelStr varchar(510)
	DECLARE @Params varchar(500)	
	SET @Params = ' [ @IDCustomer = ' + CAST(@IDCustomer AS VARCHAR) + 
			' @IDTouristGroup = ' + CAST(@IDTouristGroup AS VARCHAR) +  
			' @MediaID = ' + CAST(@MediaID AS VARCHAR) + 
			' @DeliverTypeID = '  + CAST(@DeliverTypeID AS VARCHAR) + 
			' @IDOtherCommission = '  + CAST(@IDOtherCommission AS VARCHAR) + 
			' @IDStore = '  + CAST(@IDStore AS VARCHAR) + ' ] '
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR) + @Params


	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PreSale_CreateHold', @ErrorLevelStr
 
	RETURN @ErrorLevel
GO
