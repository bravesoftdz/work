if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tr_Pur_PurchaseQtyOrder_All]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[tr_Pur_PurchaseQtyOrder_All]
GO

CREATE TRIGGER tr_Pur_PurchaseQtyOrder_All ON dbo.Pur_PurchaseQtyOrder
FOR INSERT, UPDATE, DELETE
NOT FOR REPLICATION
AS

/* -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	SUMARIO

		- Teste da existencia de Model no Inventory
		- Atualizo PreInentoryMov  QtyRealMov


	LOG DE MODIFICAÇÕES

	Data			Programador		Modificação
	--------------------------------------- --------------------------------------- -----------------------------------------------------------------------------------------------------
	15 May  2000		Eduardo Costa		Criacao;
	30 Oct	2003		Rodrigo Costa		Criacao do Cursor Inventory_Cursor;
							Chamada para sp_GetNextCode;
	02 Dec 2005		Carlos Lima		Mover quantidade entregue a mais para QtyExceeded
	04 Jan 2006		Carlos Lima		Acerto no Update do QtyRealMov
    -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  */

IF @@rowcount = 0
	RETURN

SET NOCOUNT ON

--Declaração de variáveis para o Cursor de Inventory
DECLARE @StoreID		float 
DECLARE @ModelID		float 
DECLARE @IDInventory		float
DECLARE @IDPOItem		float
DECLARE @Qty		float
DECLARE @QtyMovTotal		float
DECLARE @QtyRealMov		float
DECLARE @QtyExceeded		float
DECLARE @QtyAtualizar		float

/*--------------------------------------------------------------*/
/*		Teste da existencia de Model no Inventory       */
/*--------------------------------------------------------------*/

--Declaração do Cursor de Inventory



DECLARE Inventory_Cursor CURSOR FOR

	SELECT
		Inserted.IDStore,
		Inserted.IDModel
	FROM
		Inserted
	WHERE
	 	NOT EXISTS
		(
		SELECT
			Inventory.StoreID
		FROM
			Inventory Inventory
		WHERE
			Inventory.StoreID = Inserted.IDStore
			AND
			Inventory.ModelID = Inserted.IDModel
		)

	GROUP BY
		Inserted.IDStore,
		Inserted.IDModel

OPEN Inventory_Cursor

--Inicialização de Inventory_Cursor
FETCH NEXT FROM Inventory_Cursor INTO
	@StoreID,
	@ModelID

--Enquanto tem registros
WHILE
@@FETCH_STATUS = 0
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

	FETCH NEXT FROM Inventory_Cursor INTO
		@StoreID,
		@ModelID
END

--fechamento do cursor
CLOSE Inventory_Cursor
--Destruição do cursor
DEALLOCATE Inventory_Cursor


/*----------------------------------------------------------*/
/*		DELETE                     */
/*----------------------------------------------------------*/

-- PreInentoryMov  QtyRealMov


--Declaração do Cursor de DelPrePurchaseCur
DECLARE DelPrePurchaseCur CURSOR DYNAMIC FOR
	SELECT
		IDPOItem, IsNull(Deleted.Qty, 0), IsNull(PIM.Qty, 0), IsNull(PIM.QtyRealMov, 0), IsNull(QtyExceeded, 0)
	FROM
		PreInventoryMov PIM,
		Deleted
	WHERE
		Deleted.IDPOItem = PIM.IDPreInventoryMov
		AND
		Deleted.IDPOItem IS NOT NULL
		
OPEN DelPrePurchaseCur

--Inicialização de  de DelPrePurchaseCur
FETCH NEXT FROM DelPrePurchaseCur INTO @IDPOItem, @QtyAtualizar, @Qty, @QtyRealMov, @QtyExceeded

--Enquanto tem registros
WHILE @@FETCH_STATUS = 0
BEGIN	
	IF (@Qty >= 0)
		BEGIN			 		
			
			SET @QtyExceeded = (@QtyRealMov + @QtyExceeded - @QtyAtualizar) - @Qty


			IF @QtyExceeded < 0
				SET @QtyExceeded = 0
	
			IF @QtyExceeded > 0
				SET @QtyRealMov = @Qty
			ELSE
				SET @QtyRealMov = @QtyRealMov - @QtyAtualizar
			
		END
	ELSE
		BEGIN
			SET @QtyExceeded = 0
			SET @QtyRealMov = @QtyRealMov - @QtyAtualizar
		END

	UPDATE 
		PreInventoryMov 
	SET 
		QtyRealMov = @QtyRealMov,
		QtyExceeded = @QtyExceeded
	WHERE 
		IDPreInventoryMov = @IDPOItem

	
	FETCH NEXT FROM DelPrePurchaseCur INTO @IDPOItem, @QtyAtualizar, @Qty, @QtyRealMov, @QtyExceeded
END

--Fechamento do cursor
CLOSE DelPrePurchaseCur
--Destruição do cursor
DEALLOCATE DelPrePurchaseCur

/*----------------------------------------------------------*/
/*		INSERT	        */
/*----------------------------------------------------------*/

-- PreInentoryMov  QtyRealMov

--Declaração do Cursor de InsPrePurchaseCur
DECLARE InsPrePurchaseCur CURSOR DYNAMIC FOR
	SELECT
		IDPOItem, IsNull(Inserted.Qty, 0), IsNull(PIM.Qty, 0), IsNull(PIM.QtyRealMov, 0), IsNull(QtyExceeded, 0)
	FROM
		PreInventoryMov PIM,
		Inserted
	WHERE
		Inserted.IDPOItem = PIM.IDPreInventoryMov
		AND
		Inserted.IDPOItem IS NOT NULL

		
OPEN InsPrePurchaseCur

--Inicialização de  de InsPrePurchaseCur
FETCH NEXT FROM InsPrePurchaseCur INTO @IDPOItem, @QtyAtualizar, @Qty, @QtyRealMov, @QtyExceeded

--Enquanto tem registros
WHILE @@FETCH_STATUS = 0
BEGIN
	IF (@Qty >= 0)
		BEGIN
			SET @QtyExceeded = (@QtyRealMov + @QtyExceeded + @QtyAtualizar) - @Qty
			IF @QtyExceeded < 0
				SET @QtyExceeded = 0
	
			IF @QtyExceeded > 0
				SET @QtyRealMov = @Qty
			ELSE
				SET @QtyRealMov = @QtyRealMov + @QtyAtualizar
			
		END
	ELSE
		BEGIN
			SET @QtyExceeded = 0
			SET @QtyRealMov = @QtyRealMov + @QtyAtualizar
		END


	UPDATE 
		PreInventoryMov 
	SET 
		QtyRealMov = @QtyRealMov,
		QtyExceeded = @QtyExceeded
	WHERE 
		IDPreInventoryMov = @IDPOItem		

	
	FETCH NEXT FROM InsPrePurchaseCur INTO @IDPOItem, @QtyAtualizar, @Qty, @QtyRealMov, @QtyExceeded
END

--Fechamento do cursor
CLOSE InsPrePurchaseCur
--Destruição do cursor
DEALLOCATE InsPrePurchaseCur
GO
