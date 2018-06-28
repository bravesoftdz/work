SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[sp_PreSale_CancelInvoice]
	(
	@IDPreSale int,
	@IDUser int
	)
AS
/* ---------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Transforma Invoice em Hold (Quando necessario)
		- Cancela o Hold

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Transforma Invoice em Hold
		-202  Erro em Cancela o Hold

	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	-----------------------	-----------------------	----------------------------------------------------------------------------------
	24 Mar  2005		Carlos Lima		Criacao;
	04 Jan	2007		Maximiliano Muniz	Retirada a transação
							Alterado o "IF" antes da sp_PreSale_UnPay. Testa agora com "IS" e não com "<>";
	28 Aug	2009		Rodrigo Costa		Salvar o CashRegMov original do cancelamento
	---------------------------------------------------------------------------------------------------------------------------------- */

DECLARE @ErrorLevel	int
DECLARE @SysError	int

DECLARE @IDInvoice	int
DECLARE @IDCashRegMov	int

SELECT
	@IDInvoice = IDInvoice,
	@IDCashRegMov = CashRegMovID
FROM
	Invoice (NOLOCK) 
WHERE
	IDPreSale = @IDPreSale

/* Transforma Invoice em Hold */

IF @IDInvoice IS NOT NULL
	EXEC sp_PreSale_Unpay @IDPreSale

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
            SET @ErrorLevel = -201
            GOTO ERRO
END

EXEC sp_PreSale_CancelHold @IDPreSale, @IDUser

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
            SET @ErrorLevel = -202
            GOTO ERRO
END

--Atualiza o caixa principal do cancelamento
UPDATE
	Invoice
SET
	CashRegMovID = @IDCashRegMov
WHERE
	IDPreSale = @IDPreSale


OK:
            RETURN 0
ERRO:
            RETURN @ErrorLevel
GO
