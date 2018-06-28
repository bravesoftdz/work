SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_Util_DropDefault](@TableName varchar(50), @ColumnName varchar(50)) AS
DECLARE @PKName as varchar(50)
DECLARE @SQL VARCHAR(1000)

SET @PKName = (
	select	
		c_obj.name
	from	sysobjects	c_obj
	join 	syscomments	com on 	c_obj.id = com.id
	join 	sysobjects	t_obj on c_obj.parent_obj = t_obj.id  
	join    sysconstraints con on c_obj.id	= con.constid
	join 	syscolumns	col on t_obj.id = col.id
	and con.colid = col.colid
	where
		c_obj.uid	= user_id()
		and c_obj.xtype	= 'D'
		and t_obj.name = @TableName
		and col.name = @ColumnName
	)

IF @PKName IS null
BEGIN
	print 'There is no Default for ' + @TableName + ' Table.'
	RETURN 1
END
SET @SQL = 'ALTER TABLE ' + @TableName + ' DROP CONSTRAINT ' + @PKName
EXEC (@SQL)
GO
