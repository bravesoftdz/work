USE [a0000748__2014-03-09]
GO
/****** Object:  UserDefinedFunction [dbo].[SalesPersonInvMov]    Script Date: 03/13/2014 12:04:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  FUNCTION [dbo].[SalesPersonInvMov](
	@IDInventoryMov	int
	) RETURNS 
varchar(50) AS
BEGIN

DECLARE @Name  varchar(50)
DECLARE @Names varchar(50)

SELECT @Names = ''
	
DECLARE SalesPerson CURSOR FOR

		SELECT
			SalesPerson
		FROM
			SaleItemCommission SIC
			JOIN vwSalesPerson SP ON ( SIC.IDCommission = SP.IDSalesPerson )
		WHERE
			SIC.IDInventoryMov =  @IDInventoryMov
			
	OPEN SalesPerson

	FETCH NEXT FROM SalesPerson INTO @Name

	WHILE @@FETCH_STATUS = 0
	BEGIN
		SELECT @Names = @Names + @Name
		FETCH NEXT FROM  SalesPerson INTO @Name
		IF (@@FETCH_STATUS = 0)
			SELECT @Names = @Names + '; '

	END

	CLOSE SalesPerson
	DEALLOCATE SalesPerson
	
	RETURN @Names
END
GO
