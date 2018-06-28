if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Inventory_Adjust]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Inventory_Adjust]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Inventory_Del_Moviment]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Inventory_Del_Moviment]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Inventory_Tranfer_IN]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Inventory_Tranfer_IN]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Inventory_Tranfer_Import]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Inventory_Tranfer_Import]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Inventory_Tranfer_OUT]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Inventory_Tranfer_OUT]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Model_Adjust]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Model_Adjust]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_PreSale_Pay]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_PreSale_Pay]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Purchase_Do]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Purchase_Do]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Purchase_Remove]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Purchase_Remove]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Repair_Do]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Repair_Do]
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
		- Atualiza o saldo em valor do Model
		- Atualiza o saldo em valor do Inventoty

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Atualiza o Inventory
		-202  Erro ao Inserir o Motivo
		-203  Atualiza o saldo em valor do Model
		-204  Atualiza o saldo em valor do Inventoty




	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	31 Mar  2006		Rodrigo Costa		Criacao;
	02 Jun	2006		Rodrigo Costa		Inserir no Inv_MovComplement
	12 Jun  2006		Carlos Lima		Atualiza o saldo em valor e o custo médio
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */


DECLARE @ErrorLevel 		int
DECLARE @SysError		int
DECLARE @IDInventoryMov		int
DECLARE @MovFactor		int
DECLARE @CostPrice		money
DECLARE @AvgCost		money
DECLARE @IDInventory 		int


SET @ErrorLevel = 0


SELECT 
	@MovFactor = (2 *UpdateOnHand-1)
FROM
	InventoryMovType
WHERE
	IDInventMovType = @IDMovType

IF @MovFactor = 1
BEGIN
	SELECT
		@CostPrice = CASE WHEN IsNull(AvgCost, 0) = 0 THEN IsNull(VendorCost, 0) ELSE IsNull(AvgCost, 0) END
	FROM
		Model
	WHERE
		IDModel = @IDModel

	-- Atualiza o saldo em valor do Model

	UPDATE
		Model
	SET
		Model.AvgCostTotal = IsNull(Model.AvgCostTotal, 0) + (@CostPrice * @Qty),
		Model.AvgCost = CASE WHEN (IsNull(Model.TotQtyOnHand, 0) + @Qty) = 0 
					THEN 0 
					ELSE (IsNull(Model.AvgCostTotal, 0) + (@CostPrice * @Qty)) / (IsNull(Model.TotQtyOnHand, 0) + @Qty) 
				END
	WHERE
		Model.IDModel = @IDModel	

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		SET @ErrorLevel = -203
		GOTO ERRO
	END


	SELECT
		@CostPrice = CASE WHEN IsNull(StoreAvgPrice, 0) = 0 THEN IsNull(StoreCostPrice, 0) ELSE IsNull(StoreAvgPrice, 0) END
	FROM
		Inventory
	WHERE
		Inventory.ModelID = @IDModel
		AND
		Inventory.StoreID = @IDStore


	IF NOT EXISTS(SELECT ModelID FROM Inventory WHERE ModelID = @IDModel AND StoreID = @IDStore)
	BEGIN
		EXEC sp_Sis_GetNextCode'Inventory.IDInventory', @IDInventory OUTPUT
	
		INSERT Inventory
			(
			IDInventory,
			StoreID,
			ModelID
			)
		VALUES
			(
			@IDInventory,
			@IDStore,
			@IDModel
			)
	END



	-- Atualiza o saldo em valor do inventory

	SELECT
		@AvgCost = 
			CASE WHEN (IsNull(Inventory.QtyOnHand, 0) + @Qty) = 0 
				THEN 0 
				ELSE (IsNull(Inventory.AvgCostTotal, 0) + (@CostPrice * @Qty)) / (IsNull(Inventory.QtyOnHand, 0) + @Qty) 
			END
	FROM
		Inventory
	WHERE
		Inventory.ModelID = @IDModel
		AND
		Inventory.StoreID = @IDStore



	UPDATE
		Inventory
	SET
		Inventory.AvgCostTotal = IsNull(Inventory.AvgCostTotal, 0) + (@CostPrice * @Qty),
		Inventory.StoreAvgPrice = @AvgCost
	WHERE
		Inventory.ModelID = @IDModel
		AND
		Inventory.StoreID = @IDStore



	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		SET @ErrorLevel = -204
		GOTO ERRO
	END
END

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

CREATE PROCEDURE sp_Inventory_Del_Moviment (@IDInventoryMov int) AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO
		
		- Atualizo custo médio em Model
		- Atualizo custo médio em Inventory
		- Excluo InventoryMov

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Atualizo custo médio em Model
		-202  Erro em Atualizo custo médio em Inventory
		-203  Erro em Excluo InventoryMov

	LOG DE MODIFICAÇÕES

	Data		Programador				Modificação
	--------------- --------------------------------------- ------------------------------------------------------------------------------
	06 Jun 2006	Carlos Lima				Criação
	--------------------------------------------------------------------------------------------------------------------------------------*/

DECLARE @ErrorLevel	int
DECLARE @SysError	int


DECLARE @StoreID	int
DECLARE @ModelID	int
DECLARE @Qty		float
DECLARE @CostPrice	money
DECLARE @UpdateOnHand	int


SELECT
	@StoreID = StoreID,
	@ModelID = ModelID,
	@Qty = Qty,
	@CostPrice = CostPrice,
	@UpdateOnHand = (2 *IMT.UpdateOnHand-1)
FROM
	InventoryMov
	INNER JOIN InventoryMovType IMT ON (InventoryMov.InventMovTypeID = IMT.IDInventMovType)
WHERE
	IDInventoryMov = @IDInventoryMov

	
UPDATE
	Model
SET
	Model.AvgCostTotal = IsNull(Model.AvgCostTotal, 0) - (@CostPrice * (@UpdateOnHand * @Qty)),
	Model.AvgCost = CASE WHEN (IsNull(Model.TotQtyOnHand, 0) - (@UpdateOnHand * @Qty)) = 0 
				THEN 0 
				ELSE (IsNull(Model.AvgCostTotal, 0) - (@CostPrice * (@UpdateOnHand * @Qty))) / (IsNull(Model.TotQtyOnHand, 0) - (@UpdateOnHand * @Qty)) 
			END
WHERE
	Model.IDModel = @ModelID

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END


UPDATE
	Inventory
SET
	Inventory.AvgCostTotal = IsNull(Inventory.AvgCostTotal, 0) - (@CostPrice * (@UpdateOnHand * @Qty)),
	Inventory.StoreAvgPrice =	CASE WHEN (IsNull(Inventory.QtyOnHand, 0) - (@UpdateOnHand * @Qty)) = 0 
						THEN 0 
						ELSE (IsNull(Inventory.AvgCostTotal, 0) - (@CostPrice * (@UpdateOnHand * @Qty))) / (IsNull(Inventory.QtyOnHand, 0) - (@UpdateOnHand * @Qty)) 
					END
WHERE
	Inventory.ModelID = @ModelID
	AND
	Inventory.StoreID = @StoreID

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -202
	GOTO ERRO
END


DELETE FROM
	InventoryMov
WHERE
	IDInventoryMov = @IDInventoryMov

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

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_Inventory_Del_Moviment', @ErrorLevelStr

	RETURN @ErrorLevel
GO

CREATE PROCEDURE sp_Inventory_Tranfer_IN
	(
	@IDModelTransf	int
	)
 AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Delecao do InventoryMov
		- Atualizo o model
		- Atualizo o custo médio no Model
		- Insiro InventoryMov
		- Atualizo o custo médio no Inventory

	TABELA DE ERROS PARA RETURN_VALUE

	 000  Ok
	-201  Erro em Delecao do InventoryMov
	-202  Erro em Inserir Model
	-203  Erro em Atualizo o custo médio no Model
	-204  Erro em Insiro InventoryMov
	-205  Erro em Atualizo o custo médio no Inventory

	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------------------------------------------------------------------------------------------------------------
	16 Jul 2005		Rodrigo Costa		Criação;
	05 Jun 2006		Carlos Lima		Adicionado Custo médio na inserção de InventoryMov
	16 Jun 2006		Carlos Lima		Atualização do custo médio
        ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

DECLARE @ErrorLevel		int
DECLARE @SysError		int

--Declaração de variáveis para o Cursor de InventoryMov
DECLARE @DocumentID 	int 
DECLARE @ModelID 		int 
DECLARE @Qty 		float
DECLARE @CostPrice		money
DECLARE @IDUser 		int 
DECLARE @PreInventoryMovID 	int 
DECLARE @IDInventoryMov    	int
DECLARE @StoreIDOrigem 	int 
DECLARE @StoreIDDestino 	int 
DECLARE @AvgCost 		money 
DECLARE @AvgCostCalc		money

DECLARE @IDInventory		int


BEGIN TRAN


/*--------------------------------------------------------------*/
/*		Parte da Delecao do InventoryMov        	*/
/*--------------------------------------------------------------*/

DECLARE InventoryMov_Cursor CURSOR FOR

SELECT
	IDInventoryMov
FROM
	InventoryMov
WHERE	
	InventoryMov.InventMovTypeID = 8
	AND
	InventoryMov.DocumentID = @IDModelTransf



OPEN InventoryMov_Cursor


FETCH NEXT FROM InventoryMov_Cursor INTO
	@IDInventoryMov

WHILE @@FETCH_STATUS = 0
BEGIN
	EXEC sp_Inventory_Del_Moviment @IDInventoryMov
	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		CLOSE InventoryMov_Cursor
		DEALLOCATE InventoryMov_Cursor
		SET @ErrorLevel = -201
		GOTO ERRO
	END

	FETCH NEXT FROM InventoryMov_Cursor INTO
		@IDInventoryMov
END

CLOSE InventoryMov_Cursor
DEALLOCATE InventoryMov_Cursor
--

/*--------------------------------------------------------------*/
/*		Parte da Insercao do InventoryMov        	*/
/*--------------------------------------------------------------*/

--Declaração do Cursor de InventoryMov
DECLARE TransferIN_Cursor CURSOR FOR
	SELECT
		MTD.IDModelTransf,
		MT.IDLojaOrigem,
		MT.IDLojaDestino,
		MTD.IDModel,
		MTD.Qty,
		MT.IDUser,
		MTD.IDModelTransfDet, /* guarda a linha correspondente a inserida */
		MTD.CostPrice,
		MTD.AvgCost
	FROM
		ModelTransfDet MTD
		INNER JOIN ModelTransf MT ON (MTD.IDModelTransf = MT.IDModelTransf)		
	WHERE
		MT.IDModelTransf = @IDModelTransf

OPEN TransferIN_Cursor

--Inicialização de TransferIN_Cursor
FETCH NEXT FROM TransferIN_Cursor INTO
	@DocumentID,
	@StoreIDOrigem,
	@StoreIDDestino,
	@ModelID,
	@Qty,
	@IDUser,
	@PreInventoryMovID,
	@CostPrice,
	@AvgCost 
--Enquanto tem registros
WHILE
@@FETCH_STATUS = 0
BEGIN
	--Inclusao da loja original
	UPDATE
		Model
	SET
		Model.AvgCostTotal = IsNull(Model.AvgCostTotal, 0) + (@AvgCost * @Qty),
		Model.AvgCost = CASE WHEN (IsNull(Model.TotQtyOnHand, 0) + @Qty) = 0 
					THEN 0 
					ELSE (IsNull(Model.AvgCostTotal, 0) + (@AvgCost * @Qty)) / (IsNull(Model.TotQtyOnHand, 0) + @Qty) 
				END
	WHERE
		Model.IDModel = @ModelID

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		CLOSE TransferIN_Cursor
		DEALLOCATE TransferIN_Cursor
		SET @ErrorLevel = -203
		GOTO ERRO
	END

	IF NOT EXISTS(SELECT ModelID FROM Inventory WHERE ModelID = @ModelID AND StoreID = @StoreIDDestino)
	BEGIN
		EXEC sp_Sis_GetNextCode'Inventory.IDInventory', @IDInventory OUTPUT
	
		INSERT Inventory
			(
			IDInventory,
			StoreID,
			ModelID
			)
		VALUES
			(
			@IDInventory,
			@StoreIDDestino,
			@ModelID
			)

		SET @SysError = @@ERROR
		IF @SysError <> 0
		BEGIN
			CLOSE TransferIN_Cursor
			DEALLOCATE TransferIN_Cursor
			SET @ErrorLevel = -204
			GOTO ERRO
		END

	END

	-- Atualiza o saldo em valor do inventory

	SELECT
		@AvgCostCalc = 
			CASE WHEN (IsNull(Inventory.QtyOnHand, 0) + @Qty) = 0 
				THEN 0 
				ELSE (IsNull(Inventory.AvgCostTotal, 0) + (@AvgCost * @Qty)) / (IsNull(Inventory.QtyOnHand, 0) + @Qty) 
			END
	FROM
		Inventory
	WHERE
		Inventory.ModelID = @ModelID
		AND
		Inventory.StoreID = @StoreIDDestino



	UPDATE
		Inventory
	SET
		Inventory.AvgCostTotal = IsNull(Inventory.AvgCostTotal, 0) + (@AvgCost * @Qty),
		Inventory.StoreAvgPrice = @AvgCost
	WHERE
		Inventory.ModelID = @ModelID
		AND
		Inventory.StoreID = @StoreIDDestino


	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		CLOSE TransferIN_Cursor
		DEALLOCATE TransferIN_Cursor
		SET @ErrorLevel = -205
		GOTO ERRO
	END



	EXEC sp_Sis_GetNextCode'InventoryMov.IDInventoryMov', @IDInventoryMov OUTPUT

	INSERT InventoryMov
		(
		IDInventoryMov,
		InventMovTypeID,
		DocumentID,
		StoreID,
		ModelID,
		IDPessoa,
		MovDate,
		Qty,
		IDUser,
		PreInventoryMovID,
		CostPrice,
		AvgCost 
		)
	VALUES
		(
		@IDInventoryMov,
		8,   /* entrada da loja destino */
		@DocumentID,
		@StoreIDDestino,
		@ModelID,
		0,
		GetDate(),
		@Qty,
		@IDUser,
		@PreInventoryMovID, /* guarda a linha correspondente a inserida */
		@CostPrice,
		@AvgCost 
		)

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		CLOSE TransferIN_Cursor
		DEALLOCATE TransferIN_Cursor
		SET @ErrorLevel = -202
		GOTO ERRO
	END

	FETCH NEXT FROM TransferIN_Cursor INTO
		@DocumentID,
		@StoreIDOrigem,
		@StoreIDDestino,
		@ModelID,
		@Qty,
		@IDUser,
		@PreInventoryMovID,
		@CostPrice,
		@AvgCost 
END
--fechamento do cursor
CLOSE TransferIN_Cursor
--Destruição do cursor
DEALLOCATE TransferIN_Cursor

OK:
	COMMIT TRAN
	RETURN 0
ERRO:
	ROLLBACK TRAN
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_Inventory_Tranfer_IN', @ErrorLevelStr

	RETURN @ErrorLevel
GO

CREATE PROCEDURE sp_Inventory_Tranfer_Import
	(
	@IDTransfOUT	int,
	@IDTransfIN	int
	)
 AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Insiro a Transferencia


	TABELA DE ERROS PARA RETURN_VALUE

	 000  Ok
	-201  Erro em importar models
	-202  Erro em atualizar imported

	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------------------------------------------------------------------------------------------------------------
	16 Jul 2005		Rodrigo Costa		Criação;
        ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

DECLARE @ErrorLevel		int
DECLARE @SysError		int

--Declaração de variáveis para o Cursor de InventoryMov
DECLARE @ModelID 			int
DECLARE @Qty 			float
DECLARE @CostPrice			money
DECLARE @Tax			money
DECLARE @IDModelTransfDet   	int
DECLARE @AvgCost			money

BEGIN TRAN

/*--------------------------------------------------------------*/
/*		Parte da Insercao do InventoryMov        	*/
/*--------------------------------------------------------------*/

--Declaração do Cursor de InventoryMov
DECLARE TransferItem_Cursor CURSOR FOR
	SELECT
		MTD.IDModel,
		MTD.Qty,
		MTD.Tax,
		MTD.CostPrice,
		MTD.AvgCost
	FROM
		ModelTransfDet MTD
	WHERE
		MTD.IDModelTransf = @IDTransfOUT

OPEN TransferItem_Cursor

--Inicialização de TransferItem_Cursor
FETCH NEXT FROM TransferItem_Cursor INTO
	@ModelID,
	@Qty,
	@Tax,
	@CostPrice,
	@AvgCost
--Enquanto tem registros
WHILE
@@FETCH_STATUS = 0
BEGIN
--Inclusao da loja original
	EXEC sp_Sis_GetNextCode'ModelTransfDet.IDModelTransfDet', @IDModelTransfDet OUTPUT

	INSERT ModelTransfDet
		(
		IDModelTransfDet,
		IDModelTransf,
		IDModel,
		Qty,
		CostPrice,
		Tax,
		AvgCost
		)
	VALUES
		(
		@IDModelTransfDet,
		@IDTransfIN,
		@ModelID,
		@Qty,
		@CostPrice,
		@Tax,
		@AvgCost
		)

	FETCH NEXT FROM TransferItem_Cursor INTO
		@ModelID,
		@Qty,
		@Tax,
		@CostPrice,
		@AvgCost
END
--fechamento do cursor
CLOSE TransferItem_Cursor
--Destruição do cursor
DEALLOCATE TransferItem_Cursor

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO   ERRO
END

/*--------------------------------------------------------------*/
/*		Atualizo a importacao		        	*/
/*--------------------------------------------------------------*/

UPDATE
	ModelTransf
SET
	Imported = 1
WHERE
	IDModelTransf = @IDTransfOUT
	

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -202
	GOTO   ERRO
END


OK:
	COMMIT TRAN
	RETURN 0
ERRO:
	ROLLBACK TRAN
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_Inventory_Tranfer_Import', @ErrorLevelStr

	RETURN @ErrorLevel
GO

CREATE PROCEDURE sp_Inventory_Tranfer_OUT
	(
	@IDModelTransf	int
	)
 AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Exclusão do InventoryMov
		- Salvar custo medio no detalhe da transferencia
		- Inserção do InventoryMov


	TABELA DE ERROS PARA RETURN_VALUE

	 000  Ok
	-201  Erro em Exclusão do InventoryMov
	-202  Erro em Inserção do InventoryMov
	-203  Erro em Salvar custo medio no detalhe da transferencia

	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------------------------------------------------------------------------------------------------------------
	16 Jul 2005		Rodrigo Costa		Criação;
	05 Jun 2006		Carlos Lima		Adicionado Custo médio na inserção de InventoryMov
        ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

DECLARE @ErrorLevel		int
DECLARE @SysError		int

--Declaração de variáveis para o Cursor de InventoryMov
DECLARE @DocumentID 	int 
DECLARE @ModelID 		int 
DECLARE @Qty 		float
DECLARE @CostPrice 		money
DECLARE @IDUser 		int 
DECLARE @PreInventoryMovID 	int 
DECLARE @IDInventoryMov    	int
DECLARE @StoreIDOrigem 	int 
DECLARE @StoreIDDestino 	int 
DECLARE @AvgCost 		money 

BEGIN TRAN


/*--------------------------------------------------------------*/
/*		Parte da Delecao do InventoryMov        	*/
/*--------------------------------------------------------------*/
DECLARE InventoryMov_Cursor CURSOR FOR

SELECT
	IDInventoryMov
FROM
	InventoryMov
WHERE	
	InventoryMov.InventMovTypeID = 7
	AND
	InventoryMov.DocumentID = @IDModelTransf



OPEN InventoryMov_Cursor


FETCH NEXT FROM InventoryMov_Cursor INTO
	@IDInventoryMov

WHILE @@FETCH_STATUS = 0
BEGIN
	EXEC sp_Inventory_Del_Moviment @IDInventoryMov
	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		CLOSE InventoryMov_Cursor
		DEALLOCATE InventoryMov_Cursor
		SET @ErrorLevel = -201
		GOTO ERRO
	END

	FETCH NEXT FROM InventoryMov_Cursor INTO
		@IDInventoryMov
END

CLOSE InventoryMov_Cursor
DEALLOCATE InventoryMov_Cursor

--------------------------------------------------------------------
--  Atualiza  Custo médio de transferencia  --
--------------------------------------------------------------------
UPDATE	ModelTransfDet
SET		AvgCost = IsNull(StoreAvgPrice, 0)
FROM
	ModelTransf, Inventory
WHERE
	ModelTransfDet.IDModelTransf = ModelTransf.IDModelTransf
	AND
	ModelTransf.IDLojaOrigem = Inventory.StoreID
	AND
	ModelTransfDet.IDModel = Inventory.ModelID
	AND
	ModelTransfDet.IDModelTransf = @IDModelTransf

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -203
	GOTO   ERRO
END



/*--------------------------------------------------------------*/
/*		Parte da Insercao do InventoryMov        	*/
/*--------------------------------------------------------------*/

--Declaração do Cursor de InventoryMov
DECLARE TransferOUT_Cursor CURSOR FOR
	SELECT
		MTD.IDModelTransf,
		MT.IDLojaOrigem,
		MT.IDLojaDestino,
		MTD.IDModel,
		MTD.Qty,
		MT.IDUser,
		MTD.IDModelTransfDet, /* guarda a linha correspondente a inserida */
		MTD.CostPrice,
		Inv.StoreAvgPrice
	FROM
		ModelTransfDet MTD
		INNER JOIN ModelTransf MT ON  (MTD.IDModelTransf = MT.IDModelTransf)
		INNER JOIN Inventory Inv ON (MTD.IDModel = Inv.ModelID AND MT.IDLojaOrigem = Inv.StoreID)
	WHERE		
		MT.IDModelTransf = @IDModelTransf

OPEN TransferOUT_Cursor

--Inicialização de TransferOUT_Cursor
FETCH NEXT FROM TransferOUT_Cursor INTO
	@DocumentID,
	@StoreIDOrigem,
	@StoreIDDestino,
	@ModelID,
	@Qty,
	@IDUser,
	@PreInventoryMovID,
	@CostPrice,
	@AvgCost
--Enquanto tem registros
WHILE
@@FETCH_STATUS = 0
BEGIN
--Inclusao da loja original
	EXEC sp_Sis_GetNextCode'InventoryMov.IDInventoryMov', @IDInventoryMov OUTPUT

	INSERT InventoryMov
		(
		IDInventoryMov,
		InventMovTypeID,
		DocumentID,
		StoreID,
		ModelID,
		IDPessoa,
		MovDate,
		Qty,
		IDUser,
		PreInventoryMovID,
		CostPrice,
		AvgCost
		)
	VALUES
		(
		@IDInventoryMov,
		7,   /* saida da loja original */
		@DocumentID,
		@StoreIDOrigem,
		@ModelID,
		0,
		GetDate(),
		@Qty,
		@IDUser,
		@PreInventoryMovID, /* guarda a linha correspondente a inserida */
		@CostPrice,
		@AvgCost
		)

	FETCH NEXT FROM TransferOUT_Cursor INTO
		@DocumentID,
		@StoreIDOrigem,
		@StoreIDDestino,
		@ModelID,
		@Qty,
		@IDUser,
		@PreInventoryMovID,
		@CostPrice,
		@AvgCost
END
--fechamento do cursor
CLOSE TransferOUT_Cursor
--Destruição do cursor
DEALLOCATE TransferOUT_Cursor

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -202
	GOTO   ERRO
END


OK:
	COMMIT TRAN
	RETURN 0
ERRO:
	ROLLBACK TRAN
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_Inventory_Tranfer_OUT', @ErrorLevelStr

	RETURN @ErrorLevel
GO

CREATE PROCEDURE sp_Model_Adjust
		(
		@QtyOnOrder        	float,
		@QtyOnRepair       	float,
		@QtyOnPrePurchase  	float,
		@IDModel    	   	int,
		@IDStore      	   	int,
		@Difference 	   	float,
		@IDUser			int,
		@Date			Datetime,
		@Notes			varchar(255), -- Davi
		@IDMovReason		int
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
	05 Jun 2006		Carlos Lima		Adicionado Custo médio na inserção de InventoryMov
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */


DECLARE @ErrorLevel 	int
DECLARE @SysError	int
DECLARE @IDInventoryMov	int
DECLARE @AvgCost	money

SET @ErrorLevel = 0

SELECT @AvgCost = StoreAvgPrice FROM Inventory WHERE StoreID = @IDStore AND ModelID = @IDModel 

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
				IDUser,
				AvgCost
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
				@IDUser,
				@AvgCost
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
				IDUser,
				AvgCost
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
				@IDUser,
				@AvgCost
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

CREATE PROCEDURE sp_PreSale_Pay
			(
			@PreSaleID		int,
			@IDCashRegMov		int,
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
	- Insert Encargos de Venda na tabela de Taxas InventoryMovTax
	- Insert Impostos de Venda na tabela de Taxas InventoryMovTax
	- Move os PreSerialMov para o SerialMov
	- Deleta os seriais do Inventario
	- Deleta Pre Inventory Movement
	- Marca os lancamentos como confimados, e troca o documento
	- Update Cash RegisterMovent
	- Atualiza o custo medio dos modelos
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
	-214  Erro ao Impostos
	-216  Erro ao Colocar PreInventMovParent para Null
	-217  Erro ao atualizar SaleItemCommission
	-218  Erro ao inserir em Sal_AccountCard
	-219  Erro ao Inserir em Repair

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
	18 Dec 2003		Andre Bogado		Alteração no cursor de InvMov para atualizar InventoryMovTax
	22 Dec 2003		Rodrigo Costa		Incluir os Serias no Inventory se for Refound
	25 May 2004		Rodrigo Costa		Mover PackModels do PreInvMov para o InvMov
	18 Aug 2004		Rodrigo Costa		Gravar error log
	20 Set 2004		Rodrigo Costa		Correcao do Calculo de InventoryMovTax (IM.SalePrice-IM.Discount)
	07 Dez 2004		Rodrigo Costa		Novo calculo das taxas
	01 Fev 2005		Rodrigo Costa		Mover as QtyExchanged de Pre para Inv
	25 Fev 2005		Rodrigo Costa		Quando finalizar o Invoice nao pode atualizar o IDStore
	29 Mar 	2005		Rodrigo Costa		Atualiza o custo medio dos modelos; gravar o custo medio na venda
	11 Apr	2005		Rodrigo Costa		Inclusao do campo DesiredMarkup no PreInv e InventoryMov
	17 May	2005		Rodrigo Costa		Cursor para alterar PreInvMovParent
	01 July	2005		Rodrigo Costa		Gerar numero sequencial para Items de Servico
	28 Nov	2005		Leonardo Riego		Atualiza SaleItemCommission
	11 Jan	2006		Rodrigo Costa		Remover zerar o custo medio
	23 Mar	2006		Carlos Lima		Suporte ao Gift Card ( Chamada para a procedure que inclui em Sal_AccountCard )
	03 Apr	2006		Rodrigo Costa		Inserir em Repair


    --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

DECLARE @DataPagamento  	smalldatetime
DECLARE @ComissionPayed 	money
DECLARE @IDCentroCusto	int
DECLARE @ErrorLevel		int
DECLARE @SysError		int
DECLARE @InvoiceCode	varchar(20)
DECLARE @ServiceField	varchar(30)
--Declaração de variáveis para o Cursor de InventoryMov
DECLARE @InventMovTypeID	int
DECLARE @DocumentID		int
DECLARE @IDPessoa		int
DECLARE @ModelID		int
DECLARE @BarCodeID		char(20)
DECLARE @MovDate		smalldatetime
DECLARE @Qty 			float
DECLARE @CostPrice		money
DECLARE @SalePrice		money
DECLARE @Discount		money
DECLARE @PreInventoryMovID	int
DECLARE @IDUser			int
DECLARE @SalesTax		money
DECLARE @StoreID		int
DECLARE @IDInventoryMov		int
DECLARE @IDParentPack		int
DECLARE @QtyExchanged		float
DECLARE @IDPreInvMovExchange	int
DECLARE @AvgCost		money
DECLARE @DesiredMarkup		money
DECLARE @IsService		bit
DECLARE	@AutoCreateSrvNum	bit
DECLARE @ServiceNum		int
DECLARE	@IDGroup		int
DECLARE @CardNumber		varchar(20)
declare @GiftValue		money
declare @IDDepartment		int

--PRINT 'Starting transaction'
BEGIN TRAN

SET  @ErrorLevel = 0

-- Retorna o Centro de Custo referente a loja
SELECT @IDCentroCusto = (SELECT IDCentroCusto  FROM Store WHERE IDStore = @IDStore)

SET @SysError = @@ERROR
IF @SysError <> 0 GOTO ERRO


/*--------------------------------------------------------------------------------------------------------*/
/*		Transforma a PreSale em Sale    		  					*/
/*--------------------------------------------------------------------------------------------------------*/

-- Calcula o proximo IDInvoice
EXEC sp_Sis_GetNextCode 'InvoiceGen.IDInvoice', @IDInvoice OUTPUT

EXEC SP_PreSale_GetNewInvoiceCode @IDStore, @InvoiceCode OUTPUT

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END

 -- Transforma o hold em invoice
UPDATE Invoice
SET		Invoice.IDInvoice    	= @IDInvoice,
		Invoice.InvoiceDate  	= @PayDate,
		Invoice.CashReceived 	= @CashReceived,
		Invoice.CashRegMovID 	= @IDCashRegMov,
		Invoice.InvoiceCode	= @InvoiceCode

WHERE 	Invoice.IDPreSale = @PreSaleID

SET @SysError = @@ERROR
IF @SysError <> 0
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
			PIM.IDPreInventoryMov,
			PIM.UserID,
			(CASE WHEN (TC.SpecialDateStart <= @Date) AND (TC.SpecialDateEnd >= @Date) AND ( ISNULL((( ISNULL(PIM.SalePrice, 0) - ISNULL(PIM.Discount, 0)) / PIM.Qty), 0) < ISNULL(TC.MaxItemValue, 0))
				 THEN TC.SpecialTax ELSE TC.Tax END / 100.00)  as Tax,-- Tax
			PIM.IDParentPack,
			PIM.QtyExchanged,
			PIM.IDPreInvMovExchange,
			Inv.StoreAvgPrice,
			TG.DesiredMarkup,
			TG.ServiceAutoNumber,
			TG.Service,
			TG.IDGroup,
			PIM.IDDepartment
	FROM		
			dbo.PreInventoryMov PIM
			JOIN Model M ON ( PIM.ModelID = M.IDModel )
			JOIN TabGroup TG ON ( M.GroupID = TG.IDGroup )
			JOIN StoreToTabGroup STC ON ( STC.IDStore = PIM.StoreID AND STC.IDGroup = TG.IDGroup )
			JOIN TaxCategory TC ON ( TC.IDTaxCategory = STC.IDTaxCategory )
			JOIN Inventory Inv ON ( PIM.ModelID = INV.ModelID AND  PIM.StoreID = INV.StoreID )

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
	@PreInventoryMovID,
	@IDUser,
	@SalesTax,
	@IDParentPack,
	@QtyExchanged,
	@IDPreInvMovExchange,
	@AvgCost,
	@DesiredMarkup,
	@AutoCreateSrvNum,
	@IsService,
	@IDGroup,
	@IDDepartment
--Enquanto tem registros
WHILE
@@FETCH_STATUS = 0BEGIN

	SET @ServiceNum = Null

	IF (@AutoCreateSrvNum = 1 AND @IsService = 1  )
	BEGIN
		SET @ServiceField = 'TabGroup.Service'+CAST(@IDGroup as Varchar(10))
		EXEC sp_Sis_GetNextCode @ServiceField, @ServiceNum OUTPUT
	END

	EXEC sp_Sis_GetNextCode 'InventoryMov.IDInventoryMov', @IDInventoryMov OUTPUT

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
		PreInventoryMovID,
		IDUser,
		SalesTax,
		IDParentPack,
		QtyExchanged,
		IDPreInvMovExchange,
		AvgCost,
		DesiredMarkup,
		SequencyNum,
		IDDepartment
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
		@PreInventoryMovID,
		@IDUser,
		@SalesTax,
		@IDParentPack,
		@QtyExchanged,
		@IDPreInvMovExchange,
		@AvgCost,
		@DesiredMarkup,
		@ServiceNum,
		@IDDepartment
		)

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		CLOSE InventoryMov_Cursor
		DEALLOCATE InventoryMov_Cursor
		SET @ErrorLevel = -203
		GOTO ERRO
	END

	-- Atualiza SaleItemCommission
	UPDATE SaleItemCommission
	SET
	 	IDPreInventoryMov = NULL,
		IDInventoryMov = @IDInventoryMov
	WHERE
		IDPreInventoryMov = @PreInventoryMovID
	
	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		CLOSE InventoryMov_Cursor
		DEALLOCATE InventoryMov_Cursor
		SET @ErrorLevel = -217
		GOTO ERRO
	END

	-- Insert Encargos de Venda na tabela de Taxas InventoryMovTax
	INSERT INTO InventoryMovTax 
		(
		IDInventoryMov, 
		IDTaxCategory, 
		Tax, 
		TaxValue 
		)
	SELECT 
		IM.IDInventoryMov,
		ISNULL (TC.IDTaxCategory,0) AS IDTaxCategory,
		ISNULL (TC.Tax,0)/100 AS Tax,
		ISNULL (((IM.SalePrice * IM.Qty) - IM.Discount) * TC.Tax,0)/100 AS TaxValue

	FROM 	InventoryMov IM
		JOIN Model Mo ON (IM.ModelID = Mo.IDModel)
		JOIN StoreToTabGroup SG ON (SG.IDStore = IM.StoreID AND SG.IDGroup = Mo.GroupID )
		JOIN TaxCategory TC ON (SG.IDTaxCategory = TC.IDTaxCategoryParent)

	WHERE
	 	IM.IDInventoryMov = @IDInventoryMov

	-- Insert Impostos de Venda na tabela de Taxas InventoryMovTax
	INSERT INTO InventoryMovTax 
		(
		IDInventoryMov, 
		IDTaxCategory, 
		Tax, 
		TaxValue 
		)
	SELECT 
		IM.IDInventoryMov,
		ISNULL (TC.IDTaxCategory,0) AS IDTaxCategory,
		ISNULL (TC.Tax,0)/100 AS Tax,
		ISNULL (((IM.SalePrice * IM.Qty) - IM.Discount) * TC.Tax,0)/100 AS TaxValue

	FROM 	InventoryMov IM
		JOIN Model Mo ON (IM.ModelID = Mo.IDModel)
		JOIN StoreToTabGroup SG ON (SG.IDStore = IM.StoreID AND SG.IDGroup = Mo.GroupID )
		JOIN TaxCategory TC ON (SG.IDSaleTax = TC.IDTaxCategory)

	WHERE
	 	IM.IDInventoryMov = @IDInventoryMov



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
		@PreInventoryMovID,
		@IDUser,
		@SalesTax,
		@IDParentPack,
		@QtyExchanged,
		@IDPreInvMovExchange,
		@AvgCost,
		@DesiredMarkup,
		@AutoCreateSrvNum,
		@IsService,
		@IDGroup,
		@IDDepartment
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


/*--------------------------------------------------------------------------------------------------------*/
/*	     Insere a movimentação de crédito na tabela de AccountCard                	*/
/*--------------------------------------------------------------------------------------------------------*/

EXEC sp_PreSale_ItemRepair @PreSaleID
SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -219
	GOTO ERRO
END


/*--------------------------------------------------------------------------------------------------------*/
/*	     Insere a movimentação de crédito na tabela de AccountCard                	*/
/*--------------------------------------------------------------------------------------------------------*/


DECLARE AccountMov_Cursor CURSOR FOR
	SELECT			
		PSM.SerialNumber,
		PIM.SalePrice - (PIM.Discount / PIM.Qty),
		PIM.UserID
	FROM		
		PreSerialMov PSM
		JOIN PreInventoryMov PIM ON (PSM.PreInventoryMovID = PIM.IDPreInventoryMov)
		JOIN Model M ON (PIM.ModelID = M.IDModel)
	WHERE 	
		PIM.DocumentID = @PreSaleID
		AND
		PIM.InventMovTypeID = 1
		AND
		M.ModelType = 'G'

OPEN AccountMov_Cursor

--Inicialização de PreInventoryMov_Cursor
FETCH NEXT FROM AccountMov_Cursor INTO @CardNumber, @GiftValue, @IDUser

WHILE @@FETCH_STATUS = 0
BEGIN

	EXEC sp_Sal_AccountCard_AddAmount @CardNumber, @GiftValue, @PreSaleID, NULL, @IDUser, 1, ''


	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		CLOSE AccountMov_Cursor
		DEALLOCATE AccountMov_Cursor
		SET @ErrorLevel = -218
		GOTO ERRO
	END

	FETCH NEXT FROM AccountMov_Cursor INTO @CardNumber, @GiftValue, @IDUser
END

CLOSE AccountMov_Cursor
DEALLOCATE AccountMov_Cursor


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

SET @SysError = @@ERROR
IF @SysError <> 0
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
		

SET @SysError = @@ERROR
IF @SysError <> 0
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

SET @SysError = @@ERROR
IF @SysError <> 0
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

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -213
	GOTO ERRO
END

/*--------------------------------------------------------------------------------------------------------*/
/*	       Deleta PreInventory Movement			*/
/*--------------------------------------------------------------------------------------------------------*/
DECLARE @IDPreInventoryMov int

--Declaração do Cursor de PreInventoryMov
DECLARE PreInventoryMovDelParent_Cursor CURSOR FOR

	SELECT
		IDPreInventoryMov
	FROM
		PreInventoryMov
	WHERE
		DocumentID = @PreSaleID

OPEN PreInventoryMovDelParent_Cursor

--Inicialização de PreInventoryMov_Cursor
FETCH NEXT FROM PreInventoryMovDelParent_Cursor INTO
	@IDPreInventoryMov

WHILE @@FETCH_STATUS = 0
BEGIN

	UPDATE 	
		PreInventoryMov
	SET
		PreInventoryMov.IDPreInventoryMovParent = NULL
	WHERE 	
		PreInventoryMov.IDPreInventoryMovParent = @IDPreInventoryMov

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		CLOSE PreInventoryMovDelParent_Cursor
		DEALLOCATE PreInventoryMovDelParent_Cursor
		SET @ErrorLevel = -216
		GOTO ERRO
	END


	FETCH NEXT FROM PreInventoryMovDelParent_Cursor INTO
		@IDPreInventoryMov

END
--fechamento do cursor
CLOSE PreInventoryMovDelParent_Cursor
--Destruição do cursor
DEALLOCATE PreInventoryMovDelParent_Cursor

/*--------------------------------------------------------------------------------------------------------*/
/*	       Deleta PreInventory Movement			*/
/*--------------------------------------------------------------------------------------------------------*/
DELETE 	
		PreInventoryMov
WHERE 	
		PreInventoryMov.DocumentID = @PreSaleID
		AND
		PreInventoryMov.InventMovTypeID = 1

SET @SysError = @@ERROR
IF @SysError <> 0
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


SET @SysError = @@ERROR
IF @SysError <> 0
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

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_PreSale_Pay', @ErrorLevelStr

	RETURN @ErrorLevel

GO

CREATE PROCEDURE sp_Purchase_Do
	(
	@IDPurchase	int,
	@Date 		DateTime,
	@TaxInCost	Bit
	)
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO
		
		- Deleto os InventoryMov
		- Incluo no Inventario os barcodes que ainda nao existam
		- Altero o Category no Model quando diferente
		- Atualizo o AvgCost no Model
		- Atualizo o AvgCost no Inventory
		- Incluo o InventoryMov se necessario
		- Se necessario crio os lancamentos no contas a pagar
		- Deleto as Qty do Pur_PurchaseQtyPreSale ##Rodrigo
		- Incluo as Qty do Pur_PurchaseQtyPreSale ##Rodrigo
		- Incluo os serial Numbers no inventory
		- Crio os lancamentos de retorno no contas a pagar, se necessario


	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Deleto as Qty do Pur_PurchaseQtyPreSale
		-202  Erro em Deleto as Qty do Pur_PurchaseQtyOrder
		-203  Erro em Deleto os PreInventoryMov
		-204  Erro em Deleto os InventoryMov
		-205  Erro em Incluo no Inventario os barcodes que ainda nao exitam
		-206  Erro em Atualizo a informa??o de category
		-207  Erro em Atualizar a TBL de Model com os valores se for Final
		-208  Erro em Incluo o InventoryMov se necessario
		-209  Erro em Insiro as Qty do Pur_PurchaseQtyPrePurchase se for PreReceiving para atualizar o qtyOnPreReceive na TBL Inventory
		-210  Erro em Insiro as Qty do Pur_PurchaseQtyOrder - Atualizar as qty no PO
		-211  Erro em Atualiza o total do PO
		-212  Erro em Crio os Serial Numbers no inventory se for final
		-213  Erro em Delete os Serial Numbers do Purchase
		-214  Erro em Deleto o Term do Fin >>> Os termos so serao deletados se o Purchase Type for do tipo Invoice
		-215  Erro em Crio os lancamentos no contas a pagar, se necessario
		-216  Erro em Incluio novamente o Term do Fin >>> Os termos so serao incluidos se o Purchase Type for do typo Invoice
		-217  Erro em Deletetar o InventoryMovTax
		-218  Erro em atualizar o PO
		-219  Erro em Crio os lancamentos de retorno no contas a pagar, se necessario
		-220  Erro em Inserir na ModelVendor
		-221  Erro em Atualizo o AvgCost no Model
		-222  Erro em Atualizo o AvgCost no Inventory

	LOG DE MODIFICA??ES

	Data			Programador		Modifica??o
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	04 dezembro 	2000	Eduardo Costa		Cria??o;
	18 dezembro 	2000	Rodrigo Costa		Complemento;
	06 junho        	2001	Davi Gouveia	Variavel @ErrorLevel/Lista de Return_Values
	07 junho        	2001	Rodrigo Costa	Insert no Fin_LancamentoTerm
	07 dezembro 	2001	Rodrigo Costa		Nao pode deletar p PreInventoryMov, pois os item nao sao salvos la.
	13 May	        	2002	Rodrigo Costa	Criacao Lancamento Termo para os Disbursements 
	29 Oct		2003	Rodrigo Costa		Criado Cuersor para InvMov, Pur_PurchaseQtyPrePurchase, Pur_PurchaseQtyOrder_Cursor;
							Chamado da sp_GetNextCode;
	13 Feb		2004	Rodrigo Costa		Deletar o InventoryMovTax da Compra
	18 Aug		2004	Rodrigo Costa		Gravar error log
	14 Dez		2004	Rodrigo Costa		Cricao do campo @TaxInCost para incluir o preco do item; Retirado o update NewSalePrice
	11 Mar		2005	Carlos Lima		Tratamento das quantidades devolvidas
	11 Mar		2005	Rodrigo Costa		Atualizacao das quantidades no PO
	14 Mar		2005	Carlos Lima		Criação da Devolução no Contas a Pagar
	26 Abr		2005	Rodrigo Costa		Incluir impostos de devolucao caso necessario; Nao alterar categoria dos produtos
	02 Jan		2006	Carlos Lima		Retirada do update do AvgCost em Model e Inventory ( feito agora pela trigger do InventoryMov )
	12 Jan		2006	Carlos Lima		Update do AvgCost em InventoryMov
	22 Jan		2006	Rodrigo Costa		Atualizar o DateLastSellingPrice quando fizer a compra
	25 Jan		2006	Rodrigo Costa		Inserir na tabela de Inv_ModelVendor
	01 Jun		2006	Carlos Lima		O calculo do custo medio volta para a procedure ( espero q seja a ultima vez !!! )
	06 Jun		2006	Carlos Lima		Cursor para excluir o inventorymov e atualizar o custo médio
	19 Jun		2006	Leonardo Riego		Verificação se atualiza DateLastSellingPrice e DateLastCost na tabela de Model.
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

DECLARE @IDPO 			int
DECLARE @ErrorLevel 			int
DECLARE @SysError			int

--Declara??o de vari?veis para o Cursor de InventoryMov
DECLARE @StoreID 			int 
DECLARE @IDPessoa 			int 
DECLARE @InventMovTypeID 		int 
DECLARE @DocumentID 		int 
DECLARE @ModelID 			int 
DECLARE @Qty 			float 
DECLARE @CostPrice 			money 
DECLARE @SalePrice 			money 
DECLARE @BarCodeID 			char(20)
DECLARE @MovDate 			smalldatetime 
DECLARE @IDUser 			int 
DECLARE @IDInventoryMov		int
DECLARE @HasRet				int

--Declara??o de vari?veis para o Cursor de Pur_PurchaseQtyPrePurchase
DECLARE @IDModel 			int 
DECLARE @IDStore 			int 
DECLARE @IDPurchaseQtyPreSale	float

--Declara??o de vari?veis para o Cursor de Pur_PurchaseQtyOrder
DECLARE @IDPOItem 			int 
DECLARE @IDPurchaseQtyOrder	float
DECLARE @AvgCost		float

DECLARE @IDInventory		int

BEGIN TRAN


-----------------------------------------------------------
-- Deleto as Qty do Pur_PurchaseQtyPreSale
DELETE
	PQP
FROM
	Pur_PurchaseQtyPrePurchase PQP
WHERE
	PQP.IDPurchase = @IDPurchase

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END

-----------------------------------------------------------
-- Deleto as Qty do Pur_PurchaseQtyOrder
DELETE
	PQP
FROM
	Pur_PurchaseQtyOrder PQP
WHERE
	PQP.IDPurchase = @IDPurchase

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -202
	GOTO ERRO
END

------------------------------------------------------------------------------
-- Deleto os PreInventoryMov
/*
DELETE
	PIM
FROM
	PreInventoryMov PIM
WHERE
	PIM.DocumentID = @IDPurchase
	AND
	PIM.InventMovTypeID = 2

IF @@ERROR <> 0
BEGIN
	SET @ErrorLevel = -203
	GOTO ERRO
END
*/

------------------------------------------------------------------------------
-- Deleto os InventoryMovTax

DELETE
	IMT
FROM
	InventoryMovTax IMT
WHERE
	IMT.IDInventoryMov IN (	SELECT IDInventoryMov
			       	FROM InventoryMov IM
				WHERE IM.DocumentID = @IDPurchase AND
				IM.InventMovTypeID = 2
				)

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -217
	GOTO ERRO
END

------------------------------------------------------------------------------
-- Deleto os InventoryMov

DECLARE InventoryMov_Cursor CURSOR FOR

SELECT
	IM.IDInventoryMov
FROM
	InventoryMov IM
WHERE
	IM.DocumentID = @IDPurchase
	AND
	IM.InventMovTypeID = 2


OPEN InventoryMov_Cursor


FETCH NEXT FROM InventoryMov_Cursor INTO
	@IDInventoryMov

WHILE @@FETCH_STATUS = 0
BEGIN
	EXEC sp_Inventory_Del_Moviment @IDInventoryMov
	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		CLOSE InventoryMov_Cursor
		DEALLOCATE InventoryMov_Cursor
		SET @ErrorLevel = -204
		GOTO ERRO
	END

	FETCH NEXT FROM InventoryMov_Cursor INTO
		@IDInventoryMov
END

CLOSE InventoryMov_Cursor
DEALLOCATE InventoryMov_Cursor

------------------------------------------------------------------------------
-- Incluo no Inventario os barcodes que ainda nao exitam

INSERT
	BarCode (IDBarCode, IDModel, Data)
SELECT

	PPI.BarCode,
	PPI.IDModel,
	@Date
FROM
	Pur_PurchaseItem PPI
	LEFT OUTER JOIN BarCode BC ON (PPI.BarCode = BC.IDBarCode)
WHERE
	BC.IDModel IS Null
	AND
	PPI.BarCode IS NOT NULL
	AND
	PPI.IDPurchase = @IDPurchase

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -205
	GOTO ERRO
END

------------------------------------------------------------------------------
-- Atualizo a informacao de category

UPDATE
	M
SET
	M.GroupID = PPI.IDGroup
FROM
	Model M
	JOIN Pur_PurchaseItem PPI ON (M.IDModel = PPI.IDModel)
WHERE
	M.GroupID <> PPI.IDGroup
	AND
	PPI.IDPurchase = @IDPurchase

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -206
	GOTO ERRO
END


--------------------------------------------------------------------------------------------------
---Atualizar a TBL de Model com os valores se for Final
---Imposto nao esta incluido no Custo do produto
IF (@TaxInCost=1)
BEGIN
	UPDATE
		Model
	SET
		Model.Desativado     	= 0,
		Model.DateLastSellingPrice = CASE IsNull(PUI.NewSalePrice, 0) WHEN 0 THEN Model.DateLastSellingPrice WHEN Model.SellingPrice THEN Model.DateLastSellingPrice ELSE @Date END,
		Model.DateLastCost   	= CASE WHEN (Model.LastCost = Model.VendorCost) THEN Model.DateLastCost ELSE @Date END,
		Model.LastCost       	= IsNull(Model.VendorCost,0),
		Model.VendorCost     	= IsNull(PUI.NewCostPrice,0),
		Model.SellingPrice 	= CASE IsNull(PUI.NewSalePrice,0) WHEN 0 THEN Model.SellingPrice ELSE PUI.NewSalePrice END,
		Model.SuggRetail 	= CASE IsNull(PUI.NewSuggRetail,0) WHEN 0 THEN Model.SuggRetail ELSE PUI.NewSuggRetail END,
		Model.OtherCost		= 0, --OtherCost ja esta incluido no custo
		Model.FreightCost    	= 0 --Freight ja esta incluido no custo
		
	FROM
		Pur_Purchase PU
		JOIN Pur_PurchaseItem PUI ON (PU.IDPurchase = PUI.IDPurchase)
		JOIN Pur_PurchaseTotal PUT ON (PU.IDPurchase = PUT.IDPurchase)
	WHERE
		PU.IDPurchase = @IDPurchase
		AND
		DateFinalReceiving IS NOT NULL
		AND
		Model.IDModel = PUI.IDModel
END
ELSE
BEGIN

	UPDATE
		Model
	SET
		Model.Desativado	= 0,
		Model.DateLastSellingPrice = CASE IsNull(PUI.NewSalePrice, 0) WHEN 0 THEN Model.DateLastSellingPrice WHEN Model.SellingPrice THEN Model.DateLastSellingPrice ELSE @Date END,
		Model.DateLastCost	= CASE WHEN (Model.LastCost = Model.VendorCost) THEN Model.DateLastCost ELSE @Date END,
		Model.SellingPrice 	= IsNull(PUI.NewSalePrice,0),
		Model.SuggRetail 	= IsNull(PUI.NewSuggRetail,0),
		Model.LastCost		= IsNull(Model.VendorCost,0),
		Model.VendorCost	= IsNull(PUI.NewCostPrice,0),
				
		Model.OtherCost 	= ROUND(
					CASE	WHEN 	PUT.SubTotal = 0 THEN 0
						ELSE	( IsNull((PU.OtherCharges / PUT.SubTotal)  * (PUI.NewCostPrice)  , 0 ) )
					END
	
				      	,2),
	
	
		Model.FreightCost 	= ROUND(
					  CASE	WHEN 	PUT.SubTotal = 0 THEN 0
						ELSE	( IsNull(	(PU.Freight / PUT.SubTotal)  * (PUI.NewCostPrice) , 0 ) )
					  END
				      	,2)
			
	FROM
		Pur_Purchase PU
		JOIN Pur_PurchaseItem PUI ON (PU.IDPurchase = PUI.IDPurchase)
		JOIN Pur_PurchaseTotal PUT ON (PU.IDPurchase = PUT.IDPurchase)
	WHERE
		PU.IDPurchase = @IDPurchase
		AND
		DateFinalReceiving IS NOT NULL
		AND
		Model.IDModel = PUI.IDModel

END


SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -207
	GOTO ERRO
END


------------------------------------------------------------------------------
-- Incluo o InventoryMov se necessario
--Declara??o do Cursor de InventoryMov
DECLARE InventoryMov_Cursor CURSOR FOR

SELECT
	PP.IDStore,
	PP.IDFornecedor,
	2, -- Compra
	PP.IDPurchase,
	PPI.IDModel,
	PPI.Qty - IsNull(PPI.QtyRet, 0) AS Qty,
	PPI.NewCostPrice,
	PPI.NewSalePrice,
	PPI.BarCode,
	PP.DateFinalReceiving,
	PP.IDUserFinalReceiving
FROM
	Pur_Purchase PP
	JOIN Pur_PurchaseItem PPI ON (PP.IDPurchase = PPI.IDPurchase)
WHERE
	PP.IDPurchase = @IDPurchase
	AND
	DateFinalReceiving IS NOT NULL



OPEN InventoryMov_Cursor

--Inicializacao de InventoryMov_Cursor
FETCH NEXT FROM InventoryMov_Cursor INTO
	@StoreID,
	@IDPessoa,
	@InventMovTypeID,
	@DocumentID,
	@ModelID,
	@Qty,
	@CostPrice,
	@SalePrice,
	@BarCodeID,
	@MovDate,
	@IDUser
--Enquanto tem registros
WHILE
@@FETCH_STATUS = 0
BEGIN

	-- Atualiza o saldo em valor do Model

	UPDATE
		Model
	SET
		Model.AvgCostTotal = IsNull(Model.AvgCostTotal, 0) + (@CostPrice * @Qty),
		Model.AvgCost = CASE WHEN (IsNull(Model.TotQtyOnHand, 0) + @Qty) = 0 
					THEN 0 
					ELSE (IsNull(Model.AvgCostTotal, 0) + (@CostPrice * @Qty)) / (IsNull(Model.TotQtyOnHand, 0) + @Qty) 
				END
	WHERE
		Model.IDModel = @ModelID

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		CLOSE InventoryMov_Cursor
		DEALLOCATE InventoryMov_Cursor
		SET @ErrorLevel = -221
		GOTO ERRO
	END

	IF NOT EXISTS(SELECT ModelID FROM Inventory WHERE ModelID = @ModelID AND StoreID = @StoreID)
	BEGIN
		EXEC sp_Sis_GetNextCode'Inventory.IDInventory', @IDInventory OUTPUT
	
		INSERT Inventory
			(
			IDInventory,
			StoreID,
			ModelID
			)
		VALUES
			(
			@IDInventory,
			@StoreID,
			@ModelID
			)
	END


	-- Atualiza o saldo em valor do inventory

	SELECT
		@AvgCost = 
			CASE WHEN (IsNull(Inventory.QtyOnHand, 0) + @Qty) = 0 
				THEN 0 
				ELSE (IsNull(Inventory.AvgCostTotal, 0) + (@CostPrice * @Qty)) / (IsNull(Inventory.QtyOnHand, 0) + @Qty) 
			END
	FROM
		Inventory
	WHERE
		Inventory.ModelID = @ModelID
		AND
		Inventory.StoreID = @StoreID



	UPDATE
		Inventory
	SET
		Inventory.AvgCostTotal = IsNull(Inventory.AvgCostTotal, 0) + (@CostPrice * @Qty),
		Inventory.StoreAvgPrice = @AvgCost
	WHERE
		Inventory.ModelID = @ModelID
		AND
		Inventory.StoreID = @StoreID

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		CLOSE InventoryMov_Cursor
		DEALLOCATE InventoryMov_Cursor
		SET @ErrorLevel = -222
		GOTO ERRO
	END
	

	EXEC sp_Sis_GetNextCode 'InventoryMov.IDInventoryMov', @IDInventoryMov OUTPUT

	INSERT InventoryMov
		(
		IDInventoryMov,
		StoreID,
		IDPessoa,
		InventMovTypeID,
		DocumentID,
		ModelID,
		Qty,
		CostPrice,
		SalePrice,
		BarCodeID,
		MovDate,
		IDUser,
		AvgCost
		)
	VALUES
		(
		@IDInventoryMov,
		@StoreID,
		@IDPessoa,
		@InventMovTypeID,
		@DocumentID,
		@ModelID,
		@Qty,
		@CostPrice,
		@SalePrice,
		@BarCodeID,
		@MovDate,
		@IDUser,
		@AvgCost
		)

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		CLOSE InventoryMov_Cursor
		DEALLOCATE InventoryMov_Cursor
		SET @ErrorLevel = -208
		GOTO ERRO
	END
	

	IF NOT EXISTS (SELECT IDModel FROM Inv_ModelVendor WHERE IDModel = @ModelID AND IDPessoa = @IDPessoa)
	BEGIN
		INSERT
			Inv_ModelVendor (IDModel, IDPessoa, VendorOrder)
		SELECT
			@ModelID,
			@IDPessoa,
			IsNull(MAX(IMV.VendorOrder),0) + 1
		FROM
			Inv_ModelVendor IMV
		WHERE
			IMV.IDModel = @ModelID
	END

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		PRINT 'ERROR AQUI'
		CLOSE InventoryMov_Cursor
		DEALLOCATE InventoryMov_Cursor
		SET @ErrorLevel = -220
		GOTO ERRO
	END


	FETCH NEXT FROM InventoryMov_Cursor INTO

		@StoreID,
		@IDPessoa,
		@InventMovTypeID,
		@DocumentID,
		@ModelID,
		@Qty,
		@CostPrice,
		@SalePrice,
		@BarCodeID,
		@MovDate,
		@IDUser
END
--fechamento do cursor
CLOSE InventoryMov_Cursor
--Destrui??o do cursor
DEALLOCATE InventoryMov_Cursor

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -208
	GOTO ERRO
END


-----------------------------------------------------------
-- Insiro as Qty do Pur_PurchaseQtyPrePurchase se for PreReceiving para atualizar o qtyOnPreReceive na TBL Inventory
--Declara??o do Cursor de Pur_PurchaseQtyPrePurchase
DECLARE Pur_PurchaseQtyPrePurchase_Cursor CURSOR FOR


SELECT
	PUI.IDModel,
	PU.IDStore,
	SUM(PUI.Qty - IsNull(PUI.QtyRet, 0))
FROM
	Pur_Purchase PU
	JOIN Pur_PurchaseItem PUI ON (PU.IDPurchase = PUI.IDPurchase)
WHERE
	PU.IDPurchase = @IDPurchase
	AND
	PU.DateFinalReceiving IS NULL
GROUP BY
	PUI.IDModel,
	PU.IDStore,
	PUI.IDPOItem


OPEN Pur_PurchaseQtyPrePurchase_Cursor

--Inicializa??o de Pur_PurchaseQtyPrePurchase_Cursor
FETCH NEXT FROM Pur_PurchaseQtyPrePurchase_Cursor INTO
	@IDModel,
	@IDStore,
	@Qty
--Enquanto tem registros
WHILE
@@FETCH_STATUS = 0
BEGIN
	EXEC sp_Sis_GetNextCode'Pur_PurchaseQtyPrePurchase.IDPurchaseQtyPreSale', @IDPurchaseQtyPreSale OUTPUT
	INSERT Pur_PurchaseQtyPrePurchase
		(
		IDPurchaseQtyPreSale,
		IDPurchase,
		IDModel,
		IDStore,
		Qty
		)
	VALUES
		(
		@IDPurchaseQtyPreSale,
		@IDPurchase,
		@IDModel,
		@IDStore,
		@Qty
		)

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		CLOSE Pur_PurchaseQtyPrePurchase_Cursor
		DEALLOCATE Pur_PurchaseQtyPrePurchase_Cursor
		SET @ErrorLevel = -209
		GOTO ERRO
	END

	FETCH NEXT FROM Pur_PurchaseQtyPrePurchase_Cursor INTO
		@IDModel,
		@IDStore,
		@Qty
END
--fechamento do cursor
CLOSE Pur_PurchaseQtyPrePurchase_Cursor
--Destrui??o do cursor
DEALLOCATE Pur_PurchaseQtyPrePurchase_Cursor


SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -209
	GOTO ERRO
END


-----------------------------------------------------------
-- Insiro as Qty do Pur_PurchaseQtyOrder - Atualizar as qty no PO
--Declara??o do Cursor de Pur_PurchaseQtyOrder

DECLARE Pur_PurchaseQtyOrder_Cursor CURSOR FOR

SELECT
	PUI.IDModel,
	PU.IDStore,
	PUI.IDPOItem,
	SUM(PUI.Qty - IsNull(PUI.QtyRet, 0))
FROM
	Pur_Purchase PU
	JOIN Pur_PurchaseItem PUI ON (PU.IDPurchase = PUI.IDPurchase)
WHERE
	PU.IDPurchase = @IDPurchase
GROUP BY
	PUI.IDModel,
	PU.IDStore,
	PUI.IDPOItem

OPEN Pur_PurchaseQtyOrder_Cursor

--Inicializa??o de Pur_PurchaseQtyOrder_Cursor
FETCH NEXT FROM Pur_PurchaseQtyOrder_Cursor INTO
	@IDModel,
	@IDStore,
	@IDPOItem,
	@Qty
--Enquanto tem registros
WHILE
@@FETCH_STATUS = 0
BEGIN
	EXEC sp_Sis_GetNextCode'Pur_PurchaseQtyOrder.IDPurchaseQtyOrder', @IDPurchaseQtyOrder OUTPUT
	INSERT Pur_PurchaseQtyOrder
		(
		IDPurchaseQtyOrder,
		IDPurchase,
		IDModel,
		IDStore,
		IDPOItem,
		Qty
		)
	VALUES
		(
		@IDPurchaseQtyOrder,
		@IDPurchase,
		@IDModel,
		@IDStore,
		@IDPOItem,
		@Qty
		)

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		CLOSE Pur_PurchaseQtyOrder_Cursor
		DEALLOCATE Pur_PurchaseQtyOrder_Cursor
		SET @ErrorLevel = -210
		GOTO ERRO
	END

	FETCH NEXT FROM Pur_PurchaseQtyOrder_Cursor INTO
		@IDModel,
		@IDStore,
		@IDPOItem,
		@Qty
END
--fechamento do cursor
CLOSE Pur_PurchaseQtyOrder_Cursor
--Destrui??o do cursor
DEALLOCATE Pur_PurchaseQtyOrder_Cursor


SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -210
	GOTO ERRO
END

------------------------------------------------------------------------------
-- Atualiza o total do PO

SELECT
	@IDPO = PIM.DocumentID
FROM
	PreInventoryMov PIM
	JOIN Pur_PurchaseQtyOrder PQO ON (PIM.IDPreInventoryMov = PQO.IDPOItem)

EXEC sp_PO_AtuPOTotal @IDPO

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -211
	GOTO ERRO
END

------------------------------------------------------------------------------
-- Atualizo os totais da PO, se necessario
SELECT
	@IDPO = P.IDPO
FROM
	Pur_Purchase P
WHERE
	IDPurchase = @IDPurchase

EXEC sp_PO_CalcTotalQty @IDPO

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -218
	GOTO ERRO
END


------------------------------------------------------------------------------
-- Crio os Serial Numbers no inventory se for final
INSERT
	InventorySerial
	(
	StoreID,
	ModelID,
	Serial
	)
SELECT
	PU.IDStore,
	PUI.IDModel,
	PIS.SerialNumber
FROM
	Pur_Purchase PU
	JOIN Pur_PurchaseItemSerial PIS ON (PU.IDPurchase = PIS.IDPurchase)
	JOIN Pur_PurchaseItem PUI ON (PU.IDPurchase = PUI.IDPurchase)
WHERE
	PIS.IDPurchase = @IDPurchase
	AND
	PU.DateFinalReceiving IS NOT NULL

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -212
	GOTO ERRO
END


------------------------------------------------------------------------------
-- Delete os Serail Numbers do Purchase
DELETE
	PIS
FROM
	Pur_PurchaseItemSerial PIS
	JOIN Pur_Purchase PU ON (PU.IDPurchase = PIS.IDPurchase)
WHERE
	PIS.IDPurchase = @IDPurchase
	AND
	PU.DateFinalReceiving IS NOT NULL

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -213
	GOTO ERRO
END


------------------------------------------------------------------------------
-- Deleto o Term do Fin >>> Os termos so serao deletados se o Purchase Type for do typo Invoice


DELETE
	Fin_LancamentoTerm
WHERE
	IDLancamento IN (SELECT L.IDLancamento FROM Fin_Lancamento L WHERE L.IDPurchase = @IDPurchase)

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -214
	GOTO ERRO
END


------------------------------------------------------------------------------
-- Crio os lancamentos no contas a pagar, se necessario
IF (@TaxInCost=1)
	EXEC sp_Purchase_CriaPagamentoComImposto @IDPurchase
ELSE
	EXEC sp_Purchase_CriaPagamento @IDPurchase


SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -215
	GOTO ERRO
END


------------------------------------------------------------------------------
-- Crio os lancamentos de retorno no contas a pagar, se necessario

SELECT
	@HasRet = SUM(ABS(IsNull(PPI.QtyRet, 0)))
FROM
	Pur_Purchase PP
	JOIN Pur_PurchaseItem PPI ON (PP.IDPurchase = PPI.IDPurchase)
WHERE
	PP.IDPurchase = @IDPurchase
	AND
	DateFinalReceiving IS NOT NULL

IF ((@TaxInCost=1) AND (@HasRet>0))
	EXEC sp_Purchase_CriaPagamentoComImpostoRet @IDPurchase

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -219
	GOTO ERRO
END

------------------------------------------------------------------------------
-- Incluio novamente o Term do Fin >>> Os termos so serao incluidos se o Purchase Type for do typo Invoice

INSERT
	Fin_LancamentoTerm (IDLancamento, DueDateShift, Discount)
SELECT
	L.IDLancamento, PT.DueDateShift, PT.Discount
FROM
	Pur_PurchaseTerm PT
	JOIN Fin_Lancamento L ON (L.IDPurchase = PT.IDPurchase)
WHERE
	L.IDPurchase = @IDPurchase

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -216
	GOTO ERRO
END


OK:
	COMMIT TRAN
	RETURN 0

ERRO:
	ROLLBACK TRAN

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_Purchase_Do', @ErrorLevelStr

	RETURN @ErrorLevel
GO

CREATE PROCEDURE sp_Purchase_Remove
		(
 		@IDPurchase	 	 int
		)
AS 

/* ----------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Atualizo o QtyOnPreReceive no Inventory
		- Deleto os InventoryMov
		- Deleto os PreInventoryMov
		- Deleto os PurchaseItemSerial
		- Deleto os PurchaseItem
		- Deleto os PurchaseDueDate
		- Deleto o Term do Financeiro
		- Deleto o Term da Purchase
 		- Deleto o Contas a Pagar, caso exista
		- Deleto a total de purhcase (o bacalhau do BugBDE)
		- Deleto o Purchase
		- Deletar a TBL Pur_PurchaseQtyPreSale
		- Deletar a TBL Pur_PurchaseItemTax
		- Deletar Pur_PurchaseItemTaxRet
		- Atualizar o fechamento do PO
		- Atualizar os valores do PO

	TABELA DE ERROS PARA RETURN_VALUE

		 000  Ok
		-201  Erro em Deleto qtyOnPrePurchase do Inventory
		-202  Erro em Deleto qtyOnOrder do Inventory
		-203  Erro em Deleto os PreInventoryMov
		-204  Erro em Deleto os InventoryMov
		-205  Erro em Deleto os PurchaseItemSerial
		-206  Erro em Deleto o PurchaseDueDate
		-207  Erro em Deleto o Term do Fin
		-208  Erro em Deleto o Term do Purchase
		-209  Erro em Deleto as contas a pagar
		-210  Erro em Deleto os PurchaseTotal
		-211  Erro em Deleto os Purchase
		-212  Erro em Deletar Pur_PurchaseItemTax
		-213  Erro em Deletar Pur_PurchaseItemTaxRet
		-214  Erro em Atualizar o fechamento do PO
		-215  Erro em Atualizar os valores do PO
		-216  Erro em Atualizar o Custo Medio

	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	-----------------------	-----------------------	--------------------------------------------------------------------------------
	04 Dec	2000		Eduardo Costa		Criação;
	18 Dec	2001		Rodrigo Costa		Atualizacao;
	08 Jun	2001		Rodrigo Costa		Deletar o Term do Fin_Lancamento & Purchase;
	26 Jun	2001		Davi Gouveia		Log de Return Values;
	18 Aug	2004		Rodrigo Costa		Gravar error log;
	14 Dez	2004		Rodrigo Costa		Deletar os Pur_PurchaseItemTax;
	11 Mar	2005		Carlos Lima		Deletar os Pur_PurchaseItemTaxRet;
	11 Mar	2005		Rodrigo Costa		Alteracao do PO;
	01 Dec	2005		Carlos Lima		Atualizar Totais e Condição de fechamento do PO;
	09 Dec	2005		Rodrigo Costa		Atualizar o Custo Medio;
	11 Jan	2006		Rodrigo Costa		Remover o Custo Medio;
	23 Feb	2006		Maximiliano Muniz	Deletar os PurchaseDueDate;
	06 Jun  2006		Carlos Lima		Deleção do InvMov em um cursor, para atualizar o AvgCost
	----------------------------------------------------------------------------------------------------------------- */

DECLARE @ErrorLevel	int
DECLARE @SysError	int
DECLARE @IDPO		int
DECLARE @IDInventoryMov	int

SET @ErrorLevel = 0

BEGIN TRAN

---------------------------------------------------------------------------- ##Carlos
-- Obtenho o ID do PO

SELECT
	@IDPO = IDPO
FROM
	Pur_Purchase
WHERE
	IDPurchase = @IDPurchase

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -208
	GOTO ERRO
END

---------------------------------------------------------------------------- ##Rodrigo
-- Deleto qtyOnPrePurchase do Inventory
DELETE
	PUQ
FROM
	Pur_PurchaseQtyPrePurchase PUQ
WHERE
	PUQ.IDPurchase =  @IDPurchase

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO ERRO
END


---------------------------------------------------------------------------- ##Rodrigo
-- Deleto qtyOnOrder do Inventory
DELETE
	PUQ
FROM
	Pur_PurchaseQtyOrder PUQ
WHERE
	PUQ.IDPurchase =  @IDPurchase

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -202
	GOTO ERRO
END

------------------------------------------------------------------------------
-- Deleto os PreInventoryMov

DELETE
	PIM
FROM
	PreInventoryMov PIM
WHERE
	PIM.DocumentID = @IDPurchase
	AND
	PIM.InventMovTypeID = 2

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -203
	GOTO ERRO
END

------------------------------------------------------------------------------
-- Deleto os InventoryMov

DECLARE InventoryMov_Cursor CURSOR FOR

SELECT
	IM.IDInventoryMov
FROM
	InventoryMov IM
WHERE
	IM.DocumentID = @IDPurchase
	AND
	IM.InventMovTypeID = 2


OPEN InventoryMov_Cursor


FETCH NEXT FROM InventoryMov_Cursor INTO
	@IDInventoryMov

WHILE @@FETCH_STATUS = 0
BEGIN
	EXEC sp_Inventory_Del_Moviment @IDInventoryMov
	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		CLOSE InventoryMov_Cursor
		DEALLOCATE InventoryMov_Cursor
		SET @ErrorLevel = -204
		GOTO ERRO
	END

	FETCH NEXT FROM InventoryMov_Cursor INTO
		@IDInventoryMov
END

CLOSE InventoryMov_Cursor
DEALLOCATE InventoryMov_Cursor

/*
DELETE
	IM
FROM
	InventoryMov IM
WHERE
	IM.DocumentID = @IDPurchase
	AND
	IM.InventMovTypeID = 2

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -204
	GOTO ERRO
END

*/

------------------------------------------------------------------------------
-- Deleto os PurchaseItemSerial

DELETE
	PIS
FROM
	Pur_PurchaseItemSerial PIS
WHERE
	PIS.IDPurchase = @IDPurchase

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -205
	GOTO ERRO
END

------------------------------------------------------------------------------
-- Deleto os PurchaseItemTax

DELETE
	PIT
FROM
	Pur_PurchaseItemtax PIT
WHERE
	PIT.IDPurchase = @IDPurchase

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -212
	GOTO ERRO
END

------------------------------------------------------------------------------
-- Deleto os PurchaseItemTaxRet

DELETE
	PIT
FROM
	Pur_PurchaseItemtaxRet PIT
WHERE
	PIT.IDPurchase = @IDPurchase

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -213
	GOTO ERRO
END

------------------------------------------------------------------------------
-- Deleto os PurchaseItem

DELETE
	PPI
FROM
	Pur_PurchaseItem PPI
WHERE
	PPI.IDPurchase = @IDPurchase

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -206
	GOTO ERRO
END

------------------------------------------------------------------------------
-- Deleto os PurchaseDueDate

DELETE
	PDD
FROM
	Pur_PurchaseDueDate PDD
WHERE
	PDD.IDPurchase = @IDPurchase

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -207
	GOTO ERRO
END

------------------------------------------------------------------------------
-- Deleto o Term do Fin 

DELETE
	Fin_LancamentoTerm
WHERE	IDLancamento IN (SELECT L.IDLancamento FROM Fin_Lancamento L WHERE L.IDPurchase = @IDPurchase)

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -207
	GOTO ERRO
END


------------------------------------------------------------------------------
-- Deleto o Term do Purchase 

DELETE
	Pur_PurchaseTerm
WHERE
	IDPurchase = @IDPurchase

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -208
	GOTO ERRO
END


------------------------------------------------------------------------------
-- Deleto as contas a pagar

DELETE
	L
FROM
	Fin_Lancamento L
WHERE
	L.IDPurchase = @IDPurchase

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -209
	GOTO ERRO
END


------------------------------------------------------------------------------
-- Deleto os PurchaseTotal

DELETE
	PT
FROM
	Pur_PurchaseTotal PT
WHERE
	PT.IDPurchase = @IDPurchase

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -210
	GOTO ERRO
END


------------------------------------------------------------------------------
-- Deleto os Purchase

DELETE
	P
FROM
	Pur_Purchase P
WHERE
	P.IDPurchase = @IDPurchase

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -211
	GOTO ERRO
END

IF @IDPO IS NOT NULL
BEGIN
------------------------------------------------------------------------------
-- Call sp_PO_CalcTotalQty
	
	EXEC sp_PO_CalcTotalQty @IDPO
	
	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		SET @ErrorLevel = -214
		GOTO ERRO
	END

------------------------------------------------------------------------------
-- Call sp_PO_AtuPOTotal

	EXEC sp_PO_AtuPOTotal @IDPO
	
	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		SET @ErrorLevel = -215
		GOTO ERRO
	END

END

OK:
	COMMIT TRAN
	RETURN 0
ERRO:
	ROLLBACK TRAN
	PRINT CAST(@ErrorLevel AS VARCHAR)

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_Purchase_Remove', @ErrorLevelStr

	RETURN @ErrorLevel
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
	05 Jun	2006		Carlos Lima		Adicionado Custo médio na inserção de InventoryMov
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
DECLARE @AvgCost		money

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
		R.Defect,
		Inv.StoreAvgPrice
	FROM
		Repair R
		INNER JOIN Inventory Inv ON ( R.IDStore = Inv.StoreID AND R.IDModel =  Inv.ModelID )
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
	@Notes,
	@AvgCost
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
		CostPrice,
		AvgCost
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
		@CostPrice,
		@AvgCost
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
		@Notes,
		@AvgCost
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
		R.OBSReturn,
		Inv.StoreAvgPrice
	FROM
		Repair R
		INNER JOIN Inventory Inv ON ( R.IDStore = Inv.StoreID AND R.IDModel =  Inv.ModelID )
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
	@Notes,
	@AvgCost
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
		CostPrice,
		AvgCost
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
		@CostPrice,
		@AvgCost
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
		@Notes,
		@AvgCost
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
