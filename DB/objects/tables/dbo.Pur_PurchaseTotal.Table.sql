USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Pur_PurchaseTotal]    Script Date: 04/16/2014 10:08:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pur_PurchaseTotal](
	[IDPurchase] [int] NOT NULL,
	[SubTotal] [money] NULL,
	[SubTotalRet] [money] NULL,
	[ReplLastChange] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[IDPurchase] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Pur_PurchaseTotal]  WITH NOCHECK ADD  CONSTRAINT [FK_Purchase_PurchaseTotal_IDPurchase] FOREIGN KEY([IDPurchase])
REFERENCES [dbo].[Pur_Purchase] ([IDPurchase])
NOT FOR REPLICATION
GO
ALTER TABLE [dbo].[Pur_PurchaseTotal] CHECK CONSTRAINT [FK_Purchase_PurchaseTotal_IDPurchase]
GO
