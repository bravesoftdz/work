if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tr_ModelTransfDet_All]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[tr_ModelTransfDet_All]
GO

ALTER TABLE ModelTransfDet ADD CostPrice Money NULL
GO

ALTER TABLE ModelTransfDet ADD Tax Money NULL
GO

ALTER TABLE ModelTransf ADD Number Varchar(20) NULL
GO

ALTER TABLE ModelTransf ADD TransferType Bit NULL
GO

ALTER TABLE ModelTransf ADD Imported Bit NULL
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

CREATE PROCEDURE sp_Inventory_Tranfer_IN
	(
	@IDModelTransf	int
	)
 AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Testa qual das sub's devo rodar
		- Atualizo o model


	TABELA DE ERROS PARA RETURN_VALUE

	 000  Ok
	-201  Erro em deletar Model
	-202  Erro em Inserir Model

	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------------------------------------------------------------------------------------------------------------
	16 Jul 2005		Rodrigo Costa		Criação;
        ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

DECLARE @ErrorLevel		int
DECLARE @SysError		int

--Declaração de variáveis para o Cursor de InventoryMov
DECLARE @DocumentID 	int 
DECLARE @ModelID 		int 
DECLARE @Qty 		int 
DECLARE @CostPrice		money
DECLARE @IDUser 		int 
DECLARE @PreInventoryMovID 	int 
DECLARE @IDInventoryMov    	int
DECLARE @StoreIDOrigem 	int 
DECLARE @StoreIDDestino 	int 


BEGIN TRAN


/*--------------------------------------------------------------*/
/*		Parte da Delecao do InventoryMov        	*/
/*--------------------------------------------------------------*/
DELETE
	InventoryMov
FROM
	ModelTransfDet MTD
WHERE	
	InventoryMov.InventMovTypeID = 8
	AND
	InventoryMov.DocumentID = @IDModelTransf

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
	GOTO   ERRO
END

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
		MTD.CostPrice
	FROM
		ModelTransfDet MTD,
		ModelTransf MT
	WHERE
		MTD.IDModelTransf = MT.IDModelTransf
		AND
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
	@CostPrice
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
		CostPrice
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
		@CostPrice
		)

	FETCH NEXT FROM TransferIN_Cursor INTO
		@DocumentID,
		@StoreIDOrigem,
		@StoreIDDestino,
		@ModelID,
		@Qty,
		@IDUser,
		@PreInventoryMovID,
		@CostPrice
END
--fechamento do cursor
CLOSE TransferIN_Cursor
--Destruição do cursor
DEALLOCATE TransferIN_Cursor

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
DECLARE @ModelID 		int 
DECLARE @Qty 			int 
DECLARE @CostPrice		money
DECLARE @Tax			money 
DECLARE @IDModelTransfDet    	int

BEGIN TRAN

/*--------------------------------------------------------------*/
/*		Parte da Insercao do InventoryMov        	*/
/*--------------------------------------------------------------*/

--Declaração do Cursor de InventoryMov
DECLARE TransferItem_Cursor CURSOR FOR
	SELECT
		MTD.IDModel,
		MTD.Qty,
		MTD.CostPrice,
		MTD.Tax
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
	@CostPrice
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
		Tax
		)
	VALUES
		(
		@IDModelTransfDet,
		@IDTransfIN,
		@ModelID,
		@Qty,
		@CostPrice,
		@Tax
		)

	FETCH NEXT FROM TransferItem_Cursor INTO
		@ModelID,
		@Qty,
		@Tax,
		@CostPrice
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

		- Testa qual das sub's devo rodar
		- Atualizo o model


	TABELA DE ERROS PARA RETURN_VALUE

	 000  Ok
	-201  Erro em deletar Model
	-202  Erro em Inserir Model

	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------------------------------------------------------------------------------------------------------------
	16 Jul 2005		Rodrigo Costa		Criação;
        ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

DECLARE @ErrorLevel		int
DECLARE @SysError		int

--Declaração de variáveis para o Cursor de InventoryMov
DECLARE @DocumentID 	int 
DECLARE @ModelID 		int 
DECLARE @Qty 		int 
DECLARE @CostPrice 		money
DECLARE @IDUser 		int 
DECLARE @PreInventoryMovID 	int 
DECLARE @IDInventoryMov    	int
DECLARE @StoreIDOrigem 	int 
DECLARE @StoreIDDestino 	int 


BEGIN TRAN


/*--------------------------------------------------------------*/
/*		Parte da Delecao do InventoryMov        	*/
/*--------------------------------------------------------------*/
DELETE
	InventoryMov
FROM
	ModelTransfDet MTD
WHERE	
	InventoryMov.InventMovTypeID = 7
	AND
	InventoryMov.DocumentID = @IDModelTransf

SET @SysError = @@ERROR
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -201
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
		MTD.CostPrice
	FROM
		ModelTransfDet MTD,
		ModelTransf MT
	WHERE
		MTD.IDModelTransf = MT.IDModelTransf
		AND
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
	@CostPrice
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
		CostPrice
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
		@CostPrice
		)

	FETCH NEXT FROM TransferOUT_Cursor INTO
		@DocumentID,
		@StoreIDOrigem,
		@StoreIDDestino,
		@ModelID,
		@Qty,
		@IDUser,
		@PreInventoryMovID,
		@CostPrice
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
