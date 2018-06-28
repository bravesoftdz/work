USE [a0000748__2014-03-09]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_Pur_TotalByModel]    Script Date: 03/13/2014 12:04:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fn_Pur_TotalByModel](
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
