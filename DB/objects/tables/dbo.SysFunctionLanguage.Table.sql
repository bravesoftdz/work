USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[SysFunctionLanguage]    Script Date: 04/16/2014 10:08:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SysFunctionLanguage](
	[IDSysFunction] [int] NOT NULL,
	[IDLanguage] [int] NOT NULL,
	[SysFunction] [varchar](100) NOT NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [XPKSysFunctionLanguage] PRIMARY KEY CLUSTERED 
(
	[IDSysFunction] ASC,
	[IDLanguage] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[SysFunctionLanguage]  WITH NOCHECK ADD  CONSTRAINT [FK_Sis_Language_SysFunctionLanguage_IDLanguage] FOREIGN KEY([IDLanguage])
REFERENCES [dbo].[Sis_Language] ([IDLanguage])
GO
ALTER TABLE [dbo].[SysFunctionLanguage] CHECK CONSTRAINT [FK_Sis_Language_SysFunctionLanguage_IDLanguage]
GO
ALTER TABLE [dbo].[SysFunctionLanguage]  WITH NOCHECK ADD  CONSTRAINT [FK_SysFunction_SysFunctionLanguage_IDSysFunction] FOREIGN KEY([IDSysFunction])
REFERENCES [dbo].[SysFunction] ([IDSysFunction])
GO
ALTER TABLE [dbo].[SysFunctionLanguage] CHECK CONSTRAINT [FK_SysFunction_SysFunctionLanguage_IDSysFunction]
GO
