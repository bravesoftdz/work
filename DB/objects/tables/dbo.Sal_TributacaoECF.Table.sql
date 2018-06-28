USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Sal_TributacaoECF]    Script Date: 04/16/2014 10:08:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sal_TributacaoECF](
	[IDTributacaoECF] [int] NOT NULL,
	[Aliquota] [float] NOT NULL,
	[BaseCalculo] [money] NOT NULL,
	[ValImposto] [money] NOT NULL,
	[IDReducaoZ] [int] NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [XPKSal_TributacaoECF] PRIMARY KEY CLUSTERED 
(
	[IDTributacaoECF] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Sal_TributacaoECF]  WITH CHECK ADD  CONSTRAINT [FK_SalReducaoZ_SalTributacaoECF_IDReducaoZ] FOREIGN KEY([IDReducaoZ])
REFERENCES [dbo].[Sal_ReducaoZ] ([IDReducaoZ])
GO
ALTER TABLE [dbo].[Sal_TributacaoECF] CHECK CONSTRAINT [FK_SalReducaoZ_SalTributacaoECF_IDReducaoZ]
GO
