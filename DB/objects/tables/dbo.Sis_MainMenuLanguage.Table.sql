USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Sis_MainMenuLanguage]    Script Date: 04/16/2014 10:08:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Sis_MainMenuLanguage](
	[IDMenuItem] [int] NOT NULL,
	[IDLanguage] [int] NOT NULL,
	[MenuItem] [varchar](55) NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [XPKSis_MainMenuLanguage] PRIMARY KEY CLUSTERED 
(
	[IDMenuItem] ASC,
	[IDLanguage] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Sis_MainMenuLanguage]  WITH NOCHECK ADD  CONSTRAINT [FK_Sis_Language_Sis_MainMenuLanguage_IDLanguage] FOREIGN KEY([IDLanguage])
REFERENCES [dbo].[Sis_Language] ([IDLanguage])
GO
ALTER TABLE [dbo].[Sis_MainMenuLanguage] CHECK CONSTRAINT [FK_Sis_Language_Sis_MainMenuLanguage_IDLanguage]
GO
ALTER TABLE [dbo].[Sis_MainMenuLanguage]  WITH NOCHECK ADD  CONSTRAINT [FK_Sis_MainMenu_Sis_MainMenuLanguage_IDMenuItem] FOREIGN KEY([IDMenuItem])
REFERENCES [dbo].[Sis_MainMenu] ([IDMenuItem])
GO
ALTER TABLE [dbo].[Sis_MainMenuLanguage] CHECK CONSTRAINT [FK_Sis_MainMenu_Sis_MainMenuLanguage_IDMenuItem]
GO
