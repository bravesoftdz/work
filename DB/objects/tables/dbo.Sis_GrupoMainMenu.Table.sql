USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Sis_GrupoMainMenu]    Script Date: 04/16/2014 10:08:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sis_GrupoMainMenu](
	[IDGrupo] [int] NOT NULL,
	[IDMenuItem] [int] NOT NULL,
	[Acessa] [dbo].[TBit] NULL,
	[ReplLastChange] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[IDGrupo] ASC,
	[IDMenuItem] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Sis_GrupoMainMenu]  WITH NOCHECK ADD  CONSTRAINT [FK_SisGrupo_SisGrupoMainMenu_IDGrupo] FOREIGN KEY([IDGrupo])
REFERENCES [dbo].[Sis_Grupo] ([IDGrupo])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[Sis_GrupoMainMenu] CHECK CONSTRAINT [FK_SisGrupo_SisGrupoMainMenu_IDGrupo]
GO
ALTER TABLE [dbo].[Sis_GrupoMainMenu]  WITH NOCHECK ADD  CONSTRAINT [FK_SisMainMenu_SisGrupoMainMenu_IDMenuItem] FOREIGN KEY([IDMenuItem])
REFERENCES [dbo].[Sis_MainMenu] ([IDMenuItem])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[Sis_GrupoMainMenu] CHECK CONSTRAINT [FK_SisMainMenu_SisGrupoMainMenu_IDMenuItem]
GO
