USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[MenuMainLanguage]    Script Date: 04/16/2014 10:08:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MenuMainLanguage](
	[IDMenu] [int] NOT NULL,
	[IDLanguage] [int] NOT NULL,
	[MenuName] [varchar](30) NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [XPKMenuMainLanguage] PRIMARY KEY CLUSTERED 
(
	[IDMenu] ASC,
	[IDLanguage] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[MenuMainLanguage]  WITH CHECK ADD  CONSTRAINT [FK_MenuMain_MenuMainLanguage_IDMenu] FOREIGN KEY([IDMenu])
REFERENCES [dbo].[MenuMain] ([IDMenu])
GO
ALTER TABLE [dbo].[MenuMainLanguage] CHECK CONSTRAINT [FK_MenuMain_MenuMainLanguage_IDMenu]
GO
ALTER TABLE [dbo].[MenuMainLanguage]  WITH NOCHECK ADD  CONSTRAINT [FK_Sis_Language_MenuMainLanguage_IDLanguage] FOREIGN KEY([IDLanguage])
REFERENCES [dbo].[Sis_Language] ([IDLanguage])
GO
ALTER TABLE [dbo].[MenuMainLanguage] CHECK CONSTRAINT [FK_Sis_Language_MenuMainLanguage_IDLanguage]
GO
