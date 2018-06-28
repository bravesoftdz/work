SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_PreSale_quPreSaleValue]
		(
			@PreSaleID	int
		)
AS

/* ---------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		-

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro no Select

	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	-----------------------	-----------------------	----------------------------------------------------------------------------------
	15 May	2000		Eduardo Costa		Criacao;
	26 Jun	2001		Davi Gouveia		Log de Return Values;
	18 Aug	2004		Rodrigo Costa		Gravar error log;
	28 Set	2004		Rodrigo Costa		Novo Campo AditionalExpenses;
	11 Apr	2007		Maximiliano Muniz	Novo campo InvoiceDiscount;
	---------------------------------------------------------------------------------------------------------------------------------- */

DECLARE @ErrorLevel	int
DECLARE @SysError	int

SET @ErrorLevel = 0

SELECT
	TaxIsent,
	SubTotal ,
	ItemDiscount ,
	I.SpecialPriceID,
	SP.SpecialPrice,
	Tax,
	nOpenUser,
	TaxIsemptValue,
	TaxIsemptItemDiscount,
	AditionalExpenses,
	InvoiceDiscount
FROM
	Invoice I (NOLOCK) 
	LEFT JOIN SpecialPrice SP (NOLOCK) ON (I.SpecialPriceID = SP.IDSpecialPrice)
WHERE
	IDPreSale = @PreSaleID

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
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PreSale_quPreSaleValue', @ErrorLevelStr

	RETURN @ErrorLevel
GO
