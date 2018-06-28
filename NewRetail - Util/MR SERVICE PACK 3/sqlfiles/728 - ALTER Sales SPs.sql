if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_ChangeItem]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_ChangeItem]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_Import_Estimated]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_Import_Estimated]
GO

CREATE  PROCEDURE sp_PreSale_ChangeItem
	(
	@PreSaleID      	int,
	@ModelID     		int,
	@UserID      		int,
	@IDComission		int,
	@Qty         		float,
	@SalePrice      	money,
	@CostPrice      	money = Null,
	@Discount    		money,
	@MovDate     		smalldatetime,
	@Manager		bit = 0,
	@ResetDiscount		bit = 0,
	@Date			DateTime,
	@PreInvMovParentID	int,
	@IDDepartment		int,
	@Promo			bit,
	@IDDescriptionPrice	int,
	@IDVendorPrice		int,
	@SuggPrice		int,
	@DocumentNumber		varchar(20),
	@IDDocumentType		int,
	@PreInventMovID		int output 
	)
AS
	/* -------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Testa se o discount total ainda e valido
		- Efetivamente remove e inclui o inventory moviment
		- Passa os seriais do item antigo para o novo

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em exec @Result = sp_PreSale_SubTestDiscount
		-202  Erro em exec sp_PreSale_SubResetDiscount
		-209  Erro em exec sp_PreSale_SubCalcTotal

	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	-----------------------	-----------------------	----------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
	26 June 2001		Davi Gouveia		Log de Return Values;
	18 Aug 	2004		Rodrigo Costa		Gravar error log;
	01 Fev 	2005		Rodrigo Costa		Inclusao do IDPreInvMovExchange e qtyExchanged;
	12 Apr 	2006		Leonardo Riego		Novo campo @IDDepartment;
	16 Jun	2006		Rodrigo Costa		Adicionado os parametros para ErrorHistory;
	15 Aug 	2006		Leonardo Riego		Deleção da comissao do item novo e atualização de comissões do item novo;
	10 Aug	2007		Maximiliano Muniz	Novos parâmetros @IDDescriptionPrice, @IDVendorPrice e @SuggPrice;
							Novos parâmetros @DocumentNumber e @IDDocumentType;
	20 Aug	2007		Rodrigo Costa		Editar a tabela de PreInvMov sem deletar e incluir novamente
	---------------------------------------------------------------------------------------------------------------------------------- */

DECLARE @Result  		int
DECLARE @Value			money
DECLARE @StoreID		int
DECLARE @IDCliente		int
DECLARE @IDOldUser		int
DECLARE @OldPreInventoryMovID 	int 
DECLARE @ErrorLevel		int
DECLARE @SysError		int
DECLARE @IDPreInvMovExchange	int
DECLARE @QtyExchanged		float

SET @ErrorLevel = 0

/*------------------------------------------------------------------------------*/
/*                Testa se o discount total ainda e valido                      */
/*------------------------------------------------------------------------------*/
SELECT @Value = IsNull((@Qty * @SalePrice), 0)

IF @Manager = 0
BEGIN
	EXEC @Result = sp_PreSale_SubTestDiscount 	@PreSaleID,
							@ModelID,
							@UserID,
 							@Discount,
							@Value,
							'A', 
							@PreInventMovID

	SET @SysError = @@ERROR
	IF @SysError <> 0 	
	BEGIN
		SET @ErrorLevel = -201
		GOTO ERRO
	END

	IF @ResetDiscount = 1 and @Result <> 0
	BEGIN
		EXEC sp_PreSale_SubResetDiscount	@PreSaleID

		SET @SysError = @@ERROR
		IF @SysError <> 0 	
		BEGIN
			SET @ErrorLevel = -202
			GOTO ERRO
		END
	END
	ELSE
	BEGIN
		IF @Result <> 0
		BEGIN
			RETURN @Result
		END
	END
END

/*-------------------------------------------------------------*/
/*    Efetivamente remove e inclui o inventory moviment        */
/*-------------------------------------------------------------*/
BEGIN TRAN


UPDATE
	PreInventoryMov
SET
	QtyExchanged = @QtyExchanged,
	UserID = @UserID,
	Qty = @Qty,
	SalePrice = @SalePrice,
	CostPrice = @CostPrice,
	Discount = @Discount,
	MovDate = @MovDate,
	IDDepartment = @IDDepartment,
	Promo = @Promo,
	SuggRetail = @SuggPrice
WHERE
	IDPreInventoryMov = @PreInventMovID

if @Result <> 0 	
	rollback tran
else
begin
	exec sp_PreSale_SubCalcTotal @PreSaleID, @Date
	SET @SysError = @@ERROR
	IF @SysError <> 0 	
	BEGIN
		SET @ErrorLevel = -209
		GOTO ERRO
	END
end

OK:
	IF @Result = 0
		COMMIT TRAN
	RETURN @Result
ERRO:
	ROLLBACK TRAN
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(510)
	DECLARE @Params varchar(500)	
	SET @Params = ' [ @ModelID = ' + CAST(@ModelID AS VARCHAR) + ' @UserID = '  + CAST(@UserID AS VARCHAR) + 
			' @IDComission = ' + CAST(@IDComission AS VARCHAR) + ' @Qty = '  + CAST(@Qty AS VARCHAR) +
			' @PreInvMovParentID = '  + CAST(@PreInvMovParentID AS VARCHAR) + 
			' @IDDepartment = ' + CAST(@IDDepartment AS VARCHAR) + ' ] '

	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR) + @Params
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PreSale_ChangeItem', @ErrorLevelStr

	RETURN @ErrorLevel
GO

CREATE  PROCEDURE sp_PreSale_Import_Estimated
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
		TaxIsent,
		MediaID,
		FirstName,
		LastName,
		Layaway,
		Note
		)
		SELECT
			@NewIDPreSale,
			E.IDStore,
 			GetDate(),
			IsNull(E.IDPessoa,0),
 			@TaxIsent,
			@MediaID,
			P.PessoaFirstName,
			P.PessoaLastName,
			@Layaway,
			CAST((isNull(E.OBS, '') + char(13) + char(10) + isNull(E.OBS2, '')) AS VARCHAR(150)) as OBS
		FROM
			Estimated E
			LEFT OUTER JOIN Pessoa P ON (P.IDPessoa = E.IDPessoa)
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
			EstimatedItem EI
			JOIN Model M ON (M.IDModel = EI.IDModel) 
			JOIN TabGroup TG ON (M.GroupID = TG.IDGroup) 
			JOIN Estimated E ON (E.IDEstimated = EI.IDEstimated)
			JOIN SystemUser SU ON (SU.IDUser = E.IDUser)
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
