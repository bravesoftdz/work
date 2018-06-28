USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Sis_ConfigImport]    Script Date: 04/16/2014 10:08:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sis_ConfigImport](
	[IDConfigImport] [int] NOT NULL,
	[ImportType] [smallint] NOT NULL,
	[CrossColumn] [text] NULL,
	[CaseCost] [bit] NULL,
	[IDPessoa] [int] NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [XPKSis_ConfigImport] PRIMARY KEY CLUSTERED 
(
	[IDConfigImport] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[Sis_ConfigImport]  WITH CHECK ADD  CONSTRAINT [FK_Pessoa_Sis_ConfigImport_IDPessoa] FOREIGN KEY([IDPessoa])
REFERENCES [dbo].[Pessoa] ([IDPessoa])
GO
ALTER TABLE [dbo].[Sis_ConfigImport] CHECK CONSTRAINT [FK_Pessoa_Sis_ConfigImport_IDPessoa]
GO
ALTER TABLE [dbo].[Sis_ConfigImport] ADD  CONSTRAINT [DEF_BitCaseCost]  DEFAULT ((0)) FOR [CaseCost]
GO
