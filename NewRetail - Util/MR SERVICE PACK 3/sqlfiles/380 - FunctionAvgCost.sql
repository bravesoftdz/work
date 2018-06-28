if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Inv_AdjustAvgCost]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Inv_AdjustAvgCost]
GO

CREATE PROCEDURE sp_Inv_AdjustAvgCost
	(
	@ModelID	int
	)
AS

DECLARE @IDModel 	int
DECLARE @Qty		float
DECLARE @CostPrice	money

DECLARE @LastQty	float
DECLARE @LastCost	money
DECLARE @AvgCost	money
DECLARE @MovDate	DateTime
DECLARE @IDInvMov	int
DECLARE @InventMovTypeID	int

DECLARE @ErrorLevel	int
DECLARE @SysError	int

SET @ErrorLevel = 0

ALTER TABLE InventoryMov DISABLE TRIGGER ALL 

BEGIN TRAN

SET @LastQty = 0
SET @LastCost = 0

DECLARE AVG_Cursor CURSOR FOR

	SELECT
		Inv.IDInventoryMov,
		Inv.InventMovTypeID,
		Inv.ModelID,
		((2*IMT.UpdateOnHand-1) * Inv.Qty) as Qty,
		Inv.CostPrice,
		Inv.MovDate
	FROM
		InventoryMov Inv 
		INNER JOIN InventoryMovType IMT ON (Inv.InventMovTypeID = IMT.IDInventMovType)
	WHERE
		Inv.ModelID = @ModelID
	ORDER BY
		Inv.MovDate

OPEN AVG_Cursor

--Inicialização de AVG_Cursor
FETCH NEXT FROM AVG_Cursor INTO
	@IDInvMov,
	@InventMovTypeID,
	@IDModel,
	@Qty,
	@CostPrice,
	@MovDate
--Enquanto tem registros
WHILE
@@FETCH_STATUS = 0
BEGIN

	SET @AvgCost = CASE WHEN (@Qty + @LastQty) <= 0 THEN 0 ELSE (((@LastQty * @LastCost) + (@Qty * @CostPrice)) / (@Qty + @LastQty)) END

	SET @LastQty = @LastQty + @Qty
	IF ((@InventMovTypeID = 2) OR (@InventMovTypeID in(4,5) AND @CostPrice<>0)) -- Compra e importado
		SET @LastCost = @CostPrice

	/*
	SELECT 
		@IDInvMov as IDInvMov, 
		@MovDate as MovDate, 
		@Qty as Qty, 
		@LastQty as Balance, 
		@AvgCost as AvgCost, 
		@CostPrice as CostPrice*/

	UPDATE 
		InventoryMov
	SET 
		AvgCost = @AvgCost
	WHERE
		IDInventoryMov = @IDInvMov

	SET @SysError = @@ERROR
	IF @SysError <> 0
	BEGIN
		CLOSE AVG_Cursor
		DEALLOCATE AVG_Cursor
		SET @ErrorLevel = -201
		GOTO ERRO
	END


	FETCH NEXT FROM AVG_Cursor INTO
		@IDInvMov,
		@InventMovTypeID,
		@IDModel,
		@Qty,
		@CostPrice,
		@MovDate
	
END
--fechamento do cursor
CLOSE AVG_Cursor
--Destruição do cursor
DEALLOCATE AVG_Cursor

UPDATE 
	Model
SET
	AvgCost = @AvgCost
WHERE
	IDModel = @ModelID

SET @SysError = @@ERROR 
IF @SysError <> 0
BEGIN
	SET @ErrorLevel = -202
	GOTO ERRO
END


OK:
	COMMIT TRAN
	ALTER TABLE InventoryMov ENABLE TRIGGER ALL 
	RETURN 0
ERRO:
	ROLLBACK TRAN
	ALTER TABLE InventoryMov ENABLE TRIGGER ALL 

	DECLARE @ErrorLevelStr varchar(10)
	SET  @ErrorLevelStr =  CAST(@ErrorLevel AS VARCHAR)
	EXEC sp_Sis_AppHistory_Add 0, 0, @SysError, 'MainRetail', 'Error: sp_Inv_AdjustAvgCost', @ErrorLevelStr

	RETURN @ErrorLevel
GO


if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[LastAvgCost]') and xtype in (N'FN', N'IF', N'TF'))
drop function [dbo].[LastAvgCost]
GO

CREATE  FUNCTION dbo.LastAvgCost(
	@IDStore	int,
	@IDModel	int
	) RETURNS 
money AS
BEGIN

DECLARE @AvgCost money

SELECT @AvgCost = 0

SELECT TOP 1
	@AvgCost = H.AvgCost
FROM
	vw_Rep_InventoryHistory H
WHERE
	H.ModelID = @IDModel
	AND
	H.StoreID = (CASE @IDStore WHEN 0 THEN H.StoreID ELSE @IDStore END)
ORDER BY
	H.MovDate DESC

RETURN @AvgCost


END

GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_InventoryHistory]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_InventoryHistory]
GO

CREATE VIEW vw_Rep_InventoryHistory AS
SELECT
	IM.IDInventoryMov,
	IM.ModelID,
	IM.StoreID,
	IM.MovDate,
	IM.CostPrice,
	SUM( IsNull(IM.Qty * (2*IMT.UpdateOnHand-1), 0) ) as OnHand,
	SUM( IsNull(IM.Qty * (2*IMT.UpdateOnOrder-1), 0) ) as OnOrder,
	SUM( IsNull(IM.Qty * (2*IMT.UpdateOnRepair-1), 0) ) as OnRepair,
	SUM( IsNull(IM.Qty * (2*IMT.UpdateOnPrePurchase-1), 0) ) as OnPrePurchase,
	SUM( IsNull(IM.Qty * (2*IMT.UpdateOnPreSale-1), 0) ) as OnPreSale,
	IsNull((
		SELECT TOP 1
			AvgCost
		FROM
			InventoryMov
		WHERE
			MovDate <= MAX(IM.MovDate)
			AND
			StoreID = IM.StoreID
			AND
			ModelID = IM.ModelID
			AND
			IsNull(AvgCost, 0) <> 0
		ORDER BY MovDate DESC		
	), 0) AS AvgCost
FROM
	InventoryMov IM
	JOIN
	InventoryMovType IMT ON (IM.InventMovTypeID = IMT.IDInventMovType)
GROUP BY
	IM.IDInventoryMov,
	IM.MovDate,
	ModelID,
	StoreID,
	IM.CostPrice,
	AvgCost


GO
