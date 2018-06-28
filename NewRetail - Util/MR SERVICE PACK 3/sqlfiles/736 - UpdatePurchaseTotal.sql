IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[sp_Tmp_UpdatePurchaseTotal]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[sp_Tmp_UpdatePurchaseTotal]
GO

CREATE  PROCEDURE sp_Tmp_UpdatePurchaseTotal
AS

DECLARE @IDPurchase int
DECLARE @TaxInCost bit

SELECT @TaxInCost = CASE WHEN SrvValue = 'TRUE' THEN 1 ELSE 0 END FROM Param WHERE IDParam = 66

DECLARE Purchase_Cursor CURSOR FOR

SELECT
	IDPurchase
FROM
	Pur_Purchase

OPEN Purchase_Cursor

--Inicialização de InventoryMov_Cursor
FETCH NEXT FROM Purchase_Cursor INTO
	@IDPurchase

WHILE @@FETCH_STATUS = 0
BEGIN
	EXEC sp_Purchase_AtuPurchaseSubTotal @IDPurchase, @TaxInCost

	FETCH NEXT FROM Purchase_Cursor INTO
		@IDPurchase
END

CLOSE Purchase_Cursor
DEALLOCATE Purchase_Cursor
GO

EXEC sp_Tmp_UpdatePurchaseTotal
GO

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[sp_Tmp_UpdatePurchaseTotal]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[sp_Tmp_UpdatePurchaseTotal]
GO
