USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Sis_MainMenuPagina]    Script Date: 04/16/2014 10:08:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Sis_MainMenuPagina](
	[IDMenuItem] [int] NOT NULL,
	[PaginaNome] [dbo].[TDescricao] NOT NULL,
	[PaginaTitulo] [dbo].[TDescricao] NOT NULL,
	[ReplLastChange] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[IDMenuItem] ASC,
	[PaginaNome] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Sis_MainMenuPagina]  WITH NOCHECK ADD  CONSTRAINT [FK_SisMainMenu_SisMainMenuPagina_IDMenuItem] FOREIGN KEY([IDMenuItem])
REFERENCES [dbo].[Sis_MainMenu] ([IDMenuItem])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[Sis_MainMenuPagina] CHECK CONSTRAINT [FK_SisMainMenu_SisMainMenuPagina_IDMenuItem]
GO
