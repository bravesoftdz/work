USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Rep_Item]    Script Date: 04/16/2014 10:08:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Rep_Item](
	[ItemId] [int] NOT NULL,
	[FolderId] [int] NULL,
	[Name] [varchar](60) NULL,
	[Size] [int] NULL,
	[ItemType] [int] NULL,
	[Modified] [datetime] NULL,
	[Deleted] [datetime] NULL,
	[Template] [image] NULL,
	[Filters] [text] NULL,
	[System] [dbo].[Boolean] NULL,
	[Hint] [varchar](255) NULL,
	[Version] [int] NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [XPKRep_Item] PRIMARY KEY CLUSTERED 
(
	[ItemId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Rep_Item] ADD  CONSTRAINT [DF_Zero142]  DEFAULT (0) FOR [ItemType]
GO
