if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Inventory_Tranfer_OUT]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Inventory_Tranfer_OUT]
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
DECLARE @DocumentID		int
DECLARE @ModelID		int
DECLARE @Qty			float
DECLARE @TrasfDate		datetime
DECLARE @CostPrice		money
DECLARE @IDUser			int
DECLARE @PreInventoryMovID	int
DECLARE @IDInventoryMov		int
DECLARE @StoreIDOrigem		int
DECLARE @StoreIDDestino		int
DECLARE @AvgCost		money

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
		MT.Data,
		MT.IDUser,
		MTD.IDModelTransfDet, /* guarda a linha correspondente a inserida */
		MTD.CostPrice,
		Case WHEN (Inv.QtyOnHand - MTD.Qty) = 0 THEN 0 ELSE  Inv.StoreAvgPrice END
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
	@TrasfDate,
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
		@TrasfDate,
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
		@TrasfDate,
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
