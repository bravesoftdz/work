USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Pur_PurchaseItem]    Script Date: 04/16/2014 10:08:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Pur_PurchaseItem](
	[IDPurchaseItem] [int] NOT NULL,
	[IDPurchase] [int] NULL,
	[IDGroup] [int] NULL,
	[IDFornecedor] [int] NULL,
	[IDModel] [int] NULL,
	[IDPOItem] [int] NULL,
	[BarCode] [varchar](20) NULL,
	[NewCostPrice] [money] NULL,
	[NewSalePrice] [money] NULL,
	[NewSuggRetail] [money] NULL,
	[CostPrice] [money] NULL,
	[FreightCost] [money] NULL,
	[OtherCost] [money] NULL,
	[CostPriceRet] [money] NULL,
	[FreightCostRet] [money] NULL,
	[OtherCostRet] [money] NULL,
	[NewCostPriceRet] [money] NULL,
	[NewCostPriceResult] [money] NULL,
	[CaseCost] [money] NULL,
	[IsPromo] [bit] NOT NULL,
	[BarcodeCase] [varchar](20) NULL,
	[Qty] [decimal](38, 4) NULL,
	[QtyRet] [decimal](38, 4) NULL,
	[CaseQty] [decimal](38, 4) NULL,
	[IDLote] [int] NULL,
	[Discount] [money] NULL,
	[DiscountRet] [money] NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [PK__Pur_PurchaseItem__00AA174D] PRIMARY KEY CLUSTERED 
(
	[IDPurchaseItem] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Pur_PurchaseItem]  WITH CHECK ADD  CONSTRAINT [FK_Inv_Model_Pur_PurchaseItem_IDLot] FOREIGN KEY([IDLote])
REFERENCES [dbo].[Inv_Lot] ([IDLote])
GO
ALTER TABLE [dbo].[Pur_PurchaseItem] CHECK CONSTRAINT [FK_Inv_Model_Pur_PurchaseItem_IDLot]
GO
ALTER TABLE [dbo].[Pur_PurchaseItem]  WITH NOCHECK ADD  CONSTRAINT [FK_Model_PurchaseItem_IDModel] FOREIGN KEY([IDModel])
REFERENCES [dbo].[Model] ([IDModel])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[Pur_PurchaseItem] CHECK CONSTRAINT [FK_Model_PurchaseItem_IDModel]
GO
ALTER TABLE [dbo].[Pur_PurchaseItem]  WITH NOCHECK ADD  CONSTRAINT [FK_Pessoa_PurchaseItem_IDFornecedor] FOREIGN KEY([IDFornecedor])
REFERENCES [dbo].[Pessoa] ([IDPessoa])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[Pur_PurchaseItem] CHECK CONSTRAINT [FK_Pessoa_PurchaseItem_IDFornecedor]
GO
ALTER TABLE [dbo].[Pur_PurchaseItem]  WITH NOCHECK ADD  CONSTRAINT [FK_Purchase_PurchaseItem_IDPurchase] FOREIGN KEY([IDPurchase])
REFERENCES [dbo].[Pur_Purchase] ([IDPurchase])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[Pur_PurchaseItem] CHECK CONSTRAINT [FK_Purchase_PurchaseItem_IDPurchase]
GO
ALTER TABLE [dbo].[Pur_PurchaseItem]  WITH NOCHECK ADD  CONSTRAINT [FK_TabGroup_PurchaseItem_IDGroup] FOREIGN KEY([IDGroup])
REFERENCES [dbo].[TabGroup] ([IDGroup])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[Pur_PurchaseItem] CHECK CONSTRAINT [FK_TabGroup_PurchaseItem_IDGroup]
GO
ALTER TABLE [dbo].[Pur_PurchaseItem] ADD  DEFAULT (0) FOR [IsPromo]
GO
