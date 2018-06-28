if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[fn_Inv_LastAvgCostNonZero]') and xtype in (N'FN', N'IF', N'TF'))
drop function [dbo].[fn_Inv_LastAvgCostNonZero]
GO

CREATE FUNCTION fn_Inv_LastAvgCostNonZero(
	@IDModel	int,
	@MovDate	DateTime
	) RETURNS money AS
BEGIN

DECLARE @LastAvgCost money
DECLARE @DateInicio DateTime

SET @DateInicio = DATEADD(d, -DATEPART (d , @MovDate ) , @MovDate)

IF NOT EXISTS(select *
	   from inventorymov IM (nolock)
	  where IM.modelid = @IDModel
		AND IM.inventmovtypeid in (2, 5)
		AND CONVERT(smalldatetime, CONVERT(varchar, IM.MovDate, 103), 103) > @DateInicio
		AND CONVERT(smalldatetime, CONVERT(varchar, IM.MovDate, 103), 103) <= @MovDate
		AND CONVERT(smalldatetime, CONVERT(varchar, IM.MovDate, 103), 103) > (SELECT MAX(BalanceDate) LastBalanceDate
				 FROM Inv_ModelBalance
				WHERE IDModel = @IDModel
				      AND BalanceDate < @MovDate
				      AND Qty > 0) ) 


BEGIN

SELECT
	@LastAvgCost = MB.AvgCostOut
FROM
	Inv_ModelBalance MB
WHERE
	MB.IDModel = @IDModel
	AND MB.BalanceDate = (SELECT MAX(BalanceDate) LastBalanceDate
				 FROM Inv_ModelBalance
				WHERE IDModel = @IDModel
				      AND BalanceDate < @MovDate
				      AND Qty > 0)
END
ELSE
BEGIN

select @LastAvgCost = totalcostprice / qty
from (
select sum(im.qty) as qty,
	sum(im.qty * im.costprice) as totalcostprice
   from inventorymov im (nolock)
  where im.modelid = @IDModel
	and im.inventmovtypeid in (2, 5)
	and convert(smalldatetime, convert(varchar, im.movdate, 103), 103) <= @MovDate
	and convert(smalldatetime, convert(varchar, im.movdate, 103), 103) > (SELECT max(convert(smalldatetime, convert(varchar, im.movdate, 103), 103)) as movdate --proxima venda epois da ultima compra
										   FROM	InventoryMov IM
										  WHERE	IM.ModelID = @IDModel
											AND IM.InventMovTypeID = 1
											AND CONVERT(smalldatetime, CONVERT(varchar, IM.MovDate, 103), 103) < (select max(convert(smalldatetime, convert(varchar, im.movdate, 103), 103)) as movdate
																				   from inventorymov im (nolock) --Proxima compra
																				  where im.modelid = @IDModel
																					and convert(smalldatetime, convert(varchar, im.movdate, 103), 103) <= @MovDate
																				and im.inventmovtypeid in (2, 5) )
										) 										
) X
	

END

RETURN @LastAvgCost

END
GO
