USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Cotacao]    Script Date: 04/16/2014 10:08:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Cotacao](
	[IDCotacao] [int] NOT NULL,
	[Cotacao] [varchar](50) NOT NULL,
	[IDStore] [int] NOT NULL,
	[UltimaEmissao] [smalldatetime] NULL,
	[Desativado] [int] NULL,
	[Hidden] [bit] NULL,
	[DataCotacao] [smalldatetime] NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [PK__Cotacao__7C1A6C5A] PRIMARY KEY CLUSTERED 
(
	[IDCotacao] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Cotacao]  WITH NOCHECK ADD  CONSTRAINT [FK_Store_Cotacao_IDStore] FOREIGN KEY([IDStore])
REFERENCES [dbo].[Store] ([IDStore])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[Cotacao] CHECK CONSTRAINT [FK_Store_Cotacao_IDStore]
GO
ALTER TABLE [dbo].[Cotacao] ADD  CONSTRAINT [DF_Zero125]  DEFAULT (0) FOR [Desativado]
GO
ALTER TABLE [dbo].[Cotacao] ADD  CONSTRAINT [DF_Zero126]  DEFAULT (0) FOR [Hidden]
GO
