USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Sis_MainMenu]    Script Date: 04/16/2014 10:08:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Sis_MainMenu](
	[IDMenuItem] [int] NOT NULL,
	[IDMenuItemParent] [int] NULL,
	[FormID] [int] NULL,
	[MenuItem] [varchar](55) NOT NULL,
	[LoaderType] [int] NULL,
	[Parametro] [char](18) NULL,
	[MenuBarBefore] [dbo].[TBit] NULL,
	[Priority] [int] NULL,
	[ImageIndex] [int] NULL,
	[Obs] [varchar](255) NULL,
	[ClassName] [varchar](50) NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [PK__Sis_MainMenu__1A69E950] PRIMARY KEY CLUSTERED 
(
	[IDMenuItem] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Sis_MainMenu]  WITH NOCHECK ADD  CONSTRAINT [FK_SisMainMenu_SisMainMenu_IDMenuItemParent] FOREIGN KEY([IDMenuItemParent])
REFERENCES [dbo].[Sis_MainMenu] ([IDMenuItem])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[Sis_MainMenu] CHECK CONSTRAINT [FK_SisMainMenu_SisMainMenu_IDMenuItemParent]
GO
ALTER TABLE [dbo].[Sis_MainMenu] ADD  CONSTRAINT [DF_Zero185]  DEFAULT (0) FOR [Priority]
GO
