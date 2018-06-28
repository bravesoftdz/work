USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Mnt_PessoaHistoryResult]    Script Date: 04/16/2014 10:08:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Mnt_PessoaHistoryResult](
	[IDPessoaHistoryResult] [int] NOT NULL,
	[PessoaHistoryResult] [varchar](30) NOT NULL,
	[IDPessoaHistoryType] [int] NOT NULL,
	[ResultColor] [varchar](20) NOT NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [XPKMnt_PessoaHistoryResult] PRIMARY KEY CLUSTERED 
(
	[IDPessoaHistoryResult] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Mnt_PessoaHistoryResult]  WITH CHECK ADD  CONSTRAINT [FK_MntPessoaHistoryResult_MntPessoaHistoryType_IDPessoaHistoryResult] FOREIGN KEY([IDPessoaHistoryType])
REFERENCES [dbo].[Mnt_PessoaHistoryType] ([IDPessoaHistoryType])
GO
ALTER TABLE [dbo].[Mnt_PessoaHistoryResult] CHECK CONSTRAINT [FK_MntPessoaHistoryResult_MntPessoaHistoryType_IDPessoaHistoryResult]
GO
