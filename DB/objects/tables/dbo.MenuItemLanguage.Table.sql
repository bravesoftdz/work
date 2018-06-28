USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[MenuItemLanguage]    Script Date: 04/16/2014 10:08:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MenuItemLanguage](
	[IDMenu] [int] NOT NULL,
	[IDSubMenu] [int] NOT NULL,
	[IDLanguage] [int] NOT NULL,
	[Name] [varchar](30) NOT NULL,
	[ParentMenu] [varchar](30) NOT NULL,
	[Tip] [varchar](255) NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [XPKMenuItemLanguage] PRIMARY KEY CLUSTERED 
(
	[IDMenu] ASC,
	[IDSubMenu] ASC,
	[IDLanguage] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[MenuItemLanguage]  WITH CHECK ADD  CONSTRAINT [FK_MenuItem_MenuItemLanguage_IDMenu_IDSubMenu] FOREIGN KEY([IDMenu], [IDSubMenu])
REFERENCES [dbo].[MenuItem] ([IDMenu], [IDSubMenu])
GO
ALTER TABLE [dbo].[MenuItemLanguage] CHECK CONSTRAINT [FK_MenuItem_MenuItemLanguage_IDMenu_IDSubMenu]
GO
ALTER TABLE [dbo].[MenuItemLanguage]  WITH NOCHECK ADD  CONSTRAINT [FK_Sis_Language_MenuItem_IDLanguage] FOREIGN KEY([IDLanguage])
REFERENCES [dbo].[Sis_Language] ([IDLanguage])
GO
ALTER TABLE [dbo].[MenuItemLanguage] CHECK CONSTRAINT [FK_Sis_Language_MenuItem_IDLanguage]
GO
