USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Pur_PurchaseItemTaxRet]    Script Date: 04/16/2014 10:08:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pur_PurchaseItemTaxRet](
	[IDPurchaseItemTaxRet] [int] NOT NULL,
	[IDPurchaseItem] [int] NULL,
	[IDVendorTax] [int] NULL,
	[TaxValue] [money] NULL,
	[TaxPercentage] [money] NULL,
	[IDPurchase] [int] NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [XPKPur_PurchaseItemTaxRet] PRIMARY KEY CLUSTERED 
(
	[IDPurchaseItemTaxRet] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Pur_PurchaseItemTaxRet]  WITH CHECK ADD  CONSTRAINT [FK_Pur_Purchase_Pur_PurchaseItemTaxRet_IDPurchase] FOREIGN KEY([IDPurchase])
REFERENCES [dbo].[Pur_Purchase] ([IDPurchase])
GO
ALTER TABLE [dbo].[Pur_PurchaseItemTaxRet] CHECK CONSTRAINT [FK_Pur_Purchase_Pur_PurchaseItemTaxRet_IDPurchase]
GO
ALTER TABLE [dbo].[Pur_PurchaseItemTaxRet]  WITH CHECK ADD  CONSTRAINT [FK_VendorTax_Pur_PurchaseItemTaxRet_IDVendorTax] FOREIGN KEY([IDVendorTax])
REFERENCES [dbo].[VendorTax] ([IDVendorTax])
GO
ALTER TABLE [dbo].[Pur_PurchaseItemTaxRet] CHECK CONSTRAINT [FK_VendorTax_Pur_PurchaseItemTaxRet_IDVendorTax]
GO
ALTER TABLE [dbo].[Pur_PurchaseItemTaxRet]  WITH CHECK ADD  CONSTRAINT [Pur_PurchaseItem_Pur_PurchaseItemTaxRet_IDPurchaseItem] FOREIGN KEY([IDPurchaseItem])
REFERENCES [dbo].[Pur_PurchaseItem] ([IDPurchaseItem])
GO
ALTER TABLE [dbo].[Pur_PurchaseItemTaxRet] CHECK CONSTRAINT [Pur_PurchaseItem_Pur_PurchaseItemTaxRet_IDPurchaseItem]
GO
