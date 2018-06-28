USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Pur_PurchaseQtyOrder]    Script Date: 04/16/2014 10:08:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pur_PurchaseQtyOrder](
	[IDPurchaseQtyOrder] [int] NOT NULL,
	[IDPurchase] [int] NULL,
	[IDModel] [int] NULL,
	[IDStore] [int] NULL,
	[IDPOItem] [int] NULL,
	[Qty] [decimal](38, 4) NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [PK__Pur_PurchaseQtyO__0697FACD] PRIMARY KEY CLUSTERED 
(
	[IDPurchaseQtyOrder] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Pur_PurchaseQtyOrder]  WITH NOCHECK ADD  CONSTRAINT [FK_Model_PurchaseQtyOrder_IDModel] FOREIGN KEY([IDModel])
REFERENCES [dbo].[Model] ([IDModel])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[Pur_PurchaseQtyOrder] CHECK CONSTRAINT [FK_Model_PurchaseQtyOrder_IDModel]
GO
ALTER TABLE [dbo].[Pur_PurchaseQtyOrder]  WITH NOCHECK ADD  CONSTRAINT [FK_Purchase_PurchaseQtyOrder_IDPurchase] FOREIGN KEY([IDPurchase])
REFERENCES [dbo].[Pur_Purchase] ([IDPurchase])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[Pur_PurchaseQtyOrder] CHECK CONSTRAINT [FK_Purchase_PurchaseQtyOrder_IDPurchase]
GO
ALTER TABLE [dbo].[Pur_PurchaseQtyOrder]  WITH NOCHECK ADD  CONSTRAINT [FK_Store_PurchaseQtyOrder_IDStore] FOREIGN KEY([IDStore])
REFERENCES [dbo].[Store] ([IDStore])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[Pur_PurchaseQtyOrder] CHECK CONSTRAINT [FK_Store_PurchaseQtyOrder_IDStore]
GO
