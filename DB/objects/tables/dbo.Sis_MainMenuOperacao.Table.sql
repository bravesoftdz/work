USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Sis_MainMenuOperacao]    Script Date: 04/16/2014 10:08:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Sis_MainMenuOperacao](
	[IDMenuItem] [int] NOT NULL,
	[IDOperacao] [int] NOT NULL,
	[Operacao] [dbo].[TDescricao] NOT NULL,
	[ReplLastChange] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[IDMenuItem] ASC,
	[IDOperacao] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Sis_MainMenuOperacao]  WITH NOCHECK ADD  CONSTRAINT [FK_SisMainMenu_SisMainMenuOperacao_IDMenuItem] FOREIGN KEY([IDMenuItem])
REFERENCES [dbo].[Sis_MainMenu] ([IDMenuItem])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[Sis_MainMenuOperacao] CHECK CONSTRAINT [FK_SisMainMenu_SisMainMenuOperacao_IDMenuItem]
GO
