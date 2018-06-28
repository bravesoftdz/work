USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Sis_GrupoMainMenuPagina]    Script Date: 04/16/2014 10:08:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Sis_GrupoMainMenuPagina](
	[IDMenuItem] [int] NOT NULL,
	[PaginaNome] [dbo].[TDescricao] NOT NULL,
	[IDGrupo] [int] NOT NULL,
	[PaginaVisivel] [dbo].[TBit] NULL,
	[PaginaSoLeitura] [dbo].[TBit] NULL,
	[ReplLastChange] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[IDMenuItem] ASC,
	[PaginaNome] ASC,
	[IDGrupo] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Sis_GrupoMainMenuPagina]  WITH NOCHECK ADD  CONSTRAINT [FK_SisGrupo_SisGrupoMainMenuPagina_IDGrupo] FOREIGN KEY([IDGrupo])
REFERENCES [dbo].[Sis_Grupo] ([IDGrupo])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[Sis_GrupoMainMenuPagina] CHECK CONSTRAINT [FK_SisGrupo_SisGrupoMainMenuPagina_IDGrupo]
GO
ALTER TABLE [dbo].[Sis_GrupoMainMenuPagina]  WITH NOCHECK ADD  CONSTRAINT [FK_SisMainMenuPagina_SisGrupoMainMenuPagina_IDMenuItemPaginaNome] FOREIGN KEY([IDMenuItem], [PaginaNome])
REFERENCES [dbo].[Sis_MainMenuPagina] ([IDMenuItem], [PaginaNome])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[Sis_GrupoMainMenuPagina] CHECK CONSTRAINT [FK_SisMainMenuPagina_SisGrupoMainMenuPagina_IDMenuItemPaginaNome]
GO
