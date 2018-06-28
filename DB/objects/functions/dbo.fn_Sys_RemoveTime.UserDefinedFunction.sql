USE [a0000748__2014-03-09]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_Sys_RemoveTime]    Script Date: 03/13/2014 12:04:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fn_Sys_RemoveTime](
	@Data datetime
	)
RETURNS smalldatetime
AS
BEGIN
	RETURN convert(smalldatetime, convert(varchar, @Data, 103), 103)
END
GO
