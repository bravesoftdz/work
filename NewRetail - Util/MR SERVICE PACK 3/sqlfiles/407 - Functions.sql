if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[LastAvgCost]') and xtype in (N'FN', N'IF', N'TF'))
drop function [dbo].[LastAvgCost]
GO

CREATE FUNCTION dbo.LastAvgCost(
	@IDStore	int,
	@IDModel	int,
	@MovDate	DateTime
	) RETURNS money AS
BEGIN

DECLARE @AvgCost money

SELECT @AvgCost = 0

SELECT TOP 1
	@AvgCost = IM.AvgCost
FROM
	InventoryMov IM
WHERE
	IM.MovDate <= @MovDate
	AND
	IM.StoreID = (CASE @IDStore WHEN 0 THEN IM.StoreID ELSE @IDStore END)
	AND
	IM.ModelID = @IDModel
	AND
	IsNull(IM.AvgCost, 0) <> 0
ORDER BY
	IM.MovDate DESC

RETURN @AvgCost

END

GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw_Rep_InventoryHistory]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw_Rep_InventoryHistory]
GO

CREATE  VIEW vw_Rep_InventoryHistory AS
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
	SUM( IsNull(IM.Qty * (2*IMT.UpdateOnPreSale-1), 0) ) as OnPreSale
FROM
	InventoryMov IM
	JOIN
	InventoryMovType IMT ON (IM.InventMovTypeID = IMT.IDInventMovType)
GROUP BY
	IM.IDInventoryMov,
	IM.MovDate,
	ModelID,
	StoreID,
	IM.CostPrice

GO

------------------------------------------------------
-- fn_Inv_GetBalanceQty and fn_Inv_LastAvgCost
------------------------------------------------------

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[fn_Inv_GetBalanceQty]') and xtype in (N'FN', N'IF', N'TF'))
drop function [dbo].[fn_Inv_GetBalanceQty]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[fn_Inv_LastAvgCost]') and xtype in (N'FN', N'IF', N'TF'))
drop function [dbo].[fn_Inv_LastAvgCost]
GO

CREATE FUNCTION fn_Inv_GetBalanceQty(
	@IDModel int,
	@Date DateTime
	) RETURNS float AS
BEGIN

DECLARE @Result float
DECLARE @RealDate DateTime
SET @RealDate = CONVERT(DateTime, '01/' + convert(varchar, DatePart(MM, @Date)) + '/' +	convert(varchar, DatePart(YY, @Date)), 103)

SELECT
	@Result = SUM(IsNull(IM.Qty * (2 * IMT.UpdateOnHand - 1), 0))
FROM
	InventoryMov IM (NOLOCK)
	JOIN InventoryMovType IMT (NOLOCK) ON (IM.InventMovTypeID = IMT.IDInventMovType)
WHERE
	IM.ModelID = @IDModel
	AND IM.MovDate < @RealDate

RETURN @Result
END

GO

CREATE FUNCTION fn_Inv_LastAvgCost(
	@IDStore	int,
	@IDModel	int,
	@MovDate	DateTime
	) RETURNS money AS
BEGIN

DECLARE @AvgCost money
SET @AvgCost = 0

SELECT
	@AvgCost = IM.AvgCost
FROM
	InventoryMov IM
	INNER JOIN (
		SELECT MAX(MovDate) MovDate
		FROM InventoryMov
		WHERE MovDate <= @MovDate AND ModelID = @IDModel 
	) A ON (IM.MovDate = A.MovDate)
WHERE
	IM.StoreID = (CASE @IDStore WHEN 0 THEN IM.StoreID ELSE @IDStore END)
	AND IM.ModelID = @IDModel
	AND IsNull(IM.AvgCost, 0) <> 0

RETURN @AvgCost
END

GO
