IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[fn_Sys_RemoveTime]') AND xtype IN (N'FN', N'IF', N'TF'))
DROP FUNCTION [dbo].[fn_Sys_RemoveTime]
GO

CREATE FUNCTION fn_Sys_RemoveTime(
	@Data datetime
	)
RETURNS smalldatetime
AS
BEGIN
	RETURN convert(smalldatetime, convert(varchar, @Data, 103), 103)
END

GO
