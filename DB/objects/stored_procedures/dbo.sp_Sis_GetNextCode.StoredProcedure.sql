SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_Sis_GetNextCode]
		(
		@Tabela		varchar(100),
		@NovoCodigo	int = 0 output	
		)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Incrementa a tabela de controle de Codigos e retorna o valor 

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Campo nao existe


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	04 November 	2003	Rodrigo Costa		Criação;
	22 Octuber 	2004	Rodrigo Costa		Incliuir Tabelas automaticas
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */


DECLARE @ErrorLevel		int
SET @ErrorLevel = 0

if (@Tabela = 'InventoryMov.IDInventoryMov') BEGIN
	EXEC @NovoCodigo = sp_GetNextKey_IDInventoryMov
END ELSE IF (@Tabela = 'PreInventoryMov.IDPreInventoryMov') BEGIN
	EXEC @NovoCodigo = sp_GetNextKey_IDPreInventoryMov
END ELSE IF (@Tabela = 'Invoice.IDPreSale') BEGIN
	EXEC @NovoCodigo = sp_GetNextKey_IDPreSale
END ELSE IF (@Tabela = 'SaleItemCommission.IDSaleItemCommission') BEGIN
	EXEC @NovoCodigo = sp_GetNextKey_IDSaleItemCommission
END ELSE IF (@Tabela = 'Fin_Lancamento.IDLancamento') BEGIN
	EXEC @NovoCodigo = sp_GetNextKey_IDLancamento
END ELSE IF (@Tabela = 'InvoiceGen.IDInvoice') BEGIN
	EXEC @NovoCodigo = sp_GetNextKey_IDInvoice
END
ELSE
BEGIN
	UPDATE	
		CI
	SET	
		UltimoCodigo = UltimoCodigo + 1,
		@NovoCodigo = UltimoCodigo + 1
	FROM
		Sis_CodigoIncremental CI
	
	WHERE  	
		Tabela = @Tabela
	
	IF (@@ROWCOUNT = 0)
	BEGIN
		DECLARE @LastKey int
		SET @LastKey = (SELECT UltimoCodigo FROM Sis_CodigoIncremental WHERE Tabela = 'LastKey')
		
		SET @NovoCodigo = IsNull(@LastKey,1)
		INSERT Sis_CodigoIncremental (Tabela,  UltimoCodigo) 
		VALUES (@Tabela, @NovoCodigo)
		
		SET @ErrorLevel = -101
		GOTO ERRO
	END
END

OK:
	RETURN 0
ERRO:
	RETURN @ErrorLevel
GO
