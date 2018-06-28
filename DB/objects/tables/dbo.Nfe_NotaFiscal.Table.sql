USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Nfe_NotaFiscal]    Script Date: 04/16/2014 10:08:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Nfe_NotaFiscal](
	[IDNotaFiscal] [int] NOT NULL,
	[Origem] [varchar](20) NOT NULL,
	[Referencia] [int] NOT NULL,
	[Situacao] [char](15) NOT NULL,
	[DataSolicitacao] [datetime] NOT NULL,
	[DataUltimoEnvio] [datetime] NULL,
	[DataResultado] [datetime] NULL,
	[DataUltimaImpressao] [datetime] NULL,
	[DetalhamentoErro] [varchar](8000) NULL,
	[QtdEnvios] [int] NULL,
	[QtdImpressao] [int] NULL,
	[IDUserSolicitacao] [int] NOT NULL,
	[IDUserUltimoEnvio] [int] NULL,
	[IDUserResultado] [int] NULL,
	[IDUserUltimaImpressao] [int] NULL,
	[IDUserCancelamento] [int] NULL,
	[XMLEnviado] [text] NULL,
	[XMLRecebido] [text] NULL,
	[Chave] [varchar](255) NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [XPKNfe_NotaFiscal] PRIMARY KEY CLUSTERED 
(
	[IDNotaFiscal] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Nfe_NotaFiscal]  WITH CHECK ADD  CONSTRAINT [FK_SystemUser_Nfe_NotaFiscal_IDUserCancelamento] FOREIGN KEY([IDUserCancelamento])
REFERENCES [dbo].[SystemUser] ([IDUser])
GO
ALTER TABLE [dbo].[Nfe_NotaFiscal] CHECK CONSTRAINT [FK_SystemUser_Nfe_NotaFiscal_IDUserCancelamento]
GO
ALTER TABLE [dbo].[Nfe_NotaFiscal]  WITH CHECK ADD  CONSTRAINT [FK_SystemUser_Nfe_NotaFiscal_IDUserResultado] FOREIGN KEY([IDUserResultado])
REFERENCES [dbo].[SystemUser] ([IDUser])
GO
ALTER TABLE [dbo].[Nfe_NotaFiscal] CHECK CONSTRAINT [FK_SystemUser_Nfe_NotaFiscal_IDUserResultado]
GO
ALTER TABLE [dbo].[Nfe_NotaFiscal]  WITH CHECK ADD  CONSTRAINT [FK_SystemUser_Nfe_NotaFiscal_IDUserSolicitacao] FOREIGN KEY([IDUserSolicitacao])
REFERENCES [dbo].[SystemUser] ([IDUser])
GO
ALTER TABLE [dbo].[Nfe_NotaFiscal] CHECK CONSTRAINT [FK_SystemUser_Nfe_NotaFiscal_IDUserSolicitacao]
GO
ALTER TABLE [dbo].[Nfe_NotaFiscal]  WITH CHECK ADD  CONSTRAINT [FK_SystemUser_Nfe_NotaFiscal_IDUserUltimaImpressao] FOREIGN KEY([IDUserUltimaImpressao])
REFERENCES [dbo].[SystemUser] ([IDUser])
GO
ALTER TABLE [dbo].[Nfe_NotaFiscal] CHECK CONSTRAINT [FK_SystemUser_Nfe_NotaFiscal_IDUserUltimaImpressao]
GO
ALTER TABLE [dbo].[Nfe_NotaFiscal]  WITH CHECK ADD  CONSTRAINT [FK_SystemUser_Nfe_NotaFiscal_IDUserUltimoEnvio] FOREIGN KEY([IDUserUltimoEnvio])
REFERENCES [dbo].[SystemUser] ([IDUser])
GO
ALTER TABLE [dbo].[Nfe_NotaFiscal] CHECK CONSTRAINT [FK_SystemUser_Nfe_NotaFiscal_IDUserUltimoEnvio]
GO
