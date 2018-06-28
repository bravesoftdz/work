USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Rep_Join]    Script Date: 04/16/2014 10:08:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Rep_Join](
	[TableName1] [varchar](60) NOT NULL,
	[TableName2] [varchar](60) NOT NULL,
	[JoinType] [varchar](20) NULL,
	[FieldNames1] [varchar](60) NULL,
	[FieldNames2] [varchar](60) NULL,
	[Operators] [varchar](60) NULL,
	[ReplLastChange] [datetime] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
