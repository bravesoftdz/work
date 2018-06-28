USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Rep_FolderToTable]    Script Date: 04/16/2014 10:08:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Rep_FolderToTable](
	[FolderId] [int] NOT NULL,
	[TableName] [varchar](60) NOT NULL,
	[ReplLastChange] [datetime] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
