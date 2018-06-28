USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Sis_Grupo]    Script Date: 04/16/2014 10:08:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Sis_Grupo](
	[IDGrupo] [int] NOT NULL,
	[Grupo] [dbo].[TDescricao] NOT NULL,
	[Hidden] [dbo].[TControlField] NOT NULL,
	[Desativado] [dbo].[TControlField] NOT NULL,
	[System] [dbo].[TControlField] NOT NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [PK__Sis_Grupo__0C1BC9F9] PRIMARY KEY CLUSTERED 
(
	[IDGrupo] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
