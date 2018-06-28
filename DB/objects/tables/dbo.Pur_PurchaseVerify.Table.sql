USE [a0000748__2014-03-30]
GO
/****** Object:  Table [dbo].[Pur_PurchaseVerify]    Script Date: 04/16/2014 10:08:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Pur_PurchaseVerify](
	[IDPurchaseVerify] [int] NOT NULL,
	[IDPurchase] [int] NULL,
	[IDUser] [int] NOT NULL,
	[IDModel] [int] NULL,
	[IDBarcode] [varchar](20) NULL,
	[QtyReceiving] [decimal](38, 4) NULL,
	[QtyCounted] [decimal](38, 4) NULL,
	[EnterDate] [datetime] NULL,
	[ScanDate] [datetime] NULL,
	[ReplLastChange] [datetime] NULL,
 CONSTRAINT [XPKPur_PurchaseVerify] PRIMARY KEY CLUSTERED 
(
	[IDPurchaseVerify] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Pur_PurchaseVerify]  WITH CHECK ADD  CONSTRAINT [FK_Model_PurchaseVerify_IDModel] FOREIGN KEY([IDModel])
REFERENCES [dbo].[Model] ([IDModel])
GO
ALTER TABLE [dbo].[Pur_PurchaseVerify] CHECK CONSTRAINT [FK_Model_PurchaseVerify_IDModel]
GO
ALTER TABLE [dbo].[Pur_PurchaseVerify]  WITH CHECK ADD  CONSTRAINT [FK_Purchase_PurchaseVerify_IDPurchase] FOREIGN KEY([IDPurchase])
REFERENCES [dbo].[Pur_Purchase] ([IDPurchase])
GO
ALTER TABLE [dbo].[Pur_PurchaseVerify] CHECK CONSTRAINT [FK_Purchase_PurchaseVerify_IDPurchase]
GO
ALTER TABLE [dbo].[Pur_PurchaseVerify]  WITH CHECK ADD  CONSTRAINT [FK_SystemUSer_PurchaseVerify_IDUser] FOREIGN KEY([IDUser])
REFERENCES [dbo].[SystemUser] ([IDUser])
GO
ALTER TABLE [dbo].[Pur_PurchaseVerify] CHECK CONSTRAINT [FK_SystemUSer_PurchaseVerify_IDUser]
GO
ALTER TABLE [dbo].[Pur_PurchaseVerify] ADD  DEFAULT (NULL) FOR [ScanDate]
GO
