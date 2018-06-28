USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Ser_SOCustomerProduct]    Script Date: 04/16/2014 10:08:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Ser_SOCustomerProduct](
	[IDSOCustomerProduct] [int] NOT NULL,
	[IDManufacture] [int] NULL,
	[Model] [varchar](50) NULL,
	[Description] [varchar](100) NULL,
	[System] [bit] NOT NULL,
	[Hidden] [bit] NOT NULL,
	[Desativado] [bit] NOT NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [XPKSer_SOCustomerProduct] PRIMARY KEY CLUSTERED 
(
	[IDSOCustomerProduct] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Ser_SOCustomerProduct]  WITH CHECK ADD  CONSTRAINT [FK_Pessoa_Ser_SOCustomerProduct_IDManufacture] FOREIGN KEY([IDManufacture])
REFERENCES [dbo].[Pessoa] ([IDPessoa])
GO
ALTER TABLE [dbo].[Ser_SOCustomerProduct] CHECK CONSTRAINT [FK_Pessoa_Ser_SOCustomerProduct_IDManufacture]
GO
ALTER TABLE [dbo].[Ser_SOCustomerProduct] ADD  CONSTRAINT [DF_Zero3600]  DEFAULT (0) FOR [System]
GO
ALTER TABLE [dbo].[Ser_SOCustomerProduct] ADD  CONSTRAINT [DF_Zero3601]  DEFAULT (0) FOR [Hidden]
GO
ALTER TABLE [dbo].[Ser_SOCustomerProduct] ADD  CONSTRAINT [DF_Zero3602]  DEFAULT (0) FOR [Desativado]
GO
