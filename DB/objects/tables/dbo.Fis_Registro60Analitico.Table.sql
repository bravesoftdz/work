USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Fis_Registro60Analitico]    Script Date: 04/16/2014 10:08:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Fis_Registro60Analitico](
	[DataEmissao] [datetime] NOT NULL,
	[NumeroSerie] [dbo].[TNumeroSerie] NOT NULL,
	[SituacaoTributaria] [char](4) NOT NULL,
	[ValorAcumuladoParcial] [dbo].[TValorNull] NULL,
	[ReplLastChange] [datetime] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
