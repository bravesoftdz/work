USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Fin_CentroCusto]    Script Date: 04/16/2014 10:08:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Fin_CentroCusto](
	[IDCentroCusto] [int] NOT NULL,
	[CentroCusto] [dbo].[TDescricao] NOT NULL,
	[CodigoCentroCusto] [dbo].[TCodigoGeral] NULL,
	[Desativado] [dbo].[TBit] NULL,
	[Hidden] [dbo].[TBit] NULL,
	[System] [dbo].[TBit] NULL,
	[IDCentroCustoParent] [int] NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [PK__Fin_CentroCusto__4316F928] PRIMARY KEY CLUSTERED 
(
	[IDCentroCusto] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Fin_CentroCusto]  WITH NOCHECK ADD  CONSTRAINT [FK_CentroCusto_CentroCusto_IDCentroCustoParent] FOREIGN KEY([IDCentroCustoParent])
REFERENCES [dbo].[Fin_CentroCusto] ([IDCentroCusto])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[Fin_CentroCusto] CHECK CONSTRAINT [FK_CentroCusto_CentroCusto_IDCentroCustoParent]
GO
