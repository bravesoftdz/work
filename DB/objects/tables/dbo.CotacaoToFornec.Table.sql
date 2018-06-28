USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[CotacaoToFornec]    Script Date: 04/16/2014 10:08:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CotacaoToFornec](
	[IDCotacao] [int] NOT NULL,
	[IDFornecedor] [int] NOT NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [XPKCotacaoToFornec] PRIMARY KEY CLUSTERED 
(
	[IDCotacao] ASC,
	[IDFornecedor] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CotacaoToFornec]  WITH NOCHECK ADD  CONSTRAINT [FK_Cotacao_CotacaoToFornec_IDCotacao] FOREIGN KEY([IDCotacao])
REFERENCES [dbo].[Cotacao] ([IDCotacao])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[CotacaoToFornec] CHECK CONSTRAINT [FK_Cotacao_CotacaoToFornec_IDCotacao]
GO
ALTER TABLE [dbo].[CotacaoToFornec]  WITH NOCHECK ADD  CONSTRAINT [FK_Pessoa_CotacaoToFornec_IDFornecedor] FOREIGN KEY([IDFornecedor])
REFERENCES [dbo].[Pessoa] ([IDPessoa])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[CotacaoToFornec] CHECK CONSTRAINT [FK_Pessoa_CotacaoToFornec_IDFornecedor]
GO
