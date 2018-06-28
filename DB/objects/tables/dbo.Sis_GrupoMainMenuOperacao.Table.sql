USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Sis_GrupoMainMenuOperacao]    Script Date: 04/16/2014 10:08:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sis_GrupoMainMenuOperacao](
	[IDOperacao] [int] NOT NULL,
	[IDMenuItem] [int] NOT NULL,
	[IDGrupo] [int] NOT NULL,
	[Permissao] [dbo].[TBit] NULL,
	[ReplLastChange] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[IDOperacao] ASC,
	[IDMenuItem] ASC,
	[IDGrupo] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Sis_GrupoMainMenuOperacao]  WITH NOCHECK ADD  CONSTRAINT [FK_SisGrupo_SisGrupoMainMenuOperacao_IDGrupo] FOREIGN KEY([IDGrupo])
REFERENCES [dbo].[Sis_Grupo] ([IDGrupo])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[Sis_GrupoMainMenuOperacao] CHECK CONSTRAINT [FK_SisGrupo_SisGrupoMainMenuOperacao_IDGrupo]
GO
ALTER TABLE [dbo].[Sis_GrupoMainMenuOperacao]  WITH NOCHECK ADD  CONSTRAINT [FK_SisMainMenuOperacao_SisGrupoMainMenuOperacao_IDOperacaoIDMenuItem] FOREIGN KEY([IDMenuItem], [IDOperacao])
REFERENCES [dbo].[Sis_MainMenuOperacao] ([IDMenuItem], [IDOperacao])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[Sis_GrupoMainMenuOperacao] CHECK CONSTRAINT [FK_SisMainMenuOperacao_SisGrupoMainMenuOperacao_IDOperacaoIDMenuItem]
GO
