USE [a0000748__2014-03-09]
GO
/****** Object:  UserDefinedFunction [dbo].[LastAvgCost]    Script Date: 03/13/2014 12:04:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[LastAvgCost](
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
