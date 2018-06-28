if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SalesPersonPreInvMov]') and xtype in (N'FN', N'IF', N'TF'))
drop function [dbo].[SalesPersonPreInvMov]
GO

CREATE  FUNCTION dbo.SalesPersonPreInvMov(
	@IDPreInventoryMov	int
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
			SIC.IDPreInventoryMov =  @IDPreInventoryMov
			
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

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SalesPersonInvMov]') and xtype in (N'FN', N'IF', N'TF'))
drop function [dbo].[SalesPersonInvMov]
GO

CREATE  FUNCTION dbo.SalesPersonInvMov(
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
