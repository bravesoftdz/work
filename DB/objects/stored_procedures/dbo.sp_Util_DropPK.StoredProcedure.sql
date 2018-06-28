SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_Util_DropPK](@TableName sysname) AS
DECLARE @PKName as varchar(50)
DECLARE @SQL VARCHAR(1000)

SET @PKName = (
	SELECT 
		A.name
	FROM 
		sysindexes A
		INNER JOIN sysobjects B ON (A.ID = B.ID) 
WHERE
	B.name = @TableName
	AND 
	A.name like 'PK%')

IF @PKName IS null
BEGIN
	print 'There is no PK for ' + @TableName + ' Table.'
	RETURN 1
END

SET @SQL = 'ALTER TABLE ' + @TableName + ' DROP CONSTRAINT ' + @PKName

EXEC (@SQL)
GO
