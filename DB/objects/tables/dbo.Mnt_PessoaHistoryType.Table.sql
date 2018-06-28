USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Mnt_PessoaHistoryType]    Script Date: 04/16/2014 10:08:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Mnt_PessoaHistoryType](
	[IDPessoaHistoryType] [int] NOT NULL,
	[PessoaHistoryType] [varchar](30) NOT NULL,
	[System] [dbo].[Boolean] NOT NULL,
	[Hidden] [dbo].[Boolean] NOT NULL,
	[Desativado] [dbo].[Boolean] NOT NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [XPKMnt_PessoaHistoryType] PRIMARY KEY CLUSTERED 
(
	[IDPessoaHistoryType] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Mnt_PessoaHistoryType] ADD  CONSTRAINT [DF_MntPessoaHistoryType_System_Zero]  DEFAULT (0) FOR [System]
GO
ALTER TABLE [dbo].[Mnt_PessoaHistoryType] ADD  CONSTRAINT [DF_MntPessoaHistoryType_Hidden_Zero]  DEFAULT (0) FOR [Hidden]
GO
ALTER TABLE [dbo].[Mnt_PessoaHistoryType] ADD  CONSTRAINT [DF_MntPessoaHistoryType_Desativado_Zero]  DEFAULT (0) FOR [Desativado]
GO
