USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Sal_InvoiceShipping]    Script Date: 04/16/2014 10:08:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Sal_InvoiceShipping](
	[IDInvoiceShipping] [int] NOT NULL,
	[IDPreSale] [int] NOT NULL,
	[ShipDate] [datetime] NOT NULL,
	[Tracking] [varchar](255) NULL,
	[IDDeliverType] [int] NULL,
	[AddressName] [varchar](30) NULL,
	[Address] [varchar](50) NULL,
	[City] [varchar](20) NULL,
	[ZIP] [varchar](10) NULL,
	[IDEstado] [char](3) NULL,
	[IDPais] [int] NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [XPKSal_InvoiceShipping] PRIMARY KEY CLUSTERED 
(
	[IDInvoiceShipping] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Sal_InvoiceShipping]  WITH CHECK ADD  CONSTRAINT [FK_DeliverType_SalInvoiceShipping_IDDeliverType] FOREIGN KEY([IDDeliverType])
REFERENCES [dbo].[DeliverType] ([IDDeliverType])
GO
ALTER TABLE [dbo].[Sal_InvoiceShipping] CHECK CONSTRAINT [FK_DeliverType_SalInvoiceShipping_IDDeliverType]
GO
ALTER TABLE [dbo].[Sal_InvoiceShipping]  WITH CHECK ADD  CONSTRAINT [FK_Estado_SalInvoiceShipping_IDEstado] FOREIGN KEY([IDEstado])
REFERENCES [dbo].[Estado] ([IDEstado])
GO
ALTER TABLE [dbo].[Sal_InvoiceShipping] CHECK CONSTRAINT [FK_Estado_SalInvoiceShipping_IDEstado]
GO
ALTER TABLE [dbo].[Sal_InvoiceShipping]  WITH CHECK ADD  CONSTRAINT [FK_Invoice_SalInvoiceShipping_IDPreSale] FOREIGN KEY([IDPreSale])
REFERENCES [dbo].[Invoice] ([IDPreSale])
GO
ALTER TABLE [dbo].[Sal_InvoiceShipping] CHECK CONSTRAINT [FK_Invoice_SalInvoiceShipping_IDPreSale]
GO
ALTER TABLE [dbo].[Sal_InvoiceShipping]  WITH CHECK ADD  CONSTRAINT [FK_Pais_SalInvoiceShipping_IDPais] FOREIGN KEY([IDPais])
REFERENCES [dbo].[Pais] ([IDPais])
GO
ALTER TABLE [dbo].[Sal_InvoiceShipping] CHECK CONSTRAINT [FK_Pais_SalInvoiceShipping_IDPais]
GO
