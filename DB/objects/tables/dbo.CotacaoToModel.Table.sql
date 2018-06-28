USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[CotacaoToModel]    Script Date: 04/16/2014 10:08:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CotacaoToModel](
	[IDCotacao] [int] NOT NULL,
	[IDModel] [int] NOT NULL,
	[IDRequest] [int] NULL,
	[QtyCotada] [decimal](38, 4) NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [XPKCotacaoToModel] PRIMARY KEY CLUSTERED 
(
	[IDCotacao] ASC,
	[IDModel] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CotacaoToModel]  WITH NOCHECK ADD  CONSTRAINT [FK_Cotacao_CotacaoToModel_IDCotacao] FOREIGN KEY([IDCotacao])
REFERENCES [dbo].[Cotacao] ([IDCotacao])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[CotacaoToModel] CHECK CONSTRAINT [FK_Cotacao_CotacaoToModel_IDCotacao]
GO
ALTER TABLE [dbo].[CotacaoToModel]  WITH NOCHECK ADD  CONSTRAINT [FK_Model_CotacaoToModel_IDModel] FOREIGN KEY([IDModel])
REFERENCES [dbo].[Model] ([IDModel])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[CotacaoToModel] CHECK CONSTRAINT [FK_Model_CotacaoToModel_IDModel]
GO
ALTER TABLE [dbo].[CotacaoToModel]  WITH NOCHECK ADD  CONSTRAINT [FK_Request_CotacaoToModel_IDRequest] FOREIGN KEY([IDRequest])
REFERENCES [dbo].[Request] ([IDRequest])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[CotacaoToModel] CHECK CONSTRAINT [FK_Request_CotacaoToModel_IDRequest]
GO
ALTER TABLE [dbo].[CotacaoToModel] ADD  CONSTRAINT [DF_Zero177]  DEFAULT (0) FOR [QtyCotada]
GO
