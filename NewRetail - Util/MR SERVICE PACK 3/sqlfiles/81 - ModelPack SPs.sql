if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_SubAddItem]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_SubAddItem]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_SubRemoveItem]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_SubRemoveItem]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_Pay]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_Pay]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_ApplySpecialPrice]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_ApplySpecialPrice]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_RemoveSpecialPrice]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_RemoveSpecialPrice]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_CalcFullTotal]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_CalcFullTotal]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_quPreSaleItem]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_quPreSaleItem]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE sp_PreSale_SubAddItem
		(
		@PreSaleID      int,
		@IDCliente	int,
		@ModelID     	int,
		@StoreID     	int,
		@UserID      	int,
		@IDComission	int,
		@Qty         	int,
 		@SalePrice      money,
		@CostPrice      money = Null,
		@Discount    	money,
		@MovDate     	smalldatetime,
		@PreInventMovID int 		Output
 		)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Insert on Inventory Movement

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Insert on Inventory Movement


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
	26 June 2001		Davi Gouveia		Log de Return Values
	29 Oct	2003		Rodrigo Costa		Criado sp_Sis_GetNextCod;
	24 May	2004		André Bogado		Criado Cursor para KitModel 
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */


DECLARE @ComissionID 	int
DECLARE @ErrorLevel		int

--Declaração de variáveis para o Cursor de ModelChild
DECLARE @ModelIDChild  	int 
DECLARE @QtyChild  		int 
DECLARE @PreInvMovIDPack	int

SET @ErrorLevel = 0

BEGIN TRAN

/*-------------------------------------------------------------*/
/*                  Insert on Inventory Movement               */
/*-------------------------------------------------------------*/

EXEC sp_Sis_GetNextCode'PreInventoryMov.IDPreInventoryMov', @PreInventMovID OUTPUT
INSERT dbo.PreInventoryMov
	(
	IDPreInventoryMov,
	InventMovTypeID,
	IDPessoa,
	DocumentID,
	ModelID,
	StoreID,
	MovDate,
 	Qty,
	SalePrice,
	Discount,
	CostPrice,
	ComissionID,
	UserID
	)
	SELECT
		@PreInventMovID,
		1,
		@IDCliente,
 		@PreSaleID,
		@ModelID,
		@StoreID,
		@MovDate,
		@Qty,
		@SalePrice,
 		@Discount,
		IsNull(@CostPrice, (VendorCost+OtherCost+FreightCost)),
 		@IDComission,
		@UserID
	FROM
 		dbo.Model
 	WHERE
		dbo.Model.IDModel = @ModelID

 IF @@ERROR <> 0 BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END 

/*****************************************************************************************
	Inclusão de Models de PacketModel
******************************************************************************************/

--Declaração do Cursor de ModelChild

DECLARE ModelChild_Cursor CURSOR FOR

	SELECT
		M.IDModel,
		P.Qty
	FROM
 		dbo.PackModel P
		JOIN dbo.Model M ON (P.IDModel= M.IDModel)
 	WHERE
		P.IDPackModel = @ModelID


OPEN ModelChild_Cursor

--Inicialização de ModelChild_Cursor
FETCH NEXT FROM ModelChild_Cursor INTO
	@ModelIDChild,
	@QtyChild

--Enquanto tem registros
WHILE
@@FETCH_STATUS = 0
BEGIN
	EXEC sp_Sis_GetNextCode'PreInventoryMov.IDPreInventoryMov', @PreInvMovIDPack OUTPUT

	INSERT dbo.PreInventoryMov
	(
	IDPreInventoryMov,
	InventMovTypeID,
	IDPessoa,
	DocumentID,
	ModelID,
	StoreID,
	MovDate,
 	Qty,
	SalePrice,
	Discount,
	CostPrice,
	ComissionID,
	UserID,
	IDParentPack
	)
	SELECT
		@PreInvMovIDPack,
		1,
		@IDCliente,
 		@PreSaleID,
		@ModelIDChild,
		@StoreID,
		@MovDate,
		@Qty * @QtyChild,--Qtde Comprada x Qtde do Kit
		0,
 		0,
		FinalCost,
 		@IDComission,
		@UserID,
		@PreInventMovID
	FROM
 		dbo.Model
 	WHERE
		dbo.Model.IDModel = @ModelIDChild


	IF @@ERROR <> 0
	BEGIN
		CLOSE ModelChild_Cursor
		DEALLOCATE ModelChild_Cursor
		SET @ErrorLevel = -203
		GOTO ERRO
	END
	--Leitura do Proximo 
	FETCH NEXT FROM ModelChild_Cursor INTO
		@ModelIDChild,
		@QtyChild
END
--fechamento do cursor
CLOSE ModelChild_Cursor

--Destruição do cursor
DEALLOCATE ModelChild_Cursor

IF @@ERROR <> 0
BEGIN
	SET @ErrorLevel = -203
	GOTO ERRO
END

OK:
	COMMIT TRAN
	RETURN 0

ERRO:
	PRINT CAST(@ErrorLevel AS VARCHAR)
	ROLLBACK TRAN
	RETURN @ErrorLevel
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

CREATE PROCEDURE sp_PreSale_SubRemoveItem
			(
			@PreInventMovID int
			)
AS 
/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Delete on Pre Inventory Movement Items Packages
		- Delete on Pre Inventory Movement

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro no Delete
		-202  Erro no Delete PackItems


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
	26 June 2001		Davi Gouveia		Log de Return Values
	25 May 2004		Rodrigo Costa		Deletar os PackModels
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

DECLARE @ErrorLevel	int

SET @ErrorLevel = 0

/*-------------------------------------------------------------*/
/*                  Delete on Pre Inventory Movement Pack           */
/*-------------------------------------------------------------*/

DELETE
	dbo.PreInventoryMov
WHERE
	dbo.PreInventoryMov.IDParentPack = @PreInventMovID

IF @@ERROR <> 0
BEGIN
	SET @ErrorLevel = -202
	GOTO ERRO
END


/*-------------------------------------------------------------*/
/*                  Delete on Pre Inventory Movement           */
/*-------------------------------------------------------------*/

DELETE
	dbo.PreInventoryMov
WHERE
	dbo.PreInventoryMov.IDPreInventoryMov = @PreInventMovID

IF @@ERROR <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END

OK:
	RETURN 0
ERRO:
	PRINT CAST(@ErrorLevel AS VARCHAR)
	RETURN @ErrorLevel
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE sp_PreSale_Pay
			(
			@PreSaleID		int,
			@IDCashRegMov 	int,
			@PayDate 		smalldatetime,
			@IDStore		int,
			@IDTouristGroup 	int,
			@OtherComID 		int,
			@CashReceived   	money,
			@Date			Datetime,
			@IDInvoice 		int output
			)
AS


/* --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO
        - Transforma a PreSale em Sale
	- Move os PreInventMov para o InventMov
	- Move os PreSerialMov para o SerialMov
	- Deleta os seriais do Inventario
	- Deleta Pre Inventory Movement
	- Marca os lancamentos como confimados, e troca o documento
	- Update Cash RegisterMovent
	- Calc commissions for report performace

	TABELA DE ERROS PARA RETURN_VALUE

	 000  Ok
	-201  Erro ao gerar novo IDInvoice
	-202  Erro ao transformar Hold em Invoice
	-203  Erro movendo os PreInventMov para o InventMov
	-204  Erro movendo os PreSerialMov para o SerialMov
	-205  Erro ao deletar/inserir os Seriais do Inventario
	-206  Erro ao deletar o PreSerialMov
	-207  Erro ao deletar o PreInventoryMov
	-208  Erro ao inserir as linhas de quitacao
	-209  Erro as inserir as linhas de ligação entre lancamento e quitacao
	-210  Erro ao atualizar o NumDocumento nas parcelas do Invoice
	-212  Erro ao Atualizar as comissões
	-213  Erro ao mover Model Pack de PreInvMov para InvMov


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	26 may  2000		Eduardo Costa		Alteração para suporte as novas tabelas do financeiro;
	27 may  2000   		Eduardo Costa		Criação da rotina de tratamento e retorno de erros;
	14 aug  2000   		Eduardo Costa		A quitação dos lancamentos do invoice foi transferida
							para o close da caixa registradora;
	15 aug  2000		Rodrigo Costa		Novo campo SalesTax para calcular a tax
	26 June 2001		Davi Gouveia		Log de Return Values
	29 June 2001		Rodrigo Costa		Alteracao no delete Serial do Inventory, criado um join com a tbl PreSerialMov
	29 Oct	2003		Rodrigo Costa		Criado sp_Sis_GetNextCode para Invoice; Cursor InventoryMov;
							Deletado INSERT InvoiceGen (BitGen) VALUES (1), SELECT @IDInvoice = @@IDENTITY; 
							Criado Cursor para InvMov
	18 Dec  2003		Andre Bogado		Alteração no cursor de InvMov para atualizar InventoryMovTax
	22 Dec 2003		Rodrigo Costa		Incluir os Serias no Inventory se for Refound
	25 May 2004		Rodrigo Costa		Mover PackModels do PreInvMov para o InvMov
    --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

DECLARE @DataPagamento  	smalldatetime
DECLARE @ComissionPayed 	money
DECLARE @IDCentroCusto		int
DECLARE @ErrorLevel		int

--Declaração de variáveis para o Cursor de InventoryMov
DECLARE @InventMovTypeID 	int 
DECLARE @DocumentID 		int 
DECLARE @IDPessoa 		int 
DECLARE @ModelID 		int 
DECLARE @BarCodeID 		char(20)
DECLARE @MovDate 		smalldatetime 
DECLARE @Qty 			int 
DECLARE @CostPrice 		money 
DECLARE @SalePrice 		money 
DECLARE @Discount 		money 
DECLARE @ComissionID 		int 
DECLARE @PreInventoryMovID 	int 
DECLARE @IDUser 		int 
DECLARE @SalesTax 		money
DECLARE @StoreID 		int
DECLARE @IDInventoryMov		int
DECLARE @IDParentPack		int

--PRINT 'Starting transaction'
BEGIN TRAN

SET  @ErrorLevel = 0

-- Retorna o Centro de Custo referente a loja
SELECT @IDCentroCusto = (SELECT IDCentroCusto  FROM Store WHERE IDStore = @IDStore)

IF @@ERROR <> 0 GOTO ERRO


/*--------------------------------------------------------------------------------------------------------*/
/*		Transforma a PreSale em Sale    		  					*/
/*--------------------------------------------------------------------------------------------------------*/

-- Calcula o proximo IDInvoice
EXEC sp_Sis_GetNextCode 'InvoiceGen.IDInvoice', @IDInvoice OUTPUT
IF @@ERROR <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END
 -- Transforma o hold em invoice
UPDATE Invoice
SET		Invoice.IDInvoice    	= @IDInvoice,
		Invoice.InvoiceDate  	= @PayDate,
		Invoice.CashReceived 	= @CashReceived,
		Invoice.IDStore	 	= @IDStore,
		Invoice.CashRegMovID 	= @IDCashRegMov

WHERE 	Invoice.IDPreSale = @PreSaleID

IF @@ERROR <> 0
BEGIN
	SET @ErrorLevel = -202
	GOTO ERRO
END


/*--------------------------------------------------------------------------------------------------------*/
/*	     Move os PreInventMov para o InventMov                      */
/*------------------------------------------------------------------------------------------------------*/
--Declaração do Cursor de InventoryMov

DECLARE InventoryMov_Cursor CURSOR FOR

	SELECT	PIM.InventMovTypeID,
			@IDInvoice,
			PIM.IDPessoa,
			PIM.StoreID,
			PIM.ModelID,
			PIM.BarCodeID,
			@PayDate,
			PIM.Qty,
			PIM.CostPrice,
			PIM.SalePrice,
			PIM.Discount,
			PIM.ComissionID,
			PIM.IDPreInventoryMov,
			PIM.UserID,
			(CASE WHEN (TC.SpecialDateStart <= @Date) AND (TC.SpecialDateEnd >= @Date) AND ( ISNULL((( ISNULL(PIM.SalePrice, 0) - ISNULL(PIM.Discount, 0)) / PIM.Qty), 0) < ISNULL(TC.MaxItemValue, 0))
				 THEN TC.SpecialTax ELSE TC.Tax END / 100.00)  as Tax,-- Tax
			PIM.IDParentPack

	FROM		dbo.PreInventoryMov PIM
			JOIN Model M ON ( PIM.ModelID = M.IDModel )
			JOIN TabGroup TG ON ( M.GroupID = TG.IDGroup )
			JOIN StoreToTabGroup STC ON ( STC.IDStore = PIM.StoreID AND STC.IDGroup = TG.IDGroup )
			JOIN TaxCategory TC ON ( TC.IDTaxCategory = STC.IDTaxCategory )

	WHERE   	PIM.DocumentID = @PreSaleID
			AND
			PIM.InventMovTypeID = 1

OPEN InventoryMov_Cursor

--Inicialização de InventoryMov_Cursor
FETCH NEXT FROM InventoryMov_Cursor INTO
	@InventMovTypeID,
	@DocumentID,
	@IDPessoa,
	@StoreID,
	@ModelID,
	@BarCodeID,
	@MovDate,
	@Qty,
	@CostPrice,
	@SalePrice,
	@Discount,
	@ComissionID,
	@PreInventoryMovID,
	@IDUser,
	@SalesTax,
	@IDParentPack
--Enquanto tem registros
WHILE
@@FETCH_STATUS = 0
BEGIN
	EXEC sp_Sis_GetNextCode'InventoryMov.IDInventoryMov', @IDInventoryMov OUTPUT

	INSERT InventoryMov
		(
		IDInventoryMov,
		InventMovTypeID,
		DocumentID,
		IDPessoa,
		StoreID,
		ModelID,
		BarCodeID,
		MovDate,
		Qty,
		CostPrice,
		SalePrice,
		Discount,
		ComissionID,
		PreInventoryMovID,
		IDUser,
		SalesTax,
		IDParentPack
		)
	VALUES
		(
		@IDInventoryMov,
		@InventMovTypeID,
		@DocumentID,
		@IDPessoa,
		@StoreID,
		@ModelID,
		@BarCodeID,
		@MovDate,
		@Qty,
		@CostPrice,
		@SalePrice,
		@Discount,
		@ComissionID,
		@PreInventoryMovID,
		@IDUser,
		@SalesTax,
		@IDParentPack
		)

	IF @@ERROR <> 0
	BEGIN
		CLOSE InventoryMov_Cursor
		DEALLOCATE InventoryMov_Cursor
		SET @ErrorLevel = -203
		GOTO ERRO
	END
	-- Insert na tabela de Taxas InventoryMovTax
	INSERT INTO InventoryMovTax 
		(
		IDInventoryMov, 
		IDTaxCategory, 
		Tax, 
		TaxValue 
		)
	SELECT 
		IM.IDInventoryMov,
		ISNULL (TC.IDTaxCategory,0)AS IDTaxCategory,
		ISNULL (TC.Tax,0)/100 AS Tax,
		ISNULL (IM.SalePrice * IM.Qty * TC.Tax,0)/100 AS TaxValue

	FROM 	InventoryMov IM
		JOIN Model Mo ON (IM.ModelID = Mo.IDModel)
		JOIN StoreToTabGroup SG	ON (SG.IDStore = IM.StoreID AND SG.IDGroup = Mo.GroupID )
		JOIN TaxCategory TC ON (SG.IDTaxCategory = TC.IDTaxCategoryParent)

	WHERE 	IM.IDInventoryMov = @IDInventoryMov

	FETCH NEXT FROM InventoryMov_Cursor INTO
		@InventMovTypeID,
		@DocumentID,
		@IDPessoa,
		@StoreID,
		@ModelID,
		@BarCodeID,
		@MovDate,
		@Qty,
		@CostPrice,
		@SalePrice,
		@Discount,
		@ComissionID,
		@PreInventoryMovID,
		@IDUser,
		@SalesTax,
		@IDParentPack
END
--fechamento do cursor
CLOSE InventoryMov_Cursor
--Destruição do cursor
DEALLOCATE InventoryMov_Cursor


IF @@ERROR <> 0
BEGIN
	SET @ErrorLevel = -203
	GOTO ERRO
END

/*--------------------------------------------------------------------------------------------------------*/
/*	     Move os PreSerialMov para o SerialMov                	*/
/*--------------------------------------------------------------------------------------------------------*/
INSERT 	dbo.SerialMov ( InventoryMovID,	SerialNumber )

	SELECT	IM.IDInventoryMov,
			PSM.SerialNumber

	FROM		PreSerialMov PSM
			JOIN InventoryMov IM ON (PSM.PreInventoryMovID = IM.PreInventoryMovID)

	WHERE 	IM.DocumentID = @IDInvoice
			AND
			IM.InventMovTypeID = 1

IF @@ERROR <> 0
BEGIN
	SET @ErrorLevel = -204
	GOTO ERRO
END

/*--------------------------------------------------------------------------------------------------------*/
/*	       Deleta/Insert os seriais do Inventario			*/
/*--------------------------------------------------------------------------------------------------------*/

DELETE	
		InventorySerial
FROM	
		PreInventoryMov PIM, PreSerialMov PSV
WHERE	
		PIM.DocumentID = @PreSaleID
		AND
		PIM.InventMovTypeID = 1
		AND
		InventorySerial.ModelID = PIM.ModelID
		AND
		InventorySerial.StoreID = @IDStore
		AND
		InventorySerial.Serial = PSV.SerialNumber
		AND
		PIM.Qty > 0

--Refound
INSERT
		InventorySerial (StoreID, ModelID, Serial)
SELECT
		@IDStore,
		PIM.ModelID,	
		PSV.SerialNumber
FROM
		PreInventoryMov PIM
		JOIN PreSerialMov PSV ON (PIM. IDPreInventoryMov = PSV.PreInventoryMovID)
WHERE	
		PIM.DocumentID = @PreSaleID
		AND
		PIM.InventMovTypeID = 1
		AND
		PIM.Qty < 0
		

IF @@ERROR <> 0
BEGIN
	SET @ErrorLevel = -205
	GOTO ERRO
END


/*--------------------------------------------------------------------------------------------------------*/
/*	       Deleta PreSerial Movement			*/
/*--------------------------------------------------------------------------------------------------------*/

DELETE 	
		PreSerialMov
FROM		
		PreInventoryMov PIM
WHERE 	
		PIM.DocumentID = @PreSaleID
		AND
		PIM.InventMovTypeID = 1

IF @@ERROR <> 0
BEGIN
	SET @ErrorLevel = -206
	GOTO ERRO
END

/*--------------------------------------------------------------------------------------------------------*/
/*	       Atualiza  os ModelsPack de InvMov			*/
/*--------------------------------------------------------------------------------------------------------*/

UPDATE 
	IMC 
SET 
	IMC.IDParentPack = IMP.IDInventoryMov
FROM 
	InventoryMov IMC
	JOIN InventoryMov IMP ON ( IMP.PreInventoryMovID = IMC.IDParentPack)
WHERE 
	IMC.DocumentID = @DocumentID
	AND
	IMC.InventMovTypeID = 1

IF @@ERROR <> 0
BEGIN
	SET @ErrorLevel = -213
	GOTO ERRO
END

/*--------------------------------------------------------------------------------------------------------*/
/*	       Deleta PreInventory Movement			*/
/*--------------------------------------------------------------------------------------------------------*/

DELETE 	
		PreInventoryMov
WHERE 	
		PreInventoryMov.DocumentID = @PreSaleID
		AND
		PreInventoryMov.InventMovTypeID = 1

IF @@ERROR <> 0
BEGIN
	SET @ErrorLevel = -207
	GOTO ERRO
END


/*--------------------------------------------------------------------------------------------------------*/
/*	Marca os lancamentos como confimados,  	  	*/
/*	e troca o documento					*/
/*--------------------------------------------------------------------------------------------------------*/


UPDATE
	Fin_Lancamento
SET
	NumDocumento = Convert(varchar(50), @IDInvoice),
	DataEmissao = @PayDate,
	Previsao = 0
WHERE
	IDPreSale =  @PreSaleID


IF @@ERROR <> 0
BEGIN
	SET @ErrorLevel = -210
	GOTO ERRO
END


/*--------------------------------------------------------------------------------------------------------*/
/*	Calc commissions for report performace	     		*/
/*	Temporariamente desativa por motivo de performance     	*/
/*--------------------------------------------------------------------------------------------------------*/
/*
PRINT 'Calc Comissions'
EXEC sp_PreSale_CacheCommission @IDInvoice



IF @@ERROR <> 0
BEGIN
	SET @ErrorLevel = -212
	GOTO ERRO
END
*/

OK:
	COMMIT TRAN
	RETURN 0
ERRO:
	PRINT CAST(@ErrorLevel AS VARCHAR)
	ROLLBACK TRAN
	RETURN @ErrorLevel
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE sp_PreSale_ApplySpecialPrice
		(
		@PreSaleID 		int,
		@SpecialPriceID 	int,
		@Date 			datetime
		)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Altera baseado no Special Price do Grupo
		- Altera baseado no Special Price do Model

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Altera baseado no Special Price do Grupo
		-202  Erro em Atualizo PreInventoryMov
		-203  Erro em Atualizo Invoice
		-204  Erro em exec sp_PreSale_SubCalcTotal @PreSaleID, @Date


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
	26 June 2001		Davi Gouveia		Log de Return Values
	25 May 2004		RodrigoCosta		Special price not for PackModel
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

DECLARE @ErrorLevel	int

SET @ErrorLevel = 0

BEGIN TRAN

/* ----------------------------------------------- */
/*	Altera baseado no Special Price do Grupo   */
/* ----------------------------------------------- */
UPDATE
	PreInventoryMov
SET
	PreInventoryMov.Discount = 0,
	PreInventoryMov.SalePrice = 	ROUND(
						IsNull (
							(
							SELECT
								( (1+(IsNull( SP.SpecialMarkUp,0)/100)) * PreInventoryMov.CostPrice )
							FROM
								Model MO,
								SpecialPriceByGroup SP
							WHERE
								PreInventoryMov.ModelID = MO.IDModel
								AND
								MO.GroupID = SP.GroupID
								AND
								SP.SpecialPriceID = @SpecialPriceID
							), Model.SellingPrice)
						,2)
FROM
	Model Model
WHERE
	(PreInventoryMov.DocumentID = @PreSaleID
	AND
	PreInventoryMov.IDParentPack IS Null
	AND
	(PreInventoryMov.ModelID = Model.IDModel)
	AND
	PreInventoryMov.InventMovTypeID = 1)

IF @@ERROR <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END


/* ----------------------------------------------- */
/*	Altera baseado no Special Price do Model   */
/* ----------------------------------------------- */
-- Atualizo PreInventoryMov
UPDATE
	PreInventoryMov
SET
	PreInventoryMov.SalePrice = ROUND(IsNull (( (1+(IsNull( MoToSP.MarkUp,0)/100)) * dbo.PreInventoryMov.CostPrice ), Model.SellingPrice),2)
FROM
	ModelToSpecialPrice MoToSP,
	model Model
WHERE
	PreInventoryMov.DocumentID = @PreSaleID
	AND
	PreInventoryMov.InventMovTypeID = 1
	AND
       	PreInventoryMov.ModelID = MoToSP.IDModel
	AND
      	MoToSp.IDModel = Model.IDModel
	AND
       	MoToSP.IDSpecialPrice = @SpecialPriceID
	AND
	PreInventoryMov.IDParentPack IS Null


IF @@ERROR <> 0
BEGIN
	SET @ErrorLevel = -202
	GOTO ERRO
END


-- Atualizo Invoice
UPDATE
	Invoice
SET
	Invoice.SpecialPriceID = @SpecialPriceID,
	Invoice.TaxIsent = 0
WHERE
	Invoice.IDPreSale = @PreSaleID

IF @@ERROR <> 0
BEGIN
	SET @ErrorLevel = -203
	GOTO ERRO
END

exec sp_PreSale_SubCalcTotal @PreSaleID, @Date

IF @@ERROR <> 0
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
	RETURN @ErrorLevel
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

CREATE PROCEDURE sp_PreSale_RemoveSpecialPrice
		(
			@PreSaleID	int,
			@Date  	DateTime
		)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Remove o SpecialPrice de um PreSale

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em UPDATE dbo.PreInventoryMov
		-202  Erro em UPDATE dbo.Invoice
		-203  Erro em exec sp_PreSale_SubCalcTotal


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
	26 June 2001		Davi Gouveia		Log de Return Values
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

DECLARE @ErrorLevel	int

SET @ErrorLevel = 0

BEGIN TRAN

UPDATE
	dbo.PreInventoryMov
SET
	dbo.PreInventoryMov.SalePrice =
		(
		SELECT
			MO.SellingPrice
		FROM
			dbo.PreInventoryMov 	PIM,
			dbo.Model 		MO
		WHERE
			PIM.IDPreInventoryMov = dbo.PreInventoryMov.IDPreInventoryMov
			AND
			PIM.ModelID    = MO.IDModel
		),
	dbo.PreInventoryMov.Discount = 0
WHERE
	dbo.PreInventoryMov.DocumentID = @PreSaleID
	AND
       	dbo.PreInventoryMov.InventMovTypeID = 1
	AND
	PreInventoryMov.IDParentPack IS Null


IF @@ERROR <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END

UPDATE
	dbo.Invoice
SET
	dbo.Invoice.SpecialPriceID = NULL,
	dbo.Invoice.TaxIsent = 0
WHERE
	dbo.Invoice.IDPreSale = @PreSaleID

IF @@ERROR <> 0
BEGIN
	SET @ErrorLevel = -202
	GOTO ERRO
END

exec sp_PreSale_SubCalcTotal @PreSaleID, @Date

IF @@ERROR <> 0
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
	RETURN @ErrorLevel
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

CREATE PROCEDURE sp_PreSale_CalcFullTotal
		(
		@IDPreSale 	int,
		@FullTotal 	money output
		)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Retorna o total de uma determinada venda

	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
	25 May  2004		Rodrigo Costa		Includ PackModel Calc
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */


SELECT	@FullTotal = 	(
			SELECT
				SUM(PreInventoryMov.Qty * Model.SellingPrice)
			FROM
				dbo.PreInventoryMov PreInventoryMov , dbo.Model Model
			WHERE
 				PreInventoryMov.DocumentID  = @IDPreSale
 				AND
 				PreInventoryMov.InventMovTypeID = 1
				AND
			 	PreInventoryMov.ModelID     = Model.IDModel
				AND
				PreInventoryMov.IDParentPack IS Null
			)

SELECT @FullTotal = IsNull(@FullTotal, 0)
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

CREATE PROCEDURE sp_PreSale_quPreSaleItem
	(
		@DocumentID      	int,
		@IsPreSale		bit,
		@Date			DateTime
	)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Retorna itens de um determinado PreSale

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro no 1o select
		-202  Erro no 2o select


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
	15 Aug  2000		Rodrigo Costa		Feito o Join com a Tbl TaxCategory para pegar a tax do Item
	26 June 2001		Davi Gouveia		Log de Return Values
	26 May 2004		Rodrigo Costa		Not display Item Packs
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

DECLARE @ErrorLevel	int

SET @ErrorLevel = 0

if @IsPreSale = 1
begin
	SELECT
		ModelID ,
		M.Model,
		Description ,
		SalesPerson ,
		M.SuggRetail ,
		SU.IDUser ,
		IDSalesPerson as IDComission,
		Qty ,
		ExchangeInvoice,
		SalePrice ,
		CostPrice,
		Discount ,
		PIM.IDPreInventoryMov IDInventoryMov,
		TG.SerialNumber,
	 	 (CASE WHEN (TC.SpecialDateStart <= @Date) AND (TC.SpecialDateEnd >= @Date) AND ( ISNULL((( ISNULL(PIM.SalePrice, 0) - ISNULL(PIM.Discount, 0)) / PIM.Qty), 0) < ISNULL(TC.MaxItemValue, 0))
			 THEN TC.SpecialTax ELSE TC.Tax END) as Tax -- Tax
	FROM
		PreInventoryMov PIM
		JOIN
		vwSalesPerson SP ON ( PIM.ComissionID = SP.IDSalesPerson )
		JOIN
		Model M ON ( PIM.ModelID = M.IDModel )
		JOIN
		SystemUser SU ON ( SU.IDUser = PIM.UserID )
		JOIN
		TabGroup TG ON ( M.GroupID = TG.IDGroup )
                JOIN
		StoreToTabGroup STC ON ( STC.IDStore = PIM.StoreID AND STC.IDGroup = TG.IDGroup )
		LEFT OUTER JOIN
		TaxCategory TC ON ( TC.IDTaxCategory = STC.IDTaxCategory )
	WHERE
		PIM.DocumentID  = @DocumentID
		AND
		PIM.InventMovTypeID = 1
		AND
		PIM.IDParentPack Is Null
	ORDER BY
		SU.IDUser, Model

	IF @@ERROR <> 0
	BEGIN
		SET @ErrorLevel = -201
		GOTO ERRO
	END
end
else
begin
	SELECT
		ModelID ,
		M.Model,
		Description ,
		SalesPerson ,
		M.SuggRetail ,
		SU.IDUser ,
		IDSalesPerson as IDComission,
		Qty ,
		ExchangeInvoice,
		SalePrice ,
		CostPrice,
		Discount ,
		IDInventoryMov IDInventoryMov,
		TG.SerialNumber,
	 	IM.SalesTax as Tax -- Tax
	FROM
		dbo.InventoryMov IM
		JOIN
		vwSalesPerson SP ON ( IM.ComissionID = SP.IDSalesPerson )
		JOIN
		Model M ON ( IM.ModelID = M.IDModel )
		JOIN
		SystemUser SU ON ( SU.IDUser = IM.IDUser )
		JOIN
		TabGroup TG ON ( M.GroupID = TG.IDGroup )
		JOIN
		StoreToTabGroup STC ON ( STC.IDStore = IM.StoreID AND STC.IDGroup = TG.IDGroup )
		JOIN
		TaxCategory TC ON ( TC.IDTaxCategory = STC.IDTaxCategory )
	WHERE
		IM.DocumentID  = @DocumentID
		AND
 		IM.InventMovTypeID = 1
		AND
		IM.IDParentPack Is Null
	ORDER BY
		SU.IDUser, M.Model

	IF @@ERROR <> 0
	BEGIN
		SET @ErrorLevel = -202
		GOTO ERRO
	END
end

OK:
	RETURN 0
ERRO:
	PRINT CAST(@ErrorLevel AS VARCHAR)
	RETURN @ErrorLevel
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

