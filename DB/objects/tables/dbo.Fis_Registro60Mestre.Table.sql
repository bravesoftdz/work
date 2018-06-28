USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Fis_Registro60Mestre]    Script Date: 04/16/2014 10:08:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Fis_Registro60Mestre](
	[DataEmissao] [datetime] NOT NULL,
	[NumeroSerie] [char](20) NOT NULL,
	[NumeroOrdem] [int] NULL,
	[ModeloDocumentoFiscal] [char](2) NULL,
	[NumeroInicialDia] [int] NULL,
	[NumeroFinalDia] [int] NULL,
	[NumeroReducao] [int] NULL,
	[NumeroReinicioOperacao] [int] NULL,
	[ValorVendaBruta] [dbo].[TValorNull] NULL,
	[ValorTotalGeral] [dbo].[TValorNull] NULL,
	[ReplLastChange] [datetime] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
