USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[VendorTax]    Script Date: 04/16/2014 10:08:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VendorTax](
	[IDVendorTax] [int] NOT NULL,
	[IDPessoa] [int] NULL,
	[IDGroup] [int] NULL,
	[IDTaxCategory] [int] NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [XPKVendorTax] PRIMARY KEY CLUSTERED 
(
	[IDVendorTax] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[VendorTax]  WITH CHECK ADD  CONSTRAINT [FK_Pessoa_VendorTax_IDPessoa] FOREIGN KEY([IDPessoa])
REFERENCES [dbo].[Pessoa] ([IDPessoa])
GO
ALTER TABLE [dbo].[VendorTax] CHECK CONSTRAINT [FK_Pessoa_VendorTax_IDPessoa]
GO
ALTER TABLE [dbo].[VendorTax]  WITH CHECK ADD  CONSTRAINT [FK_TabGroup_VendorTax_IDGroup] FOREIGN KEY([IDGroup])
REFERENCES [dbo].[TabGroup] ([IDGroup])
GO
ALTER TABLE [dbo].[VendorTax] CHECK CONSTRAINT [FK_TabGroup_VendorTax_IDGroup]
GO
ALTER TABLE [dbo].[VendorTax]  WITH CHECK ADD  CONSTRAINT [FK_TaxCategory_VendorTax_IDTaxCategory] FOREIGN KEY([IDTaxCategory])
REFERENCES [dbo].[TaxCategory] ([IDTaxCategory])
GO
ALTER TABLE [dbo].[VendorTax] CHECK CONSTRAINT [FK_TaxCategory_VendorTax_IDTaxCategory]
GO
