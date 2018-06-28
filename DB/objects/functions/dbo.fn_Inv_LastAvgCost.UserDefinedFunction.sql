USE [a0000748__2014-03-09]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_Inv_LastAvgCost]    Script Date: 03/13/2014 12:04:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fn_Inv_LastAvgCost](
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
