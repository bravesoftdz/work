USE [a0000748__2014-03-09]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_Inv_GetBalanceQty]    Script Date: 03/13/2014 12:04:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fn_Inv_GetBalanceQty](
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
