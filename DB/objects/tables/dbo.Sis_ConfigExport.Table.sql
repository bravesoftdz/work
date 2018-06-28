USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Sis_ConfigExport]    Script Date: 04/16/2014 10:08:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Sis_ConfigExport](
	[IDConfigExport] [int] NOT NULL,
	[DelimiterSeparator] [char](1) NULL,
	[DecimalSeparator] [char](1) NULL,
	[HeaderConfig] [text] NULL,
	[FileFormat] [text] NOT NULL,
	[HeaderFile] [bit] NOT NULL,
	[IDPessoa] [int] NULL,
	[ExportType] [smallint] NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [XPKSis_ConfigExport] PRIMARY KEY CLUSTERED 
(
	[IDConfigExport] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Sis_ConfigExport]  WITH CHECK ADD  CONSTRAINT [FK_Pessoa_Sis_ConfigExport_IDPessoa] FOREIGN KEY([IDPessoa])
REFERENCES [dbo].[Pessoa] ([IDPessoa])
GO
ALTER TABLE [dbo].[Sis_ConfigExport] CHECK CONSTRAINT [FK_Pessoa_Sis_ConfigExport_IDPessoa]
GO
ALTER TABLE [dbo].[Sis_ConfigExport] ADD  CONSTRAINT [DEF_BitHeaderfile]  DEFAULT ((0)) FOR [HeaderFile]
GO
