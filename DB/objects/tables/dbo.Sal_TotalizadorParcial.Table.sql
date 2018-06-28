USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Sal_TotalizadorParcial]    Script Date: 04/16/2014 10:08:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Sal_TotalizadorParcial](
	[IDTotalizadorParcial] [int] NOT NULL,
	[IDReducaoZ] [int] NOT NULL,
	[Codigo] [varchar](10) NULL,
	[ValorAcumulado] [money] NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [XPKSal_TotalizadorParcial] PRIMARY KEY CLUSTERED 
(
	[IDTotalizadorParcial] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Sal_TotalizadorParcial]  WITH CHECK ADD  CONSTRAINT [FK_Sal_ReducaoZ_Sal_TotalizadorParcial_IDReducaoZ] FOREIGN KEY([IDReducaoZ])
REFERENCES [dbo].[Sal_ReducaoZ] ([IDReducaoZ])
GO
ALTER TABLE [dbo].[Sal_TotalizadorParcial] CHECK CONSTRAINT [FK_Sal_ReducaoZ_Sal_TotalizadorParcial_IDReducaoZ]
GO
