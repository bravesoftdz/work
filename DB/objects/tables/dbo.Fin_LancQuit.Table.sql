USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Fin_LancQuit]    Script Date: 04/16/2014 10:08:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Fin_LancQuit](
	[IDQuitacao] [int] NOT NULL,
	[IDLancamento] [int] NOT NULL,
	[ValorQuitado] [dbo].[TValor] NOT NULL,
	[IDUsuarioQuitacao] [int] NOT NULL,
	[DataQuitacao] [smalldatetime] NULL,
	[ValorJuros] [dbo].[TValor] NOT NULL,
	[ReplLastChange] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[IDQuitacao] ASC,
	[IDLancamento] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Fin_LancQuit]  WITH NOCHECK ADD  CONSTRAINT [FK_Lancamento_LancQuit_IDLancamento] FOREIGN KEY([IDLancamento])
REFERENCES [dbo].[Fin_Lancamento] ([IDLancamento])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[Fin_LancQuit] CHECK CONSTRAINT [FK_Lancamento_LancQuit_IDLancamento]
GO
ALTER TABLE [dbo].[Fin_LancQuit]  WITH NOCHECK ADD  CONSTRAINT [FK_Quitacao_LancQuit_IDQuitacao] FOREIGN KEY([IDQuitacao])
REFERENCES [dbo].[Fin_Quitacao] ([IDQuitacao])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[Fin_LancQuit] CHECK CONSTRAINT [FK_Quitacao_LancQuit_IDQuitacao]
GO
ALTER TABLE [dbo].[Fin_LancQuit]  WITH NOCHECK ADD  CONSTRAINT [FK_SystemUser_Fin_LancQuit_IDUsuarioQuitacao] FOREIGN KEY([IDUsuarioQuitacao])
REFERENCES [dbo].[SystemUser] ([IDUser])
GO
ALTER TABLE [dbo].[Fin_LancQuit] CHECK CONSTRAINT [FK_SystemUser_Fin_LancQuit_IDUsuarioQuitacao]
GO
