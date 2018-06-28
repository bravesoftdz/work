USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Sal_ReducaoZ]    Script Date: 04/16/2014 10:08:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Sal_ReducaoZ](
	[IDReducaoZ] [int] NOT NULL,
	[MovDate] [datetime] NOT NULL,
	[NumeroSerie] [varchar](20) NOT NULL,
	[NumeroLoja] [int] NOT NULL,
	[NumeroECF] [int] NOT NULL,
	[NumReducaoZ] [int] NOT NULL,
	[COOInicial] [int] NOT NULL,
	[COOFinal] [int] NOT NULL,
	[NumCancelamentos] [int] NOT NULL,
	[ValCancelamentos] [money] NOT NULL,
	[ValDescontos] [money] NOT NULL,
	[GTInicial] [money] NOT NULL,
	[GTFinal] [money] NOT NULL,
	[SubstituicaoTrib] [money] NOT NULL,
	[Isencao] [money] NOT NULL,
	[NaoTributavel] [money] NULL,
	[MFAdicional] [char](1) NULL,
	[TipoECF] [varchar](20) NULL,
	[MarcaECF] [varchar](20) NULL,
	[ModeloECF] [varchar](20) NULL,
	[VersaoSBECF] [varchar](10) NULL,
	[DataInstalacaoSBECF] [datetime] NULL,
	[ContadorReducaoZ] [int] NULL,
	[ContadorOrdemOperacao] [int] NULL,
	[ContadorReinicioOperacao] [int] NULL,
	[NumeroUsuarioECF] [int] NULL,
	[IncideISSQN] [bit] NULL,
	[DataEmissao] [datetime] NULL,
	[IDCashRegister] [int] NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [XPKSal_ReducaoZ] PRIMARY KEY CLUSTERED 
(
	[IDReducaoZ] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Sal_ReducaoZ]  WITH CHECK ADD  CONSTRAINT [FK_CashRegister_Sal_TotalizadorParcial_IDReducaoZ] FOREIGN KEY([IDCashRegister])
REFERENCES [dbo].[CashRegister] ([IDCashRegister])
GO
ALTER TABLE [dbo].[Sal_ReducaoZ] CHECK CONSTRAINT [FK_CashRegister_Sal_TotalizadorParcial_IDReducaoZ]
GO
