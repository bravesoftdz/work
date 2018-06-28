USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Sis_Municipio]    Script Date: 04/16/2014 10:08:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Sis_Municipio](
	[IDMunicipio] [int] NOT NULL,
	[Codigo] [varchar](20) NULL,
	[Descricao] [varchar](100) NULL,
	[System] [bit] NULL,
	[Hidden] [bit] NULL,
	[Desativado] [bit] NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [XPKSis_Municipo] PRIMARY KEY CLUSTERED 
(
	[IDMunicipio] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Sis_Municipio] ADD  CONSTRAINT [DEF_SystemMun]  DEFAULT ((0)) FOR [System]
GO
ALTER TABLE [dbo].[Sis_Municipio] ADD  CONSTRAINT [DEF_HiddenMun]  DEFAULT ((0)) FOR [Hidden]
GO
ALTER TABLE [dbo].[Sis_Municipio] ADD  CONSTRAINT [DEF_DesMun]  DEFAULT ((0)) FOR [Desativado]
GO
