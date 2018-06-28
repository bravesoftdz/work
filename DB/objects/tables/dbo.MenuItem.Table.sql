USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[MenuItem]    Script Date: 04/16/2014 10:08:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MenuItem](
	[IDMenu] [int] NOT NULL,
	[IDSubMenu] [int] NOT NULL,
	[Name] [varchar](30) NOT NULL,
	[ParentMenu] [varchar](30) NOT NULL,
	[Tip] [varchar](255) NULL,
	[CmdLine] [varchar](255) NULL,
	[Visible] [bit] NULL,
	[Enabled] [bit] NULL,
	[Shortcut] [int] NULL,
	[ImageIndex] [int] NULL,
	[ReplLastChange] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[IDMenu] ASC,
	[IDSubMenu] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[MenuItem]  WITH NOCHECK ADD  CONSTRAINT [FK_MenuMain_MenuItem_IDMenu] FOREIGN KEY([IDMenu])
REFERENCES [dbo].[MenuMain] ([IDMenu])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[MenuItem] CHECK CONSTRAINT [FK_MenuMain_MenuItem_IDMenu]
GO
ALTER TABLE [dbo].[MenuItem] ADD  CONSTRAINT [DF_MenuItem_Enabled6]  DEFAULT (1) FOR [Visible]
GO
ALTER TABLE [dbo].[MenuItem] ADD  CONSTRAINT [DF_MenuItem_Enabled7]  DEFAULT (1) FOR [Enabled]
GO
