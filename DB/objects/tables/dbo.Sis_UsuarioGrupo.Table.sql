USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Sis_UsuarioGrupo]    Script Date: 04/16/2014 10:08:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sis_UsuarioGrupo](
	[IDGrupo] [int] NOT NULL,
	[IDUsuario] [int] NOT NULL,
	[ReplLastChange] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[IDGrupo] ASC,
	[IDUsuario] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Sis_UsuarioGrupo]  WITH NOCHECK ADD  CONSTRAINT [FK__Sis_Usuar__IDGru__100C566E] FOREIGN KEY([IDGrupo])
REFERENCES [dbo].[Sis_Grupo] ([IDGrupo])
GO
ALTER TABLE [dbo].[Sis_UsuarioGrupo] CHECK CONSTRAINT [FK__Sis_Usuar__IDGru__100C566E]
GO
ALTER TABLE [dbo].[Sis_UsuarioGrupo]  WITH NOCHECK ADD  CONSTRAINT [FK_SystemUser_Sis_UsuarioGrupo_IDUsuario] FOREIGN KEY([IDUsuario])
REFERENCES [dbo].[SystemUser] ([IDUser])
GO
ALTER TABLE [dbo].[Sis_UsuarioGrupo] CHECK CONSTRAINT [FK_SystemUser_Sis_UsuarioGrupo_IDUsuario]
GO
