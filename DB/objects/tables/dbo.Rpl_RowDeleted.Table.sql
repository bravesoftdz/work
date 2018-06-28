USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Rpl_RowDeleted]    Script Date: 04/16/2014 10:08:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[Rpl_RowDeleted](
	[TableName] [varchar](40) NOT NULL,
	[Script] [varchar](255) NOT NULL,
	[ReplLastChange] [datetime] NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
