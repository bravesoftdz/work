USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Pur_PurchaseItemSerial]    Script Date: 04/16/2014 10:08:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Pur_PurchaseItemSerial](
	[IDPurchaseItemSerial] [int] NOT NULL,
	[IDPurchaseItem] [int] NOT NULL,
	[SerialNumber] [varchar](30) NOT NULL,
	[IDPurchase] [int] NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [PK__Pur_PurchaseItem__02925FBF] PRIMARY KEY CLUSTERED 
(
	[IDPurchaseItemSerial] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Pur_PurchaseItemSerial]  WITH NOCHECK ADD  CONSTRAINT [FK_Purchase_PurchaseItemSerial_IDPurchase] FOREIGN KEY([IDPurchase])
REFERENCES [dbo].[Pur_Purchase] ([IDPurchase])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[Pur_PurchaseItemSerial] CHECK CONSTRAINT [FK_Purchase_PurchaseItemSerial_IDPurchase]
GO
ALTER TABLE [dbo].[Pur_PurchaseItemSerial]  WITH NOCHECK ADD  CONSTRAINT [FK_PurchaseItem_PurchaseItemSerial_IDPurchaseItem] FOREIGN KEY([IDPurchaseItem])
REFERENCES [dbo].[Pur_PurchaseItem] ([IDPurchaseItem])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[Pur_PurchaseItemSerial] CHECK CONSTRAINT [FK_PurchaseItem_PurchaseItemSerial_IDPurchaseItem]
GO
