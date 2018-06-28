USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Sis_GrupoEmpresa]    Script Date: 04/16/2014 10:08:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sis_GrupoEmpresa](
	[IDGrupo] [int] NOT NULL,
	[IDEmpresa] [int] NOT NULL,
	[Permissao] [dbo].[TBit] NULL,
	[ReplLastChange] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[IDGrupo] ASC,
	[IDEmpresa] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Sis_GrupoEmpresa]  WITH NOCHECK ADD  CONSTRAINT [FK_SisEmpresa_SisGrupoEmpresa_IDEmpresa] FOREIGN KEY([IDEmpresa])
REFERENCES [dbo].[Sis_Empresa] ([IDEmpresa])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[Sis_GrupoEmpresa] CHECK CONSTRAINT [FK_SisEmpresa_SisGrupoEmpresa_IDEmpresa]
GO
ALTER TABLE [dbo].[Sis_GrupoEmpresa]  WITH NOCHECK ADD  CONSTRAINT [FK_SisGrupo_SisGrupoEmpresa_IDGrupo] FOREIGN KEY([IDGrupo])
REFERENCES [dbo].[Sis_Grupo] ([IDGrupo])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[Sis_GrupoEmpresa] CHECK CONSTRAINT [FK_SisGrupo_SisGrupoEmpresa_IDGrupo]
GO
