if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_Remove]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_Remove]
GO

CREATE PROCEDURE sp_PreSale_Remove
			(
				@PreSaleID	int,
				@IDUser		int
			)
AS

/* ---------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Deleto PreSerialMov
		- Remove InventoryMov
		- Deleta os pagamentos
		- Remove o Invoice

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Delecao do PreSerialMov
		-202  Erro em Remove the Inventory Mov
		-203  Erro em Remover os lancamentos
		-207  Erro em Remove the Invoice
		-208  Erro em Remove historico
		-208  Erro em Remove outros custos
		-209  Erro em Deletar Account Number
		-210  Erro em Deletar Item repair
		-211  Erro em Remove the Shipping
		-212  Erro no Update Sal_RebateDiscount

	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	-----------------------	-----------------------	----------------------------------------------------------------------------------
	15 May	2000		Eduardo Costa		Criacao;
	26 Jun	2001		Davi Gouveia		Log de Return Values;
	19 Jul	2001		Davi Gouveia		Exclusao de testes se Hold está sendo usado, visto q o teste ja é feito no Delphi;
	18 Aug	2004		Rodrigo Costa		Gravar error log;
	25 Oct	2004		Rodrigo Costa		Deleta os Historicos dos pedidos;
	19 Jan	2005		Rodrigo Costa		Deleta os outros custos do pedido;
	22 Mar	2006		Rodrigo Costa		Deletar Account Number;
	03 Apr	2006		Rodrigo Costa		Deletar o Item Repair;
	14 Feb	2007		Maximiliano Muniz	Deletar da tabela Sal_InvoiceShipping;
	21 Mar	2007		Maic Nogueira		Update na tabela Sal_RebateDiscount para remover o vínculo com a tabela Invoice;
	---------------------------------------------------------------------------------------------------------------------------------- */

DECLARE @IsLayaway	bit
DECLARE @ErrorLevel	int 
DECLARE @SysError	int
DECLARE @IDPreInvMovOld	int
SET @ErrorLevel = 0

BEGIN TRAN

/*----------------------------------------------*/
/*	Deleta os Historicos dos pedidos	*/
/*----------------------------------------------*/
DELETE
	H
FROM
	History H
WHERE
	H.IDPreSale = @PreSaleID

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -208
	GOTO ERRO
END

/*--------------------------------------*/
/*	Delecao do Account Number	*/
/*--------------------------------------*/
DELETE
	AC
FROM
	PreInventoryMov PIM
	JOIN Sal_AccountCard AC ON (PIM.IDPreInventoryMov = AC.IDPreInventoryMov)
WHERE
	PIM.DocumentID = @PreSaleID
	AND
	PIM.InventMovTypeID = 1

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -209
	GOTO ERRO
END


/*--------------------------------------------------------------*/
/*		Delecao do Sal_ItemRepair	        */
/*--------------------------------------------------------------*/
DELETE
	IR
FROM
	PreInventoryMov PIM
	JOIN Sal_ItemRepair IR ON (PIM.IDPreInventoryMov = IR.IDPreInventoryMov)
WHERE
	PIM.DocumentID = @PreSaleID
	AND
	PIM.InventMovTypeID = 1

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -210
	GOTO ERRO
END


/*--------------------------------------------------------------*/
/*	Delecao do PreSerialMov	        */
/*--------------------------------------------------------------*/
DELETE
	PSM
FROM
	PreInventoryMov PIM
	JOIN PreSerialMov PSM ON (PSM.PreInventoryMovID = PIM.IDPreInventoryMov)
WHERE
	PIM.DocumentID = @PreSaleID
	AND
	PIM.InventMovTypeID = 1

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END

/*----------------------------------------------------------------*/
/*	Remove the PreInventoryMov		  */
/*----------------------------------------------------------------*/
--Declaração do Cursor de PreInvDel_Cursor
DECLARE PreInvDel_Cursor CURSOR STATIC FOR 
	SELECT
		IDPreInventoryMov
	FROM
		PreInventoryMov
	WHERE
		DocumentID = @PreSaleID
		AND 
		InventMovTypeID = 1

OPEN PreInvDel_Cursor

--Inicialização de PreInv_Cursor
FETCH NEXT FROM PreInvDel_Cursor INTO
            @IDPreInvMovOld

--Enquanto tem registros
WHILE @@FETCH_STATUS = 0
BEGIN
	--Deletar os items
	EXEC sp_PreSale_SubRemoveItem @IDPreInvMovOld

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
	            SET @ErrorLevel = -202
	            GOTO ERRO
	END

            FETCH NEXT FROM PreInvDel_Cursor INTO
                        @IDPreInvMovOld
END

--fechamento do cursor
CLOSE PreInvDel_Cursor
--Destruição do cursor
DEALLOCATE PreInvDel_Cursor

/*--------------------------------------*/
/*	Deleta os pagamentos		*/
/*--------------------------------------*/

EXEC sp_PreSale_DeletePayments @PreSaleID, @IDUser

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
            SET @ErrorLevel = -203
            GOTO ERRO
END

-- Remove os outros custos
DELETE
	C
FROM
	InvoiceToCostType C
WHERE
	C.IDPreSale = @PreSaleID

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -209
	GOTO ERRO
END

/*------------------------------*/
/*	Remove the Shipping	*/
/*------------------------------*/
DELETE
	Sal_InvoiceShipping
WHERE
	IDPreSale = @PreSaleID

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -211
	GOTO ERRO
END

/*--------------------------------------*/
/*	Update Sal_RebateDiscount	*/
/*--------------------------------------*/
UPDATE
	Sal_RebateDiscount
SET
	IDPreSaleUsed = NULL
WHERE
	IDPreSaleUsed = @PreSaleID

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -212
	GOTO ERRO
END

/*------------------------------*/
/*	Remove the Invoice	*/
/*------------------------------*/
DELETE
	I
FROM
	Invoice I
WHERE
	I.IDPreSale = @PreSaleID
	AND
	I.IDInvoice IS  NULL 

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -207
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
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PreSale_Remove', @ErrorLevelStr
	RETURN @ErrorLevel
GO
