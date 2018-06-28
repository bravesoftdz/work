USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Sis_Moeda]    Script Date: 04/16/2014 10:08:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Sis_Moeda](
	[IDMoeda] [int] NOT NULL,
	[CodigoMoeda] [dbo].[TCodigoGeral] NOT NULL,
	[Moeda] [dbo].[TDescricao] NOT NULL,
	[MoedaPadrao] [dbo].[TBit] NULL,
	[Sigla] [dbo].[TCodigoGeral] NOT NULL,
	[IDMoedaCotacao] [int] NULL,
	[ValorMoedaPadrao] [dbo].[TValor] NULL,
	[DataCotacao] [datetime] NULL,
	[Desativado] [dbo].[TBit] NULL,
	[System] [dbo].[TBit] NULL,
	[Hidden] [dbo].[TBit] NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [PK__Sis_Moeda__00200768] PRIMARY KEY CLUSTERED 
(
	[IDMoeda] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
