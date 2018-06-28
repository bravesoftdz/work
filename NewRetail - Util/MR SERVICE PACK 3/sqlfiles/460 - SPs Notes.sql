if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Model_Adjust]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Model_Adjust]
GO

CREATE PROCEDURE sp_Model_Adjust
		(
	             @QtyOnOrder        	float,
	             @QtyOnRepair       	float,
		@QtyOnPrePurchase  	float,
		@IDModel    	   	int,
		@IDStore      	   	int,
		@Difference 	   	float,
		@IDUser		int,
		@Date			Datetime,
		@Notes			varchar(255), -- Davi
		@IDMovReason	int
		)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Ajuste por entrada ou saida de estoque
		- Atualiza o Inventory

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Ajuste por entrada de estoque
		-202  Erro em Ajuste por saida de estoque
		-203  Erro em Atualiza o Inventory
		-204  Erro em Inserir o InventoryMovReason
		


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
	25 June 2001		Davi Gouveia		Log de Return Values
 	21 Oct	2003		Rodrigo Costa		Chamada a sp_Sis_GetNextCode para @IDInventoryMov; 
							Criado @IDInventoryMov;
	18 Aug 2004		Rodrigo Costa		Gravar error log
	02 Jun 2006		Rodrigo Costa		Inserir o Inventory Mov Reason 
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */


DECLARE @ErrorLevel 		int
DECLARE @SysError		int
DECLARE @IDInventoryMov	int

SET @ErrorLevel = 0

EXEC sp_Sis_GetNextCode 'InventoryMov.IDInventoryMov', @IDInventoryMov OUTPUT
IF @Difference > 0
BEGIN
	/*	Ajuste por entrada de estoque	*/
	INSERT InventoryMov 	(
				IDInventoryMov,
				InventMovTypeID,
				DocumentID,
				StoreID,
				ModelID,
				MovDate,
				Qty,
				IDUser
				)
				VALUES
				(
				@IDInventoryMov,
				4,
				0,
				@IDStore,
				@IDModel,
				@Date,
				Abs(@Difference),
				@IDUser
				)

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		SET @ErrorLevel = -201
		GOTO ERRO
	END


	INSERT Inv_MovComplement 	(
				IDInventoryMov,
				IDMovReason,
				Notes
				)
				VALUES
				(
				@IDInventoryMov,
				@IDMovReason,
				@Notes
				)


	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		SET @ErrorLevel = -204
		GOTO ERRO
	END


END
ELSE
BEGIN
	/*	Ajuste por saida de estoque	*/
	INSERT InventoryMov 	(
				IDInventoryMov,
				InventMovTypeID,
				DocumentID,
				StoreID,
				ModelID,
				MovDate,
				Qty,
				IDUser
				)
				VALUES
				(
				@IDInventoryMov,
				3,
				0,
				@IDStore,
				@IDModel,
				@Date,
				Abs(@Difference),
				@IDUser
				)

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		SET @ErrorLevel = -202
		GOTO ERRO
	END

	INSERT Inv_MovComplement 	(
				IDInventoryMov,
				IDMovReason,
				Notes
				)
				VALUES
				(
				@IDInventoryMov,
				@IDMovReason,
				@Notes
				)


	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		SET @ErrorLevel = -204
		GOTO ERRO
	END


END

OK:
	RETURN 0
ERRO:
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_Model_Adjust', @ErrorLevelStr

	RETURN @ErrorLevel
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Inventory_Adjust]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Inventory_Adjust]
GO

CREATE PROCEDURE sp_Inventory_Adjust
		(
		@IDMovType   	int,
		@IDModel   	int,
		@IDStore   	int,
		@Qty	  	float,
		@IDUser		int,
		@Date		Datetime,
		@Notes		varchar(255),
		@IDMovReason	int
		)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Ajuste estoque
		- Atualiza o Inventory

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Atualiza o Inventory
		-202  Erro ao Inserir o Motivo


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	31 Mar  2006		Rodrigo Costa		Criacao;
	02 Jun	2006		Rodrigo Costa		Inserir no Inv_MovComplement
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */


DECLARE @ErrorLevel 		int
DECLARE @SysError		int
DECLARE @IDInventoryMov	int

SET @ErrorLevel = 0

EXEC sp_Sis_GetNextCode 'InventoryMov.IDInventoryMov', @IDInventoryMov OUTPUT

INSERT InventoryMov 	(
			IDInventoryMov,
			InventMovTypeID,
			DocumentID,
			StoreID,
			ModelID,
			MovDate,
			Qty,
			IDUser
			)
			VALUES
			(
			@IDInventoryMov,
			@IDMovType,
			0,
			@IDStore,
			@IDModel,
			@Date,
			Abs(@Qty),
			@IDUser
			)

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END

INSERT Inv_MovComplement 	(
				IDInventoryMov,
				IDMovReason,
				Notes
				)
				VALUES
				(
				@IDInventoryMov,
				@IDMovReason,
				@Notes
				)



SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -202
	GOTO ERRO
END


OK:
	RETURN 0
ERRO:
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_Inventory_Adjust', @ErrorLevelStr

	RETURN @ErrorLevel
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vwModelHistoryMov]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vwModelHistoryMov]
GO

CREATE VIEW vwModelHistoryMov AS

SELECT
	IMT.Name,
	IM.DocumentID,
	IM.MovDate,
	ISNull((Qty * (IMT.UpdateOnHand * 2 - 1)),0) as Qty,
	CASE Qty
		WHEN 0 THEN SalePrice
		ELSE (SalePrice - (Discount / Qty))
	END as SalePrice,
	IM.IDInventoryMov,
	IMT.System,
	IM.CostPrice,
	IM.AvgCost,
	IM.Freight,
	IM.OtherCost,
	SU.SystemUser,
	IM.ModelID,
	IM.StoreID,
	S.Name as Store
FROM
	InventoryMov IM	
	JOIN InventoryMovType IMT ON (IM.InventMovTypeID = IMT.IDInventMovType)
	LEFT JOIN SystemUser SU ON (IM.IDUser = SU.IDUser)
	JOIN Store S ON (IM.StoreID = S.IDStore)

GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vwSaleItem]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vwSaleItem]
GO

CREATE VIEW vwSaleItem AS
SELECT
	1 as Invoice,
	IM.IDInventoryMov,
	IM.InventMovTypeID,
	IM.DocumentID,
	IM.StoreID,
	IM.Qty,
	IM.CostPrice,
	IM.SalePrice,
	IM.Discount,
	SIC.IDCommission AS ComissionID,
	IM.MovDate,
	IM.ModelID,
	M.GroupID,
	M.Model,
	M.Description,
	TP.IDTipoPessoa,
	GTCT.Comission,
	TP.ComissionOnProfit,
	NULL AS IDCotacao,
	NULL AS IDPreInventoryMovParent,
	NULL AS DateEstimatedMov,
	NULL AS DateRealMov,
	NULL AS QtyRealMov,
	NULL AS Marked,
	NULL AS SuggRetail,
	IM.IDRepair,
	IM.IDPessoa,
	IM.IDAgrupaPag,
	IM.IDTemp,
	IM.IDLancPagCom,
	IM.IDUser,
	IM.BarCodeID,
	IM.PreInventoryMovID AS IDPreInventoryMov,
	IM.Freight,
	IM.OtherCost,
	IM.ExchangeInvoice,
	IM.QtyExchanged,
	IM.SalesTax,
	NULL AS Notes,
	IM.IDParentPack,
	IM.IDModelService,
	IM.IDPreInvMovExchange,
	IM.AvgCost,
	(IM.CostPrice * IM.Qty) as ItemCostTotal,
	((IM.SalePrice * IM.Qty) - IM.Discount) as ItemSaleTotal,
	((((IM.SalePrice - (IM.CostPrice * TP.ComissionOnProfit)) * IM.Qty - IM.Discount)) * (GTCT.Comission / ((100 / SIC.CommissionPercent) * 100))) as ItemCommis,
	IM.DesiredMarkup,
	I.IDPreSale,
	I.PreSaleDate,
	SX.Tax,
	(((IM.SalePrice * IM.Qty) - IM.Discount) * SX.Tax) as TaxValue,
	(((IM.SalePrice * IM.Qty) - IM.Discount) - (IM.CostPrice * IM.Qty) - (((IM.SalePrice * IM.Qty) - IM.Discount) * SX.Tax)) as ItemNetValue
FROM
	InventoryMov IM
	JOIN Model M ON (IM.ModelID = M.IDModel)
	JOIN GroupToComissionType GTCT ON (M.GroupID = GTCT.GroupID)
	JOIN TipoPessoa TP ON (TP.IDTipoPessoa = GTCT.IDTipoComissionado)
	JOIN Invoice I ON (IM.DocumentID = I.IDInvoice AND IM.InventMovTypeID = 1)
	JOIN vwSaleItemTax SX ON (IM.IDInventoryMov = SX.IDMov AND SX.IsInvoice = 1) 
	LEFT JOIN SaleItemCommission SIC ON (SIC.IDInventoryMov = IM.IDInventoryMov)

UNION ALL
 
SELECT
	0 as Invoice,
	PIM.IDPreInventoryMov,
	PIM.InventMovTypeID,
	PIM.DocumentID,
	PIM.StoreID,
	PIM.Qty,
	PIM.CostPrice,
	PIM.SalePrice,
	PIM.Discount,
	SIC.IDCommission AS ComissionID,
	PIM.MovDate,
	M.IDModel,
	M.GroupID,
	M.Model,
	M.Description,
	TP.IDTipoPessoa,
	GTCT.Comission,
	TP.ComissionOnProfit,
	PIM.IDCotacao,
	PIM.IDPreInventoryMovParent,
	PIM.DateEstimatedMov,
	PIM.DateRealMov,
	PIM.QtyRealMov,
	PIM.Marked,
	PIM.SuggRetail,
	NULL AS IDRepair,
	PIM.IDPessoa,
	NULL AS IDAgrupaPag,
	NULL AS IDTemp,
	NULL AS IDLancPagCom,
	PIM.UserID AS IDUser,
	PIM.BarCodeID,
	PIM.IDPreInventoryMov,
	NULL AS Freight,
	NULL AS OtherCost,
	PIM.ExchangeInvoice,
	PIM.QtyExchanged,
	NULL AS SalesTax,
	NULL AS Notes,
	PIM.IDParentPack,
	PIM.IDModelService,
	PIM.IDPreInvMovExchange,
	NULL AS AvgCost,
	(PIM.CostPrice * PIM.Qty) as ItemCostTotal,
	((PIM.SalePrice * PIM.Qty) - PIM.Discount) as ItemSaleTotal,
	((((PIM.SalePrice - (PIM.CostPrice * TP.ComissionOnProfit)) * PIM.Qty - PIM.Discount)) * (GTCT.Comission / ((100 / SIC.CommissionPercent) * 100))) as ItemCommis,
	PIM.DesiredMarkup,
	I.IDPreSale,
	I.PreSaleDate,
	SX.Tax,
	(((PIM.SalePrice * PIM.Qty) - PIM.Discount) * SX.Tax) as TaxValue,
	(((PIM.SalePrice * PIM.Qty) - PIM.Discount) - (PIM.CostPrice * PIM.Qty) - ((PIM.SalePrice * PIM.Qty) - PIM.Discount) * SX.Tax) as ItemNetValue
FROM
	PreInventoryMov PIM
	JOIN Model M ON (PIM.ModelID = M.IDModel)
	JOIN GroupToComissionType GTCT ON (M.GroupID = GTCT.GroupID)
	JOIN TipoPessoa TP ON (TP.IDTipoPessoa = GTCT.IDTipoComissionado)
	JOIN Invoice I ON (PIM.DocumentID = I.IDPreSale AND PIM.InventMovTypeID = 1)
	JOIN vwSaleItemTax SX ON (PIM.IDPreInventoryMov = SX.IDMov AND SX.IsInvoice = 0) 
	LEFT JOIN SaleItemCommission SIC ON (SIC.IDPreInventoryMov = PIM.IDPreInventoryMov)

GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Inventory_Count]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Inventory_Count]
GO

CREATE PROCEDURE sp_Inventory_Count
		(
		@IDModel    	int,
		@IDStore      	int,
		@Difference 	float,
		@CountDate 	SmallDateTime,
		@IDUser	int,
		@Date		Datetime,
		@Notes		varchar(255) -- Davi
		)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		Calcula o total de quantidade movimentada ate a contagem

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Ajuste por entrada de estoque
		-202  Erro em Ajuste por saida de estoque


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
	25 June 2001		Davi Gouveia		Log de Return Values
 	21 Oct	2003		Rodrigo Costa		Chamada a sp_Sis_GetNextCode para @IDInventoryMov; 
							Criado @IDInventoryMov;
	18 Aug 2004		Rodrigo Costa		Gravar error log
	02 Jun	2006		Rodrigo Costa		Removido Notes do InventoryMov
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

DECLARE @TotalMov		int
DECLARE @ErrorLevel 		int
DECLARE @SysError		int
DECLARE @IDInventoryMov	int

SET @ErrorLevel = 0

SELECT @TotalMov = (
		SELECT
			SUM(IM.Qty * (2*IMT.UpdateOnHand-1))
		FROM
			InventoryMov IM Inner Join InventoryMovType IMT on (IM.InventMovTypeID = IMT.IDInventMovType)
		WHERE
			IM.StoreID = @IDStore     
			AND
			IM.ModelID = @IDModel     	
			AND
			IM.MovDate > @CountDate
		   )


SELECT @TotalMov = IsNull(@TotalMov,0)


EXEC sp_Sis_GetNextCode 'InventoryMov.IDInventoryMov', @IDInventoryMov OUTPUT
if (@Difference + @TotalMov) > 0
begin
	/*	Ajuste por entrada de estoque	*/
	INSERT InventoryMov 	(
				IDInventoryMov,
				InventMovTypeID,
				DocumentID,
				StoreID,
				ModelID,
				MovDate,
				Qty,
				IDUser
				)
				VALUES
				(
				@IDInventoryMov,
				21,
				0,
				@IDStore,
				@IDModel,
				@Date,
				Abs(@Difference + @TotalMov),
				@IDUser
				)

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		SET @ErrorLevel = -201
		GOTO ERRO
	END

end
else
begin
	/*	Ajuste por saida de estoque	*/
	INSERT InventoryMov 	(
				IDInventoryMov,
				InventMovTypeID,
				DocumentID,
				StoreID,
				ModelID,
				MovDate,
				Qty,
				IDUser
				)
				VALUES
				(
				@IDInventoryMov,
				22,
				0,
				@IDStore,
 				@IDModel,
				@Date,
				Abs(@Difference + @TotalMov),
				@IDUser
				)
	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		SET @ErrorLevel = -202
		GOTO ERRO
	END
end

OK:
	RETURN 0
ERRO:
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_Inventory_Count', @ErrorLevelStr

	RETURN @ErrorLevel
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Repair_Do]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Repair_Do]
GO

CREATE PROCEDURE sp_Repair_Do 
		(
		@IDRepair	int
		)

AS


/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Deleto os InventoryMov
		- Incluo no Inventario se necessario

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em DELETO O INVMOV
		-202  Erro em Send To Vendor
		-203  Erro em Back From Vendor
		-204  Erro em Inserir Notes
		-205  Erro em deletar o Notes


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 June 2001		Rodrigo Costa		Criacao;
	26 June 2001		Davi Gouveia		Log de Return Values
	28 Oct	2003		Rodrigo Costa		Criacao do InventoryMov Cursor;
							Chama sp_GetNextCode
	18 Aug 2004		Rodrigo Costa		Gravar error log
	19 Dec 2005		Carlos Lima		Correção dos campos do InventoryMov Cursor 
	02 Jun	2006		Rodrigo Costa		Inserir notes no Inventory
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

DECLARE @ErrorLevel		int
DECLARE @SysError		int

--Declaração de variáveis para o Cursor de InventoryMov
DECLARE @InventMovTypeID 	int 
DECLARE @DocumentID 	int 
DECLARE @StoreID 		int 
DECLARE @ModelID 		int 
DECLARE @IDPessoa 		int 
DECLARE @MovDate 		smalldatetime 
DECLARE @Qty 		float
DECLARE @IDUser 		int 
DECLARE @CostPrice 		money 
DECLARE @Notes 		varchar(255)
DECLARE @IDInventoryMov	int

BEGIN TRAN
---------------------------------------
-- DELETO O INVMOV
DELETE
	Inv_MovComplement
FROM
	InventoryMov
WHERE
	Inv_MovComplement.IDInventoryMov = InventoryMov.IDInventoryMov
	AND
	InventoryMov.IDRepair = @IDRepair

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -205
	GOTO ERRO
END

DELETE
	InventoryMov
WHERE
	IDRepair = @IDRepair

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END


---------------------------------------
--- Send To Vendor

--Declaração do Cursor de InventoryMov

DECLARE InventoryMov_Cursor CURSOR FOR

	SELECT
		9,   /* saida por Repair */
		R.IDRepair,
		R.IDRepair,
		R.IDStore,
		R.IDModel,
		0,
		R.SentDate, --Data que foi enviado o Item
		R.Qty,
		R.IDUserSent,
		R.LastCost,
		R.Defect
	FROM
		Repair R
	WHERE
		R.IDRepair = @IDRepair
		AND
		R.SentDate IS NOT NULL
		AND
		R.Tipo = 2 -- so atualiza se for Inventory

OPEN InventoryMov_Cursor

--Inicialização de InventoryMov_Cursor
FETCH NEXT FROM InventoryMov_Cursor INTO
	@InventMovTypeID,
	@IDRepair,
	@DocumentID,
	@StoreID,
	@ModelID,
	@IDPessoa,
	@MovDate,
	@Qty,
	@IDUser,
	@CostPrice,
	@Notes
--Enquanto tem registros
WHILE
@@FETCH_STATUS = 0
BEGIN
	EXEC sp_Sis_GetNextCode'InventoryMov.IDInventoryMov', @IDInventoryMov OUTPUT
	INSERT InventoryMov
		(
		IDInventoryMov,
		InventMovTypeID,
		IDRepair,
		DocumentID,
		StoreID,
		ModelID,
		IDPessoa,
		MovDate,
		Qty,
		IDUser,
		CostPrice
		)
	VALUES
		(
		@IDInventoryMov,
		@InventMovTypeID,
		@IDRepair,
		@DocumentID,
		@StoreID,
		@ModelID,
		@IDPessoa,
		@MovDate,
		@Qty,
		@IDUser,
		@CostPrice
		)

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		CLOSE InventoryMov_Cursor
		DEALLOCATE InventoryMov_Cursor
		SET @ErrorLevel = -202
		GOTO ERRO
	END


	INSERT Inv_MovComplement 	
		(
		IDInventoryMov,
		IDMovReason,
		Notes
		)
		VALUES
		(
		@IDInventoryMov,
		1,
		@Notes
		)


	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		CLOSE InventoryMov_Cursor
		DEALLOCATE InventoryMov_Cursor
		SET @ErrorLevel = -204
		GOTO ERRO
	END

	FETCH NEXT FROM InventoryMov_Cursor INTO
		@InventMovTypeID,
		@IDRepair,
		@DocumentID,
		@StoreID,
		@ModelID,
		@IDPessoa,
		@MovDate,
		@Qty,
		@IDUser,
		@CostPrice,
		@Notes
END
--fechamento do cursor
CLOSE InventoryMov_Cursor
--Destruição do cursor
DEALLOCATE InventoryMov_Cursor

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -202
	GOTO ERRO
END

---------------------------------------
--- Back From Vendor
--Declaração do Cursor de InventoryMov
DECLARE InventoryMov_Cursor CURSOR FOR

	SELECT
		(
		CASE TipoRepair
			WHEN 1 THEN 10   /* Exchanged - Back from Repair */
			WHEN 2 THEN 10   /* Fixed - Back from Repair */
			WHEN 3 THEN 16   /* Repair Damage*/
			WHEN 4 THEN 17   /* Vendor Credit - Repair */
		END
		) as RepairType,
		R.IDRepair,
		R.IDRepair,
		R.IDStore,
		R.IDModel,
		0,
		R.ReturnDate, --Data recebida do Vendor		
		R.Qty,
		R.IDUserReturn, --Usuario que enviou
		R.LastCost,
		R.OBSReturn

	FROM
		Repair R
	WHERE
		R.IDRepair = @IDRepair
		AND
		R.ReturnDate IS NOT NULL
		AND
		R.Tipo = 2 -- so atualiza se for Inventory

OPEN InventoryMov_Cursor

--Inicialização de InventoryMov_Cursor
FETCH NEXT FROM InventoryMov_Cursor INTO
	@InventMovTypeID,
	@IDRepair,
	@DocumentID,
	@StoreID,
	@ModelID,
	@IDPessoa,
	@MovDate,
	@Qty,
	@IDUser,
	@CostPrice,
	@Notes
--Enquanto tem registros
WHILE
@@FETCH_STATUS = 0
BEGIN
	EXEC sp_Sis_GetNextCode'InventoryMov.IDInventoryMov', @IDInventoryMov OUTPUT

	INSERT InventoryMov
		(
		IDInventoryMov,
		InventMovTypeID,
		IDRepair,
		DocumentID,
		StoreID,
		ModelID,
		IDPessoa,
		MovDate,
		Qty,
		IDUser,
		CostPrice
		)
	VALUES
		(
		@IDInventoryMov,
		@InventMovTypeID,
		@IDRepair,
		@DocumentID,
		@StoreID,
		@ModelID,
		@IDPessoa,
		@MovDate,
		@Qty,
		@IDUser,
		@CostPrice
		)

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		CLOSE InventoryMov_Cursor
		DEALLOCATE InventoryMov_Cursor
		SET @ErrorLevel = -203
		GOTO ERRO
	END

	INSERT Inv_MovComplement 	
		(
		IDInventoryMov,
		IDMovReason,
		Notes
		)
		VALUES
		(
		@IDInventoryMov,
		1,
		@Notes
		)

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		CLOSE InventoryMov_Cursor
		DEALLOCATE InventoryMov_Cursor
		SET @ErrorLevel = -204
		GOTO ERRO
	END

	FETCH NEXT FROM InventoryMov_Cursor INTO
		@InventMovTypeID,
		@IDRepair,
		@DocumentID,
		@StoreID,
		@ModelID,
		@IDPessoa,
		@MovDate,
		@Qty,
		@IDUser,
		@CostPrice,
		@Notes
END
--fechamento do cursor
CLOSE InventoryMov_Cursor
--Destruição do cursor
DEALLOCATE InventoryMov_Cursor

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -203
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
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_Repair_Do', @ErrorLevelStr

	RETURN @ErrorLevel
GO
