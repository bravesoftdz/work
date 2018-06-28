SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_PreSale_AtuOpenUser]
		( 
		@PreSaleID 	int,
		@IsOpen  	bit,
		@IsCash  	bit,
		@nOpenUser 	int output
		)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Deleto os InventoryMov
		- Incluo no Inventario se necessario

	TABELA DE ERROS PARA RETURN_VALUE

		-1, 1, @Ret   Ok
		-201              Erro em UPDATE dbo.Invoice


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
	26 June 2001		Davi Gouveia		Log de Return Values
	18 Aug 2004		Rodrigo Costa		Gravar error log
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */


DECLARE @Ret   		int 
DECLARE @NewOpenUser 	int
DECLARE @ErrorLevel		int
DECLARE @SysError		int

SET @ErrorLevel = 0

SELECT @nOpenUser = (SELECT IsNull(nOpenUser, 0) FROM
		     dbo.Invoice (NOLOCK) 
		     WHERE dbo.Invoice.IDPreSale = @PreSaleID) 

SELECT @nOpenUser = IsNull(@nOpenUser, -1)

IF @IsOpen = 1
  begin
    IF @nOpenUser < 0
      begin
       return -1
      end

    if @IsCash = 1
      begin
        if @nOpenUser = 0 
          begin
           SELECT @Ret = 0
           if @IsCash = 1
	      SELECT @NewOpenUser = -1
          end
	else
          begin
           return 1
	  end
      end
    else
      begin
        if @nOpenUser = 0 
           SELECT @Ret = 0
	else
           SELECT @Ret = 1

 	SELECT @NewOpenUser = @nOpenUser + 1
      end
  end
ELSE
  begin
    IF @IsCash = 1
      begin
	if @nOpenUser < 0
           SELECT @NewOpenUser = 0
        else
          begin
            return 1
          end
      end
    else
      begin
	if @nOpenUser > 0
          begin
            SELECT @Ret = 0
            SELECT @NewOpenUser = @nOpenUser - 1
          end
      end
  end
 
BEGIN TRAN

UPDATE dbo.Invoice SET nOpenUser = @NewOpenUser WHERE dbo.Invoice.IDPreSale = @PreSaleID

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END


OK:
	COMMIT TRAN
	RETURN @Ret
ERRO:
	ROLLBACK TRAN
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PreSale_AtuOpenUser', @ErrorLevelStr

	RETURN @ErrorLevel
GO
