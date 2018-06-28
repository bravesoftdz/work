if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[fn_Pur_TotalByCategory]') and xtype in (N'FN', N'IF', N'TF'))
drop function [dbo].[fn_Pur_TotalByCategory]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[fn_Pur_TotalByModel]') and xtype in (N'FN', N'IF', N'TF'))
drop function [dbo].[fn_Pur_TotalByModel]
GO

CREATE FUNCTION dbo.fn_Pur_TotalByCategory(
	@IDGroup int,
	@FirstMovDate DateTime,
	@LastMovDate DateTime
	) RETURNS float AS
BEGIN

DECLARE @Result float

SELECT
	@Result = SUM(ISNULL(IM.Qty, 0) * IsNull(IM.CostPrice, 0))
FROM
	vw_Rep_InventoryMov IM
	JOIN Model M ON (M.IDModel = IM.IDModel)
WHERE
	M.GroupID = @IDGroup
	AND IM.IDInventMovType = 2
	AND CONVERT(smalldatetime, CONVERT(varchar, IM.MovDate, 103), 103) >= @FirstMovDate
	AND CONVERT(smalldatetime, CONVERT(varchar, IM.MovDate, 103), 103) <= @LastMovDate  

RETURN IsNull(@Result,0)
END

GO

CREATE FUNCTION dbo.fn_Pur_TotalByModel(
	@IDModel	Int,
	@FirstMovDate	DateTime,
	@LastMovDate	DateTime
	) RETURNS money AS
BEGIN
DECLARE @Result money

SELECT
	@Result = SUM(ISNULL(IM.Qty, 0) * IsNull(IM.CostPrice, 0))
FROM
	vw_Rep_InventoryMov IM
WHERE
	IM.IDModel = @IDModel
	AND IM.IDInventMovType = 2
	AND CONVERT(smalldatetime, CONVERT(varchar, IM.MovDate, 103), 103) >= @FirstMovDate
	AND CONVERT(smalldatetime, CONVERT(varchar, IM.MovDate, 103), 103) <= @LastMovDate

RETURN @Result
END

GO
