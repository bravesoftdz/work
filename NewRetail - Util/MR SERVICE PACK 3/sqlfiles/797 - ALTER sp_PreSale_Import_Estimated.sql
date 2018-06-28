if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_Import_Estimated]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_Import_Estimated]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_Remove]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_Remove]
GO

CREATE PROCEDURE sp_PreSale_Import_Estimated
			(
			@IDEstimated		int,
			@TaxIsent		bit,
			@MediaID		int,
			@IDStore		int,
			@IDUser		int,
			@UpdateSalePrice	bit,
			@NewIDPreSale	int   Output 			
			)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Cria um novo cabeçalho para o PreSale
		- Inclui os items do orcamento

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Cria um novo cabeçalho para o PreSale
		-202  Erro em Atualizar o Orcamento
		-203  Erro ao importas os items do orcamento
		-204  Erro em exec sp_PreSale_SubCalcTotal
		-206  Erro em inserir comissao
		-207  Erro em Atualizar a sugestao de pgto


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	-----------------------	-----------------------	-----------------------------------------------------------------
	19 Aug  2005		Rodrigo Costa		Criacao;
	09 Dec	2005		Rodrigo Costa		Inclusao da comissao;
	24 Feb	2006		Maximiliano Muniz	Ordenação dos itens por código;
	25 Jul	2007		Maximiliano Muniz	Teste do tipo de tela de venda, para o valor do campo LAYAWAY;
	30 Jul	2007		Maximiliano Muniz	Corrigigo tamanho do OBS a ser importado (150 caracteres);
	08 Aug	2007		Maximiliano Muniz	Inclusão do campo IDDepartment na importação dos dados;
	20 Aug	2007		Rodrigo Costa		Removido a opcao de atualizar Cliente Para Prospect
	09 Jun	2008		Rodrigo Costa		Adicionado o campo de IDTourGroup na importacao
	16 Jun	2008		Rodrigo Costa		Importar DeliveryInfo e Atualizar Sugetao de Pagamentos
	----------------------------------------------------------------------------------------------------------------- */

DECLARE @ErrorLevel		int
DECLARE @SysError		int
--Declaração de variáveis para o Cursor de PreInventoryMov
DECLARE @InventMovTypeID 	int 
DECLARE @StoreID		int
DECLARE @DocumentID 		int 
DECLARE @ModelID 		int 
DECLARE @MovDate 		smalldatetime 
DECLARE @Qty 			float
DECLARE @CostPrice 		money 
DECLARE @SalePrice 		money 
DECLARE @IDPessoa 		int 
DECLARE @DateEstimatedMov 	smalldatetime 
DECLARE @DateRealMov 		smalldatetime 
DECLARE @ComissionID 		int 
DECLARE @IDPreInventoryMov	int
DECLARE @DesiredMarkup		money
DECLARE @Date			DateTime
DECLARE @IDSaleItemCommission	int
DECLARE @Layaway		bit
DECLARE @IDDepartment		int

SET @ErrorLevel = 0

SELECT @Layaway = CAST((CASE WHEN CAST(SrvValue AS INT) = 2 THEN 1 ELSE 0 END) AS BIT) FROM Param WHERE IDParam = 63

BEGIN TRAN
 
/*---------------------------------------------------------------------*/
/*                  Cria um novo cabeçalho para o PreSale              */
/*---------------------------------------------------------------------*/ 

EXEC sp_Sis_GetNextCode 'Invoice.IDPreSale', @NewIDPreSale OUTPUT
INSERT Invoice	(
		IDPreSale,
		IDStore,
 		PreSaleDate,
		IDCustomer,
		IDTouristGroup,
		TaxIsent,
		MediaID,
		FirstName,
		LastName,
		Layaway,
		Note,
		DeliverTypeID,
		DeliverDate,
		DeliverAddress,
		DeliverOBS
		)
		SELECT
			@NewIDPreSale,
			E.IDStore,
 			GetDate(),
			IsNull(E.IDPessoa,0),
			IDTouristGroup,
 			@TaxIsent,
			@MediaID,
			P.PessoaFirstName,
			P.PessoaLastName,
			@Layaway,
			CAST((isNull(E.OBS, '') + char(13) + char(10) + isNull(E.OBS2, '')) AS VARCHAR(150)) as OBS,
			IDDeliverType,
			DeliverDate,
			DeliverAddress,
			DeliverOBS
		FROM
			Estimated E (NOLOCK) 
			LEFT OUTER JOIN Pessoa P (NOLOCK) ON (P.IDPessoa = E.IDPessoa)
		WHERE
			E.IDEstimated = @IDEstimated

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END

-- Atualizo o orcamento
UPDATE
	Estimated
SET
	IDPreSale = @NewIDPreSale
WHERE
	IDEstimated = @IDEstimated


SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -202
	GOTO ERRO
END

/*---------------------------------------------------------------------*/
/*           Inclui os items marcados para o novo PreSale              */
/*---------------------------------------------------------------------*/
--Declaração do Cursor de PreInventoryMov
DECLARE PreInventoryMov_Cursor CURSOR FOR

		SELECT
			1,
			@NewIDPreSale,
			@IDStore,
			EI.IDModel,
			GetDate(),
			EI.Qty,
			IsNull(M.VendorCost, M.VendorCost),
			CASE @UpdateSalePrice WHEN 1 THEN M.SellingPrice ELSE EI.SalePrice END,
			IsNull(E.IDPessoa,0),
			E.EstimatedDate,
			GetDate(),
			SU.ComissionID,
			TG.DesiredMarkup,
			EI.IDDepartment
		FROM
			EstimatedItem EI (NOLOCK) 
			JOIN Model M (NOLOCK) ON (M.IDModel = EI.IDModel) 
			JOIN TabGroup TG (NOLOCK) ON (M.GroupID = TG.IDGroup) 
			JOIN Estimated E (NOLOCK) ON (E.IDEstimated = EI.IDEstimated)
			JOIN SystemUser SU (NOLOCK) ON (SU.IDUser = E.IDUser)
		WHERE
			EI.IDEstimated = @IDEstimated
		ORDER BY
			EI.Code

OPEN PreInventoryMov_Cursor

--Inicialização de PreInventoryMov_Cursor
FETCH NEXT FROM PreInventoryMov_Cursor INTO
	@InventMovTypeID,
	@DocumentID,
	@StoreID,
	@ModelID,
	@MovDate,
	@Qty,
	@CostPrice,
	@SalePrice,
	@IDPessoa,
	@DateEstimatedMov,
	@DateRealMov,
	@ComissionID,
	@DesiredMarkup,
	@IDDepartment

--Enquanto tem registros
WHILE
@@FETCH_STATUS = 0
BEGIN
	EXEC sp_Sis_GetNextCode'PreInventoryMov.IDPreInventoryMov', @IDPreInventoryMov OUTPUT

	INSERT PreInventoryMov
		(
		IDPreInventoryMov,
		InventMovTypeID,
		UserID,
		DocumentID,
		StoreID,
		ModelID,
		MovDate,
		Qty,
		CostPrice,
		SalePrice,
		IDPessoa,
		DateEstimatedMov,
		DateRealMov,
		DesiredMarkup,
		IDDepartment
		)
	VALUES
		(
		@IDPreInventoryMov,
		@InventMovTypeID,
		@IDUser,
		@DocumentID,
		@StoreID,
		@ModelID,
		@MovDate,
		@Qty,
		@CostPrice,
		@SalePrice,
		@IDPessoa,
		@DateEstimatedMov,
		@DateRealMov,
		@DesiredMarkup,
		@IDDepartment
		)

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		CLOSE PreInventoryMov_Cursor
		DEALLOCATE PreInventoryMov_Cursor
		SET @ErrorLevel = -203
		GOTO ERRO
	END

	
	/*****************************************************************************************
		Inclusão do Comissionado na tabela de SaleItemCommission
	******************************************************************************************/
	EXEC sp_Sis_GetNextCode'SaleItemCommission.IDSaleItemCommission', @IDSaleItemCommission OUTPUT
	INSERT INTO dbo.SaleItemCommission
		(
		 IDSaleItemCommission,
		 IDPreInventoryMov,
		 IDCommission,
		 CommissionPercent
		)
		VALUES
		(
		 @IDSaleItemCommission,
		 @IDPreInventoryMov,
		 @ComissionID,
		 100
		)
	
	SET @SysError = @@ERROR
	IF @SysError <> 0 
	BEGIN
		SET @ErrorLevel = -206
		GOTO ERRO
	END


	FETCH NEXT FROM PreInventoryMov_Cursor INTO
		@InventMovTypeID,
		@DocumentID,
		@StoreID,
		@ModelID,
		@MovDate,
		@Qty,
		@CostPrice,
		@SalePrice,
		@IDPessoa,
		@DateEstimatedMov,
		@DateRealMov,
		@ComissionID,
		@DesiredMarkup,
		@IDDepartment
END
--fechamento do cursor
CLOSE PreInventoryMov_Cursor
--Destruição do cursor
DEALLOCATE PreInventoryMov_Cursor

/*---------------------------------------------------------------------*/
/*           Atualiza a sugetao de Pgto para o novo PreSale            */
/*---------------------------------------------------------------------*/
UPDATE
	Sal_PaymentCondition
SET
	IDPreSale = @NewIDPreSale
WHERE
	IDEstimated = @IDEstimated

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -207
	GOTO ERRO 
END 

/*---------------------------------------------------------------------*/
/*           Recalcular os totais                                      */
/*---------------------------------------------------------------------*/
SET @Date = GetDate()
EXEC sp_PreSale_SubCalcTotal @NewIDPreSale, @Date

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -204
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
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PreSale_Import_Estimated', @ErrorLevelStr

	RETURN @ErrorLevel
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
		-213  Erro em Remove Sal_AccountCardMov
		-214  Erro em Update Estimated
		-215  Erro em Remove InvoiceOBS
		-216  Erro em Remover Sal_PaymentCondition

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
	23 Jul	2007		Maximiliano Muniz	Deleção nas tabelas Sal_AccountCardMov e InvoiceOBS, e update na Estimated;
	16 Jul	2008		Rodrigo Costa		Deleção na tabela de Sal_PaymentCondition;
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
	History H (NOLOCK) 
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
	PreInventoryMov PIM (NOLOCK) 
	JOIN Sal_AccountCard AC (NOLOCK) ON (PIM.IDPreInventoryMov = AC.IDPreInventoryMov)
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
	PreInventoryMov PIM (NOLOCK) 
	JOIN Sal_ItemRepair IR (NOLOCK) ON (PIM.IDPreInventoryMov = IR.IDPreInventoryMov)
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
	PreInventoryMov PIM (NOLOCK) 
	JOIN PreSerialMov PSM (NOLOCK) ON (PSM.PreInventoryMovID = PIM.IDPreInventoryMov)
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
		PreInventoryMov (NOLOCK) 
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
	InvoiceToCostType C (NOLOCK) 
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

/*--------------------------------------*/
/*	Remove the Sal_AccountCardMov	*/
/*--------------------------------------*/

DELETE
	Sal_AccountCardMov
WHERE
	IDPreSale = @PreSaleID

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -213
	GOTO ERRO
END

/*--------------------------------------*/
/*	Update Estimated		*/
/*--------------------------------------*/

UPDATE
	Estimated
SET
	IDPreSale = NULL
WHERE
	IDPreSale = @PreSaleID

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -214
	GOTO ERRO
END

/*------------------------------*/
/*	Remove the InvoiceOBS	*/
/*------------------------------*/

DELETE
	InvoiceOBS
WHERE
	IDPreSale = @PreSaleID

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -215
	GOTO ERRO
END

/*------------------------------*/
/*	Remove Sal_PaymentCondition */
/*------------------------------*/
DELETE
	P
FROM
	Sal_PaymentCondition P
WHERE
	P.IDPreSale = @PreSaleID

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -216
	GOTO ERRO
END


/*------------------------------*/
/*	Remove the Invoice	*/
/*------------------------------*/
DELETE
	I
FROM
	Invoice I (NOLOCK) 
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
