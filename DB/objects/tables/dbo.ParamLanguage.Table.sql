USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[ParamLanguage]    Script Date: 04/16/2014 10:08:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ParamLanguage](
	[IDParam] [int] NOT NULL,
	[IDLanguage] [int] NOT NULL,
	[SrvParameter] [varchar](40) NOT NULL,
	[Description] [varchar](200) NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [XPKParamLanguage] PRIMARY KEY CLUSTERED 
(
	[IDParam] ASC,
	[IDLanguage] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[ParamLanguage]  WITH CHECK ADD  CONSTRAINT [FK_Param_ParamLanguage_IDParam] FOREIGN KEY([IDParam])
REFERENCES [dbo].[Param] ([IDParam])
GO
ALTER TABLE [dbo].[ParamLanguage] CHECK CONSTRAINT [FK_Param_ParamLanguage_IDParam]
GO
ALTER TABLE [dbo].[ParamLanguage]  WITH NOCHECK ADD  CONSTRAINT [FK_Sis_Language_Param_IDLanguage] FOREIGN KEY([IDLanguage])
REFERENCES [dbo].[Sis_Language] ([IDLanguage])
GO
ALTER TABLE [dbo].[ParamLanguage] CHECK CONSTRAINT [FK_Sis_Language_Param_IDLanguage]
GO
