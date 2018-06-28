USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Mnt_PessoaHistory]    Script Date: 04/16/2014 10:08:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Mnt_PessoaHistory](
	[IDPessoaHistory] [int] NOT NULL,
	[IDUser] [int] NOT NULL,
	[MovDate] [datetime] NOT NULL,
	[IDPessoa] [int] NOT NULL,
	[IDPessoaHistoryType] [int] NOT NULL,
	[IDPessoaHistoryResult] [int] NOT NULL,
	[Obs] [varchar](255) NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [XPKMnt_PessoaHistory] PRIMARY KEY CLUSTERED 
(
	[IDPessoaHistory] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Mnt_PessoaHistory]  WITH CHECK ADD  CONSTRAINT [FK_MntPessoaHistoryResult_MntPessoaHistory_IDPessoaHistoryResult] FOREIGN KEY([IDPessoaHistoryResult])
REFERENCES [dbo].[Mnt_PessoaHistoryResult] ([IDPessoaHistoryResult])
GO
ALTER TABLE [dbo].[Mnt_PessoaHistory] CHECK CONSTRAINT [FK_MntPessoaHistoryResult_MntPessoaHistory_IDPessoaHistoryResult]
GO
ALTER TABLE [dbo].[Mnt_PessoaHistory]  WITH CHECK ADD  CONSTRAINT [FK_MntPessoaHistoryType_MntPessoaHistory_IDPessoaHistoryType] FOREIGN KEY([IDPessoaHistoryType])
REFERENCES [dbo].[Mnt_PessoaHistoryType] ([IDPessoaHistoryType])
GO
ALTER TABLE [dbo].[Mnt_PessoaHistory] CHECK CONSTRAINT [FK_MntPessoaHistoryType_MntPessoaHistory_IDPessoaHistoryType]
GO
ALTER TABLE [dbo].[Mnt_PessoaHistory]  WITH CHECK ADD  CONSTRAINT [FK_Pessoa_MntPessoaHistory_IDPessoa] FOREIGN KEY([IDPessoa])
REFERENCES [dbo].[Pessoa] ([IDPessoa])
GO
ALTER TABLE [dbo].[Mnt_PessoaHistory] CHECK CONSTRAINT [FK_Pessoa_MntPessoaHistory_IDPessoa]
GO
ALTER TABLE [dbo].[Mnt_PessoaHistory]  WITH CHECK ADD  CONSTRAINT [FK_SystemUser_MntPessoaHistory_IDUser] FOREIGN KEY([IDUser])
REFERENCES [dbo].[SystemUser] ([IDUser])
GO
ALTER TABLE [dbo].[Mnt_PessoaHistory] CHECK CONSTRAINT [FK_SystemUser_MntPessoaHistory_IDUser]
GO
