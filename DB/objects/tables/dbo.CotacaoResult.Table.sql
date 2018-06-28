USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[CotacaoResult]    Script Date: 04/16/2014 10:08:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CotacaoResult](
	[IDModel] [int] NOT NULL,
	[IDFornecedor] [int] NOT NULL,
	[IDCotacao] [int] NOT NULL,
	[Cost] [money] NULL,
	[PO] [bit] NULL,
	[Qty] [decimal](38, 4) NULL,
	[ReplLastChange] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[IDModel] ASC,
	[IDFornecedor] ASC,
	[IDCotacao] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CotacaoResult]  WITH NOCHECK ADD  CONSTRAINT [FK_Cotacao_CotacaoResult_IDCotacao] FOREIGN KEY([IDCotacao])
REFERENCES [dbo].[Cotacao] ([IDCotacao])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[CotacaoResult] CHECK CONSTRAINT [FK_Cotacao_CotacaoResult_IDCotacao]
GO
ALTER TABLE [dbo].[CotacaoResult]  WITH NOCHECK ADD  CONSTRAINT [FK_Model_CotacaoResult_IDModel] FOREIGN KEY([IDModel])
REFERENCES [dbo].[Model] ([IDModel])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[CotacaoResult] CHECK CONSTRAINT [FK_Model_CotacaoResult_IDModel]
GO
ALTER TABLE [dbo].[CotacaoResult]  WITH NOCHECK ADD  CONSTRAINT [FK_Pessoa_CotacaoResult_IDFornecedor] FOREIGN KEY([IDFornecedor])
REFERENCES [dbo].[Pessoa] ([IDPessoa])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[CotacaoResult] CHECK CONSTRAINT [FK_Pessoa_CotacaoResult_IDFornecedor]
GO
ALTER TABLE [dbo].[CotacaoResult] ADD  CONSTRAINT [DF_Zero176]  DEFAULT (0) FOR [PO]
GO
